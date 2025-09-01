class HomeController < ApplicationController
  before_action :require_user, only: [ :index ]

  def index
    year  = (params[:year]  || Date.today.year).to_i
    month = (params[:month] || Date.today.month).to_i

    @date = Date.new(year, month, 1)
    @end_date = @date.end_of_month
    @start_wday = @date.wday

    @events_by_date = Event.includes(:registrations).where(date: @date..@end_date).group_by(&:date)

    if request.headers["Turbo-Frame"] == "calendar"
      render partial: "calendar/index", locals: {
        date: @date,
        end_date: @end_date,
        start_wday: @start_wday,
        events_by_date: @events_by_date
      }
    end
  end
end
