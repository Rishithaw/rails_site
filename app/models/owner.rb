class Owner < ApplicationRecord
  has_many :dogs, dependent: :destroy
  validates :name, presence: true
end
