module HomePage
  def login_as person
    visit "/teams?auth_token=#{person.auth_token}"
  end
end