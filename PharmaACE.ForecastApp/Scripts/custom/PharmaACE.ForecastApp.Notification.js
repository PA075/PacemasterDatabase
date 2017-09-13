
$(document).ready(function () {
    $('#flyerbox .dropdown').click(function () {
        //alert('in');
       // if ($(this).hasClass('open')) {
            if ($('#flyerInnerbox>li').length >= 0) {
                var notificationLength = $('#flyerInnerbox>li').length;
                var notificationIdArr = [];

                for (var i = 0 ; i < notificationLength ; i++) {
                    if ($('#flyerInnerbox>li')[i].children[0]) {
                        var firstChildOfBell = $('#flyerInnerbox>li')[i].children[0];
                        if (firstChildOfBell.children[1]) {
                            var secondchildOfBell = firstChildOfBell.children[1];
                            if (secondchildOfBell.children[0]) {
                                var checkIsread = secondchildOfBell.children[0]
                                var notificationReadOrNot = checkIsread.getAttribute('isReadAttr');
                                if (notificationReadOrNot == "false") {
                                    var recentnotificationId = secondchildOfBell.children[0].value;
                                    notificationIdArr.push(recentnotificationId);
                                    //var url = window.location.pathname.split("/");
                                    //var calleeName = url[1];
                                }
                            }
                        }
                    }
                }
                var url = "";
                url = "/Home/UpdateNotificationStatus";
                var postData = JSON.stringify({ "NotificationIdArr": notificationIdArr });
                PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData(url, postData,
                function (result) {
                    if (result.success) {
                        //successfully updated notification status
                        GetNotifications();
                    }
                    else {
                        //failed to update notification status
                    }
                },
                     function (result) {
                         //failed to update notification status
                     });
            }
       // }
    });
});

