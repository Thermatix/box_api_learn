BoxApiLearn::Application.routes.draw do

  resource :sessions, only: %w(create new destroy update)
  resource :box_access, only: %w(index show)
  root to: 'box_access#index'
end
