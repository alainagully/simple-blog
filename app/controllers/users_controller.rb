class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:new]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      redirect_to index_path, notice: "User successfully created"
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end


  #update params to prevent password change
  def update
    @user = current_user
    if @user.authenticate(params[:user][:password]) && @user.update(user_params)
      redirect_to index_path, notice: "User information updated."
    else
      flash[:alert] = "Wrong password" if !@user.authenticate(@user.password)
      render :edit
    end
  end

  def change_password
    @user = current_user
    
  end

  def update_password
    @user = current_user
    old_pw = params[:user][:old_password]
    new_pw = params[:user][:new_password]
    new_pw_conf = params[:user][:new_password_confirmation]
    if !@user.authenticate(old_pw)
      flash[:alert] = "Wrong password"
      render :change_password
    elsif new_pw != new_pw_conf
      flash[:alert] = "New passwords do not match"
      render :change_password
    elsif new_pw == old_pw
      flash[:alert] = "The new password must differ from the old one"
      render :change_password
    elsif new_pw.length < 4
      flash[:alert] = "New password is too short"
      render :change_password
    else
      @user.password = new_pw
      if @user.save
        redirect_to index_path, notice: "Password changed"
      end
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
