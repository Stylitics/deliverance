require 'sinatra'
require 'rack/test'
require_relative '../../lib/deliverance/server.rb'

Deliverance::Server.project_id = 123
Deliverance::Server.token = 123


def app
  Deliverance::Server.new
end

def git_log
<<MSG
* Len Smith: bind hover menus after every sort in closet [fixes #39724311]
* Len Smith: remove save custom arrangement javascript
* Len Smith: Remove Add From WishList from a user's own outfit tab on closet [fixes #39495373]
* Jeremy Raines: [completed #39588661] removed outfits
MSG
end

describe app do
  include Rack::Test::Methods

  describe 'posting to /deliver' do
    before { stub(RestClient).as_null_object }

    it 'should work' do
      RestClient.should_receive(:put).exactly(3).times
      post '/deliver', git_log: git_log
    end
  end

end
