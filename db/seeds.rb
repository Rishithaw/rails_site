require "faker"
require "net/http"
require "json"

puts "Clearing old data..."
Owner.destroy_all
Dog.destroy_all
Breed.destroy_all
SubBreed.destroy_all
Trait.destroy_all
Image.destroy_all
DogTrait.destroy_all

puts "Fetching dog breeds from Dog API..."
url = URI("https://dog.ceo/api/breeds/list/all")
response = Net::HTTP.get(url)
data = JSON.parse(response)

data["message"].each do |breed_name, sub_breeds|
  breed = Breed.create!(name: breed_name.capitalize)

  if sub_breeds.any?
    sub_breeds.each do |sub|
      sub_breed = breed.sub_breeds.create!(name: sub.capitalize)

      # Fetching one image per sub-breed
      img_url = "https://dog.ceo/api/breed/#{breed_name}/#{sub}/images/random"
      img_response = Net::HTTP.get(URI(img_url))
      img_data = JSON.parse(img_response)
      sub_breed.images.create!(url: img_data["message"])
    end
  else
    # Breed without sub-breed — stores image directly
    img_url = "https://dog.ceo/api/breed/#{breed_name}/images/random"
    img_response = Net::HTTP.get(URI(img_url))
    img_data = JSON.parse(img_response)
    sub_breed = breed.sub_breeds.create!(name: "Standard")
    sub_breed.images.create!(url: img_data["message"])
  end
end

puts "Creating traits..."
traits = [
  "Playful", "Friendly", "Aggressive", "Energetic", "Calm", "Curious", "Protective",
  "Loyal", "Gentle", "Independent", "Smart", "Obedient"
]
traits.each { |trait| Trait.create!(name: trait) }

puts "Creating owners and dogs..."
10.times do
  owner = Owner.create!(
    name: Faker::Name.name
  )

  rand(1..3).times do
    breed = Breed.order("RANDOM()").first
    sub_breed = breed.sub_breeds.sample
    image = sub_breed.images.sample

    dog = owner.dogs.create!(
      name: Faker::Creature::Dog.name,
      sub_breed: sub_breed
    )

    # Attaches traits through join table
    dog.traits << Trait.all.sample(rand(1..3))

    puts "Created #{dog.name} (#{breed.name} / #{sub_breed.name}) with #{dog.traits.size} traits"
  end
end

puts "✅ Seeding complete!"
