1000.times do
  adhaar_number = Faker::Number.unique.number(digits: 12)
  full_name = Faker::Name.name.split(' ')
  name = full_name[0]
  surname = full_name[1]
  search_key_for_name = name.downcase
  search_key_for_surname = surname.downcase
  membership_start_date = Faker::Date.between(from: '2014-01-01', to: '2023-12-31')
  membership_end_date = membership_start_date + rand(1..1000)

  Member.create(
    search_key_for_name: search_key_for_name,
    search_key_for_surname: search_key_for_surname,
    name: name,
    surname: surname,
    adhaar_number: adhaar_number,
    membership_start_date: membership_start_date,
    membership_end_date: membership_end_date
  )
end

puts "Members created Successfully"

1000.times do
  name = Faker::Book.title
  author = Faker::Book.author
  published_on = Faker::Date.between(from: '2010-01-01', to: '2023-12-31')
  about = Faker::Lorem.paragraph(sentence_count: rand(10..12))
  genre = ["Action", "Adventure", "Biography", "Comic", "Crime", "Drama", "Fantasy", "History", "Horror", "Mystery", "Romance","Sci-Fi","Self-Help","Thriller"].sample

  Book.create(
    name: name,
    author: author,
    published_on: published_on,
    about: about,
    genre: genre,
    search_key_for_genre: genre.downcase,
    search_key_for_name: name.downcase,
    search_key_for_author: author.downcase
  )
end

puts "Books created successfully"

rooms = [101,102,103,104]


rooms.each do |room|
  ('A'..'D').each do |section|
    (1..5).each do |rack|
      (1..10).each do |shelf|
        4.times do
          BookLocation.create(room: room, section: section, rack: rack, shelf: shelf, availability: false)
        end
      end
    end
  end
end

puts "Books location created"

books = Book.all

books.each do |book|
  rand(3..4).times do
    book_location = BookLocation.where(availability: false).order("RANDOM()").first
      book_location.update(book_id: book.id, availability: true)
  end
end

puts "Book Location Assigned"

shuffled_indices = (0...BookLocation.count).to_a.shuffle
i = 0
shuffled_indices.each do |index|
  book_location = BookLocation.offset(index).first
  rented_on = Faker::Date.backward(days: 365)
  return_by = rented_on + rand(1..40).days # Return by date is within 40 days
  member_id = rand(1..1000)
  BookLocation.where(id: book_location.id).update(availability: false)
  BookCheckoutRecord.create(
    book_location_id: book_location.id,
    book_id: book_location.book_id,
    rented_on: rented_on,
    return_by: return_by,
    member_id: member_id
  )
  i=i+1
  if(i>1000)
    break
  end
end

today = Date.today

returned_records = BookCheckoutRecord.where('return_by < ?', today)
returned_records.each_with_index do |record, index|
  returned_at = if index % 50 == 0
                  (record.return_by + rand(1..40).days).strftime('%Y-%m-%d') # Returned at date is within 40 days after return by date
                else
                  (record.return_by - rand(1..20).days).strftime('%Y-%m-%d') # Returned at date is within 20 days before return by date
                end
  record.update(returned_at: returned_at, is_returned: true)
  BookLocation.find(record.book_location_id).update(availability: true)
end
