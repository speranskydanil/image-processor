class CommonController < ApplicationController
  authorize_resource class: false

  def update_counters
    Node.root.delay.update_counters
    redirect_to Node.root
  end

  def statistics
    @disk_usage_for_zips = Node.where('archive_file_name is not null').map { |n| `du #{n.archive.path}`.to_i }.reduce(&:+).to_i
  end

  def disk_usage_for_images
    pages_count = Page.count
    approx = 0

    if pages_count > 0
      20.times do
        page = Page.where('id >= ?', rand(pages_count)).limit(1).first
        path = page.raw.path.split('original').first
        approx += `du #{path}`.split("\n").last.split(' ').first.to_i / 10 * pages_count
      end
    end

    render text: approx
  end

  def new_mail_to_admin
  end

  def create_mail_to_admin
    AdminMailer.email(params[:message]).deliver
    redirect_to new_mail_to_admin_url, notice: I18n.t('mail_to_admin.created')
  end
end
