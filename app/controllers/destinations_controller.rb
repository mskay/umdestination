class DestinationsController < ApplicationController
	
	require 'httparty'

	before_action :find_destination, only: [:show, :edit, :update, :destroy]


	def search
	    if params[:search].present?
			@destinations = Destination.search(params[:search])
		else
			@destinations = Destination.all
		end
	end


	def index
    	@user_ip = remote_ip()
    	#@locate_ip = location().ip


    	@building = request_building_api()
    	@bus = request_bus_api()
    	@response = @bus.parsed_response["predictions"]
		@body = JSON.parse(@bus.body)


		@destination = Destination.all.order("title ASC")
	end

	def show
		@current_location = "9 Fraternity Row"
		@user_ip = remote_ip()
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
