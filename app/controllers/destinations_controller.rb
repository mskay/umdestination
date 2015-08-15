class DestinationsController < ApplicationController
	before_action :find_destination, only: [:show, :edit, :update, :destroy]
	def index

	end

	def show

	end

	def new
		@destination = Destination.new
	end

	def create
		@destination = Destination.new[destination_params]

		if @destination.save
			redirect_to @destination, notice: "Successfully created new destination"
		else
			render 'new'
		end
	end

	def destination_params
		params.require(:destination).permit(:title, :description)
	end

	private

	def find_destination
		@destination = Destination.find(params[:id])
	end

end
