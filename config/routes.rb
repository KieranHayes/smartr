ActionController::Routing::Routes.draw do |map|
  
  map.connect "questions/hot/:page", :controller => :questions, :action => :index_for_hot, :page => nil
  map.connect "questions/active/:page", :controller => :questions, :action => :index_for_active, :page => nil
  map.connect "questions/unanswered/:page", :controller => :questions, :action => :index_for_unanswered, :page => nil
  map.connect "questions/page/:page", :controller => :questions, :action => :index
  
  map.resources :questions, :member => {:update_for_toggle_acceptance => :put} do |question|
    question.resources :answers
  end
  
  map.resources :comments
  map.resources :tags
  map.connect "questions/tagged/:tag", :controller => :questions, :action => :index
  map.resources :votes
  map.resources :users, :collection => {:who_is_online => :get, :search => :get}
  map.resource :user_session
  map.resources :favourites
  map.root :controller => "questions", :action => "index"
  
end
