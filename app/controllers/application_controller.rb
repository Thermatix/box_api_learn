require 'box'
require 'awesome_print'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?

  def logged_in?
  	if (session[:token] && session[:time])
  		if Time.now >= session[:time]
			  returning = :old
  		else
        returning = :true 
      end    		
	  else
	    returning = :false
	  end
	  returning
  end

end
