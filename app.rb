require_relative  'lib/database_connection'

DatabaseConnection.connect('book_store')

sql = 'SELECT * FROM books;'
result = DatabaseConnection.exec_params(sql, [])

result.each do |book|
   p book.values.join(" - ")
end