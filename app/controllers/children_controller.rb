class ChildrenController < ApplicationController
  def index
    @children = Child.find(:all)
  end
  
  def new
    @child = Child.new
  end
  
  def create
    @child = Child.new(params[:child])
    @child.parent = current_identity

    if @child.save
      flash[:message] = "Child added."
      redirect_to children_url
    else
      flash[:error] = "Error saving Child."
      render :action =>  "new"
    end
  end
end
