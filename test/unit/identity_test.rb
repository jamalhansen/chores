require 'test_helper'

class IdentityShouldBeValidatedTest < ActiveSupport::TestCase
  specify "that an open ID is required on create" do
    identity = Identity.new
    invalid identity
    identity.open_id = "test.example.com"
    valid identity
  end
  
  specify "message for an overly long identifier" do
    identity = Identity.new :identifier => hundred_and_one_character_identifier
    validation_message_for identity, :identifier, "is too long."
  end
  
  specify "message for a null identifier" do
    identity = Identity.new
    validation_message_for identity, :identifier, "can not be blank."
  end
  
  specify "message for a poorly formatted" do
    identity = Identity.new :identifier => invalid_open_id
    validation_message_for identity, :identifier, "is not a valid Open ID."
  end
  
  specify "message for a duplicate identifier" do
    Identity.make :identifier => valid_identifier
    identity = Identity.new :identifier => valid_identifier
    validation_message_for identity, :identifier, "is already in use, please use another."
  end
  
  specify "that 100 character identifier is valid" do
    identity = Identity.new :identifier => hundred_character_identifier
    valid identity
  end
  
  specify "that identifier is unique" do
    Identity.make :identifier => valid_identifier
    identity = Identity.new :identifier =>  valid_identifier
    invalid identity
  end
  
  specify "that open_id must have the correct format" do
    identity = Identity.new
    identity.open_id = invalid_open_id
    invalid identity
  end
  
  specify "that open_id uniqueness extends to identifier when validated" do
    Identity.make  :identifier => valid_identifier
    identity = Identity.new :open_id => "test.example.com"
    invalid identity
  end

  protected
    def hundred_character_identifier
      "http://This.is.a.hundred.character.description.one.hundred.chatacters.is.not.too.long.but.it.of.com/"
    end
    
    def hundred_and_one_character_identifier
      "http://This.is.a.hundred1.character.description.one.hundred.chatacters.is.not.too.long.but.it.of.com/"
    end
       
    def invalid_open_id
      "bad_id"
    end
    
end

class IdentityOpenIdShouldSetIdentifierTest < ActiveSupport::TestCase
  specify "that open_id sets identifier" do
    identity = Identity.new
    assert_nil identity.identifier
    identity.open_id = "test.example.com"
    assert_not_nil identity.identifier
  end
  
  specify "that identifier sets open_id" do
    identity = Identity.new
    assert_nil identity.open_id
    identity.identifier = "http://test.example.com/"
    assert_not_nil identity.open_id
  end
  
  specify "that open_id is nicely formatted for display" do
    identity = Identity.new :identifier => "http://test.example.com/"
    assert_equal valid_open_id, identity.open_id
  end
end

class IdentityShouldBeImmutableTest < ActiveSupport::TestCase
  specify "that open_id is immutable" do
    identity = Identity.make
    assert_raise RuntimeError do
      identity.open_id = "monkey.example.com"
    end
  end

  specify "that identifier is immutable" do
    identity = Identity.make
    assert_raise RuntimeError do
      identity.identifier = "http://monkey.example.com/"
    end
  end
end

class IdentityShouldBeFoundByOpenID < ActiveSupport::TestCase
  specify "that open_id can be used to find a record" do
    identity = Identity.make :identifier => valid_identifier
    identity_from_db = Identity.find_by_open_id valid_open_id
    assert_equal identity.identifier, identity.identifier
  end
  
  specify "that display formatted open_id can be used to find a record" do
    identity = Identity.make :identifier => valid_identifier
    identity_from_db = Identity.find_by_open_id valid_identifier
    assert_equal identity.identifier, identity.identifier
  end
end
