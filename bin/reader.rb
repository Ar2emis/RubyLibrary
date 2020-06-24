# frozen_string_literal: true

class Reader
  include Validator
  attr_reader :name, :email, :city, :street, :house

  def initialize(name:, email:, city:, street:, house:)
    validate_data(name: name, email: email, city: city, street: street, house: house)

    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end

  def to_s
    "Reader\n\
  Name: #{name}\n\
  Email: #{email}\n\
  City: #{city}\n\
  Street: #{street} #{house}"
  end

  private

  def validate_data(name:, email:, city:, street:, house:)
    validate_string_parameters(name: name, email: email, city: city, street: street)
    validate_house(house)
  end

  def validate_string_parameters(name:, email:, city:, street:)
    [name, email, city, street].each do |string|
      validate_class(String, string)
      validate_non_empty_string(string)
    end
  end

  def validate_house(house)
    validate_class(Integer, house)
    validate_positive_integer(house)
  end
end
