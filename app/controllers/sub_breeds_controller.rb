class SubBreedsController < ApplicationController
  before_action :set_sub_breed, only: %i[ show edit update destroy ]

  # GET /sub_breeds or /sub_breeds.json
  def index
    @sub_breeds = SubBreed.all
  end

  # GET /sub_breeds/1 or /sub_breeds/1.json
  def show
  end

  # GET /sub_breeds/new
  def new
    @sub_breed = SubBreed.new
  end

  # GET /sub_breeds/1/edit
  def edit
  end

  # POST /sub_breeds or /sub_breeds.json
  def create
    @sub_breed = SubBreed.new(sub_breed_params)

    respond_to do |format|
      if @sub_breed.save
        format.html { redirect_to @sub_breed, notice: "Sub breed was successfully created." }
        format.json { render :show, status: :created, location: @sub_breed }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sub_breed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_breeds/1 or /sub_breeds/1.json
  def update
    respond_to do |format|
      if @sub_breed.update(sub_breed_params)
        format.html { redirect_to @sub_breed, notice: "Sub breed was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @sub_breed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sub_breed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_breeds/1 or /sub_breeds/1.json
  def destroy
    @sub_breed.destroy!

    respond_to do |format|
      format.html { redirect_to sub_breeds_path, notice: "Sub breed was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_breed
      @sub_breed = SubBreed.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def sub_breed_params
      params.expect(sub_breed: [ :name, :breed_id ])
    end
end
