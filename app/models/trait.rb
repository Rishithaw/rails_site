class Trait < ApplicationRecord
  has_many :dogs_traits, dependent: :destroy
  has_many :dogs, through: :dogs_traits
end
