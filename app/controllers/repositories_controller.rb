class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    begin
      @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
        req.params['client_id'] = ENV['GITHUB_KEY']
        req.params['client_secret'] = ENV['GITHUB_SECRET']
        req.params['q'] = params[:query]
      end

      body = JSON.parse(@resp.body)
      @github_search = body["items"]

      rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
      end
      render 'search'

  end
end
