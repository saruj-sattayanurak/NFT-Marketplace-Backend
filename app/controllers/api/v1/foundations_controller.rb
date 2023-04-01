class Api::V1::FoundationsController < Api::V1::BaseController
    def index
        foundation_list = []

        Foundation.all.each do |foundation|
            foundation_json_object = {
                id: foundation.id,
                name: foundation.name
            }
            foundation_list << foundation_json_object
        end

        render json: {data: foundation_list}, status: 200
    end

    def show
        foundation = Foundation.find(params[:id].to_i)

        render json: foundation, status: 200
    end
end
  