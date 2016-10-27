Rails.application.routes.draw do
  mount ActionCable.server => :cable
  get 'check/:term', to: 'query#show'
end
