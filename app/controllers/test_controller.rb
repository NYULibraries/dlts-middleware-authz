class TestController < ApplicationController
  before_action :authenticate!

  def home
  end
end
