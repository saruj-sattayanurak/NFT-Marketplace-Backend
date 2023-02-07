require 'eth'

class Api::V1::ArtworksController < Api::V1::BaseController
    def index
        cli = Contract::Cli.new
        nft_list = []

        Artwork.all.each do |artwork|
            nft_list << cli.nft_data(artwork.id)
        end

        render json: {data: nft_list}, status: 200
    end

    def show
        # What if id is prese
        cli = Contract::Cli.new
        result = cli.nft_data(params[:id].to_i)

        return render_error("NFT not found", 400) unless result.present?

        render json: result, status: 200
    end
  
    def create
        cli = Contract::Cli.new
        errors_list = validate_params(params)
        return render_error(errors_list, 400) unless errors_list.empty?

        artwork = Artwork.new(
            name: params[:name],
            description: params[:description]
        )

        return render_error(artwork.errors.as_json.values.flatten, 400) unless artwork.save

        # query form database (need fix)
        foundation_wallet = Figaro.env.wallet_address

        # handle error needed (need fix)
        cli.mint(foundation_wallet, artwork.id, params[:image_url], params[:price])

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
  