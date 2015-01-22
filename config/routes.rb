Rails.application.routes.draw do
  	get 'sessions/new'

  	post 'sessions/create'

  	get 'sessions/destroy'

  	get 'sessions/login'

  	get 'sessions/logout'

	get 'dashboard/show'

	post 'dashboard/show'

	get '/login' => 'sessions#new'

	get '/logout' => 'sessions#destroy'
	
	root to: 'sessions#new'

	match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]

end
