  class BookUploadFile < ApplicationRecord
    mount_uploader :file, FileUploader

    def self.add_books(id)
      begin
        uploaded_file = BookUploadFile.find(id)
        if uploaded_file.file.nil?
          raise StandardError, "File attribute is nil"
        end

        creek = Creek::Book.new uploaded_file.file.current_path
        sheet = creek.sheets[0]
        unfiltered_headers = sheet.rows.first.values
        headers = []
        unfiltered_headers.each do |header|
          headers.push(header.downcase)
        end
        uploaded_file.update(total_entries: sheet.rows.count-1)

        errors = []
        wrong_entries = 0
        correct_entries = 0

        sheet.rows.each_with_index do |row,index|
          next if(index== 0)
          data = row.values
          book_data = Hash[headers.zip(data)]
          begin
            book = Book.new(book_data)
            book.save!
            correct_entries +=1
          rescue StandardError => e
            errors << {book_data: book_data, error_message: e.message}
            wrong_entries +=1
          end
          uploaded_file.update(wrong_entries: wrong_entries, correct_entries:correct_entries)
        end
        uploaded_file.update(file_errors: errors, completed: true)
      rescue StandardError => e
        uploaded_file.update(file_errors: e.message, completed: true)
      end
    end



  end
