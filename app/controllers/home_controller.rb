class HomeController < ApplicationController
  before_action :require_user, only: [ :index ]

  def index
    @event = Event.new
    year  = (params[:year]  || Date.today.year).to_i
    month = (params[:month] || Date.today.month).to_i

    @date = Date.new(year, month, 1)
    @end_date = @date.end_of_month
    @start_wday = @date.wday

    @events_by_date = current_user.events.where(date: @date..@end_date).group_by(&:date)
  end
end
