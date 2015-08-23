class FavoritesController < ApplicationController
  require 'httparty'

  
	before_action :find_favorite, only: [:show, :edit, :update, :destroy]


	def index
    	@user_ip = request.remote_ip
    	@response = request_api()
		@body = JSON.parse(@response.body)
		

		@favorite = Favorite.all.order("created_at DESC")
	end

	def show
		@current_location = "9 Fraternity Row"
		@user_ip = request.location
	end

	def new
		@favorite = Favorite.new
	end

	def create
		@favorite = Favorite.new(favorite_params)

		if @favorite.save
			redirect_to @favorite, notice: "Successfully created new favorite"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @favorite.update(favorite_params)
			redirect_to @favorite
		else
			render 'edit'
		end
	end

	def destroy
		@favorite.destroy
		redirect_to root_path, notice: "Successfully deleted the favorite"
	end

	def favorite_params
		params.require(:favorite).permit(:name, :description, :image, :address, :latitude, :longitude, directions_attributes: [:id, :step, :_destroy])
	end

	private

	def find_favorite
		@favorite = Favorite.find(params[:id])
	end
end
