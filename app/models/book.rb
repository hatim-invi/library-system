class Book < ApplicationRecord
    has_many :book_copy
    has_many :book_checkout_record
    before_validation :strip_whitespace


    def self.get_data(search_string, search_params)
        data =[]
        if search_string.present?
            if search_params =="published_on"
                year = search_string
                data = Book.where("strftime('%Y', published_on) = ?", year)
            else
            data = Book.where("search_key_for_#{search_params} LIKE ?", "#{search_string.downcase}%")
            end
        else
            data = Book.all
        end
    return data
    end

    def self.get_genres
        @genres = ["Action", "Adventure", "Biography", "Comic", "Crime", "Drama", "Fantasy", "History", "Horror", "Mystery", "Romance","Sci-Fi","Self-Help","Thriller"]
    end


    validates :name, presence: true, format: { with: /\A[a-zA-Z0-9\s.]+\z/, message: "only letters and numbers are allowed" }
    validates :author, presence: true, format: { with: /\A[a-zA-Z\s.]+\z/, message: "only letters are allowed" }
    validates :published_on, presence: true
    validates :about, presence: true
    validates :genre, presence: true
    validates :book_width_in_cm, presence:true,numericality:true
    validate :published_on_is_date
    validate :genre_in_list
    validate :unique_combination


  private

  def published_on_is_date
    unless published_on.is_a?(Date)
      errors.add(:published_on, "must be a valid date")
    end
    unless published_on.present? && published_on <= Date.current
        errors.add(:published_on, "date cannot be in the future")
    end
  end
  def strip_whitespace
    self.name = name.strip unless name.nil?
    self.about = about.strip unless about.nil?
  end
  def genre_in_list
    @genres = Book.get_genres()
    unless @genres.include?(genre)
      errors.add(:genre, "not a valid genre")
    end
  end
  def unique_combination
    if Book.exists?(name: name, author: author, published_on: published_on)
      errors.add(:base, "A book with the same name, author, and published on date already exists")
    end
  end

end
