class StreamNotificationsJob < Hyrax::ApplicationJob
  def perform(users)
    Array.wrap(users).each do |user|
      Hyrax::NotificationsChannel.broadcast_to(user.user_key,
                                               notify_number: user.mailbox.inbox(unread: true).count)
    end
  end
end
