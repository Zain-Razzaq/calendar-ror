class EventsController < ApplicationController
  before_action :require_user, only: [ :create ]

  def create
      @event = Event.new(event_params)
      @event.user = current_user

      if @event.save
        UserMailer.eventCreationMailer(@event).deliver
        redirect_to root_path, notice: "Event created successfully"
      else
        redirect_to root_path, alert: @event.errors.full_messages.join(", ")
      end
  end


  private

  def event_params
    params.require(:event).permit(:title, :desc, :date, :start_time, :end_time)
  end
end
