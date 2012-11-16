Given /^I am not signed in$/ do

end

When /^I go to home page$/ do
  visit '/'
end

Then /^I should click login link$/ do
  page.execute_script("window.location.href='/test_login'")
end

Then /^I see list of team$/ do
  page.should have_content('team')
end

Then /^I should add a team$/ do
  click_link('add team')
  fill_in 'Team Name', :with => 'Test_team'
  fill_in 'URL', :with => 'Test_URL'
  click_button 'Create'
end

Then /^I should quit that team$/ do
  click_button 'Quit Team'
end
