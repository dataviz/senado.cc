SenadoCc::Application.routes.draw do
  root 'home#index'
   get '/:slug' => 'senadores#show'
end
