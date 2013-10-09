require 'sinatra'
require 'rest-client'
require 'json'

module Deliverance
  class Server < Sinatra::Base

    #these should be set in config.ru like so: Deliverance::Server.token = 'foo'
    class << self
      attr_accessor :user
      attr_accessor :password
    end

    get '/' do
      'running'
    end

    post '/deliver' do
      filter = JSON.parse RestClient.get filter_url
      search_url = filter['searchUrl'].gsub(/stylitics/, "#{self.class.user}:#{self.class.password}@stylitics")
      issues = JSON.parse RestClient.get search_url
      ids = issues['issues'].map{|i| i['id']}
      ids.each do |story|
        deliver story
      end
    end

    helpers do

      def filter_url
        "https://#{self.class.user}:#{self.class.password}@stylitics.atlassian.net/rest/api/latest/filter/11004"
      end

      def transition_url(story_id)
        "https://#{self.class.user}:#{self.class.password}@stylitics.atlassian.net/rest/api/latest/issue/#{story_id}/transitions?expand=transitions.fields"
      end

      def transition_json
        { transition: { id: 51 } }.to_json
      end

      def deliver(story_id)
        RestClient.post transition_url(story_id), transition_json, content_type: :json
      end
    end
  end
end
