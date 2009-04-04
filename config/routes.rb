ActionController::Routing::Routes.draw do |map|
  map.resources :chores
  map.resources :children
  map.root :controller => 'home' 
 
  map.open_id_complete 'session', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.resource :session
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
end
