class UserMailer < ActionMailer::Base
    default from: "no-reply@entrepreserve.com"

    def welcome( user )
        @recipient = user
        subject = "Welcome to our site!"
        mail( to: user.email, from: "welcome@entrepreserve.com", subject: subject )
    end

    def password_reset( user )
        @recipient = user
        @link = change_password_user_url( user, token: user.password_reset_token )
        subject = "Password Reset"
        mail( to: user.email, from: "support@entrepreserve.com", subject: subject )
    end

    def contact_message( msg )
        contact_email = "contact@entrepreserve.com"
        subject = "Contact: " + msg.subject
        @message = msg
        mail( to: contact_email, subject: subject )
    end
end
