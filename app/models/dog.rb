class Dog < ApplicationRecord
  belongs_to :owner
  belongs_to :sub_breed

  has_many :dogs_traits, dependent: :destroy
  has_many :traits, through: :dog_traits

  validates :name, presence: true
  validates :sub_breed_id, presence: true
end
