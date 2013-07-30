# == Schema Information
#
# Table name: trees
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tree < ActiveRecord::Base

	belongs_to :owner, class_name: "User"

	validates :title, presence: true, length: { maximum: 250 }
	validates :owner_id, presence: true

end
