require 'spec_helper'

describe "AuthenticationPages" do
	subject { page }
	before { visit root_path }

	describe "| Basic login" do
		let!(:user) { FactoryGirl.create(:user) }
	
		it "| Signin signout" do
			is_signed_out

			visit signin_path

			#click_button "signinPrime"
			#has_error
			is_signed_out

			fill_in "usernamePrime", with: user.username
			fill_in "passwordPrime", with: user.password
			click_button "signinPrime"

			has_no_error
			is_signed_in

			click_link "Sign Out"
			is_signed_out
		end

		#Test signin shortcut
		it "| Signin shortcut" do
			is_signed_out
			sign_in user
			is_signed_in
			sign_out
			is_signed_out
		end
	end

	before(:all) { DatabaseCleaner.strategy = :truncation }
	after(:all) { DatabaseCleaner.clean; Capybara.reset_sessions!; Capybara.use_default_driver }

end
