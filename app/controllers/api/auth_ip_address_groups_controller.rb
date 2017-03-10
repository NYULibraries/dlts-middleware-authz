class Api::AuthIpAddressGroupsController < ApplicationController
  before_action :set_auth_ip_address_group, only: [:show, :update, :destroy]

  # GET /api/auth_ip_address_groups
  # GET /api/auth_ip_address_groups.json
  def index
    render json: AuthIpAddressGroup.paginate(page: params[:page], per_page: 25)
  end

  # GET /api/auth_ip_address_groups/1
  # GET /api/auth_ip_address_groups/1.json
  def show
    render json: @auth_ip_address_group, status: :ok
  end

  # POST /api/auth_ip_address_groups
  def create
    auth_ip_address_group = AuthIpAddressGroup.new(auth_ip_address_group_params)
    if auth_ip_address_group.save
      render json: auth_ip_address_group, status: :created
    else
      render_error(auth_ip_address_group, :unprocessable_entity)
    end
  end

  # PATCH/PUT /api/auth_ip_address_groups/1
  # PATCH/PUT /api/auth_ip_address_groups/1.json
  def update
    if @auth_ip_address_group.update_attributes(auth_ip_address_group_params)
      render json: @auth_ip_address_group, status: :ok
    else
      render_error(@auth_ip_address_group, :unprocessable_entity)
    end
  end

  # DELETE /api/auth_ip_address_groups/1
  # DELETE /api/auth_ip_address_groups/1.json
  def destroy
    @auth_ip_address_group.destroy
    head :no_content
  end

  private

  def auth_ip_address_group_params
    params.require(:auth_ip_address_group).permit(:name, :uri)
  end

  def set_auth_ip_address_group
    @auth_ip_address_group = AuthIpAddressGroup.find(params[:id])
  end
end
