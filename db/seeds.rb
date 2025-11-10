require 'net/http'
require 'json'
require 'faker'

puts "Clearing old data..."
DogsTrait.destroy_all
Image.destroy_all
Dog.destroy_all
Trait.destroy_all
SubBreed.destroy_all
Breed.destroy_all
Owner.destroy_all

puts "Fetching dog breeds from Dog API..."
url = "https://dog.ceo/api/breeds/list/all"
response = Net::HTTP.get(URI(url))
data = JSON.parse(response)

# Create breeds and sub-breeds
data["message"].each do |breed_name, sub_breed_names|
  breed = Breed.create!(name: breed_name)

  if sub_breed_names.empty?
    SubBreed.create!(name: breed_name, breed: breed)
  else
    sub_breed_names.each do |sub_name|
      SubBreed.create!(name: "#{sub_name} #{breed_name}", breed: breed)
    end
  end
end

puts "Creating traits..."
traits = %w[Playful Loyal Gentle Brave Energetic Calm Friendly Intelligent]
traits.each { |t| Trait.create!(name: t) }

puts "Creating owners and dogs..."
10.times do
  owner = Owner.create!(name: Faker::Name.name)

  rand(2..4).times do
    sub_breed = SubBreed.order("RANDOM()").first
    dog = Dog.create!(
      name: Faker::Creature::Dog.name,
      owner: owner,
      sub_breed: sub_breed
    )

    # Assign random traits
    dog.traits << Trait.order("RANDOM()").limit(rand(2..4))
  end
end

puts "Fetching dog images..."
SubBreed.limit(20).each do |sub|
  image_url = "https://dog.ceo/api/breed/#{sub.breed.name}/images/random"
  response = Net::HTTP.get(URI(image_url))
  img = JSON.parse(response)
  Image.create!(url: img["message"], sub_breed: sub)
end

puts "✅ Seeding complete!"
