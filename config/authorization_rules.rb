authorization do
	role :guest do
		has_permission_on :home, :to => [:index]
		has_permission_on :user_sessions, :to => [:new, :create]
		has_permission_on :users, :to => [:index, :show, :new, :create]
		has_permission_on :navigations, :to => [:permalink]
		has_permission_on :forums, :to => [:index]
		has_permission_on :forums, :to => [:show] do
			if_attribute :canviews => contains { user.role_symbols.to_s }
		end
		has_permission_on :topics, :to => [:show]
		has_permission_on :topics, :to => [:new,:create] do
			if_attribute :forum => { :cantopics => contains { user.role_symbols.to_s } }
		end
		has_permission_on :planets, :to => [:index]
		has_permission_on :pages, :to => [:show]
	end
	role :admin do
		has_permission_on :home, :to => [:index]
		has_permission_on :user_sessions, :to => [:destroy]
		has_permission_on :users, :to => [:index, :show, :edit, :update, :destroy]
		has_permission_on :systems, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
		has_permission_on :navigations, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :permalink]
		has_permission_on :acp, :to => [:index]
		has_permission_on :forums, :to => [:index, :new, :create, :edit, :update, :destroy]
		has_permission_on :forums, :to => [:show] do
			if_attribute :canviews => contains { user.role }
		end
		has_permission_on :topics, :to => [:show]
		has_permission_on :topics, :to => [:new, :create] do
			if_attribute :topicable => is { user.topicable }
		end
		has_permission_on :posts, :to => [:new, :create] do
			if_attribute :postable => is { user.postable }
		end
		has_permission_on :posts, :to => [:edit, :update, :destroy] do
			if_attribute :forum => { :canmoderates => contains { user.role } }
		end
		has_permission_on :planet_feeds, :to => [:index, :show, :new, :create, :edit, :update]
		has_permission_on :planets, :to => [:index]
		has_permission_on :pages, :to => [:index, :show, :edit, :new, :create, :update, :destroy]
		has_permission_on :messages, :to => [:index, :show, :edit, :new, :create, :update, :destroy]
		has_permission_on :templates, :to => [:index, :show, :edit, :new, :create, :update, :destroy]
	end
	role :member do
		has_permission_on :home, :to => [:index]
		has_permission_on :navigations, :to => [:permalink]
		has_permission_on :user_sessions, :to => [:destroy]
		has_permission_on :users, :to => [:index, :show, :edit, :update] do
			if_attribute :id => is { user.id }
		end
		has_permission_on :forums, :to => [:index,:show]
		has_permission_on :topics, :to => [:show]
		has_permission_on :topics, :to => [:new, :create] do
			if_attribute :topicable => is { user.topicable }
		end
		has_permission_on :posts, :to => [:new, :create] do
			if_attribute :postable => is { user.postable }
		end
		has_permission_on :planets, :to => [:index]
		has_permission_on :pages, :to => [:show]
		has_permission_on :messages, :to => [:index, :show, :edit, :new, :create, :update, :destroy]
	end
	role :moderator do
		includes :member
		has_permission_on :acp, :to => [:index]
		has_permission_on :users, :to => [:index, :show]
		has_permission_on :users, :to => [:index, :show, :edit, :update] do
			if_attribute :role => is_not { User::ROLES[0] }
		end
	end
end
