# frozen_string_literal: true

class UnexpectedClassError < StandardError
  STANDARD_MESSAGE = 'Not expected class'

  def initialize(message = STANDARD_MESSAGE)
    super(message)
  end
end
