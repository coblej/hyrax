class StreamNotificationsJob < Hyrax::ApplicationJob
  def perform(users)
    Array.wrap(users).each do |user|
      mailbox = UserMailbox.new(user)
      Hyrax::NotificationsChannel.broadcast_to(user,
                                               notify_number: mailbox.unread_count,
                                               label: mailbox.label)
    end
  end
end
