Rails.application.routes.draw do
  
  get 'calendar/view'

  get 'financial_advisors/new'

  get 'financial_advisors/create'

  get 'financial_advisors/destroy'

  get 'financial_advisors/edit'

  get 'financial_advisors/view'

  get 'profile/view'

  get 'profile/edit'

  get 'market/show'

	get 'sessions/new'
	post 'sessions/create'
	get 'sessions/destroy'
	get 'sessions/login'
	get 'sessions/logout'
	get 'dashboard/show'
	get '/login' => 'sessions#new'
	get '/logout' => 'sessions#destroy'
	
	root to: 'sessions#new'

	resources :meetings
  	get 'market/show'

  	get 'market/search'

  	get 'market/show'

  	get 'market/search'

	get 'profile/view'
	get 'profile/edit'
	get 'profile/delete'
end
