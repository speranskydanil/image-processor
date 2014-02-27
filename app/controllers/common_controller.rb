class CommonController < ApplicationController
  def statistics
  end

  def disk_usage_for_images
    pages_count = Page.count
    approx = 0.0

    if pages_count == 0
      render text: "~ #{approx.round(2)} #{dim}"
      return
    end

    20.times do
      page = Page.where('id >= ?', rand(pages_count)).limit(1).first
      path = page.raw.path.split('original').first
      approx += `du #{path}`.split("\n").last.split(' ').first.to_i / 10 * pages_count
    end

    if approx > 1e9
      approx, dim = approx / 1e9, 'TB'
    elsif approx > 1e6
      approx, dim = approx / 1e6, 'GB'
    elsif approx > 1e3
      approx, dim = approx / 1e3, 'MB'
    else
      dim = 'KB'
    end

    render text: "~ #{approx.round(2)} #{dim}"
  end

  def new_mail_to_admin
  end

  def create_mail_to_admin
    AdminMailer.email(params[:message]).deliver
    redirect_to new_mail_to_admin_url, notice: I18n.t('mail_to_admin.created')
  end
end
