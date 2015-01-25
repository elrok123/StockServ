
Rails.application.routes.draw do
  
	get 'sessions/new'
	post 'sessions/create'
	get 'sessions/destroy'
	get 'sessions/login'
	get 'sessions/logout'
	get 'dashboard/show'
	get '/login' => 'sessions#new'
	get '/logout' => 'sessions#destroy'
	get 'market/show'
	get 'profile/view'
	get 'profile/edit'
	
	
	root to: 'sessions#new'

	resources :meetings

end

