class SessionsController < ApplicationController
  skip_before_filter :login_required, :unless => :destroy
  def create
    open_id_authentication(params[:name])
  end
  
  def destroy
    logout
  end

  protected
    def open_id_authentication(identity_url)
      authenticate_with_open_id do |result, identity_url|
        if result.successful?
          self.current_identity = Identity.find_or_make_if_valid(identity_url)
          successful_login
        else
          failed_login result.messager_make_if_
        end
      end
    end
    
    def logout
      self.current_identity = nil
      redirect_back_or_default(root_url)
    end

  private
    def successful_login
      session[:identity_id] = self.current_identity.id
      redirect_back_or_default(root_url)
    end

    def failed_login(message)
      flash[:error] = message
      redirect_back_or_default(root_url)
    end
end
