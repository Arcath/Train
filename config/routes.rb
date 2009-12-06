ActionController::Routing::Routes.draw do |map|
	#Special Mappings
	map.login "login", :controller => 'user_sessions', :action => 'new'
	map.logout "logout", :controller => 'user_sessions', :action => 'destroy'
	#Most Special Mappings should be handled by the PermaLink function in navigation
	#Resources
	map.resources :user_sessions
	map.resources :users
	map.resources :home
	map.resources :systems
	map.resources :navigations
	map.resources :acp
	map.resources :forums
	map.resources :topics
	map.resources :posts
	#PermaLinks
	map.permalink "permalink/:permalink", :controller => 'navigations', :action => 'permalink'
	#Home Page
	map.root :controller => 'home', :action => 'index'
end
