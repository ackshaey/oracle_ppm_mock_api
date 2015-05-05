require 'rest_client'
require 'base64'

def establish_user_server
	@username = 'connor.horton'
	@password = 'Welcome1'
	@server = 'http://slc05kvt.us.oracle.com:7011/projectsManagement/rest/v1/pjlMyTasks'
end

def get_my_tasks
	establish_user_server
	token = @username + ":" + @password
	hash = Base64.encode64(token)
	authorization_header = "Basic "+hash
	url = @server
	params = {}
	headers = { "Authorization" => authorization_header,
				"X-ANTICSRF" => "TRUE",
				"Content-Type" => "application/json",
				"Accept-Encoding" => "compress, gzip",
				"Accept-Language" => "en-US",
				"Content-Length" => "112",
				"User-Agent" => "Oracle Tap/3.0.1 (iPhone Simulator; iPhone OS 7.0.3; en_US)",
				"Cache-Control" => "no-cache"
			  }
	response = RestClient.get(url, headers)
end

def get_followed_tasks
	establish_user_server
	token = @username + ":" + @password
	hash = Base64.encode64(token)
	authorization_header = "Basic "+hash
	url = @server[0..-11]+"pjlFollowedTasks"
	params = {}
	headers = { "Authorization" => authorization_header,
				"X-ANTICSRF" => "TRUE",
				"Content-Type" => "application/json",
				"Accept-Encoding" => "compress, gzip",
				"Accept-Language" => "en-US",
				"Content-Length" => "112",
				"User-Agent" => "Oracle Tap/3.0.1 (iPhone Simulator; iPhone OS 7.0.3; en_US)",
				"Cache-Control" => "no-cache"
			  }
	response = RestClient.get(url, headers)
end

list_data = get_followed_tasks
file = File.open("pjlFollowedTasks.json", "w") do |file|
	file.write list_data
	file.close
end
puts "Completed!"
