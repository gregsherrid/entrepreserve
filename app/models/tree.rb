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

class Tree < ActiveRecord::Base

	belongs_to :owner, class_name: "User"
	belongs_to :root, class_name: "Node", dependent: :destroy

	validates :title, presence: true, length: { maximum: 250 }
	validates :owner_id, presence: true

	before_save do
		self.root = Node.create! if root.nil?
	end

	def nodes
		def gather( node )
			node.children.collect{ |c| gather c } << node
		end
		gather( root ).flatten
	end
end
