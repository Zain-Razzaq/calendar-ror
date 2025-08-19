class EventsController < ApplicationController
  def create
    begin
      @event = Event.new(event_params)
      @event.user = current_user

      if @event.end_time <= @event.start_time
        flash[:alert] = "End time should be after start time"
        redirect_to root_path
        return
      end
      
      if @event.save
        redirect_to root_path, notice: "Event created successfully"
      else
        redirect_to root_path, alert: "Event creation failed"
      end
    rescue => e
      flash[:alert] = "Event creation failed: #{e.message}"
      redirect_to root_path
    end
  end


  private

  def event_params
    params.require(:event).permit(:title, :desc, :date, :start_time, :end_time)
  end
end