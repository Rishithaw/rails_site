# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'net/http'
require 'json'
require 'faker'

puts " Starting database seeding..."

# Reset tables
DogsTrait.destroy_all
Image.destroy_all
Dog.destroy_all
SubBreed.destroy_all
Breed.destroy_all
Owner.destroy_all
Trait.destroy_all

# Creating traits
puts " Creating traits..."
traits_list = ["Playful", "Loyal", "Energetic", "Calm", "Protective", "Friendly", "Curious", "Obedient", "Independent"]
traits = traits_list.map { |t| Trait.create!(name: t) }

# Creating owners
puts " Creating owners..."
owners = []
10.times do
  owners << Owner.create!(
    name: Faker::Name.name
  )
end

# Fetching dog breeds and sub-breeds from Dog API
puts "Fetching data from Dog CEO API..."
api_url = "https://dog.ceo/api/breeds/list/all"
response = Net::HTTP.get(URI(api_url))
data = JSON.parse(response)["message"]

data.each do |breed_name, sub_breeds|
  breed = Breed.create!(name: breed_name)

  # If breed has sub-breeds
  if sub_breeds.any?
    sub_breeds.each do |sub_name|
      sub_breed = SubBreed.create!(name: sub_name, breed: breed)

      # Fetches a few images for each sub-breed
      img_url = "https://dog.ceo/api/breed/#{breed_name}/#{sub_name}/images/random/3"
      img_data = JSON.parse(Net::HTTP.get(URI(img_url)))["message"]
      img_data.each { |url| Image.create!(url: url, sub_breed: sub_breed) }

      # Creates random dogs for each sub-breed
      2.times do
        owner = owners.sample
        dog = Dog.create!(
          name: Faker::Creature::Dog.name,
          owner: owner,
          sub_breed: sub_breed
        )
        dog.traits << traits.sample(2)
      end
    end
  else
    # Breeds without sub-breeds
    sub_breed = SubBreed.create!(name: "Standard", breed: breed)
    img_url = "https://dog.ceo/api/breed/#{breed_name}/images/random/3"
    img_data = JSON.parse(Net::HTTP.get(URI(img_url)))["message"]
    img_data.each { |url| Image.create!(url: url, sub_breed: sub_breed) }

    2.times do
      owner = owners.sample
      dog = Dog.create!(
        name: Faker::Creature::Dog.name,
        owner: owner,
        sub_breed: sub_breed
      )
      dog.traits << traits.sample(2)
    end
  end
end

puts "✅ Seeding complete!"
puts "#{Breed.count} breeds"
puts "#{SubBreed.count} sub-breeds"
puts "#{Dog.count} dogs"
puts "#{Owner.count} owners"
puts "#{Trait.count} traits"
puts "#{Image.count} images"
puts "#{DogsTrait.count} dog-trait associations"
