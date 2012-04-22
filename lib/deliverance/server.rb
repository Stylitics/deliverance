require 'sinatra'
require 'rest-client'

module Deliverance
  class Server < Sinatra::Base

    #these should be set in config.ru like so: Deliverance::Server.token = 'foo'
    class << self
      attr_accessor :project_id
      attr_accessor :token
    end
    
    get '/' do
      tracker_token + ' ' + project_id
    end

    post '/deliver' do
      stories = params[:git_log].scan /\d{8}/
      stories.each do |story|
        deliver story
      end
    end

    helpers do
      def tracker_url(story_id)
        "http://http://www.pivotaltracker.com/services/v3/projects/#{project_id}/stories/#{story_id}"
      end

      def delivery_xml
        '<story><state>delivered</state></story>'
      end

      def tracker_token
        self.class.token || raise('You must set your PT API token in config.ru')
      end

      def project_id
        self.class.project_id || raise('You must set a project id in config.ru')
      end

      def headers
        { 'X-Tracker-Token' => tracker_token, 'Content-Type' => 'application/xml' }
      end

      def deliver(story_id)
        RestClient.put tracker_url(story_id), delivery_xml, headers
      end
    end
  end
end
