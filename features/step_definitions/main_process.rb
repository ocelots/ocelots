Given /^I am an existing user$/ do
  @person = Person.create_for_email 'test@gmail.com'
end

When /^I login$/ do
  on(HomePage).login_as @person
end

Then /^I see list of teams$/ do
  should be_on TeamPage
end

Then /^I should create a team$/ do
  click_link 'add team'
  fill_in 'Team Name', with: 'Test_team'
  fill_in 'URL', with: 'Test_URL'
  click_button 'Create'
end

Then /^I should quit that team$/ do
  click_button 'Quit Team'
end

Then /^I should join that team again$/ do
  visit '/teams/Test_URL'
  click_button 'Join Team'
end