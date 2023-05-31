# frozen_string_literal: true
class Recipe < Contentful::Entry
  CONTENT_TYPE = { "content_type": "recipe" }

  attr_reader :title, :photo, :calories, :description, :list_of_tags, :chef_name

  def initialize(response, lazy_loaded: true)
    super(response, lazy_loaded:)
    return if lazy_loaded

    @title        = parse_title(response)
    @photo        = parse_photo(response)
    @calories     = parse_calories(response)
    @description  = parse_description(response)
    @list_of_tags = parse_list_of_tags(response)
    @chef         = parse_chef(response)
  end

  def self.all
    Contentful::Array.new(Contentful.new(CONTENT_TYPE).entries, self)
  end

  private

  def parse_title(response)
    raise Contentfull::Errors::MissingField if response["fields"]["title"].nil?

    response["fields"]["title"]
  end

  def parse_photo(response)
    return if response["fields"]["photo"].nil?

    Photo.new(response["fields"]["photo"], lazy_loaded: false)
  end

  def parse_calories(response)
    return if response["fields"]["calories"].nil?

    response["fields"]["calories"]
  end

  def parse_description(response)
    return if response["fields"]["description"].nil?

    response["fields"]["description"]
  end

  def parse_list_of_tags(response)
    return if response["fields"]["tags"].nil?

    response["fields"]["tags"].map do |tag|
      Tag.new(tag, lazy_loaded: true)
    end
  end

  def parse_chef(response)
    return if response["fields"]["chef"].nil?

    Chef.new(response["fields"]["chef"], lazy_loaded: true)
  end
end
