# frozen_string_literal: true

class Author
  include Validator
  attr_reader :name, :description

  def initialize(name, biography = '')
    validate_data(name)

    @name = name
    @biography = biography
  end

  def to_s
    "Author\n\
  Name: #{name}\n\
  Description: #{biography.empty? ? 'None' : biography}"
  end

  private

  def validate_data(name)
    validate_name(name)
  end

  def validate_name(name)
    validate_class(String, name)
    validate_non_empty_string(name)
  end
end
