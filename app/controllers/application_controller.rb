class ApplicationController < ActionController::Base

  # this ensures that you need to be signed in to do stuff except see the index and show pages
  before_action :authenticate_user!, except: [:index, :show]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
  end


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # makes an api call
  def request_bus_api 
		@response = HTTParty.get('http://api.umd.io/v0/bus/routes/115/arrivals/laplat')
	end

  def request_building_api 
    @response = HTTParty.get('http://api.umd.io/v0/map/buildings/251')
  end
  


  def remote_ip
    if request.remote_ip == '::1'
      # Hard coded remote address
      '50.78.167.161'
    else
      request.remote_ip
    end
  end


 # def location
  #  if params[:location].blank?
   #   if Rails.env.test? || Rails.env.development?
    #    @location ||= Geocoder.search("50.78.167.161").first
     # else
      #  @location ||= request.location
     # end
   # else
     # params[:location].each {|l| l = l.to_i } if params[:location].is_a? Array
     # @location ||= Geocoder.search(params[:location]).first
     # allowed = [:latitude, :longitude, :address, :city]
     # puts @location.methods
     # @location
   # end
 # end

end
