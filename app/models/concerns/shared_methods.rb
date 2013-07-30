module SharedMethods

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\s\-.]+\.[a-z]+\z/i.freeze
	def email_format
		if ( EMAIL_REGEX =~ email ) != 0
			errors.add(:email, "format is invalid" )
		end
	end

end