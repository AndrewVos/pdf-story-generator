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
end
