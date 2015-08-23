class LibrariesController < ApplicationController
	require 'httparty'

	before_action :find_library, only: [:show, :edit, :update, :destroy]


	def index
    	@user_ip = request.remote_ip
    	@response = request_api()
		@body = JSON.parse(@response.body)
		

		@library = Library.all.order("created_at DESC")
	end

	def show
		@current_location = "9 Fraternity Row"
		@user_ip = request.location
	end

	def new
		@library = Library.new
	end

	def create
		@library = Library.new(library_params)

		if @library.save
			redirect_to @library, notice: "Successfully created new library"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @library.update(library_params)
			redirect_to @library
		else
			render 'edit'
		end
	end

	def destroy
		@library.destroy
		redirect_to root_path, notice: "Successfully deleted the library"
	end

	def library_params
		params.require(:library).permit(:name, :description, :image, :address, :latitude, :longitude, directions_attributes: [:id, :step, :_destroy])
	end

	private

	def find_library
		@library = Library.find(params[:id])
	end

end
