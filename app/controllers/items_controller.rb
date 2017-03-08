class ItemsController < ApplicationController
  before_action :set_item
  before_action :authenticate!

  def fetch
    end_service = @item.end_service
    uri = URI(end_service.uri)
    uri.query = {item_token: @item.token, session_token: session[:session]['token']}.to_query
    redirect_to uri.to_s
  end

  private
  def set_item
    @item = Item.where(token: params[:token]).first
  end
end
