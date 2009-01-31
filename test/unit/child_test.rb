require 'test_helper'

class ChildShouldBeValidated < ActiveSupport::TestCase
  
  specify "that a parent is required" do
    child = Child.new :identity => Identity.make
    invalid child
    child.parent = Identity.make
    valid child
  end
  
  specify "that a child is required" do
    child = Child.new :parent => Identity.make
    invalid child
    child.identity = Identity.make 
    valid child
  end
  
  specify "message for a null identity" do
    child = Child.new :parent => Identity.make
    validation_message_for child, :identity, "can not be blank."
  end
  
  specify "message for a null parent" do
    child = Child.new :identity => Identity.make
    validation_message_for child, :parent, "can not be blank."
  end
end
