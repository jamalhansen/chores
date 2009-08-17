require 'test_helper'

class ChildTest < ActiveSupport::TestCase
  context "validation" do

    should "that a parent is required" do
      child = Child.new
      child.open_identifier = valid_open_id
      invalid child
      child.parent = Identity.make
      valid child
    end

    should "that a child is required" do
      child = Child.new :parent => Identity.make
      invalid child
      child.open_identifier = valid_open_id
      valid child
    end

    should "message for a null identity" do
      child = Child.new :parent => Identity.make
      validation_message_for child, :open_identifier, "can not be blank."
    end

    should "message for a null parent" do
      child = Child.new :identity => Identity.make
      validation_message_for child, :parent, "can not be blank."
    end
  end

  context "creating identity" do

    should "that open_identifier is used to pass the OpenId" do
      child = Child.new :parent => Identity.make
      child.open_identifier = valid_open_id
      assert child.save
    end
  end

end