ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require File.expand_path(File.dirname(__FILE__) + "/blueprints")
require 'test_help'
require 'faker'

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
    
end

def specify *args, &block
  test(*args, &block)
end

