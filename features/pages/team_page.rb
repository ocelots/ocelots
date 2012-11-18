module TeamPage
  def self.on?
    Capybara.current_session.find 'a.brand'
  end
end