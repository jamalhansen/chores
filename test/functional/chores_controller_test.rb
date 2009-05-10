require 'test_helper'

class ChoresCanCrud < ActionController::TestCase
  tests ChoresController
  
  def setup
    @identity = Identity.make
  end

  specify "that it should respond to index" do
    get :index, nil, build_session_hash_for(@identity)
    assert_response :success
    assert_not_nil assigns(:chores)
  end

  specify "that it should pass chore on new" do
    get :new, nil, build_session_hash_for(@identity)
    assert_response :success
    assert_not_nil assigns(:chore)
  end

  specify "that it should create chore" do
    assert_difference 'Chore.count' do
      post :create, {:chore => { :description => 'My Chore' }}, build_session_hash_for(@identity)
    end

    assert_redirected_to chores_url
  end

  specify "that it will destroy a chore, muahahahahaha" do
    chore = Chore.make
    assert_difference 'Chore.count', -1 do
      delete :destroy, {:id => chore.id}, build_session_hash_for(@identity)
    end
    assert_redirected_to chores_url
  end
  
    
  specify "that it should send a message that chore was created" do
    post :create, {:chore => { :description => 'My Chore' }}, build_session_hash_for(@identity)
    assert_equal "Chore added.", flash[:message]
  end
  
  specify "that it should send a message that chore creation failed" do
    post :create, {:chore => { :description => nil }}, build_session_hash_for(@identity)
    assert_equal "Error saving Chore.", flash[:error]
  end
  
end


