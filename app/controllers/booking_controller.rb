class BookingController < ApplicationController
  def index
    render :json => {:message => 'Connection is working! :D'}
  end

  def create
    BookingJob.perform_async(params[:userId], params[:srcLocation], params[:tgtLocation])
    render :json => {:message => 'OK', :requestParams => params}
  end
end
