require 'test_helper'

class ChoreShouldBeValidated < ActiveSupport::TestCase
  
  specify "that a description is required" do
    chore = Chore.new
    invalid chore
    chore.description = "Clean your room"
    valid chore
  end
  
  specify "that a description of 255 characters is valid" do
    chore = Chore.new :description => max_description
    valid chore
  end
  
  specify "that a description of 256 characters is invalid" do
    chore = Chore.new :description => overly_long_description
    invalid chore
  end
  
  specify "message for a null description" do
    chore = Chore.new
    validation_message_for chore, :description, "Description cannot be blank."
  end
  
  specify "message for an overly long description" do
    chore = Chore.new :description => overly_long_description
    validation_message_for chore, :description, "Description cannot be longer than 255 characters."
  end
  
  protected
    def max_description
      "This is a really long string that is the description of a chore and it is used to validate that the chore model will accept a string of 255 characters.  This string is longer than the longest string ever which also included some numbers 012345678901234567"
    end
    
    def overly_long_description
      max_description + "8"
    end
    
    def invalid model
      assert !model.valid?
    end
    
    def valid model
      assert model.valid?
    end
    
    def validation_message_for model, column, message
      invalid model
      assert_equal message, model.errors.on(column)
    end
end
