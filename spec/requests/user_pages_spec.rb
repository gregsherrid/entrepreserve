require 'spec_helper'

describe "UserPages" do

	subject { page }

	it "| Signup" do
		first_name = "Geory"
		last_name = "Sherkof"
		username = "gsherk1"
		email = "gsherkof@example.com"
		password = "foobar1"

		visit new_user_path

		click_button "Create Account"
		has_error
		is_signed_out
		user = User.find_by username: username
		user.should be_nil

		fill_in "First name", with: first_name
		fill_in "Last name", with: last_name
		fill_in "Username", with: username
		fill_in "Email", with: email
		fill_in "Password", with: password
		fill_in "Password confirmation", with: password

		click_button "Create Account"
		has_no_error
		is_signed_in

		user = User.find_by username: username
		user.should_not be_nil
		user.full_name.should == first_name + " " + last_name
		user.authenticate("fakePw").should == false
		user.authenticate(password).should == user
	end

	describe "| User pages" do
		let!(:user) { FactoryGirl.create(:user) }

		it "| Profile page" do
			visit user_path( user )
			should have_content user.username
		end

		it "| Editing" do
			other_user = FactoryGirl.create(:user )

			visit edit_user_path( user )
			fill_in "Username", with: other_user.username
			click_button "Submit Changes"
			has_error

			user.reload.username.should_not == other_user.username
			fill_in "Username", with: other_user.username + "est"
			click_button "Submit"			
			has_no_error
			user.reload.username.should == other_user.username + "est"
		end
	end

	before(:all) { DatabaseCleaner.strategy = :truncation }
	after(:all) { DatabaseCleaner.clean; Capybara.reset_sessions!; Capybara.use_default_driver }
end
