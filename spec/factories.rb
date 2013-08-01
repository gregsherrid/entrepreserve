FactoryGirl.define do
	
	factory :user do
		sequence(:first_name) { |n| "Default#{n}" }
		sequence(:last_name) { |n| "Last#{n}" }
		sequence(:username) { |n| "User_#{n}" }
		sequence(:email) { |n| "example-#{n}@example.com" }

		password "foobar1"
		password_confirmation "foobar1"

		factory :admin do
			is_admin true
		end
	end

	factory :tree do
		sequence(:title) { |n| "Tree#{n}" }

		association :owner, factory: :user
	end

	factory :node do
		sequence(:text) { |n| "Node#{n}" }
		tree nil
		parent nil
	end
end