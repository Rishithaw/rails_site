json.extract! dog, :id, :name, :age, :owner_id, :breed_id, :created_at, :updated_at
json.url dog_url(dog, format: :json)
