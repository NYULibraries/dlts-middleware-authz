class ItemsController < ApplicationController
  before_action :authenticate!
  def get
    # TODO: Do what I actually need to do here.
    render json: Item.find(1)
  end
end
