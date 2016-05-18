class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  skip_before_filter :authenticate, :only => [:create]
  skip_before_filter :authorize

  def create
    session["user"] = User.from_css_auth_hash auth_hash
    redirect_to '/'
  end

  def destroy
    session["user"] = nil
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
