Rails.application.routes.draw do
	get 'dashboard/show'
	
	root to: => 'Dashboard#show'

end
