RssReader::Application.routes.draw do

  resources :subscriptions, :only => [:index, :create, :destroy]

  # root :to => 'welcome#index'

  # match ':controller(/:action(/:id))(.:format)'
end
