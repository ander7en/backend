class BookingController < ApplicationController
  def index
    render :json => {:message => 'Connection is working! :D'}
  end

  def create
    render :json => {:message => 'Some useful actions suppose to happen in here', :requestParams => params}
  end
  
  def pusher_check
    Pusher.trigger('test_channel', 'my_event', {
      message: 'hello world'
    })
    render :json => {:message => 'pusher_check happened'}
  end
end
