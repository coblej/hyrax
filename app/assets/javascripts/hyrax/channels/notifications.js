App.cable.subscriptions.create("Hyrax::NotificationsChannel", {
    received: function(data) {
        console.log("received");
        let count = data["notify_number"];
        let notification = $('.notify-number');
        let countSelector = notification.find('.count');
        countSelector.html(count);
        if (count == 0) {
            console.log("count is zero");
            countSelector.addClass('invisible');
            notification.prop('aria-label', 'You have no unread notifications');
        }
        else if (count == 1) {
            console.log("count is one");
            countSelector.removeClass('invisible');
            notification.prop('aria-label', 'You have one unread notification');
            countSelector.addClass('label-danger').removeClass('label-default');
        }
        else {
            console.log("count is else");
            countSelector.removeClass('invisible');
            notification.prop('aria-label', 'You have ' + count.toString() + ' unread notifications');
            countSelector.addClass('label-danger').removeClass('label-default');
        }
    }
});
