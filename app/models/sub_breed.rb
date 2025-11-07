class SubBreed < ApplicationRecord
  belongs_to :breed
  has_many :dogs, dependent: :destroy
  has_many :images, dependent: :destroy
end
