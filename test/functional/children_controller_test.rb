require 'test_helper'

class ChildrenCanCrud < ActionController::TestCase
  tests ChildrenController

  def setup
    @identity = Identity.make
  end
  
  specify "test that it should respond to index" do
    get :index, nil, build_session_hash_for(@identity)
    assert_response :success
    assert_not_nil assigns(:children)
  end

  specify "that it should pass child on new" do
    get :new, nil, build_session_hash_for(@identity)
    assert_response :success
    assert_not_nil assigns(:child)
  end

  specify "that it should create child" do
    assert_difference 'Child.count' do
      post :create, {:child => { :open_identifier => "cheese.example.com" }}, build_session_hash_for(@identity)
    end

    assert_redirected_to children_url
  end
  
end

