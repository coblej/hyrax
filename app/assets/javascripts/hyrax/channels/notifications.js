App.cable.subscriptions.create("Hyrax::NotificationsChannel", {
    received: function(data) {
        let count = data["notify_number"]
        let notification = $('.notify_number');
        let countSelector = notification.find('.count');
        countSelector.html(count);
        if (count == 0) {
            countSelector.addClass('invisible');
            notification.prop('aria-label', 'You have no unread notifications');
        }
        else if (count == 1) {
            countSelector.removeClass('invisible');
            notification.prop('aria-label', 'You have one unread notification');
            notification.addClass('label-danger').removeClass('label-default');
        }
        else {
            countSelector.removeClass('invisible');
            notification.prop('aria-label', 'You have %{count} unread notifications');
            notification.addClass('label-danger').removeClass('label-default');
        }
    }
});
