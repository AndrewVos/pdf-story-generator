require 'mongo_mapper'

class Story
  include MongoMapper::Document
  key :title, String
  key :content, String
end
