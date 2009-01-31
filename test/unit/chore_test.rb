require 'test_helper'

class ChoreShouldBeValidated < ActiveSupport::TestCase
  
  specify "that a description is required" do
    chore = Chore.new
    invalid chore
    chore.description = "Clean your room"
    valid chore
  end
  
  specify "that a description of 255 characters is valid" do
    chore = Chore.new :description => two_hundred_fifty_character_string
    valid chore
  end
  
  specify "that a description of 256 characters is invalid" do
    chore = Chore.new :description => two_hundred_fifty_one_character_string
    invalid chore
  end
  
  specify "message for a null description" do
    chore = Chore.new
    validation_message_for chore, :description, "Description cannot be blank."
  end
  
  specify "message for an overly long description" do
    chore = Chore.new :description => two_hundred_fifty_one_character_string
    validation_message_for chore, :description, "Description cannot be longer than 255 characters."
  end
  
  protected
    def two_hundred_fifty_character_string
      "This is a really long string that is the description of a chore and it is used to validate that the chore model will accept a string of 255 characters.  This string is longer than the longest string ever which also included some numbers 012345678901234567"
    end
    
    def two_hundred_fifty_one_character_string
      two_hundred_fifty_character_string + "1"
    end
end
