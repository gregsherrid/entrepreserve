class SessionsController < ApplicationController

	prepend_before_action :unsigned_in_user,
		only: [ :new, :create ]

	def new
	end
	
	def create
		user = User.find_by( username: params[:username].downcase )

		if user && user.authenticate( params[:password] )
			sign_in user
			redirect_to user
		else
			flash.now[:error] = 'Invalid username/password'
			render "new"
		end
	end
	
	def destroy
		sign_out
		redirect_to root_url
	end

	def password_reset
		sign_out
	end

	def request_reset
		sign_out

		user = User.find_by( email: params[:email] )
		user.prep_password_reset unless user.nil?

		flash[:notice] = "Email sent with password reset instructions."
		redirect_to root_path
	end
	
end
