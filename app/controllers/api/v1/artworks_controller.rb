require 'eth'

class Api::V1::ArtworksController < Api::V1::BaseController
    def index
        cli = Contract::Cli.new
        nft_list = []

        Artwork.all.each do |artwork|
            begin
                nft_list << cli.nft_data(artwork.id)
            rescue
                # just pass for now
            end
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

        foundation = get_foundation

        artwork = Artwork.new(
            name: params[:name],
            description: params[:description],
            foundation_id: foundation.id
        )

        return render_error(artwork.errors.as_json.values.flatten, 400) unless artwork.save

        foundation_wallet = foundation.wallet_address

        # handle error needed (need fix)
        begin
            cli.mint(foundation_wallet, artwork.id, params[:image_url], params[:price])
        rescue => e
            return render_error(e, 400)
        end

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

    def get_foundation
        encrypted_foundation_identifier = request.headers['Foundation-Identifier']
        foundation_identifier = JWT.decode(encrypted_foundation_identifier, Figaro.env.jwt_secret_key, 'HS256')[0]["foundation_id"]
        foundation = Foundation.find_by(id: foundation_identifier)
    end
  end
  