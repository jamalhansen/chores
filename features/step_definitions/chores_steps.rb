Given /^I am on the homepage$/ do
  visits '/'
end

When /^I fill in the chore with "(.*)"$/ do |chore_text|
  fills_in 'chore[name]', :with => chore_text 
end

When /^I press Add$/ do
  clicks_button
end


