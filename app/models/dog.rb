class Dog < ApplicationRecord
  belongs_to :owner
  belongs_to :sub_breed
end
