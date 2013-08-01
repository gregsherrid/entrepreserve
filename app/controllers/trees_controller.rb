class TreesController < ApplicationController

    prepend_before_action :require_tree,
        except: [:new, :create, :index]

    prepend_before_action :signed_in_user,
        only: [:new, :create ]

    before_action :is_current_owner,
        only: [ :edit, :update ]

    before_action :is_admin,
        only: [ :destroy ]

    def new
        @tree = Tree.new
    end

    def create
        @tree = current_user.trees.build( tree_params )
        if @tree.save
            redirect_to @tree
        else
            render :new
        end

    end

    def edit
        gon.runEditBranch = true
        gon.nodes         = @tree.nodes.index_by(&:id)
        gon.rootId        = @tree.root.id
        gon.updatePath    = nodes_path
    end

    def update
    end

    def show
    end

    def index
    end

    def destroy
    end

    private

        def tree_params
            params.require(:tree).permit(:title)
        end 

        def require_tree
            @tree = Tree.find( params[:id] )
        end

        def is_current_owner
            auth_redirect unless current_user?( @tree.owner )
        end


end
