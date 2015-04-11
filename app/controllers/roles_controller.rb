class RolesController < ApplicationController
  authorize_resource

  def index
    @roles = Role.all
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def edit
    @role = Role.find(params[:id])
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      redirect_to @role, notice: I18n.t('roles.created')
    else
      render action: 'new'
    end
  end

  def update
    @role = Role.find(params[:id])

    if @role.update_attributes(role_params)
      redirect_to @role, notice: I18n.t('roles.updated')
    else
      render action: 'edit'
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    redirect_to roles_url
  end


  def role_params
    params.require(:role).permit!
  end
end
