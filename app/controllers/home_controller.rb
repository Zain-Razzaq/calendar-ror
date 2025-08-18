class HomeController < ApplicationController
  def show
    year  = (params[:year]  || Date.today.year).to_i
    month = (params[:month] || Date.today.month).to_i

    @date = Date.new(year, month, 1)
    @end_date = @date.end_of_month
    @start_wday = @date.wday
  end
end
