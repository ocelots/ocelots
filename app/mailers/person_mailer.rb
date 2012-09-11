class PersonMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def invite inviter, membership
    @inviter, @membership = inviter, membership
    mail to: @membership.person.email, subject: "You have been invited to join a #{membership.team.name}"
  end
end