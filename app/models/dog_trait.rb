class DogsTrait < ApplicationRecord
  belongs_to :dog
  belongs_to :trait
  validates :name, presence: true, uniqueness: true
end
