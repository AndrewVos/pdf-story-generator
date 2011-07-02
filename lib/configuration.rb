class Application < Sinatra::Base
  configure do
    set :app_file, File.join(File.dirname(__FILE__), 'application.rb')
    set :public,   File.join(File.dirname(__FILE__), '..', 'public')
    set :views,    File.join(File.dirname(__FILE__) , '..', 'views')
  end

  MongoMapper.database = "stories"

  configure :production do
    MongoMapper.connection = Mongo::Connection.new('staff.mongohq.com', 10008)
    MongoMapper.database.authenticate('ministryofstoriesdev4good@gmail.com', 'ewfwefmslkdsqqpwq')
  end

  configure :development do

  end

  configure :test do

  end
end
