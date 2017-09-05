App.cable.subscriptions.create("Hyrax::NotificationsChannel", {
    connected: function(data) {
        this.perform("update_locale", { locale: $('html').attr('lang') })
    },

    received: function(data) {
        let count = data["notify_number"];
        let label = data["label"];
        let notification = $('.notify-number');
        let countSelector = notification.find('.count');

        notification.attr('aria-label', label);
        countSelector.html(count);

        if (count == 0) {
            countSelector.addClass('invisible');
        }
        else if (count == 1) {
            countSelector.removeClass('invisible');
            countSelector.addClass('label-danger').removeClass('label-default');
        }
        else {
            countSelector.removeClass('invisible');
            countSelector.addClass('label-danger').removeClass('label-default');
        }
    }
});
