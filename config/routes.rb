Rails.application.routes.draw do
<<<<<<< HEAD
  

  get 'users/new'
=======
  	get 'sessions/new'
>>>>>>> master

  	post 'sessions/create'

  	get 'sessions/destroy'

  	get 'sessions/login'

  	get 'sessions/logout'

	get 'dashboard/show'

	get '/login' => 'sessions#new'

	get '/logout' => 'sessions#destroy'
	
<<<<<<< HEAD
	root to: 'dashboard#show'

  resources :meetings

=======
	root to: 'sessions#new'
>>>>>>> master
end
