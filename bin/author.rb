# frozen_string_literal: true

# Library book author class
class Author
  attr_reader :name, :description

  def initialize(name, biography = nil)
    validate_data(name, description)

    @name      = name
    @biography = biography
  end

  def to_s
    "Author\n\
  Name: #{@name}\n\
  Description: #{@biography.nil? ? 'None' : @biography}"
  end

  private

  def validate_data(name, biography)
    validate_name(name)
    validate_biography(biography)
  end

  def validate_name(name)
    raise ArgumentError, 'Name must be String object and not be empty' if !name.is_a?(String) || name.empty?
  end

  def validate_biography(biography)
    raise ArgumentError, 'Description must be String object' unless biography.is_a?(String) || biography.nil?
  end
end
