Rails.application.routes.draw do
  defaults format: :json do
    resources :todos
    resource :status, only: [:show]
  end
end
