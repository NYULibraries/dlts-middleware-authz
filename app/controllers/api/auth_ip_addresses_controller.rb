class Api::AuthIpAddressesController < Api::ApiController
  before_action :set_auth_ip_address, only: [:show, :update, :destroy]

  # GET /v1/auth_ip_addresss
  # GET /v1/auth_ip_addresss.json
  def index
    render json: AuthIpAddress.paginate(page: params[:page], per_page: 25)
  end

  # GET /v1/auth_ip_addresss/1
  # GET /v1/auth_ip_addresss/1.json
  def show
    render json: @auth_ip_address, status: :ok
  end

  # POST /api/auth_ip_addresses
  def create
    ip_address = AuthIpAddress.new(auth_ip_address_params)
    if ip_address.save!
      render json: ip_address, status: :created
    else
      render_error(ip_address, :unprocessable_entity)
    end
  end

  # PATCH/PUT /auth_ip_addresss/1
  # PATCH/PUT /auth_ip_addresss/1.json
  def update
    if @auth_ip_address.update_attributes(auth_ip_address_params)
      render json: @auth_ip_address, status: :ok
    else
      render_error(@auth_ip_address, :unprocessable_entity)
    end
  end

  # DELETE /auth_ip_addresss/1
  # DELETE /auth_ip_addresss/1.json
  def destroy
    @auth_ip_address.destroy
    head :no_content
  end

  private

  def auth_ip_address_params
    params.require(:auth_ip_address).permit(:name, :ipv4_address, :ipv6_address)
  end

  def set_auth_ip_address
    @auth_ip_address = AuthIpAddress.find(params[:id])
  end
end
