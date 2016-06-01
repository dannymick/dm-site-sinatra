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

		erb :project, :locals => {:project => @project }
	end
end