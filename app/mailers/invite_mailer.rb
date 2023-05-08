class InviteMailer < ApplicationMailer
  def invite_email(email, token, doctor_name)
    @token = token
    @doctor_name = doctor_name
    mail(to: email, subject: "You've been invited to join a team")
  end
end
