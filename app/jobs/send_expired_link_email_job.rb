class SendExpiredLinkEmailJob
  include Sidekiq::Job
  sidekiq_options queue: 'default'

  def perform(link_id)
    link = Link.find(link_id)
    UserMailer.with(recipient: link.user, link:)
              .expired_link
              .deliver_now
    link.destroy
  end
end
