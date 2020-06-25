# frozen_string_literal: true

class EmptyStringError < StandardError
  STANDARD_MESSAGE = 'String was empty'

  def initialize(message = STANDARD_MESSAGE)
    super(message)
  end
end
