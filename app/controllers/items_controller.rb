class ItemsController < ApplicationController
  before_action :set_item
  before_action :authenticate!

  def fetch
    end_service = @item.end_service

    uri = URI(end_service.uri)
    query = Hash.new
    {
        item_handle: @item.handle,
        session_token: session[:session]['token'],
        item_uri_extra: @item.uri_extra
    }.each do |url_param, value|
      if uri.path.include? ":#{url_param}"
        uri.path = uri.path.gsub ":#{url_param}", value
      else
        query[url_param] = value
      end
    end

    uri.query = query.to_query unless query.empty?

    redirect_to uri.to_s
  end

  private
  def set_item
    @item = Item.where(handle: params[:handle]).first
  end
end
