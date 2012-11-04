RssReader::Application.routes.draw do

  resources :subscriptions do
    get '/refresh', :action => :refresh
  end

  root :to => 'subscriptions#index'

  # match ':controller(/:action(/:id))(.:format)'
end
