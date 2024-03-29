# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  first_name           :string(255)
#  last_name            :string(255)
#  email                :string(255)
#  username             :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  password_digest      :string(255)
#  remember_token       :string(255)
#  password_reset_token :string(255)
#  password_reset_at    :datetime
#  is_admin             :boolean
#

class User < ActiveRecord::Base
	include SharedMethods
	
	has_secure_password

	before_save do
		username.downcase! unless username.nil?
		email.downcase! unless email.nil?
		is_admin = !!is_admin
		generate_token(:remember_token)
	end

	has_many :trees, foreign_key: "owner_id"

	def full_name
		first_name + " " + last_name
	end

	def prep_password_reset
		generate_token(:password_reset_token)
		self.password_reset_at = Time.zone.now
		save
		UserMailer.password_reset( self ).deliver
	end

	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	validates :username, presence: true, 
		length: { maximum: 50 }, uniqueness: { case_sensitive: false }

	validates :email, uniqueness: { case_sensitive: false }
	validate :email, :email_format

	validates_length_of :password, :minimum => 6, :maximum => 100, :allow_blank => true

	private

		def generate_token(column)
			begin
				self[column] = SecureRandom.urlsafe_base64
			end while User.exists?(column => self[column])
		end
end
