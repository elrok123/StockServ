
Rails.application.routes.draw do
  
  get 'users/new'

  get 'users/create'

  get 'users/edit'

  get 'users/destroy'

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
	post 'dashboard/show'
	get 'clients/show'
	post 'meetings/create'
	get "/calendar/show"
	post '/portfolios/add' => 'portfolios#add'
	post '/portfolios/sell' => 'portfolios#sell'
	post '/portfolios/:id' => 'portfolios#show'
	post '/clients/get_clients' => 'clients#get_clients'
	
	root to: 'sessions#new'

	resources :meetings
 	match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]
	resources :clients
	resources :users
	resources :portfolios
	resources :users

end