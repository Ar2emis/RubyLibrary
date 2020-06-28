# frozen_string_literal: true

require_relative 'autoload'

class Library
  include Validator
  STORAGE_FILE = 'library_storage.yml'
  attr_reader :authors, :books, :readers, :orders

  def initialize
    @library_store = LibraryStore.new
    data = @library_store.data

    @authors = data[:authors]
    @books = data[:books]
    @readers = data[:readers]
    @orders = data[:orders]
  end

  def top_readers(amount = 1)
    top_objects_from_orders(:reader, :book, amount)
  end

  def most_popular_books(amount = 1)
    top_objects_from_orders(:book, :reader, amount)
  end

  def number_of_readers_of_the_most_popular_books(amount = 3)
    @orders.select { |order| most_popular_books(amount).include?(order.book) }.uniq(&:reader).count
  end

  def add(library_object)
    library_group = case library_object
                    when Author then authors
                    when Book   then books
                    when Reader then readers
                    when Order  then orders
                    else
                      raise UnexpectedClassError
                    end

    library_group << library_object
  end

  def save
    @library_store.save
  end

  private

  def top_objects_from_orders(grouper, uniquer, amount)
    @orders.group_by(&grouper).transform_values { |values| values.uniq(&uniquer).count }
           .to_a.max_by(amount, &:last).map(&:first)
  end
end
