require 'rest_client'
require 'base64'
require 'json'

# Global Plan Line Id volatile
planLineId = nil

def establish_user_server
	@username = 'connor.horton'
	@password = 'Welcome1'
	@server = 'http://slc05kvt.us.oracle.com:7011/projectsManagement/rest/v1/pjlMyTasks'
end

def get_task_details(plan_line_id)
	plan_line_id = plan_line_id.to_s
	establish_user_server
	token = @username + ":" + @password
	hash = Base64.encode64(token)
	authorization_header = "Basic "+hash
	url = @server+"/"+plan_line_id
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

#============================== Detail scraping start for my tasks
jsonMyTasksList = File.read("pjlMyTasks.json")
obj = JSON.parse(jsonMyTasksList)
task_list = obj["items"]
task_list.each do |task|
	id = task["attributes"]["Id"]
	if !File.exist?("pjlMyTasks/#{id}.json")
		begin
			content = get_task_details(id)
			File.open("pjlMyTasks/#{id}.json", "w") do |file|
				file.write content
				file.close
				puts "Completed writing task #{id} details!"
			end
		rescue
			puts "Failed : #{id}"
		end
	end
end
