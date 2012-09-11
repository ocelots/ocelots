class PersonMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def invite person, team
    mail to: person.email, subject: "You have been invited to join a team"
  end
end