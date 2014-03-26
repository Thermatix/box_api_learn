require 'box'
class SessionsController < ApplicationController

	def new
		@box_session = Box::Access.new
		session[:token],session[:rtoken] = @box_session.get_access_from(params['code'])
		redirect_to :root

	end

	def create
		@box_session = Box::Access.new
		session[:token] = ""
		session[:rtoken] = ""
		redirect_to @box_session.get_authorize_url

	end

	def update
		@box_session = Box::Access.new
		session[:token],session[:rtoken] = @box_session.get_new_token(session[:rtoken])
		redirect_to :root
	end

	def destroy
		session[:token] = nil
		session[:rtoken] = nil
		redirect_to :root
	end
end