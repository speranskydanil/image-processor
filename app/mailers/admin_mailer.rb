class AdminMailer < ActionMailer::Base
  def email(msg)
    @msg = msg
    mail(from: 'image_processor@company.com', to: 'image_processor@company.com', subject: 'Image Processor')
  end
end

