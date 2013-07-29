module SessionsHelper

	#Methods for redirecting users
	def signed_in_user
		auth_redirect unless signed_in?
	end

	def unsigned_in_user
		auth_redirect if signed_in?
	end
	
	def is_admin
		auth_redirect unless current_user.is_admin
	end

	def no_access
		auth_redirect
	end

	def auth_redirect
		flash[:error] = "Permission Denied"
		redirect_to root_path
	end

	###########################################################
	######### Methods for signing in, signing out, ############
	######### And tracking current user            ############
	###########################################################

	def sign_in( user )
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		self.current_user = nil
		cookies.delete( :remember_token )
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token( cookies[:remember_token] )
	end

	def current_user?(user)
		user == current_user
	end
end
