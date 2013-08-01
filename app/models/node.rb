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

class Node < ActiveRecord::Base

	#Getter overwritten below
	has_one :tree, foreign_key: "root_id"

	belongs_to :parent, class_name: "Node"
	has_many :children, dependent: :destroy,
		foreign_key: "parent_id", class_name: "Node"

	before_save do
		self.text = '' if text.nil?
		self.text.strip!
	end

	def root
		#Returns self if root, or the parent's root
		root? ? self : parent.root
	end

	def root?() parent.nil? end

	alias_method :tree_bar, :tree
	def tree
		root? ? self.tree_bar : parent.tree
	end
end
