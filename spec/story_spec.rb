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

  describe ".pdf" do
    before :each do
      @pdf = mock
      @pdf.stub!(:text)
      @pdf.stub!(:render)
      Prawn::Document.stub!(:new).and_return(@pdf)
    end

    it "sets the pdf title" do
      @story.title = 'story title'
      @story.content = 'content'
      @pdf.should_receive(:text).with('story title')
      @pdf.should_receive(:text).with('content')
      @story.pdf
    end

    it "renders the pdf" do
      @pdf.should_receive(:render).and_return 'rendered content'
      @story.pdf.should == 'rendered content'
    end
  end
end
