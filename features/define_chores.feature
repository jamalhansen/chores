Story:  Define chores
As a parent
I want to define chores
So that I can assign them to my children

Scenario: Creating a chore
Given I am logged in as "test.example.com"
And I am on the homepage
When I follow "Add Chore"
And I fill in the chore with "My first chore"
And I press "Add"
Then I should see "Chore added."
And I should see "My first chore"
