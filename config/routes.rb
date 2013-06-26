SenadoCc::Application.routes.draw do

  root 'home#index'

  get '/profile' => 'home#profile'

end
