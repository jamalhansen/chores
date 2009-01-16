class ChoresController < ApplicationController
  def index
    @chores = Chore.find(:all)
  end
  
  def new
    @chore = Chore.new
  end
  
  def create
    @chore = Chore.new(params[:chore])
    if @chore.save
      flash[:message] = "Chore added."
      redirect_to chores_url
    else
      flash[:error] = "Error saving Chore."
      render :action =>  "new"
    end
  end
  
  def destroy
    chore = Chore.find(params[:id])
    chore.destroy
    redirect_to chores_url
  end
end
