Rails.application.routes.draw do
  	get 'sessions/login'

  	get 'sessions/logout'

	get 'dashboard/show'
	
	root to: 'sessions#login'
end
