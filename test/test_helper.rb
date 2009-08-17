ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require File.expand_path(File.dirname(__FILE__) + "/blueprints")
require 'test_help'
require 'faker'
require 'machinist'
require 'shoulda'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

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
  
  def valid_identifier
    "http://test.example.com/"
  end

  def build_session_hash_for identity
    @session_hash = {'identity_id' => identity.id}
  end
  
  def valid_open_id
    "test.example.com"
  end
  
  def invalid_open_id
    "bad_id"
  end


      def hundred_character_identifier
        "http://This.is.a.hundred.character.description.one.hundred.chatacters.is.not.too.long.but.it.of.com/"
      end

      def hundred_and_one_character_identifier
        "http://This.is.a.hundred1.character.description.one.hundred.chatacters.is.not.too.long.but.it.of.com/"
      end

  def two_hundred_fifty_character_string
    "This is a really long string that is the description of a chore and it is used to validate that the chore model will accept a string of 255 characters.  This string is longer than the longest string ever which also included some numbers 012345678901234567"
  end

  def two_hundred_fifty_one_character_string
    two_hundred_fifty_character_string + "1"
  end
    
end

