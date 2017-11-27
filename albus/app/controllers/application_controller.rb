class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    render 'index'
  end

  def authorize
    unless session[:user_id]
      redirect_to root_url
    end
  end

end
