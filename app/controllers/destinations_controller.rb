class DestinationsController < ApplicationController
	
	require 'httparty'

	before_action :find_destination, only: [:show, :edit, :update, :destroy]


	def index
    	@user_ip = request.remote_ip
    	@response = request_api()
		@body = JSON.parse(@response.body)
		

		@destination = Destination.all.order("created_at DESC")
	end

	def show
		@current_location = "9 Fraternity Row"
		@user_ip = request.location
	end

	def new
		@destination = current_user.destinations.build
	end

	def create
		@destination = current_user.destinations.build(destination_params)

		if @destination.save
			redirect_to @destination, notice: "Successfully created new destination"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @destination.update(destination_params)
			redirect_to @destination
		else
			render 'edit'
		end
	end

	def destroy
		@destination.destroy
		redirect_to root_path, notice: "Successfully deleted the destination"
	end

	def destination_params
		params.require(:destination).permit(:title, :description, :image, :address, :latitude, :longitude, directions_attributes: [:id, :step, :_destroy])
	end

	private

	def find_destination
		@destination = Destination.find(params[:id])
	end

end
