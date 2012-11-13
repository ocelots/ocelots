class PersonMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def invite inviter, membership
    @inviter, @membership = inviter, membership
    mail to: @membership.email, subject: "You have been invited to join a #{membership.team_name}"
  end
end