class UserMailer < ActionMailer::Base
    default from: "no-reply@example.com"

    def welcome( user )
        @recipient = user
        subject = "Welcome to our site!"
        mail( to: user.email, from: "welcome@example.com", subject: subject )
    end

    def password_reset( user )
        @recipient = user
        @link = change_password_user_url( user, token: user.password_reset_token )
        subject = "Password Reset"
        mail( to: user.email, from: "support@example.com", subject: subject )
    end
end
