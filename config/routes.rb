require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end

  mount ActionCable.server => '/cable'

  mount API::Root => '/api/'

  root to: 'home#index'
end
