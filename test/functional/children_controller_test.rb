
class ChildrenCanCrud < ActionController::TestCase
  tests ChildrenController
  
  specify "test that it should respond to index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:children)
  end

  specify "that it should pass child on new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:child)
  end

  specify "that it should create child" do
    assert_difference 'Child.count' do
      post :create, :child => { :parent => Identity.make, :identity => Identity.make }
    end

    assert_redirected_to children_url
  end
  
end

