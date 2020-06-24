# frozen_string_literal: true

require_relative 'autoload'

class Library
  include Validator
  STORAGE_FILE = 'library_storage.yml'
  attr_reader :authors, :books, :readers, :orders

  def initialize
    @library_store = LibraryStore.new
    @authors = @library_store.authors
    @books = @library_store.books
    @readers = @library_store.readers
    @orders = @library_store.orders
  end

  def top_readers(amount = 1)
    top_objects_from_collection(@orders, :reader, :book, amount)
  end

  def most_popular_books(amount = 1)
    top_objects_from_collection(@orders, :book, :reader, amount)
  end

  def number_of_readers_of_the_most_popular_books(amount = 3)
    most_popular_books = most_popular_books(amount)
    filter_orders_of_most_popular_books = ->(order) { most_popular_books.include?(order.book) }

    @orders.select(&filter_orders_of_most_popular_books).uniq(&:reader).count
  end

  def add(library_object)
    library_group = case library_object
                    when Author then @authors
                    when Book   then @books
                    when Reader then @readers
                    when Order  then @orders
                    else
                      raise UnexpectedClassError
                    end

    library_group << library_object
  end

  def save
    @library_store.save
  end

  private

  def top_objects_from_collection(collection, grouper, uniquer, amount)
    distinct_and_count = ->(values) { values.uniq(&uniquer).count }
    compare = ->(first_object, second_object) { first_object[1] <=> second_object[1] }

    collection.group_by(&grouper).transform_values(&distinct_and_count)
              .to_a.max(amount, &compare).map(&:first)
  end
end
