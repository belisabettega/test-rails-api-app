class Api::V1::RestaurantsController < Api::V1::BaseController
    acts_as_token_authentication_handler_for User, only: [:update]
    before_action :set_restaurant, only: [:show, :update]

    def index
        @restaurants = policy_scope(Restaurant)
    end

    def show
    end

    def update
        @restaurant.update(restaurant_params) ? (render :show) : render_error
    end

    private

    def set_restaurant
        @restaurant = Restaurant.find(params[:id])
        authorize @restaurant
    end

    def restaurant_params
        params.require(:restaurant).permit(:name, :address)
    end

    def render_error
        render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
end