ActionController::Routing::Routes.draw do |map|
  map.resources :chores
  map.root :controller => 'home' 
end
