class StaticPagesController < ApplicationController
	def home
		@trees = Tree.all
	end
end
