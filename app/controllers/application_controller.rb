class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_encryption_key
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: decrypt_user_id(session[:user_id])) if session[:user_id]
  end

  def require_user
    redirect_to login_path, alert: "You must be logged in to perform this action" unless current_user
    nil
  end

  def set_encryption_key
    # Use a 32-byte key for AES-256
    secret = Rails.application.secret_key_base.byteslice(0, 32)
    @encryptor = ActiveSupport::MessageEncryptor.new(secret)
  end

  def encrypt_user_id(user_id)
    @encryptor.encrypt_and_sign(user_id.to_s)
  end

  def decrypt_user_id(encrypted_id)
    @encryptor.decrypt_and_verify(encrypted_id)
  rescue
    nil
  end
end
