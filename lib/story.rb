require 'mongo_mapper'

class Story
  include MongoMapper::Document
  key :title, String
  key :content, String

  def pdf
    pdf = Prawn::Document.new
    pdf.text(title)
    pdf.text(content)
    pdf.render
  end
end
