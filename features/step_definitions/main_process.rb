Given /^I am an existing user$/ do
  @person = Person.create_for_email 'test@gmail.com'
end

When /^I login$/ do
  visit "/teams?auth_token=#{@person.auth_token}"
end

Then /^I see list of teams$/ do
  should be_on TeamPage
end