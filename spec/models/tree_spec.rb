# == Schema Information
#
# Table name: trees
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  root_id    :integer
#

require 'spec_helper'

describe Tree do

	describe "Basics" do

		let(:user) { FactoryGirl.create(:user) }
		let(:tree) { FactoryGirl.create(:tree, owner: user ) }
		subject { tree }

		it "Responds" do
			should respond_to( :owner )
			should respond_to( :title )
			should respond_to( :root )
			should respond_to( :nodes )
		end

		it { should be_valid }

		it "| Attribute presence" do
			must_be_present( tree, "owner_id" )
			must_be_present( tree, "title" )
		end

		its(:owner) { should == user }

		it "| Generated a root node" do
			tree.root.tree.should == tree
		end
	end

	before(:all) { DatabaseCleaner.strategy = :truncation }
	after(:all) { DatabaseCleaner.clean; Capybara.reset_sessions!; Capybara.use_default_driver }

end
