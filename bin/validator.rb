# frozen_string_literal: true

module Validator
  def validate_class(expected_class, instance_class)
    message = "Not expected class. Expected #{expected_class} class, but was #{instance_class} class"
    raise_error(message) unless expected_class == instance_class
  end

  def validate_class_or_nil(expected_class, instance_class)
    message = "Not expected class. Expected #{expected_class} class or NilClass, but was #{instance_class} class"
    raise_error(message) unless [expected_class, NilClass].include?(instance_class)
  end

  def validate_non_empty_string(string)
    message = 'String was empty'
    raise_error(message) if string.empty?
  end

  def validate_positive_integer(number)
    message = 'Integer was not positive'
    raise_error(message) if number <= 0
  end

  def raise_error(message)
    raise LibraryArgumentError, message
  end
end
