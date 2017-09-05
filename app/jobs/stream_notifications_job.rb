class StreamNotificationsJob < Hyrax::ApplicationJob
  def perform(users)
    Array.wrap(users).each do |user|
      Hyrax::NotificationsChannel.broadcast_to(user,
                                               notify_number: UserMailbox.new(user).unread_count)
    end
  end
end
