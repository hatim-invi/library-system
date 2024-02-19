class Racker < ApplicationRecord
  belongs_to :section
  has_many :shelf
end
