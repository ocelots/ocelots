Given /^I am not signed in$/ do

end

When /^I go to home page$/ do
  visit '/'
end

Then /^I should click login link$/ do
  #page.execute_script("$('#test_login').click();")
end

Then /^I see list of team$/ do
  #page.should have_content('team')
end
