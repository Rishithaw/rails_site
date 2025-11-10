class PagesController < ApplicationController
  def home
    @dogs = Dog.includes({ sub_breed: [:breed, :images] }, :owner).limit(10)
  end

  def about
  end
end
