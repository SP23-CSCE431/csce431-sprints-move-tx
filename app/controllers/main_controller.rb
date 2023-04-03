class MainController < ApplicationController
  before_action :set_user, :set_member_event;
  before_action :member_admin_deletion_protection

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

  # protects against site crashing when deleting members
  def member_admin_deletion_protection
    if @user.nil?
      redirect_to new_member_path
    end
  end

  def set_member_event
    @member_event = MemberEvent.all
  end
end