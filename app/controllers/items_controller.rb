class ItemsController < ApplicationController
  before_action :set_item
  before_action :auth_item!

  def fetch
    end_service = @item.end_service

    uri = URI(end_service.uri)
    query = Hash.new
    {
        item_handle: @item.handle,
        session_token: session[:session]['token'],
        item_uri_fragment: @item.uri_fragment
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
    @item = Item.includes(:auth_ip_addresses)
                .includes(:auth_services)
                .where(handle: params[:handle]).first
  end

  def auth_item!
    if current_ip_whitelisted?
      SessionsController.create_ip_session session
      return
    end

    if @item.auth_services.any?
      authenticate! @item.auth_services.pluck(:provider)
    else
      head :unauthorized
    end
  end

  def current_ip_whitelisted?
    @item.auth_ip_addresses.any? { |auth_ip_address| request.ip == auth_ip_address.ipv4_address.to_s }
  end
end
