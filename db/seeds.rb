

Array.new(100) do
  adhaar_no = "123456789012"
  name = Faker::Name.name
  membership_start_date = Faker::Date.backward(days: 365).strftime('%d/%m/%Y')
  membership_end_date = (Date.parse(membership_start_date) + rand(1..365)).strftime('%d/%m/%Y')
  books_taken = rand(0..5)

  Member.create(adhaar_no: adhaar_no.to_i,name:name,membership_start_date: membership_start_date, membership_end_date: membership_end_date, books_taken: books_taken)
end


Array.new(1000) do
  book_name = Faker::Book.title
  author_name = Faker::Book.author
  days_in_range = (Date.new(2024, 12, 31) - Date.new(2000, 1, 1)).to_i
  published_on = Faker::Date.backward(days: rand(0..days_in_range)).strftime('%d/%m/%Y')
  quantity = rand(1..5)
  about = Faker::Lorem.paragraph(sentence_count: rand(10..12))
  genre = ["Action", "Adventure", "Biography", "Comic", "Crime", "Drama", "Fantasy", "History", "Horror", "Mystery", "Romance","Sci-Fi","Self-Help","Thriller"].sample

  BooksInventory.create(book_name: book_name, author: author_name, published_on: published_on, quantity: quantity, about: about, genre: genre)
end

books_inventory_data = BooksInventory.all

books_inventory_data.each do |book|
    quantity = book.quantity

    quantity.times do
      room = rand(1..9) * 100 + rand(1..9)
      section = "#{rand(1..10)}#{('A'..'Z').to_a.sample}"
      rack = rand(1..99)
      shelf = rand(1..9)

      BooksLocation.create(
        books_inventory_id: book.id, room: room, section: section, rack: rack, shelf: shelf)
    end
  end


available_books_locations = BooksLocation.all.pluck(:id, :books_inventory_id)

shuffled_indices = (0...available_books_locations.length).to_a.shuffle

shuffled_indices.each_with_index do |i, index|
  id, books_inventory_id = available_books_locations[i]

  rented_on = Faker::Date.backward(days: 365).strftime('%d/%m/%Y')
  return_by = (Date.parse(rented_on) + rand(1..365)).strftime('%d/%m/%Y')
  BooksRented.create(books_location_id: id, books_inventory_id: books_inventory_id, rented_on: rented_on, return_by: return_by, member_id: rand(1..100))

  break if index >= 999
end
