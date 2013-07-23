FactoryGirl.define do
	
	factory :user do
		sequence(:first_name) { |n| "Default#{n}" }
		sequence(:last_name) { |n| "Last#{n}" }
		sequence(:username) { |n| "User_#{n}" }
		sequence(:email) { |n| "example-#{n}@example.com" }

		password "foobar1"
		password_confirmation "foobar1"
	end
end