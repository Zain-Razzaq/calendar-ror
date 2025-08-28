class EventsController < ApplicationController
  before_action :require_user, only: [ :index, :new, :create ]

  def index
    @events = Event.all
    render json: @events
  end

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
      UserMailer.eventCreationMailer(@event).deliver_later

      karachi_tz = TZInfo::Timezone.get("Asia/Karachi")
      local_time = DateTime.new(@event.date.year, @event.date.month, @event.date.day, @event.start_time.hour, @event.start_time.min, @event.start_time.sec)
      reminder_time = karachi_tz.local_to_utc(local_time) - 15.minutes

      EventReminderJob.set(wait_until: reminder_time).perform_later(@event.id)

      render json: @event, status: :created
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :desc, :date, :start_time, :end_time)
  end
end
