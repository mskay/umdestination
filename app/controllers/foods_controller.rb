class FoodsController < ApplicationController
	require 'httparty'

	before_action :find_food, only: [:show, :edit, :update, :destroy]


	def index
    	@user_ip = request.remote_ip
    	@response = request_api()
		@body = JSON.parse(@response.body)
		

		@food = Food.all.order("created_at DESC")
	end

	def show
		@current_location = "9 Fraternity Row"
		@user_ip = request.location
	end

	def new
		@food = Food.new
	end

	def create
		@food = Food.new(food_params)

		if @food.save
			redirect_to @food, notice: "Successfully created new food"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @food.update(food_params)
			redirect_to @food
		else
			render 'edit'
		end
	end

	def destroy
		@food.destroy
		redirect_to root_path, notice: "Successfully deleted the food"
	end

	def food_params
		params.require(:food).permit(:name, :description, :image, :address, :latitude, :longitude, directions_attributes: [:id, :step, :_destroy])
	end

	private

	def find_food
		@food = Food.find(params[:id])
	end
end
