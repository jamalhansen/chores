require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "test", "test_helper"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
include NavigationHelpers

When /^I fill in the chore with "(.*)"$/ do |chore_text|
  fill_in 'chore[description]', :with => chore_text
end

Given /^I am logged in as "(.*)"$/ do |identifier|
  post '/session', :openid_url => Identity.normalize_identifier(identifier)
end


