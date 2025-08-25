class EventsController < ApplicationController
  before_action :require_user, only: [ :new, :create ]

  def new
    @event = Event.new

    if params[:date].present?
      @event.date = Date.parse(params[:date])
    end
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      UserMailer.eventCreationMailer(@event).deliver
      redirect_to root_path, notice: "Event created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :desc, :date, :start_time, :end_time)
  end
end
