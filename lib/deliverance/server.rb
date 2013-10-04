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
      stories = params[:git_log].scan /([A-Z]+-\d+).(#complete|#resolve)/
      stories = stories.map { |s| s[0] }
      stories.each do |story|
        deliver story
      end
    end

    helpers do
      def jira_url(story_id)
        "https://#{self.class.user}:#{self.class.password}@stylitics.atlassian.net/rest/api/latest/issue/#{story_id}/transitions?expand=transitions.fields"
      end

      def transition_json
        { transition: { id: 51 } }.to_json
      end

      def deliver(story_id)
        RestClient.post jira_url(story_id), transition_json, content_type: :json
      end
    end
  end
end
