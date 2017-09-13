<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<ul class="nav navbar-right" id="flyerbox">
    <li class="dropdown">
        <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false" onmouseover="return false;" id="notificationid" >
            <i class="fa fa-bell"></i>
            <span class="badge" id="notification-num"></span>
        </a>
        <ul class="dropdown-menu list-unstyled msg_list wow animated fadeInDown" id="flyerInnerbox">
         </ul>
    </li>
</ul>


<script>
    //start Notification code
    //window.setInterval(function () {
    //    GetNotifications();
    //}, 5000);
    //Ends Notification code
    $(document).ready(function () {
        GetNotifications();
    });

    function GetNotifications() {
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/GetUserNotification", null,
            function (result) {
                if (result.success) {
                    PHARMAACE.FORECASTAPP.UTILITY.populateNotificationList(result.notifications)
                }
            });
    }
</script>

