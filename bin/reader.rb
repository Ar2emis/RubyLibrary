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
    validate_name(name)
    validate_email(email)
    validate_city(city)
    validate_street(street)
    validate_house(house)
  end

  def validate_name(name)
    validate_class(String, name)
    validate_non_empty_string(name)
  end

  def validate_email(email)
    validate_class(String, email)
    validate_non_empty_string(email)
  end

  def validate_city(city)
    validate_class(String, city)
    validate_non_empty_string(city)
  end

  def validate_street(street)
    validate_class(String, street)
    validate_non_empty_string(street)
  end

  def validate_house(house)
    validate_class(Integer, house)
    validate_positive_integer(house)
  end
end
