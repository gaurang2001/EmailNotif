class NotifMailer < ApplicationMailer

  # Notify a given user
  def notification(user, content, admin)
    @body = content[:body]
    mail(
        to: user.email,
        subject: content[:subject],
        reply_to: "donotreply@gmail.com"
    ) do |format|
      format.html { render 'notif_mailer/notification', locals: { user: user, admin: admin } }
    end
  end
end
