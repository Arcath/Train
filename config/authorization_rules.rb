authorization do
	role :guest do
		has_permission_on :home, :to => [:index]
		has_permission_on :user_sessions, :to => [:new, :create]
		has_permission_on :users, :to => [:new, :create]
	end
	role :admin do
		has_permission_on :home, :to => [:index]
		has_permission_on :user_sessions, :to => [:destroy]
		has_permission_on :users, :to => [:edit, :update, :destroy]
	end
	role :member do
		has_permission_on :home, :to => [:index]
		has_permission_on :user_sessions, :to => [:destroy]
		has_permission_on :users, :to => [:edit, :update] do
			if_attribute :id => is { user.id }
		end
	end
end
