require 'spec_helper'

describe "TreePages" do
	subject { page }

	describe "| Creation" do
		let!(:user) { FactoryGirl.create(:user) }
		let(:treeName) { "A rather clever plan" }

		before { sign_in user }

		it "| Process" do
			visit new_tree_path
			should have_selector( "h1", text: "New Tree" )

			click_button "Create Tree"
			has_error

			fill_in "Title", with: treeName
			click_button "Create Tree"
			has_no_error

			should have_content treeName
			tree = Tree.find_by( title: treeName )
			tree.owner.should == user
		end
	end

	describe "| Tree lists" do
		let!(:user1) { FactoryGirl.create(:user) }
		let!(:tree1) { FactoryGirl.create(:tree, owner: user1 ) }
		let!(:tree2) { FactoryGirl.create(:tree, owner: user1 ) }

		let!(:user2) { FactoryGirl.create(:user) }
		let!(:tree3) { FactoryGirl.create(:tree, owner: user2 ) }

		before { sign_in user1 }

		def trees_on_page( where, trees )
			visit where

			other_trees = [ tree1, tree2, tree3 ] - trees

			trees.each       { |t| should     have_content t.title }
			other_trees.each { |t| should_not have_content t.title }
		end

		it "| On User 1" do trees_on_page( user_path( user1 ), [tree1,tree2] ) end
		it "| On User 2" do trees_on_page( user_path( user2 ), [tree3] ) end
		it "| On Index"  do trees_on_page( root_path, [tree1,tree2,tree3] ) end
		
	end

	before(:all) { DatabaseCleaner.strategy = :truncation }
	after(:all) { DatabaseCleaner.clean; Capybara.reset_sessions!; Capybara.use_default_driver }

end
