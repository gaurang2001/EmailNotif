class ApplicationMailer < ActionMailer::Base
  default from: "EmailNotif <#{ENV["gmail_username"]}>"
  layout 'mailer'
end
