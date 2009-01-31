ActionController::Routing::Routes.draw do |map|
  map.resources :chores
  map.resources :children
  map.root :controller => 'home' 
end
