# frozen_string_literal: true

class LibraryStore
  STORAGE_DIRECTORY = 'db'
  STORAGE_FILE = 'library_storage.yml'
  attr_accessor :authors, :books, :readers, :orders

  def initialize
    initialize_db unless db_initialized?

    store = YAML::Store.new(storage_file_path)

    store.transaction do
      @authors = store[:authors] || []
      @books = store[:books] || []
      @readers = store[:readers] || []
      @orders = store[:orders] || []
    end
  end

  def save
    store = YAML::Store.new(storage_file_path)

    store.transaction do
      store[:authors] = authors
      store[:books] = books
      store[:readers] = readers
      store[:orders] = orders
    end
  end

  private

  def initialize_db
    Dir.mkdir(File.join(STORAGE_DIRECTORY))
  end

  def storage_file_path
    File.join(STORAGE_DIRECTORY, STORAGE_FILE)
  end

  def db_initialized?
    Dir.exist?(STORAGE_DIRECTORY)
  end
end
