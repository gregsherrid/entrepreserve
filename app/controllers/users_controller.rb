class UsersController < ApplicationController

	prepend_before_action :require_user,
		except: [:new, :create, :index]

	prepend_before_action :signed_in_user,
		except: [:new, :create ]

	prepend_before_action :unsigned_in_user,
		only: [ :new, :create ]

	before_action :is_current_user,
		only: [ :edit, :update, :change_password, :update_password ]

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

	def change_password
	end

	def update_password
		can_change = true
		if @user.authenticate( params[:old_password] ) != @user
			flash.now[:error] = "Existing password is incorrect"
			can_change = false
		elsif params[:new_password].blank?
			#Will overwrite past option
			flash.now[:error] = "New password may not be blank"
			can_change = false
		end

		@user.password = params[:new_password]
		@user.password_confirmation = params[:repeat_new_password]
			
		if !@user.valid?
			can_change = false
		end

		if can_change
			@user.save
			flash[:notice] = "Password Changed!"
			render 'show'
		else
			render 'change_password'
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

		def is_current_user
			redirect_to root_path unless @user == current_user
		end

end
