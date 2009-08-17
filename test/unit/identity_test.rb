require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
  context "validation" do
    should "that an open ID is required on create" do
      identity = Identity.new
      invalid identity
      identity.open_id = "test.example.com"
      valid identity
    end

    should "message for an overly long identifier" do
      identity = Identity.new :identifier => hundred_and_one_character_identifier
      validation_message_for identity, :identifier, "is too long."
    end

    should "message for a null identifier" do
      identity = Identity.new
      validation_message_for identity, :identifier, "can not be blank."
    end

    should "message for a poorly formatted" do
      identity = Identity.new :identifier => invalid_open_id
      validation_message_for identity, :identifier, "is not a valid Open ID."
    end

    should "message for a duplicate identifier" do
      Identity.make :identifier => valid_identifier
      identity = Identity.new :identifier => valid_identifier
      validation_message_for identity, :identifier, "is already in use, please use another."
    end

    should "that 100 character identifier is valid" do
      identity = Identity.new :identifier => hundred_character_identifier
      valid identity
    end

    should "that identifier is unique" do
      Identity.make :identifier => valid_identifier
      identity = Identity.new :identifier =>  valid_identifier
      invalid identity
    end

    should "that open_id must have the correct format" do
      identity = Identity.new
      identity.open_id = invalid_open_id
      invalid identity
    end

    should "that open_id uniqueness extends to identifier when validated" do
      Identity.make  :identifier => valid_identifier
      identity = Identity.new :open_id => "test.example.com"
      invalid identity
    end


  end

  context "setting idenitifier" do
    should "that open_id sets identifier" do
      identity = Identity.new
      assert_nil identity.identifier
      identity.open_id = "test.example.com"
      assert_not_nil identity.identifier
    end

    should "that identifier sets open_id" do
      identity = Identity.new
      assert_nil identity.open_id
      identity.identifier = "http://test.example.com/"
      assert_not_nil identity.open_id
    end

    should "that open_id is nicely formatted for display" do
      identity = Identity.new :identifier => "http://test.example.com/"
      assert_equal valid_open_id, identity.open_id
    end
  end

  context "imutability" do
    should "that open_id is immutable" do
      identity = Identity.make
      assert_raise RuntimeError do
        identity.open_id = "monkey.example.com"
      end
    end

    should "that identifier is immutable" do
      identity = Identity.make
      assert_raise RuntimeError do
        identity.identifier = "http://monkey.example.com/"
      end
    end
  end

  context "finding by openId" do
    should "that open_id can be used to find a record" do
      identity = Identity.make :identifier => valid_identifier
      identity_from_db = Identity.find_by_open_id valid_open_id
      assert_not_nil identity_from_db
      assert_equal identity.identifier, identity_from_db.identifier
    end

    should "that display formatted open_id can be used to find a record" do
      identity = Identity.make :identifier => valid_identifier
      identity_from_db = Identity.find_by_open_id valid_identifier
      assert_not_nil identity_from_db
      assert_equal identity.identifier, identity_from_db.identifier
    end

    should "that find_or_make_if_valid will return the existing value" do
      oid = Identity.make :identifier => valid_open_id
      oid_from_db = Identity.find_or_make_if_valid valid_open_id
      assert_equal oid.open_id, oid_from_db.open_id
    end

    should "that find_or_make_if_valid will create a new identity if none exists" do
      oid = Identity.find_or_make_if_valid valid_open_id
      assert_equal valid_open_id, oid.open_id
    end

    should "that find_or_make_if_valid will return nil is the identifier is not valid" do
      assert_nil Identity.find_or_make_if_valid invalid_open_id
    end
  end
end

