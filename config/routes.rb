SenadoCc::Application.routes.draw do

  root 'home#index'

  get '/:id' => 'senador#show', as: :senador

end
