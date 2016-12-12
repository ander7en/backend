class PusherController < ApplicationController
  def auth
      auth = Pusher.authenticate(params[:channel_name], params[:socket_id])

      render(
          text: params[:callback] + "(" + auth.to_json + ")",
          content_type: 'application/javascript'
      )
  end
end
