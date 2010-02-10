ActionController::Routing::Routes.draw do |map|
  map.resources :templates

	#Special Mappings
	map.login "login", :controller => 'user_sessions', :action => 'new'
	map.logout "logout", :controller => 'user_sessions', :action => 'destroy'
	#Most Special Mappings should be handled by the PermaLink function in navigation
	#PermaLinks
	map.permalink "permalink/:permalink", :controller => 'navigations', :action => 'permalink'
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
	map.resources :planet_feeds
	map.resources :planets
	map.resources :pages
	map.resources :messages
	map.resources :tbbce
	#Home Page
	map.root :controller => 'home', :action => 'index'
end
