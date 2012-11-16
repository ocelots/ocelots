Feature: Main process of Ocelots
  AS A normal user
  I WANT TO use main functionality of Ocelots
  SO THAT I can know my team members better

Scenario: Go to home page
  Given I am not signed in
  When I go to home page
  Then I should click login link
  Then I see list of team
  Then I should add a team
  Then I should quit that team
