class DormsController < ApplicationController
  require 'httparty'

  before_action :find_dorm, only: [:show, :edit, :update, :destroy]


  def index
      @user_ip = request.remote_ip
      @response = request_api()
    @body = JSON.parse(@response.body)
    

    @dorm = Dorm.all.order("created_at DESC")
  end

  def show
    @current_location = "9 Fraternity Row"
    @user_ip = request.location
  end

  def new
    @dorm = Dorm.new
  end

  def create
    @dorm = Dorm.new(dorm_params)

    if @dorm.save
      redirect_to @dorm, notice: "Successfully created new dorm"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @dorm.update(dorm_params)
      redirect_to @dorm
    else
      render 'edit'
    end
  end

  def destroy
    @dorm.destroy
    redirect_to root_path, notice: "Successfully deleted the dorm"
  end

  def dorm_params
    params.require(:dorm).permit(:title, :description, :image, :address, :latitude, :longitude, directions_attributes: [:id, :step, :_destroy])
  end

  private

  def find_dorm
    @dorm = Dorm.find(params[:id])
  end
end
