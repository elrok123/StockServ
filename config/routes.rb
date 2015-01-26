
Rails.application.routes.draw do
  
	get 'sessions/new'
	post 'sessions/create'
	get 'sessions/destroy'
	get 'sessions/login'
	get 'sessions/logout'
	get 'dashboard/show'
	get '/login' => 'sessions#new'
	get '/logout' => 'sessions#destroy'
<<<<<<< HEAD
<<<<<<< HEAD
	root to: 'sessions#new'		
	
	resources :meetings
end
=======
=======
	get 'market/show'
	get 'profile/view'
	get 'profile/edit'
	post 'dashboard/show'
	get 'clients/show'
	post 'meetings/create'
>>>>>>> master
	
	root to: 'sessions#new'

	resources :meetings
 	match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]
	resources :clients

end
>>>>>>> master
