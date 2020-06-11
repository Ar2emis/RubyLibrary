# frozen_string_literal: true

require_relative 'book'
require_relative 'author'
require_relative 'reader'
require_relative 'order'
require_relative 'validator'
require_relative 'library_argument_error'
require 'yaml/store'

# Library class
class Library
  include Validator
  STORAGE_FILE = 'library_storage.yml'
  attr_reader :authors, :books, :readers, :orders

  def initialize
    library_data = load
    @authors = library_data[:authors]
    @books   = library_data[:books]
    @readers = library_data[:readers]
    @orders  = library_data[:orders]
  end

  def save
    store = YAML::Store.new(STORAGE_FILE)

    store.transaction do
      store[:authors] = @authors
      store[:books]   = @books
      store[:readers] = @readers
      store[:orders]  = @orders
    end
  end

  def top_readers(amount = 1)
    distinct_orders_by_book_and_count = ->(orders) { orders.uniq(&:book).count }
    compare_readers = ->(first_reader, second_reader) { first_reader[1] <=> second_reader[1] }

    @orders.group_by(&:reader).transform_values(&distinct_orders_by_book_and_count)
           .to_a.max(amount, &compare_readers).map(&:first)
  end

  def most_popular_books(amount = 1)
    distinct_orders_by_reader_and_count = ->(orders) { orders.uniq(&:reader).count }
    compare_books = ->(first_book, second_book) { first_book[1] <=> second_book[1] }

    @orders.group_by(&:book).transform_values(&distinct_orders_by_reader_and_count)
           .to_a.max(amount, &compare_books).map(&:first)
  end

  def number_of_readers_of_the_most_popular_books(amount = 3)
    most_popular_books = most_popular_books(amount)
    filter_orders_of_most_popular_books = ->(order) { most_popular_books.include?(order.book) }

    @orders.select(&filter_orders_of_most_popular_books).uniq(&:reader).count
  end

  def add_author(author)
    validate_class(expected_class: Author, instance_class: author.class,
                   error_class: LibraryArgumentError, message: 'author must be an Author object')

    authors.append(author)
  end

  def add_book(book)
    validate_class(expected_class: Book, instance_class: book.class,
                   error_class: LibraryArgumentError, message: 'book must be a Book object')

    add_author(book.author) unless @authors.include?(book.author)
    @books.append(book)
  end

  def add_reader(reader)
    validate_class(expected_class: Reader, instance_class: reader.class,
                   error_class: LibraryArgumentError, message: 'reader must be a Reader object')

    readers.append(reader)
  end

  def add_order(order)
    validate_class(expected_class: Order, instance_class: order.class,
                   error_class: LibraryArgumentError, message: 'order must be an Order object')

    add_book(order.book) unless @books.include?(order.book)
    add_reader(order.reader) unless @readers.include?(order.reader)
    @orders.append(order)
  end

  private

  def load
    store = YAML::Store.new(STORAGE_FILE)

    library_data = nil
    store.transaction do
      library_data = { authors: store[:authors] || [],
                       books: store[:books] || [],
                       readers: store[:readers] || [],
                       orders: store[:orders] || [] }
    end

    library_data
  end
end
