Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/show', to: 'marvel#show'
    end
  end
  root to: 'marvel#show'
end
