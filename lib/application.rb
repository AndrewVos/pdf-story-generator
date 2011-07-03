require 'rubygems'
require 'sinatra/base'
require 'mongo_mapper'
require 'json'
require 'prawn'
require_relative 'story'
require File.join(File.dirname(__FILE__), 'configuration.rb')

class Application < Sinatra::Base
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

  delete '/story/:id' do
    story = Story.find(params[:id])
    story.delete
  end

  get '/stories/?' do
    body = ''
    Story.all.each do |story|
     body << "<a href=\"http://pdf-story-generator.heroku.com/story/#{story.id}\">#{story.title}</a>"
     body << "<br />"
    end
    body
  end
end
