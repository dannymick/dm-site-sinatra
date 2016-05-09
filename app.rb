# app.rb
# https://github.com/RestPack/sinatra-sample/blob/master/config.ru
#  run app: bundle exec rackup config.ru
require 'sinatra'
require 'json'
configure { set :server, :puma }

class App < Sinatra::Base
	set :static, true
	set :views, File.dirname(__FILE__) + '/views'
	set :public_folder, 'public'

	# @@page_data = YAML.load_file('data.yaml')
	file = File.read('data.json')
	@@page_data = JSON.parse(file)

	get '/' do
		erb :index, :locals => {:page_data => @@page_data }
	end

	get '/cv' do
		erb :cv, :locals => {:page_data => @@page_data }
	end

	get '/work/:project' do |proj|
		@project = ""
		@@page_data.each do |work|
			if work["name"] == proj 
				@project = work
			end
		end
		puts @project
		erb :project, :locals => {:project => @project }
		# erb :project, :locals => {:page_data => @@page_data }
	end
end

# project_url_array = ["fplwatch", "slader", "sierra-mist", "tylenol", "mry", "sumday", lurkers", "jade-hotel"]

# tylenol:
# America's hangover cure, Tylenol, reached out to MRY for a hip new responsive website with a Drupal 7 backend to replace their old, ugly flash website. Over the course of six weeks I worked on this project with two other developers, all three of us had no prior knowledge of Drupal or Drupal theming.
