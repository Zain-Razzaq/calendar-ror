class HomeController < ApplicationController
  def show
    @event = Event.new
    year  = (params[:year]  || Date.today.year).to_i
    month = (params[:month] || Date.today.month).to_i

    @date = Date.new(year, month, 1)
    @end_date = @date.end_of_month
    @start_wday = @date.wday

    @events = Event.where(user: current_user, date: @date..@end_date)
    @events_by_date = @events.group_by(&:date)
  end
end
