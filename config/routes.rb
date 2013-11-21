SenadoCc::Application.routes.draw do

  root 'home#index'

   get '/:id' => 'senadores#show', as: :senador


end
