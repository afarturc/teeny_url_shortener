class UserMailer < ApplicationMailer
  before_action :set_recipient
  before_action :set_link

  default to: -> { @recipient.email }

  def expired_link
    mail(subject: 'Link expired')
  end

  private

  def set_recipient
    @recipient = params[:recipient]
  end

  def set_link
    @link = params[:link]
  end
end
