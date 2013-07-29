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

			fill_in "emailPrime", with: user.email
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

	describe "| Net" do
		let(:user1) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user) }

		def base_restrictions( c_user )

			#No one can do these

			#All users can do this

			#signed-out users only
			user_is_signed_out = c_user.nil?
			can_view 		new_user_path,		user_is_signed_out
			can_create 		users_path,			user_is_signed_out
			can_view 		new_session_path, 	user_is_signed_out
			can_create		sessions_path, 	user_is_signed_out

			#all signed-in users
			user_is_signed_in = !c_user.nil?
			can_view 		user1,				user_is_signed_in
			can_view 		user2,				user_is_signed_in

			#is this particular user only
			user_is_user = c_user == user1
			can_alter		user1,				user_is_user
			can_view 		change_password_user_path( user1 ),
												user_is_user
			can_patch 		update_password_user_path( user1 ),
									user_is_user, false

		end

		describe "| When signed in as" do
			def run_bar( user )
				sign_in user
				base_restrictions user
			end

			it "| No one"	do base_restrictions( nil )   end
			it "| A user"	do run_bar( user1 ) 		  end
		end
	end


	#### Tests for (un)/authorized pages or actions ####
	#### Assumes that all illegal view/actions redirect ####
	#### to index page. Some actions have other tests ####

	def can_view( path, flag=true )
		path = polymorphic_path( path ) if path.class.name != "String"
		visit path
		is_auth_redirect( !flag )
	end
	def cannot_view( path ) can_view( path, false ) end

	def can_alter( obj, flag=true )
		can_view( edit_polymorphic_path( obj ), flag )
		can_patch( polymorphic_path( obj ), flag )
	end

	#kinda hacky, we expect that any post without parameters
	#will end up raising an error somehow
	def can_create( path, flag=true )
		if flag
			expect { post path }.to raise_error
		else
			expect { post path }.not_to raise_error
		end
	end	
	def cannot_create( path ) can_create( path, false ) end

	def can_patch( path, flag=true, exp_fail=true )
		if exp_fail
			expect { patch path }.to raise_error if flag
			expect { patch path }.not_to raise_error if !flag
		else
			patch path
			is_auth_redirect( !flag )
		end
	end	
	def cannot_patch( path ) can_patch( patch, false ) end

	before(:all) { DatabaseCleaner.strategy = :truncation }
	after(:all) { DatabaseCleaner.clean; Capybara.reset_sessions!; Capybara.use_default_driver }

end
