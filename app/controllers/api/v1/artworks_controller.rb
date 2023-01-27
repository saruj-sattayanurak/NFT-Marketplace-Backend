class Api::V1::ArtworksController < Api::V1::BaseController
    def index
        artworks = Artwork.all
        render json: {data: artworks}, status: 200
    end

    def show
        artwork = Artwork.find(params[:id])
        render json: artwork, status: 200
    end
  
    def create
        errors_list = validate_params(params)
        return render_error(errors_list, 400) unless errors_list.empty?

        artwork = Artwork.new(
            name: params[:name],
            description: params[:description],
            image_url: params[:image_url],
            price: params[:price]
        )

        return render_error(artwork.errors.as_json.values.flatten, 400) unless artwork.save

        render json: artwork, status: 200
    end
  
    private
  
    def validate_params(params)
      errors_list = []
      errors_list << "name can not be null" unless params[:name].present?
      errors_list << "description can not be null" unless params[:description].present?
      errors_list << "image url can not be null" unless params[:image_url].present?
      errors_list << "price can not be null" unless params[:price].present?
      errors_list
    end
  end
  