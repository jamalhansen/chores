require 'test_helper'

class ChoreTest < ActiveSupport::TestCase
  test "description is required" do
    chore = Chore.new
    assert !chore.valid?
    chore.description = "Clean your room"
    assert chore.valid?
  end
  
  test "a description of 255 characters is valid" do
    chore = Chore.new :description => "This is a really long string that is the description of a chore and it is used to validate that the chore model will accept a string of 255 characters.  This string is longer than the longest string ever which also included some numbers 012345678901234567"
    assert chore.valid?
  end
  
  test "a description of 256 characters is invalid" do
    chore = Chore.new :description => "This is a really long string that is the description of a chore and it is used to validate that the chore model will accept a string of 255 characters.  This string is longer than the longest string ever which also included some numbers 0123456789012345678"
    assert !chore.valid?
  end
  
  test "validation message for description" do
    chore = Chore.new
    chore.valid?
    assert_equal "Description cannot be blank and must be less than 255 characters long.", chore.errors.on(:description)
  end
end
