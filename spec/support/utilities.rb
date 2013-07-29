def sign_in(user, pwd=nil )
	password = pwd ? pwd : user.password
	visit root_path
	fill_in "username", with: user.username
	fill_in "password", with: password
	click_button "Log In"
	# Sign in when not using Capybara as well.
	if user.authenticate( password )
		cookies[:remember_token] = user.remember_token
	end
end

def sign_out
	click_link "Sign Out"
	cookies[:remember_token] = 0
end

def is_signed_out
	should have_selector( 'input#signin' )
end

def is_signed_in
	should have_selector( "a#signout")
end

def must_be_present( obj, assign )
	val = obj.send( assign )

	obj.send( assign+"=", "" )
	should_not be_valid

	obj.send( assign+"=", val )
	should be_valid
end

def is_auth_redirect( flag = true )
	if flag
		is_home
		should have_selector( "li", text: "Permission Denied" )
	else
		is_not_home
		should_not have_selector( "li", text: "Permission Denied" )
	end
end

def has_error( flag=true )
	should     have_selector( "div#errors" ) if flag
	should_not have_selector( "div#errors" ) if !flag
end
def has_no_error() has_error(false) end

def is_home( flag = true )
	should 	   have_selector( 'section#homePage' ) if flag
	should_not have_selector( 'section#homePage' ) if !flag
end
def is_not_home() is_home( false ) end

#returns an array of hrefs in string
def grab_links( text )
	regex = /href="(.+?)"/i
	links = text.scan( regex ).flatten
end