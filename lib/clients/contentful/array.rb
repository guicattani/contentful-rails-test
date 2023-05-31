# frozen_string_literal: true
class Contentful::Array
  attr_reader :items, :count, :model, :lazy_loaded

  def initialize(response, model, lazy_loaded: true)
    raise Contentful::Errors::InvalidStatus if !response.success?

    if !response["sys"] || response["sys"]["type"] != "Array"
      raise Contentful::Errors::InvalidBody
    end

    @model       = model
    @lazy_loaded = lazy_loaded
    @items       = parse_items(response.parsed_response)
    @count       = parse_count(response.parsed_response)
  end

  private

  def parse_count(parsed_response)
    parsed_response["total"]
  end

  def parse_items(parsed_response)
    parsed_response["items"].map do |item|
      model.new(item, lazy_loaded:)
    end
  end
end
