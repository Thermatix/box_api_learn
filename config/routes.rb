BoxApiLearn::Application.routes.draw do

  resource :sessions, only: %w(create new destroy update)
  resource :box_access , only: %w(index)
  get '/:folder_id', to: 'box_access#index', as: :select_folder	
  post '/save_file', to: 'box_access#save_file', as: :save_file 
 
  root to: 'box_access#index'
end
