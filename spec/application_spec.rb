ENV['RACK_ENV'] = 'test'

require 'application'
require 'rspec'
require 'rack/test'

describe Application do
  include Rack::Test::Methods

  def app
    Application
  end

  context "POST /story" do
    before :each do
      @story = Story.new
      @story.stub!(:save)
      Story.stub!(:new).and_return(@story)
    end

    it "saves story title" do
      post "/story", :title => 'story title'
      @story.title.should == 'story title'
    end

    it "saves story content" do
      post "/story", :content => 'story content'
      @story.content.should == 'story content'
    end

    it "saves the story" do
      @story.should_receive(:save)
      post "/story"
    end

    it "returns the story id as json" do
      post "/story"
      last_response.body.should == @story.to_json
    end

    it "sets content type to json" do
      post "/story"
      last_response.content_type.should == "application/json"
    end
  end

  context "GET /stories" do
    it "shows a list of stories" do
      stories = []
      1.upto(2).each do |story_number|
        story = Story.new
        story.id = "story-id-#{story_number}"
        story.title = "Story number #{story_number}"
        stories << story
      end

      Story.should_receive(:all).and_return(stories)
      get '/stories'
      last_response.body.should include '<a href="http://pdf-story-generator.heroku.com/story/story-id-1">Story number 1</a>'
      last_response.body.should include '<a href="http://pdf-story-generator.heroku.com/story/story-id-2">Story number 2</a>'
    end
  end

  context "GET /story/:id" do
    it "returns the story as pdf" do
      story = mock
      story.stub!(:pdf).and_return('pdf content')
      Story.stub!(:find).and_return(story)
      get '/story/some-story-id'
      last_response.body.should == 'pdf content'
    end

    it "sets the content type to pdf" do
      story = mock
      story.stub!(:pdf).and_return('pdf content')
      Story.stub!(:find).and_return(story)
      get '/story/some-story-id'
      last_response.content_type.should == 'application/pdf'
    end
  end

  context "DELETE /story/:id" do
    before :each do
      @story = Story.new
      @story.stub!(:delete)
      Story.stub!(:find).and_return(@story)
    end

    it "finds the story by the id" do
      Story.should_receive(:find).with('some-story-id')
      delete '/story/some-story-id'
    end

    it "deletes the story" do
      @story.should_receive(:delete)
      delete '/story/some-story-id'
    end
  end
end
