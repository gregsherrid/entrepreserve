class ContactController < ApplicationController
	def new
		@message = Message.new
	end

	def create
		@message = Message.new( params[:message] )
		if @message.valid?
			UserMailer.contact_message(@message).deliver
			flash[:notice] = "Message sent!"
			redirect_to root_path
		else
			render :new
		end
	end
end
