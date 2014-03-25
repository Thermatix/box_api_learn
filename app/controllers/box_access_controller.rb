class BoxAccessController < ApplicationController

	def index
		if ((token = session[:token]))
			@box = Box::Client.new(token)
		end
	end

	def show

	end
end
