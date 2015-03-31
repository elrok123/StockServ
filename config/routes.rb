
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
	post 'market/show'
	get 'profile/view'
	get 'profile/edit'
	post 'dashboard/show'
	get 'clients/show'
	post 'meetings/create'
	get "/calendar/show"
	
	root to: 'sessions#new'

	resources :meetings
 	match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]
	resources :clients
	resources :portfolios

end