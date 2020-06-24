# frozen_string_literal: true

class EmptyStringError < StandardError
  STANDARD_MESSAGE = 'String was empty'

  def initialize(message = nil)
    super(message.nil? ? STANDARD_MESSAGE : message)
  end
end
