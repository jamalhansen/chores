require 'test_helper'

class ChoresCanCrud < ActionController::TestCase
  tests ChoresController
  
  specify "test that it should respond to index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chores)
  end

  specify "that it should pass chore on new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:chore)
  end

  specify "that it should create chore" do
    assert_difference 'Chore.count' do
      post :create, :chore => { :description => 'My Chore' }
    end

    assert_redirected_to chores_url
  end

  specify "that it will destroy a chore, muahahahahaha" do
    chore = Chore.make
    assert_difference 'Chore.count', -1 do
      delete :destroy, :id => chore.id
    end
    assert_redirected_to chores_url
  end
  
    
  specify "that it should send a message that chore was created" do
    post :create, :chore => { :description => 'My Chore' }
    assert_equal "Chore added.", flash[:message]
  end
  
  specify "that it should send a message that chore creation failed" do
    post :create, :chore => { :description => nil }
    assert_equal "Error saving Chore.", flash[:error]
  end
  
end


