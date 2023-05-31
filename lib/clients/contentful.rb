# frozen_string_literal: true
class Contentful
  include HTTParty
  base_uri "cdn.contentful.com/spaces/#{ENV["CONTENTFUL_SPACE_ID"]}/environments/#{ENV["CONTENTFUL_ENVIRONMENT_ID"]}/"

  attr_accessor :query, :page

  def initialize(query = nil, page = 1)
    @query = query
    @page = page
  end

  def entries
    self.class.get("/entries", options)
  end

  def asset(link_id)
    self.class.get("/assets/#{link_id}", options)
  end

  def entry(link_id)
    self.class.get("/entries/#{link_id}", options)
  end

  private

  def options
    query.merge(auth.merge(format))
  end

  def query
    { page: @page, query: @query }
  end

  def auth
    { 
      headers:
      {
       "Authorization" => "Bearer #{ENV["CONTENTFUL_ACCESS_TOKEN"]}",
       "Content-Type"  => "application/json"
      },
    }
  end

  def format
    { format: :json }
  end
end

require_relative "contentful/array"
require_relative "contentful/asset"
require_relative "contentful/entry"
require_relative "contentful/errors"
