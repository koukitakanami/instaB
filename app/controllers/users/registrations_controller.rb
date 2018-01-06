class Users::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
  
  # def create
  #   redirect_to new_user_session_path, notice: "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
  # end
  
   def create
     build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
        #redirect_to new_user_session_path, notice: "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"

      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        #respond_with resource, location: after_inactive_sign_up_path_for(resource)
        redirect_to new_user_session_path, notice: "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
    
  end
  
  def after_sign_up_path_for(resource)
    user_session_path
  end
end