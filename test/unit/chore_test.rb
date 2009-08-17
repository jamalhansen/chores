require 'test_helper'

class ChoreTest < ActiveSupport::TestCase

  context "validation" do

    should "that a description is required" do
      chore = Chore.new
      invalid chore
      chore.description = "Clean your room"
      valid chore
    end

    should "that a description of 255 characters is valid" do
      chore = Chore.new :description => two_hundred_fifty_character_string
      valid chore
    end

    should "that a description of 256 characters is invalid" do
      chore = Chore.new :description => two_hundred_fifty_one_character_string
      invalid chore
    end

    should "message for a null description" do
      chore = Chore.new
      validation_message_for chore, :description, "Description cannot be blank."
    end

    should "message for an overly long description" do
      chore = Chore.new :description => two_hundred_fifty_one_character_string
      validation_message_for chore, :description, "Description cannot be longer than 255 characters."
    end


  end
end