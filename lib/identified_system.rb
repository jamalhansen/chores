module IdentifiedSystem  
  # Blatently copied from AuthenticatedSystem via the RestfulAuthentication plugin available here: http://github.com/technoweenie/restful-authentication/tree/master
  protected
    # Returns true or false if the identity is logged in.
    # Preloads @current_identity with the identity model if they're logged in.
    def logged_in?
      !!current_identity
    end

    # Accesses the current identity from the session. 
    # Future calls avoid the database because nil is not equal to false.
    def current_identity
      @current_identity ||= (login_from_session) unless @current_identity == false
    end

    # Store the given identity id in the session.
    def current_identity=(new_identity)
      session[:identity_id] = new_identity ? new_identity.id : nil
      @current_identity = new_identity || false
    end

    # Check if the identity is authorized
    #
    # Override this method in your controllers if you want to restrict access
    # to only a few actions or if you want to check if the identity
    # has the correct rights.
    #
    # Example:
    #
    #  # only allow nonbobs
    #  def authorized?
    #    current_identity.login != "bob"
    #  end
    def authorized?
      logged_in?
    end

    # Filter method to enforce a login requirement.
    #
    # To require logins for all actions, use this in your controllers:
    #
    #   before_filter :login_required
    #
    # To require logins for specific actions, use this in your controllers:
    #
    #   before_filter :login_required, :only => [ :edit, :update ]
    #
    # To skip this in a subclassed controller:
    #
    #   skip_before_filter :login_required
    #
    def login_required
      authorized? || access_denied
    end

    # Redirect as appropriate when an access request fails.
    #
    # The default action is to redirect to the login screen.
    #
    # Override this method in your controllers if you want to have special
    # behavior in case the identity is not authorized
    # to access the requested action.  For example, a popup window might
    # simply close itself.
    def access_denied
      respond_to do |format|
        format.html do
          store_location
          redirect_to new_session_path
        end
      end
    end

    # Store the URI of the current request in the session.
    #
    # We can return to this location by calling #redirect_back_or_default.
    def store_location
      session[:return_to] = request.request_uri
    end

    # Redirect to the URI stored by the most recent store_location call or
    # to the passed default.
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    # Inclusion hook to make #current_identity and #logged_in?
    # available as ActionView helper methods.
    def self.included(base)
      base.send :helper_method, :current_identity, :logged_in?
    end

    # Called from #current_identity.  First attempt to login by the identity id stored in the session.
    def login_from_session
      self.current_identity = Identity.find_by_id(session[:identity_id]) if session[:identity_id]
    end
end
