class Foundations::SessionsController < Devise::SessionsController
    protect_from_forgery with: :null_session

    respond_to :json

    def create
      foundation = Foundation.find_by(email: params[:foundation][:email])
      if foundation && foundation.valid_password?(params[:foundation][:password])
        render json: { token: JWT.encode({ foundation_id: foundation.id }, Figaro.env.jwt_secret_key, 'HS256') }
      else
        render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
      end
    end
end