class Api::V1::BaseController < ActionController::API
    before_action only: [:index, :show] do
      doorkeeper_authorize! :read
    end
  
    before_action only: [:create] do
      doorkeeper_authorize! :write
    end

    before_action :authenticate_foundation!
  
    rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  
    protected

    def authenticate_foundation!

      encrypted_foundation_identifier = request.headers['Foundation-Identifier']

      return render_error("Header not found", 404) unless encrypted_foundation_identifier.present?

      begin
        foundation_identifier = JWT.decode(encrypted_foundation_identifier, Figaro.env.jwt_secret_key, 'HS256')[0]["foundation_id"]
      rescue => e
        return render_error("Foundation id not decryptable", 404) unless foundation_identifier.present?
      end

      return render_error("Foundation id not found", 404) unless foundation_identifier.present?

      foundation = Foundation.find_by(id: foundation_identifier)

      return render_error("Foundation not found", 404) unless foundation.present?
    end
  
    def record_not_found(exception)
      render_error("Record not found", 404)
    end
  
    def render_error(errors_list, status)
      render json: {errors: [*errors_list]}.to_json, status: status
    end
  end
  