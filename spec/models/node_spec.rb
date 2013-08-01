# == Schema Information
#
# Table name: nodes
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Node do

	describe "| Basics" do
		let(:user) { FactoryGirl.create(:user) }
		let(:tree) { FactoryGirl.create(:tree, owner: user ) }
		let(:node) { tree.root }

		subject { node }

		it "| Responds" do
			should respond_to( :text )
			should respond_to( :parent )
			should respond_to( :tree )
			should respond_to( :root? )
			should respond_to( :root )
		end

		it { should be_valid }
		its(:tree) { should == tree }

	end

	describe "| Tree Structure" do
		let!(:user) { FactoryGirl.create(:user) }
		let!(:tree) { FactoryGirl.create(:tree, owner: user ) }
		let!(:root) { tree.root }

		#Setup should be
		#root
		# : node1
		# : node2
		# : : node3
		# : : : node4
		# : : node5
		let!(:node1) { FactoryGirl.create(:node, parent: root ) }
		let!(:node2) { FactoryGirl.create(:node, parent: root ) }
		let!(:node3) { FactoryGirl.create(:node, parent: node2 ) }
		let!(:node4) { FactoryGirl.create(:node, parent: node3 ) }
		let!(:node5) { FactoryGirl.create(:node, parent: node2 ) }

		it "| Confirm Structure" do
			node1.parent.should == root
			node2.parent.should == root
			node3.parent.should == node2
			node4.parent.should == node3
			node5.parent.should == node2

			node1.children.to_a.should =~ []
			node3.children.to_a.should =~ [node4]
			node2.children.to_a.should =~ [node3,node5]

			root.should be_root
			node1.should_not be_root
			node5.should_not be_root

			root.root.should == root
			node1.root.should == root
			node5.root.should == root

			root.tree.should  == tree
			node1.tree.should == tree
			node5.tree.should == tree

			tree.nodes.should =~ [root,node1,node2,node3,node4,node5]
		end

		it "| Dependent Destroy" do
			#Removes node3 and node4
			expect { node3.destroy }.to change(Node, :count).by(-2)

			node2.children.to_a.should =~ [node5]

			#Removes all remaining nodes
			expect { tree.destroy }.to change(Node, :count).by(-4)
		end
	end

	before(:all) { DatabaseCleaner.strategy = :truncation }
	after(:all) { DatabaseCleaner.clean; Capybara.reset_sessions!; Capybara.use_default_driver }

end
