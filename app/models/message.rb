class Message
	include ActiveModel::Model
	include SharedMethods

	attr_accessor :name, :email, :subject, :body

	validates :name, :email, :subject, :body, :presence => true
	validate :email, :email_format

end
