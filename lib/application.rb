require 'rubygems'
require 'sinatra/base'
require 'mongo_mapper'
require 'json'
require File.join(File.dirname(__FILE__), 'configuration.rb')

class Application < Sinatra::Base
  get '/?' do
    erb :index
  end

  post '/story' do
    story = Story.new
    story.title   = params[:title]
    story.content = params[:content]
    story.save
    content_type :json
    story.id.to_json
  end
end
