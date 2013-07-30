require 'spec_helper'

describe Message do

	let(:message) { Message.new }
	before do
		message.name =	  "Rufus Scold"
		message.email =	  "rufus@example.com"
		message.subject = "A proposal"
		message.body =	  "We take them out"
	end

	subject { message }

	it "| Responds" do
		should respond_to( :name )
		should respond_to( :email )
		should respond_to( :subject )
		should respond_to( :body )
	end

	it "| Attribute presence" do
		must_be_present( message, "name" )
		must_be_present( message, "email" )
		must_be_present( message, "subject" )
		must_be_present( message, "body" )
	end

	it { should be_valid }

	it "| Email format" do
		addresses = %w[richie user@foo,com user_at_foo.org example.user@foot.
				   	   foo@bar_baz.com foo@bar+baz.com]
		addresses.each do |invalid_address|
			message.email = invalid_address
			message.should_not be_valid
		end
	end

end
