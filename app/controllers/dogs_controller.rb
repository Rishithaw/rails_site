class DogsController < ApplicationController
  before_action :set_dog, only: %i[show edit update destroy]

  # GET /dogs
  def index
    @breeds = Breed.all

    # Base query joining related tables for searching
    @dogs = Dog.joins(:owner, sub_breed: :breed).distinct

    # Simple text search
    if params[:search].present?
      @dogs = @dogs.where(
        "dogs.name LIKE :q OR owners.name LIKE :q OR breeds.name LIKE :q OR sub_breeds.name LIKE :q",
        q: "%#{params[:search]}%"
      )
    end

    # Hierarchical search (filter by breed)
    if params[:breed_id].present?
      @dogs = @dogs.where(breeds: { id: params[:breed_id] })
    end
  end

  # GET /dogs/1
  def show; end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit; end

  # POST /dogs
  def create
    @dog = Dog.new(dog_params)
    if @dog.save
      redirect_to @dog, notice: "Dog was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dogs/1
  def update
    if @dog.update(dog_params)
      redirect_to @dog, notice: "Dog was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /dogs/1
  def destroy
    @dog.destroy!
    redirect_to dogs_path, notice: "Dog was successfully destroyed.", status: :see_other
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def dog_params
    params.require(:dog).permit(:name, :owner_id, :sub_breed_id)
  end
end
