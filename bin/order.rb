# frozen_string_literal: true

class Order
  include Validator
  attr_reader :book, :reader, :date

  def initialize(book:, reader:, date: Date.today)
    validate_data(book: book, reader: reader, date: date)

    @book   = book
    @reader = reader
    @date   = date
  end

  def to_s
    "Order\n\
    Book: \"#{@book.title}\" #{@book.author.name}\n\
    Reader: #{@reader.name}\n\
    Date: #{@date}"
  end

  private

  def validate_data(book:, reader:, date:)
    validate_book(book)
    validate_reader(reader)
    validate_date(date)
  end

  def validate_book(book)
    validate_class(Book, book.class)
  end

  def validate_reader(reader)
    validate_class(Reader, reader.class)
  end

  def validate_date(date)
    validate_class(Date, date.class)
  end
end
