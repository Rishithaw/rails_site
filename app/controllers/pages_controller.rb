class PagesController < ApplicationController
  def home
    # @dogs = Dog.includes({ sub_breed: [:breed, :images] }, :owner).limit(10)
    @dogs = Dog.includes({ sub_breed: [:breed, :images] }, :owner)
             .order(created_at: :desc)
             .page(params[:page])
             .per(6)
  end

  def about
  end
end
