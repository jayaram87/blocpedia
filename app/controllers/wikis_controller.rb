class WikisController < ApplicationController

    def index
        @wikis = policy_scope(Wiki)
    end
    
    def show
        @wiki = Wiki.find(params[:id])
        
        unless @wiki.private || current_user
            flash[:alert] = "New to upgrade to premium membership"
            redirect_to new_charge_path
        end
        
    end

    def new
        @wiki = Wiki.new
    end
    
    def create
        @wiki = Wiki.new
        @wiki.title = params[:wiki][:title]
        @wiki.body = params[:wiki][:body]
        @wiki.private = params[:wiki][:private]
        @wiki.user = current_user
        
        if @wiki.save
            flash[:notice] = "Wiki created"
            redirect_to @wiki
        end
    end
    
    def edit
        @wiki = Wiki.find(params[:id])
        authorize @wiki
        if @wiki.private?
            @eligible_collaborators = User.all.reject{ |user| user == current_user }
        else    
            @eligible_collaborators = User.none
        end
    end
    
    def update
            @wiki = Wiki.find(params[:id])
            authorize @wiki
            @wiki.title = params[:wiki][:title]
            @wiki.body = params[:wiki][:body]
            @wiki.private = params[:wiki][:private]
        
            if @wiki.save
                flash[:notice] = "Wiki updated"
                redirect_to @wiki
            end
        
    end
    
    def destroy
            @wiki = Wiki.find(params[:id])
            authorize @wiki
        
            if @wiki.destroy
                flash[:notice] = "#{@wiki.title} was deleted successfully."
                redirect_to root_path
            end
       
    end
    
end
