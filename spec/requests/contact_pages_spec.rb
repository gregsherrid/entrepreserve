require 'spec_helper'

describe "ContactPages" do

	subject { page }

	let(:name)    { "Bob Baskerville"}
	let(:email)   { "bob@gmail.com"}
	let(:topic) { "TWIMC"}
	let(:body)    { "I <3 your site!"}

	it "| Process" do
		visit contact_path
		should have_selector( "h1", text: "Contact" )

		click_button "Send Message"
		#Won't send empty message
		has_error
		should have_selector( "h1", text: "Contact" )

		fill_in "Name",    with: name
		fill_in "Email",   with: email
		fill_in "Subject", with: topic
		fill_in "Message", with: body

		click_button "Send Message"
		has_no_error
		is_home
		should have_content( "Message sent" )

		email = ActionMailer::Base.deliveries.last.to_s
		email.should include( "To: contact@entrepreserve.com" )
		email.should include( email )
		email.should include( topic )
		email.should include( name )
		email.should include( body )
	end
end
