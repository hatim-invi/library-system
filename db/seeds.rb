days = [30, 180, 360]

1000.times do
  adhaar_number = Faker::Number.unique.number(digits: 12)
  full_name = Faker::Name.name.split(' ')
  name = full_name[0]
  surname = full_name[1]
  search_key_for_name = name.downcase
  search_key_for_surname = surname.downcase
  membership_start_date = Faker::Date.between(from: '2024-01-01', to: Date.today)
  membership_end_date = membership_start_date + days.sample

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
    search_key_for_author: author.downcase,
    book_width_in_cm: rand(1..3)*10
  )
end

puts "Books created successfully"

rooms = ['101','102','103', '104']

rooms.each do |room|
  cap = rand(3..5)
  Room.create(name: room, maximum_section_capacity: cap)
end

puts "Rooms created successfully"

sections = [ "Fiction", "Non-fiction", "Biography", "History", "Science", "Technology", "Arts",
"Literature", "Philosophy", "Religion", "Self-help", "Cooking", "Travel", "Languages", "Business",
"Psychology", "Sports", "Music", "Magazines", "Newspapers",];

rooms = Room.all

j=0
rooms.each do |room|
  i = room.maximum_section_capacity
  i.times do
    Section.create(room_id: room.id, maximum_rack_capacity: rand(3..5), name: sections[j])
    j=j+1
  end
end

puts "Sections created successfully"

rackers = ["A","B","C","D","E"]

sections = Section.all

sections.each do |section|
  i = section.maximum_rack_capacity
  j=0;
  i.times do
    Racker.create(name: rackers[j], maximum_shelf_capacity: rand(8..12), section_id: section.id)
    j=j+1
  end
end

puts "rackers created Successfully"

rackers = Racker.all

rackers.each do |rack|
  i = rack.maximum_shelf_capacity
  j=1;
  i.times do
    Shelf.create(name: j.to_s, racker_id: rack.id, shelf_length_in_cm: rand(6..8)*10)
    j=j+1
  end
end

puts "Shelves created successfully"

books = Book.all.shuffle
shelves = Shelf.all.shuffle

books.each do |book|
  shelf_index = 0

  # Create random number of copies for each book
  num_copies = rand(3..7)

  # Iterate to place each copy on a shelf
  num_copies.times do
    break if shelf_index >= shelves.length # Break if there are no more shelves

    shelf = shelves[shelf_index]
    shelf_length = shelf.shelf_length_in_cm

    # Check if the book fits on the current shelf
    if shelf_length >= book.book_width_in_cm
      # Place the book on the shelf
      BookCopy.create(shelf_id: shelf.id, book_id: book.id, availability: true)
      shelf_length -= book.book_width_in_cm
    else
      # Move to the next shelf
      shelf_index += 1
      redo # Restart the loop with the next shelf
    end
  end
end


puts "Book Copies on location"


shuffled_indices = (0...BookCopy.count).to_a.shuffle

members = Member.all


i = 0
shuffled_indices.each do |index|
  member= members.sample
  book_copy = BookCopy.offset(index).first
  rented_on = Faker::Date.between(from: member.membership_start_date, to: member.membership_end_date)
  return_by = rented_on + rand(1..4)*7.days
  BookCopy.where(id: book_copy.id).update(availability: false)
  BookCheckoutRecord.create(
    book_copy_id: book_copy.id,
    book_id: book_copy.book_id,
    rented_on: rented_on,
    return_by: return_by,
    member_id: member.id
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
  record.update(returned_at: returned_at)
  BookCopy.find(record.book_copy_id).update(availability: true)
end
