class BoxAccessController < ApplicationController

	def index
		if ((token = session[:token]))
			@box = Box::Client.new(token)
		end
	end

	def save_file
		@box = Box::Client.new(session[:token])
		(redirect_to :root, flash: { notice: 'No file name present, please enter a file name'} ) if params[:filename].blank?
		filename = Rails.root.join("tmp/#{params[:filename]}.txt").to_s
		File.open(filename, 'w') {|f| f.write(params[:content]) }
		file = @box.client.upload_file(filename, '/martin_becker')
		ap file.inspec
		redirect_to :root, flash: { notice: "File sucessfully uploaded."}

	end
end
