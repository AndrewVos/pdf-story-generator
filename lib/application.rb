require 'rubygems'
require 'sinatra/base'
require 'mongo_mapper'
require 'json'
require 'prawn'
require_relative 'story'
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
    story.to_json
  end

  get '/story/:id' do
    story = Story.find(params[:id])
    content_type :pdf
    story.pdf
  end
end
