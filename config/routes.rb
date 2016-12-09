Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: redirect('/booking')
  get '/booking', to: 'booking#index'
  post '/booking', to: 'booking#create'
  get '/pusher_check', to: 'booking#pusher_check'
  get '/drivers', to: 'driver#nearby_drivers'
end
