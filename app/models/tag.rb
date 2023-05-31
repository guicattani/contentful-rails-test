# frozen_string_literal: true
class Tag < Contentful::Entry
  attr_reader :name

  def initialize(response, lazy_loaded: true)
    super(response, lazy_loaded: lazy_loaded)
    return if lazy_loaded

    @name = parse_name(response)
  end

  private

  def parse_name(response)
    raise Contentfull::Errors::MissingField if response["fields"]["name"] == nil

    response["fields"]["name"]
  end
end
