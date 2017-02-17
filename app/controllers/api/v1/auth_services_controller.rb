class Api::V1::AuthServicesController < Api::ApiController
  before_action :set_auth_service, only: [:show, :update, :destroy]

  # GET /v1/auth_services
  # GET /v1/auth_services.json
  def index
    render json: AuthService.paginate(page: params[:page], per_page: 25)
  end

  # GET /v1/auth_services/1
  # GET /v1/auth_services/1.json
  def show
    render json: @auth_service, status: :ok
  end

  # POST /end_services
  def create
    auth_service = AuthService.new(auth_service_params)
    if auth_service.save
      render json: auth_service, status: :created
    else
      render_error(auth_service, :unprocessable_entity)
    end
  end

  # PATCH/PUT /auth_services/1
  # PATCH/PUT /auth_services/1.json
  def update
    if @auth_service.update_attributes(auth_service_params)
      render json: @auth_service, status: :ok
    else
      render_error(@auth_service, :unprocessable_entity)
    end
  end

  # DELETE /auth_services/1
  # DELETE /auth_services/1.json
  def destroy
    @auth_service.destroy
    head :no_content
  end

  private

  def auth_service_params
    params.require(:auth_service).permit(:name)
  end

  def set_auth_service
    @auth_service= AuthService.find(params[:id])
  end
end
