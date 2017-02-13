class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /v1/items
  # GET /v1/items.json
  def index
    render json: Item.paginate(page: params[:page], per_page: 25)
  end

  # GET /v1/items/1
  # GET /v1/items/1.json
  def show
    render json: @item, status: :ok
  end

  # POST /api/v1/items
  def create
    item = Item.new(item_params)
    if item.save!
      render json: item, status: :created
    else
      render_error(item, :unprocessable_entity)
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    if @item.update_attributes(item_params)
      render json: @item, status: :ok
    else
      render_error(@item, :unprocessable_entity)
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.require(:item).permit(:handle, :token, :end_service_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
