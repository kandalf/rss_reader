RssReader::Application.routes.draw do

  resources :subscriptions, :only => [:index, :create, :destroy]

  root :to => 'subscriptions#index'

  # match ':controller(/:action(/:id))(.:format)'
end
