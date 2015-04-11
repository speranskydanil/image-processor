class JobsController < ApplicationController
  authorize_resource class: false

  def index
    @jobs = Delayed::Job.all.page(params[:page]).per(params[:per_page] || @project.default_per_page)
  end

  def update
    Delayed::Job.find(params[:id]).update_attributes(params.require(:job).permit!)
    redirect_to jobs_path
  end

  def destroy
    Delayed::Job.find(params[:id]).destroy
    redirect_to jobs_path
  end

  def destroy_all
    Delayed::Job.destroy_all
    redirect_to jobs_path
  end
end

