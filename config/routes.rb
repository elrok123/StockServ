Rails.application.routes.draw do
  	get 'sessions/new'

  	post 'sessions/create'

  	get 'sessions/destroy'

  	get 'sessions/login'

  	get 'sessions/logout'

	get 'dashboard/show'

	get '/login' => 'sessions#new'
	
	root to: 'sessions#new'
end
