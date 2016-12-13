class NotificationController < ApplicationController

def receive
  if params.has_key?(:driver_id) && params.has_key?(:response) && params.has_key?(:order_id)

    driver_id = params[:driver_id]
    response  = params[:response]
    order_id  = params[:order_id]

    NotifyDriver.driver_response(driver_id,response,order_id)

    render :json => {:text => "Notification Recieved"}

  else

      render :json => {:text => "error"}

  end

end


end
