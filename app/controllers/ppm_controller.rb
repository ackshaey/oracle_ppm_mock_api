class PpmController < ApplicationController
	before_filter :set_default_response_format, :except => [:readme]
	
	def readme
	end

	def pjlMyTasks
		id = params[:id]
		if id
			path_name = Rails.root.join('app', 'views', 'ppm', 'pjlMyTasks', "#{id}.json")
			if File.exist? path_name
				json_data = File.read(path_name)
				render :json => json_data
			else
				error = {"message" => "#{id} Not found"}
				render :json => error.to_json, :status => 404
			end
		else
			respond_to do |format|
				format.json
			end
		end
	end

	def pjlFollowedTasks
		id = params[:id]
		if id
			path_name = Rails.root.join('app', 'views', 'ppm', 'pjlFollowedTasks', "#{id}.json")
			path_name = "#{RAILS_ROOT}/app/views/#{id}.json"
			if File.exist? path_name
				json_data = File.read(path_name)
				render :json => json_data
			else
				error = {"message" => "#{id} Not found"}
				render :json => error.to_json, :status => 404
			end
		else
			respond_to do |format|
				format.json
			end
		end
	end

	private

	def set_default_response_format
		request.format = :json
	end
end
