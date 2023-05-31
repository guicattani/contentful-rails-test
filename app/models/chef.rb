# frozen_string_literal: true
class Chef < Contentful::Entry
  attr_reader :name

  def initialize(response, lazy_loaded: true)
    super(response, lazy_loaded:)
    return if lazy_loaded

    @name = parse_name
  end

  private

  def parse_name
    if fields.nil? || fields["name"].nil?
      raise ::Contentful::Errors::MissingField
    end

    fields["name"]
  end
end
