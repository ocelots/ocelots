Feature: Main process of Ocelots
  As a user
  I want to use the main functionality of ocelots
  So that I can know my team members better

Scenario: Go to home page
  Given I am an existing user
  When I login
  Then I see list of teams
  Then I should create a team
  Then I should quit that team
  Then I should join that team again