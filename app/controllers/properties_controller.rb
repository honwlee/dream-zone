class PropertiesController < ApplicationController
  def index
    @properties = Property.order_by([:name, :desc]).page(params[:page] || 1).per(20)
  end

  def show
  	@property = Property.find(params[:id])
  	@words = @property.words.page(params[:page] || 1).per(20)
  end	
end