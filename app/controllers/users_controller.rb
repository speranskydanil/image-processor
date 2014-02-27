class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create_by_admin
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: I18n.t('users.created')
    else
      render action: 'new'
    end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to @user, notice: I18n.t('users.updated')
    else
      render action: 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
