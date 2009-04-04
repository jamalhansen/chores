module IdentifiedTestHelper
  # Sets the current Identity in the session.
  def login_as(identity)
    @request.session[identity_id] = identity ? (identity.is_a?(Identity) ? identity.id : Identity.make(:identifier => identity)) : nil
  end
end