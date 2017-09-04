class StreamNotificationsJob < Hyrax::ApplicationJob
  def perform(users)
    Array.wrap(users).each do |user|
      Hyrax::NotificationsChannel.broadcast_to(user,
                                               notify_number: user.mailbox.inbox(unread: true).count)
    end
  end
end
