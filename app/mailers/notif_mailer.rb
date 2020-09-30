class NotifMailer < ApplicationMailer

  # Notify all users
  def notification(emails, content)
    @body = content[:body]
    emails.each do |email|
      mail(to: email, subject: content[:subject], reply_to: "donotreply@gmail.com")
    end
  end

end
