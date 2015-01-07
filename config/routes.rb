Rails.application.routes.draw do
  get 'users/new'

  get 'users/create'

  get 'users/login'

  get 'users/logout'

  get 'sessions/login'

  get 'sessions/logout'

	get 'dashboard/show'
	
	root to: 'dashboard#show'
end
