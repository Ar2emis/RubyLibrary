# frozen_string_literal: true

# Library reader class
class Reader
  attr_accessor :name, :email, :city, :street, :house

  def initialize(name, email, city, street, house)
    validate_data(name, email, city, street, house)

    @name   = name
    @email  = email
    @city   = city
    @street = street
    @house  = house
  end

  def to_s
    "Reader\n\
  Name: #{@name}\n\
  Email: #{@email}\n\
  City: #{@city}\n\
  Street: #{@street} #{@house}"
  end

  private

  def validate_data(name, email, city, street, house)
    validate_name(name)
    validate_email(email)
    validate_city(city)
    validate_street(street)
    validate_house(house)
  end

  def validate_name(name)
    raise ArgumentError, 'Name must be String object and not be empty' if !name.is_a?(String) || name.empty?
  end

  def validate_email(email)
    raise ArgumentError, 'Email must be String object and not be empty' if !email.is_a?(String) || email.empty?
  end

  def validate_city(city)
    raise ArgumentError, 'City must be String object and not be empty' if !city.is_a?(String) || city.empty?
  end

  def validate_street(street)
    raise ArgumentError, 'Street must be String object and not be empty' if !street.is_a?(String) || street.empty?
  end

  def validate_house(house)
    raise ArgumentError, 'Hosue must be Integer object and positive number' if !house.is_a?(Integer) || house <= 0
  end
end
