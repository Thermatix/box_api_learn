class BoxAccessController < ApplicationController

	def index

		if ((token = session[:token]))
			if session[:time] && (Time.now >= session[:time] )
				redirect_to update_sessions_path
			else
				@box = Box::Client.new(token)
			end
		end

	end

	def save_file

		@box = Box::Client.new(session[:token])
		(redirect_to :root, flash: { notice: 'No file name present, please enter a file name'} ) if params[:filename].blank?
		filename = Rails.root.join("tmp/#{params[:filename]}.txt").to_s
		File.open(filename, 'w') {|f| f.write(params[:content]) }
		file = @box.client.upload_file_by_folder_id(filename, params[:select_folder])
		ap file.inspect
		redirect_to :root, flash: { notice: "File sucessfully uploaded."}

	end
end
