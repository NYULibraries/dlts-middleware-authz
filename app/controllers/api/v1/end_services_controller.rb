class Api::V1::EndServicesController < ApplicationController
  before_action :set_end_service, only: [:show, :update, :destroy]

  # GET /v1/end_services
  # GET /v1/end_services.json
  def index
    render json: EndService.paginate(page: params[:page], per_page: 25)
  end

  # GET /v1/end_services/1
  # GET /v1/end_services/1.json
  def show
    render json: @end_service, status: :ok
  end

  # POST /api/v1/end_services
  def create
    end_service = EndService.new(end_service_params)
    if end_service.save
      render json: end_service, status: :created
    else
      render_error(end_service, :unprocessable_entity)
    end
  end

  # PATCH/PUT /end_services/1
  # PATCH/PUT /end_services/1.json
  def update
    if @end_service.update_attributes(end_service_params)
      render json: @end_service, status: :ok
    else
      render_error(@end_service, :unprocessable_entity)
    end
  end

  # DELETE /end_services/1
  # DELETE /end_services/1.json
  def destroy
    @end_service.destroy
    head :no_content
  end

  private

  def end_service_params
    params.require(:end_service).permit(:name, :uri)
  end

  def set_end_service
    @end_service = EndService.find(params[:id])
  end
end
