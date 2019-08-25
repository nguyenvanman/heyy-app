class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i[edit reset update_password]
  before_action :valid_user, only: %i[edit]

  def new
  end

  def update_password
    if params[:user][:password].blank?
      flash[:danger] = "Password must not be empty"
      render 'edit'
    elsif params[:user][:password] != params[:user][:password_confirmation] 
      flash[:danger] = "Password not matched"
      render 'edit'
    else
      @user.update_attributes(user_params) 
      flash[:success] = "Password has been reset"
      redirect_to new_password_reset_url
    end
  end

  def edit
    if @user.nil? 
      flash[:danger] = "Invalid or expired link"
      redirect_to new_password_reset_url
    end
  end

  def user_params
    params[:password] = params[:user][:password]
    params[:password_confirmation] = params[:user][:password_confirmation]
    params[:reset_digest] = nil
    params.permit(:password, :password_confirmation, :reset_digest)
  end

  def reset
    if @user.nil? 
      render_error('Invalid or unregistered email address', :bad_request) and return
    end
    @user.create_reset_digest
    @user.send_password_reset_email

    render json: { message: :ok, detail: "Sent" }
  end

  private 

  def get_user
    @user = User.find_by_email(params[:email])
  end

  def valid_user
    unless @user.nil? || @user.authenticated?(params[:id]) || @user.password_reset_expired?
      flash[:danger] = "Invalid or expired link" 
      redirect_to new_password_reset_url
    end
  end
end
