class Breed < ApplicationRecord
  has_many :sub_breeds, dependent: :destroy
end
