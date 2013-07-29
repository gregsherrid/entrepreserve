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

		describe "| Email" do
			it "| Format" do
				addresses = %w[richie user@foo,com user_at_foo.org example.user@foot.
						   	   foo@bar_baz.com foo@bar+baz.com]
				addresses.each do |invalid_address|
					user.email = invalid_address
					user.should_not be_valid
				end
			end

			it "| Unique" do
				expect do
					FactoryGirl.create( :user, email: user.email )
				end.to raise_error
			end

			it "| Case insensitive" do
				mixed_case_email = "Foo@eXAmple.CoM"
				user.email = mixed_case_email
				user.save
				user.reload.email.should == mixed_case_email.downcase
			end
		end

		describe "| Password" do
			it "| mismatch" do
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

			it "| Length" do
				user.password = "a"*5
				user.password_confirmation = user.password
				should_not be_valid
				user.password = "a"*6
				user.password_confirmation = user.password
				should be_valid
			end
		end

		it "| First and last names are valid" do
			user.first_name = ""
			should_not be_valid
			user.first_name = "a"*100
			should_not be_valid
			user.first_name = "Frank"
			should be_valid

			user.last_name = ""
			should_not be_valid
			user.last_name = "a"*100
			should_not be_valid
			user.last_name = "Merkle"
			should be_valid
		end

		describe "| Username" do

			it "| Case insensitive" do
				user2 = FactoryGirl.create( :user, username: "UpperName" )
				User.find_by( username: "uppername" ).should == user2
			end

			it "| Has valid format" do
				user.username = ""
				should_not be_valid
				user.username = "v"*51
				should_not be_valid
				user.username = "Merkle4"
				should be_valid
			end

			it "| Unique" do 
				user_with_same = user.dup
				user_with_same.username = user.username.upcase

				user_with_same.should_not be_valid
			
				user_with_same.username == user.username + "X"
				should be_valid
			end
		end

	end

	before(:all) { DatabaseCleaner.strategy = :truncation }
	after(:all) { DatabaseCleaner.clean; Capybara.reset_sessions!; Capybara.use_default_driver }

end
