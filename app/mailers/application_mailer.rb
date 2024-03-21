class ApplicationMailer < ActionMailer::Base
  before_action :set_recipient

  default from: 'teeny@deemaze.com'

  layout 'mailer'

  private

  def set_recipient
    @recipient = params[:recipient]
  end
end
