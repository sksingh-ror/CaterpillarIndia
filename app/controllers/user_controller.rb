class UserController < ApplicationController
  before_action :set_user, only: [:update]

  # POST /user
  def create
    @user = User.new(user_params)

    if @user.save
      notify_third_party_apis(@user)
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user/1
  def update
    if @user.update(user_params)
      notify_third_party_apis(@user)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :user)
    end

    # Notify third-party APIs
    def notify_third_party_apis(user)
      third_party_endpoints = Rails.application.config.third_party_endpoints
      third_party_endpoints.each do |endpoint|
        response = HTTParty.post(endpoint, body: { user: user.attributes, secret_key: Rails.application.credentials.webhook_secret_key })
        # Handle response if needed
      end
    end
end
