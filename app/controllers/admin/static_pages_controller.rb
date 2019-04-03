class Admin::StaticPagesController < ApplicationController
  layout "admin"
  before_action :logged_in_user, only: :index
  before_action :is_admin, only: :index
  def index; end
end
