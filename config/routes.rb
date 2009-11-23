ActionController::Routing::Routes.draw do |map|
  map.resources :systems

	map.login "login", :controller => 'user_sessions', :action => 'new'
	map.logout "logout", :controller => 'user_sessions', :action => 'destroy'
	map.resources :user_sessions
	map.resources :users
	map.resources :home
	map.resources :systems
	map.root :controller => 'home', :action => 'index'
end
