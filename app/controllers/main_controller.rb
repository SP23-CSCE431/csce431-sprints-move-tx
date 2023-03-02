class MainController < ApplicationController
  before_action :set_user;

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destory
  end

  private

  def set_user
    @user = current_admin.member
  end
end
