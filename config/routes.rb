require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end

  mount ActionCable.server => '/cable'

  mount API::Root => '/api/'

  get '/',      to: 'home#index'
  get '/user',  to: 'user#index'
  get '/admin', to: 'admin#index'

  constraints(UserSubdomain) do
    root to: 'user#index'
  end

  constraints(AdminSubdomain) do
    root to: 'admin#index'
  end
end
