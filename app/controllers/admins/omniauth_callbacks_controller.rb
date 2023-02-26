class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      admin = Admin.from_google(  email: from_google_params[:email],
        full_name: from_google_params[:full_name],
        uid: from_google_params[:uid],
        avatar_url: from_google_params[:avatar_url])
  
      if admin.present?
        sign_out_all_scopes
        flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect admin, event: :authentication
      else
        flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
        redirect_to new_admin_session_path
      end
    end
  
    protected
  
    def after_omniauth_failure_path_for(_scope)
      new_admin_session_path
    end
    
    # changes path based if you already have an account or not
    def after_sign_in_path_for(resource_or_scope)
      # if admin is not linked to a member go to new member page
      if current_admin.member.nil?
        stored_location_for(resource_or_scope) || new_member_path
      # if admin linked to member got to root_path
      else
        stored_location_for(resource_or_scope) || root_path
      end
    end
  
    private
  
    def from_google_params
      @from_google_params ||= {
        uid: auth.uid,
        email: auth.info.email,
        full_name: auth.info.name,
        avatar_url: auth.info.image
      }
    end

    def auth
        @auth ||= request.env['omniauth.auth']
    end
end