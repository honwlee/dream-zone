class Property 
	include Mongoid::Document
	has_many :words
	field :name
end
