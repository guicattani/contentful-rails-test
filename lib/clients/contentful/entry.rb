# frozen_string_literal: true
class Contentful::Entry
  attr_reader :link_id, :metadata, :sys, :fields
  attr_reader :lazy_loaded

  def initialize(response, lazy_loaded: true)
    @lazy_loaded = lazy_loaded
    @sys         = parse_sys(response)
    @link_id     = parse_link_id(response)
    return if lazy_loaded

    entry_response = Contentful.new.entry(@link_id)
    @metadata      = parse_metadata(entry_response)
    @fields        = parse_fields(entry_response)
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
end
