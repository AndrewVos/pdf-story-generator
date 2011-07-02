require_relative 'helper'
require_relative '../lib/story'

describe Story do
  before :each do
    Story.collection.remove
    @story = Story.new
  end

  describe ".save" do
    it "stores a title" do
      @story.title = 'story title'
      @story.save
      Story.all.first.title.should == 'story title'
    end

    it "stores content" do
      @story.content = 'some story content'
      @story.save
      Story.all.first.content.should == 'some story content'
    end
  end
end
