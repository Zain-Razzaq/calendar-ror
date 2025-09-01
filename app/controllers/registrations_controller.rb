class RegistrationsController < ApplicationController
  before_action :require_user

  def create
    @event = Event.find(params[:registration][:event_id])

    if @event.user_registered?(current_user)
      redirect_to root_path, alert: "You are already registered for this event"
      return
    end

    if @event.event_type == "free"
      @registration = @event.registrations.new(
        user: current_user,
        payment_status: "paid",
        amount: 0
      )

      if @registration.save
        redirect_to root_path, notice: "Successfully registered for the event!"
      else
        redirect_to root_path, alert: "Registration failed: #{@registration.errors.full_messages.join(', ')}"
      end
    else
      redirect_to event_register_path(@event)
    end
  end

  def new
    unless params[:id].present?
      redirect_to root_path, alert: "Event ID is missing"
      return
    end

    @event = Event.find(params[:id])

    if @event.user_registered?(current_user)
      redirect_to root_path, notice: "You are already registered for this event"
      return
    end

    @registration = @event.registrations.new
  end

  private

  def registration_params
    params.require(:registration).permit(:event_id, :payment_status, :amount)
  end
end
