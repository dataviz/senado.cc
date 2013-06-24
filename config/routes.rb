SenadoCc::Application.routes.draw do

  root 'home#index'

  get '/profile' => 'home#profile'
  get '/new'     => 'home#new'

end
