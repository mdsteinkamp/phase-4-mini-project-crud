class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found

  def index
    render json: Spice.all
  end

  # def show
  #   spice = Spice.find_by(id: params[:id])
  #   if spice
  #     render json: spice
  #   else
  #     render json: {error: "Spice not found"}, status: :not_found
  #   end
  # end

  def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end

  def update
    spice = find_spice
    spice.update(spice_params)
    render json: spice
  end

  def destroy
    spice = find_spice
    spice.destroy
    head :no_content
  end

  private

  def find_spice
    Spice.find(params[:id])
  end

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def render_response_not_found
    render json: {error: "Spice not found"}, status: :not_found
  end

end
