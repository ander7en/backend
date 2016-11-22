class BookingController < ApplicationController
  def index
    render :json => {:message => 'Connection is working! :D'}
  end

  def create
    render :json => {:message => 'Some useful actions suppose to happen in here', :requestParams => params}
  end
end
