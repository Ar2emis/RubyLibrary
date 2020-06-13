# frozen_string_literal: true

class LibraryStore
  STORAGE_FILE = 'library_storage.yml'

  def save(authors:, books:, readers:, orders:)
    store = YAML::Store.new(STORAGE_FILE)

    store.transaction do
      store[:authors] = authors
      store[:books]   = books
      store[:readers] = readers
      store[:orders]  = orders
    end
  end

  def load
    store = YAML::Store.new(STORAGE_FILE)

    library_data = nil
    store.transaction do
      library_data = { authors: store[:authors] || [],
                       books: store[:books]     || [],
                       readers: store[:readers] || [],
                       orders: store[:orders]   || [] }
    end

    library_data
  end
end
