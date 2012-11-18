Given /^I am an existing user$/ do
  @person = Person.create_for_email 'test@gmail.com'
end

When /^I login$/ do
  on(HomePage).login_as @person
end

Then /^I see list of teams$/ do
  should be_on TeamPage
end