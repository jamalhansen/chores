Story:  Define child
As a parent
I want to define my child(ren)
So that I can assign them chores

Scenario: Defining a child
Given I am on the homepage
When I follow "Add Child"
And I fill in "child[nickname]" with "Bobby"
And I fill in "child[open_identifier]" with "bobby.example.com"
And I press Add
Then I should see "Child added."
And I should see "Bobby"

Scenario: Defining a second child
Given I am on the homepage
When I follow "Add Child"
And I fill in "child[nickname]" with "Bobby"
And I fill in "child[open_identifier]" with "bobby.example.com"
And I press Add
And I follow "Add another Child"
And I fill in "child[nickname]" with "Suzy"
And I fill in "child[open_identifier]" with "suzy.example.com"
And I press Add
Then I should see "Child added."
And I should see "Bobby"
And I should see "Suzy"
