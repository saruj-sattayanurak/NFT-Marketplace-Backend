class Api::V1::BaseController < ActionController::API
    before_action only: [:index, :show] do
      doorkeeper_authorize! :read
    end
  
    before_action only: [:create] do
      doorkeeper_authorize! :write
    end
  
    rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  
    protected
  
    def record_not_found(exception)
      render_error("Record not found", 404)
    end
  
    def render_error(errors_list, status)
      render json: {errors: [*errors_list]}.to_json, status: status
    end
  end
  