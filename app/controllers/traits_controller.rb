class TraitsController < ApplicationController
  before_action :set_trait, only: %i[ show edit update destroy ]

  # GET /traits or /traits.json
  def index
    @traits = Trait.includes(:dogs)
  end

  # GET /traits/1 or /traits/1.json
  def show
  end

  # GET /traits/new
  def new
    @trait = Trait.new
  end

  # GET /traits/1/edit
  def edit
  end

  # POST /traits or /traits.json
  def create
    @trait = Trait.new(trait_params)

    respond_to do |format|
      if @trait.save
        format.html { redirect_to @trait, notice: "Trait was successfully created." }
        format.json { render :show, status: :created, location: @trait }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /traits/1 or /traits/1.json
  def update
    respond_to do |format|
      if @trait.update(trait_params)
        format.html { redirect_to @trait, notice: "Trait was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @trait }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /traits/1 or /traits/1.json
  def destroy
    @trait.destroy!

    respond_to do |format|
      format.html { redirect_to traits_path, notice: "Trait was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trait
      @trait = Trait.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def trait_params
      params.expect(trait: [ :name ])
    end
end
