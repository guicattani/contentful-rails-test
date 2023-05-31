# frozen_string_literal: true
class Contentful::Asset
  attr_reader :link_id, :metadata, :sys, :fields
  attr_reader :title, :file, :url, :details, :file_name, :content_type
  attr_reader :lazy_loaded

  def initialize(response, lazy_loaded: true)
    @lazy_loaded = lazy_loaded
    @sys          = parse_sys(response)
    @link_id      = parse_link_id(response)
    return if lazy_loaded

    asset_response = Contentful.new.asset(@link_id)
    @metadata      = parse_metadata(asset_response)
    @fields        = parse_fields(asset_response)
    @title         = parse_title(asset_response)
    @file          = parse_file(asset_response)
    @url           = parse_url(asset_response)
    @file_name     = parse_file_name(asset_response)
    @content_type  = parse_content_type(asset_response)
  end

  private

  def parse_link_id(response)
    response["sys"]["id"]
  end

  def parse_metadata(response)
    response["parse_metadata"]
  end

  def parse_sys(response)
    response["sys"]
  end

  def parse_fields(response)
    response["fields"]
  end

  def parse_title(response)
    response["fields"]["title"]
  end

  def parse_file(response)
    response["fields"]["file"]
  end

  def parse_url(response)
    response["fields"]["url"]
  end

  def parse_file_name(response)
    response["fields"]["fileName"]
  end

  def parse_content_type(response)
    response["fields"]["contentType"]
  end
end
