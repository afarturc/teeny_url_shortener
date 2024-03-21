class EnqueueExpiredLinkEmailJob
  include Sidekiq::Job
  sidekiq_options queue: 'default'

  def perform
    Link.expired
        .pluck(:id)
        .each do |link_id|
      SendExpiredLinkEmailJob.perform_async(link_id)
    end
  end
end
