class Destination < ActiveRecord::Base
	searchkick
	
	belongs_to :user
	
	geocoded_by :address
	#geocoded_by :ip_address, :latitude => :latitude, :longitude => :longitude 
	after_validation :geocode

	has_attached_file :image, :styles => { :medium => "400x400#" }
  	#validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  	validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png) 

  	has_many :directions

  	#these are the manditory fields for the destination
	validates :title, :description, :image, presence: true

  	
 	accepts_nested_attributes_for :directions, reject_if: proc { |attributes| attributes['step'].blank? }, allow_destroy: true
 	#accepts_nested_attributes_for :locations, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
end
