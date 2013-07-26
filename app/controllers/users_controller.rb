class UsersController < ApplicationController

	prepend_before_action :require_user,
		except: [:new, :create, :index]

	def show
	end

	def index

	end
	
	def new
		@user = User.new
	end
	
	def create
		@user = User.new( user_params )
		if @user.save
			sign_in @user
			redirect_to @user
		else
			render "new"
		end
	end
	
	def destroy

	end

	def edit
	end

	def update
		if @user.update_attributes( user_params )
			sign_in @user
			redirect_to @user
		else
			render "edit"
		end	
	end

	private

		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :username,
										 :password, :password_confirmation )
		end	

		def require_user
			@user = User.find( params[:id] )
		end
end
