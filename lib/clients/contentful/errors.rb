# frozen_string_literal: true
class Contentful::Errors
  class InvalidStatus < StandardError; end
  class InvalidBody   < StandardError; end
  class MissingField  < StandardError; end
end
