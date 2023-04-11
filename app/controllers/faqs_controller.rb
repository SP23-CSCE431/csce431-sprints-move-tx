class FaqsController < ApplicationController
  before_action :set_user, :set_member_event

  def index
  end

  private

  def set_user
    @user = current_admin.member
  end

  def set_member_event
    @member_event = MemberEvent.all
  end
end
