class PaymentsController < ApplicationController
  before_action :require_user
  before_action :set_event

  def create_checkout_session
    if @event.user_registered?(current_user)
      redirect_to root_path, alert: "You are already registered for this event"
      return
    end

    begin
      registration = @event.registrations.create!(
        user: current_user,
        payment_status: "pending",
        amount: @event.price
      )

      success_url = "http://localhost:3000/payments/#{@event.id}/success?session_id={CHECKOUT_SESSION_ID}"
      cancel_url = "http://localhost:3000/payments/#{@event.id}/cancel"

      session = Stripe::Checkout::Session.create({
        payment_method_types: [ "card" ],
        line_items: [ {
          price_data: {
            currency: "usd",
            product_data: {
              name: @event.title,
              description: @event.desc
            },
            unit_amount: (@event.price * 100).to_i
          },
          quantity: 1
        } ],
        mode: "payment",
        success_url: success_url,
        cancel_url: cancel_url,
        metadata: {
          event_id: @event.id,
          user_id: current_user.id,
          registration_id: registration.id
        }
      })

      registration.update!(stripe_session_id: session.id)

      redirect_to session.url, allow_other_host: true
    rescue => e
      redirect_to register_event_path(@event), alert: "Something went wrong: #{e.message}"
    end
  end

  def success
    session_id = params[:session_id]

    begin
      stripe_session = Stripe::Checkout::Session.retrieve(session_id)

      if stripe_session.metadata["user_id"].to_i != current_user.id ||
         stripe_session.metadata["event_id"].to_i != @event.id
        redirect_to root_path, alert: "Invalid payment session."
        return
      end

      # Find the pending registration
      registration = @event.registrations.find_by(
        user: current_user,
        stripe_session_id: session_id,
        payment_status: "pending"
      )

      unless registration
        redirect_to root_path, alert: "Registration not found or already processed."
        return
      end

      if stripe_session.payment_status == "paid"
        registration.update!(payment_status: "paid")
        redirect_to root_path, notice: "Payment successful! You are now registered for #{@event.title}"
      else
        registration.update!(payment_status: "failed")
        redirect_to root_path, alert: "Payment was not completed. Please try again."
      end
    rescue => e
      redirect_to root_path, alert: "Registration failed: #{e.message}"
    end
  end

  def cancel
    pending_registration = @event.registrations.find_by(
      user: current_user,
      payment_status: "pending"
    )

    pending_registration&.update!(payment_status: "failed")
    redirect_to register_event_path(@event), alert: "Payment was cancelled"
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
