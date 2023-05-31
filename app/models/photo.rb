# frozen_string_literal: true
class Photo < Contentful::Asset
  def initialize(response, lazy_loaded: true)
    super(response, lazy_loaded:)
  end
end
