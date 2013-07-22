# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  username   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do

	describe "Basics" do
		let(:user) { FactoryGirl.create(:user) }
		subject { user }

		it "Responds" do
			should respond_to( :first_name )
			should respond_to( :last_name )
			should respond_to( :full_name )
			should respond_to( :username )
			should respond_to( :email )

			should respond_to( :password_digest )
			should respond_to( :password )
			should respond_to( :password_confirmation )
		end

		it { should be_valid }

		it "| Attribute presence" do
			must_be_present( user, "first_name" )
			must_be_present( user, "last_name" )
			must_be_present( user, "username" )
			must_be_present( user, "email" )
		end

		it "| Email format" do
			addresses = %w[richie user@foo,com user_at_foo.org example.user@foot.
					   	   foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				user.email = invalid_address
				user.should_not be_valid
			end
		end

		it "| Password mismatch" do
			user.password_confirmation = "nottrue"
			should_not be_valid
			user.password_confirmation = user.password
			should be_valid
		end
		it "| Password/Confirmation is valid" do
			expect do
				FactoryGirl.create( :user, password: "foobar1", 
										   password_confirmation: "" )
			end.to raise_error

			expect do
				FactoryGirl.create( :user, password: nil, 
										   password_confirmation: "foobar1" )
			end.to raise_error
		end

		it "| Password length" do
			user.password = "a"*5
			user.password_confirmation = user.password
			should_not be_valid
			user.password = "a"*6
			user.password_confirmation = user.password
			should be_valid
		end
	end
end
