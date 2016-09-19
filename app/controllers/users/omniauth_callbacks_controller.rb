
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_filter  :verify_authenticity_token

    def saml
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: "Saml") if is_navigational_format?
      else
        session["devise.saml_data"] = request.env["omniauth.auth"]
        redirect_to root_url, notice: "No user found with pid #{@user.pid}"
      end
    end

    def failure
      redirect_to root_path, alert: 'Something went wrong'
    end
  end
end
