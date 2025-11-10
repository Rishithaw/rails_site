class Breed < ApplicationRecord
  has_many :sub_breeds, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
