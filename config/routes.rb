Rails.application.routes.draw do
  mount ActionCable.server => :cable
  get 'check/:term', to: 'query#show'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
