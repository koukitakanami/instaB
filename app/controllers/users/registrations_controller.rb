class Users::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
  
  def create
    redirect_to new_user_session_path, notice: "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
  end
end