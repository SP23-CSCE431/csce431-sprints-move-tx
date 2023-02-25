class Admins::SessionsController < Devise::SessionsController
    def after_sign_out_path_for(_resource_or_scope)
      new_admin_session_path
    end
  
    # changes path based on if you have an account already or not 
    def after_sign_in_path_for(resource_or_scope)
      # if admin is not linked to a member go to new member page
      if current_admin.member.nil?
        stored_location_for(resource_or_scope) || new_member_path
      # if admin linked to member got to root_path
      else
        stored_location_for(resource_or_scope) || root_path
      end
    end
  end