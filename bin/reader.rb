# frozen_string_literal: true

# Library reader class
class Reader
  attr_reader :name, :email, :city, :street, :house

  def initialize(name:, email:, city:, street:, house:)
    self.name   = name
    self.email  = email
    self.city   = city
    self.street = street
    self.house  = house
  end

  def to_s
    "Reader\n\
  Name: #{name}\n\
  Email: #{email}\n\
  City: #{city}\n\
  Street: #{street} #{house}"
  end

  private

  def name=(name)
    Validator.validate_class(expected_class: String, instance_class: name.class,
                             error_class: LibraryArgumentError, message: 'name must be a String object')
    Validator.validate_non_empty_string(string: name,
                                        error_class: LibraryArgumentError, message: 'name must not be empty')

    @name = name
  end

  def email=(email)
    Validator.validate_class(expected_class: String, instance_class: email.class,
                             error_class: LibraryArgumentError, message: 'email must be a String object')
    Validator.validate_non_empty_string(string: email,
                                        error_class: LibraryArgumentError, message: 'email must not be empty')

    @email = email
  end

  def city=(city)
    Validator.validate_class(expected_class: String, instance_class: city.class,
                             error_class: LibraryArgumentError, message: 'city must be a String object')
    Validator.validate_non_empty_string(string: city,
                                        error_class: LibraryArgumentError, message: 'city must not be empty')

    @city = city
  end

  def street=(street)
    Validator.validate_class(expected_class: String, instance_class: street.class,
                             error_class: LibraryArgumentError, message: 'street must be a String object')
    Validator.validate_non_empty_string(string: street,
                                        error_class: LibraryArgumentError, message: 'street must not be empty')

    @street = street
  end

  def house=(house)
    Validator.validate_class(expected_class: Integer, instance_class: house.class,
                             error_class: LibraryArgumentError, message: 'house must be Integer object')
    Validator.validate_positive_integer(number: house,
                                        error_class: LibraryArgumentError, message: 'house must be a positive number')

    @house = house
  end
end
