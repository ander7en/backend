class BookingController < ApplicationController
  def index
    render :json => {:message => 'Connection is working! :D'}
  end

  def create
    BookingJob.perform_async(params[:userId], params[:srcLocation], params[:tgtLocation])
    render :json => {:message => 'Some useful actions suppose to happen in here', :requestParams => params}
  end
end
