class DogsController < ApplicationController
  before_action :set_dog, only: %i[show edit update destroy]

  # GET /dogs or /dogs.json
  def index
     @breeds = Breed.all  # For dropdown list

    @dogs = Dog.joins(:owner, sub_breed: :breed).distinct

    if params[:search].present?
      # Search dogs by name, owner, breed, or sub-breed
      @dogs = Dog.joins(:owner, sub_breed: :breed)
                 .where("dogs.name LIKE :q OR owners.name LIKE :q OR breeds.name LIKE :q OR sub_breeds.name LIKE :q",
                        q: "%#{params[:search]}%")
                 .distinct
    else
      @dogs = Dog.all
    end

    if params[:breed_id].present?
    @dogs = @dogs.where("breeds.id = ?", params[:breed_id])
    end
  end

  # GET /dogs/1 or /dogs/1.json
  def show
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs or /dogs.json
  def create
    @dog = Dog.new(dog_params)

    respond_to do |format|
      if @dog.save
        format.html { redirect_to @dog, notice: "Dog was successfully created." }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1 or /dogs/1.json
  def update
    respond_to do |format|
      if @dog.update(dog_params)
        format.html { redirect_to @dog, notice: "Dog was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1 or /dogs/1.json
  def destroy
    @dog.destroy!
    respond_to do |format|
      format.html { redirect_to dogs_path, notice: "Dog was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dog_params
      params.require(:dog).permit(:name, :owner_id, :sub_breed_id)
    end
end
