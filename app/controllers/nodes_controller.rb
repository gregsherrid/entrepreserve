class NodesController < ApplicationController

    prepend_before_action :signed_in_user,
        only: [ :create ]

    #also handles permission
    before_action :require_parent

    def create
    	@node = Node.new
        @node.parent = @parent
        if @node.save
            respond_to do |format|
                format.html { redirect_to edit_tree_path( @node.tree ) }
                format.js
            end
        else
            raise "something went wrong"
        end
    end

    #ajax only
    def update
        debug params
        render nothing: true
    end

    private

    	def require_parent
    		@parent = Node.find( params[:parent_id] )
    		auth_redirect unless current_user?( @parent.tree.owner )
    	end
end
