require 'sinatra'
require 'rack/test'
require_relative '../../lib/deliverance/server.rb'

Deliverance::Server.project_id = 123
Deliverance::Server.token = 123


def app
  Deliverance::Server.new
end

def git_log
  "[#12345678] fafafaf \n [completes #87654321] \n [fixes #12121212]"
end

describe app do
  include Rack::Test::Methods

  describe 'posting to /deliver' do
    before { stub(RestClient).as_null_object }

    it 'should work' do
      RestClient.should_receive(:put).exactly(:twice)
      post '/deliver', git_log: git_log
    end
  end

end
