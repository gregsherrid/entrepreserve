class TreesController < ApplicationController

    prepend_before_action :require_tree,
        except: [:new, :create, :index]

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
            auth_redirect unless @tree.owner == current_user
        end


end
