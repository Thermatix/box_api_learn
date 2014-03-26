require 'ruby-box'

module Box
	class Access
		attr_reader :session, :token
		def initialize access_token = nil
			self.session = session_create access_token
		end

		def get_authorize_url
			self.session.authorize_url(ENV['RETURN_URL'])
		end

		def get_access_from code
			self.token = self.session.get_access_token(code)
			[self.token.token,self.token.refresh_token]
		end

		def get_new_token rtoken
			self.token = self.session.refresh_token(rtoken)
			[self.token.token,self.token.refresh_token]
		end
		
		def refresh_session token
			self.session = session_create(token)
		end

		private

			def session= input
				@session = input
			end
			def token= input
				@token = input
			end

			def session_create access_token = nil
				ses_hash = {
							client_id: ENV['CLIENT_ID'] ,
  							client_secret: ENV['CLIENT_SECRET']
				}
				ses_hash[:access_token] = access_token if access_token
				RubyBox::Session.new(ses_hash)
			end

	end
	
	class Client
		 attr_reader :client
		
		def initialize access_token
			self.client = RubyBox::Client.new(Access.new(access_token).session)
		end

		def get_folder input
			t = self.client.folder_by_id((input ||= 0).to_i).folders
			t.inject(Array.new) do |result,value| 
				result << value.instance_variable_get("@raw_item")
				result
			end
		end

		def get_files input
			self.client.folder_by_id(input).files
		end
		private
			def client= input
				@client = input
			end

	end

end

