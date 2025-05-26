class CatsController < ApplicationController
  include HTTParty
  base_uri 'https://api.thecatapi.com/v1'

  def index
  end

  def search
    breed_name = params[:breed].downcase
    response = self.class.get("/breeds")
    if response.success?
      @breed = response.parsed_response.find { |b| b["name"].downcase.include?(breed_name) }

      if @breed
        redirect_to cat_path(@breed["id"])
      else
        flash[:alert] = "Breed not found"
        redirect_to root_path
      end
    else
      flash[:alert] = "API Error"
      redirect_to root_path
    end
  end

  def show
    breed_id = params[:id]
    response = self.class.get("/breeds/#{breed_id}")
    image_response = self.class.get("/images/search", query: { breed_ids: breed_id, limit: 1 })

    if response.success?
      @breed = response.parsed_response
      @image_url = image_response.parsed_response.first["url"] rescue nil
    else
      redirect_to root_path, alert: "Could not fetch breed info"
    end
  end
end
