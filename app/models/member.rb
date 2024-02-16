class Member < ApplicationRecord
    has_many :book_checkout_record
    before_validation :strip_whitespace

    def self.get_data(search_string)
        data =[]
        if search_string.present?
          data = Member.where(
            "search_key_for_name LIKE :search OR search_key_for_surname LIKE :search OR adhaar_number = :adhaar_number",
            search: "#{search_string.downcase}%",
            adhaar_number: search_string.to_i
          )
        else
            data = Member.all
        end
    return data
    end

    validates :name, presence: true, format: { with: /\A[a-zA-Z\s.]+\z/, message: "only letters are allowed" }
    validates :surname, presence: true, format: { with: /\A[a-zA-Z\s.]+\z/, message: "only letters are allowed" }
    validates :adhaar_number, presence: true, length: {minimum: 12, maximum:12}, uniqueness: true
    validates :membership_start_date, presence: true
    validates :membership_end_date, presence:true
    validate :end_date_after_start_date
    validate :start_and_end_dates_are_dates

  private

  def end_date_after_start_date
    return unless membership_start_date && membership_end_date

    errors.add(:membership_end_date, "must be greater than the start date") if membership_end_date <= membership_start_date
  end

  def start_and_end_dates_are_dates
    unless membership_start_date.is_a?(Date)
      errors.add(:membership_start_date, "must be a valid date")
    end

    unless membership_end_date.is_a?(Date)
      errors.add(:membership_end_date, "must be a valid date")
    end
  end
  def strip_whitespace
    self.name = name.strip unless name.nil?
    self.surname = surname.strip unless surname.nil?
  end
end
