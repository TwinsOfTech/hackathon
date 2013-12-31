class RegistrationsController < Devise::RegistrationsController
  #ssl_required :new, :create
  respond_to :html, :js, :json

  def resource_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :username, :current_password)
  end

  def create
    resource = User.new(resource_params)
    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def destroy
    resource ||= User.find(params[:user_id])
    resource.destroy
    if params[:no_signout]
      redirect_to :root
    else
      set_flash_message :notice, :destroyed
      sign_out_and_redirect(self.resource)
    end
  end

  private :resource_params

end

