<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<ul class="nav navbar-right" id="flyerbox">
    <li class="dropdown">
        <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false" onmouseover="return false;">
            <i class="fa fa-bell"></i>
            <span class="badge" id="notification-num"></span>
        </a>
        <ul class="dropdown-menu list-unstyled msg_list wow animated fadeInDown" id="flyerInnerbox" style="visibility: visible; animation-name: fadeInDown;">
         </ul>
    </li>
</ul>
  <style type="text/css">
/*
    #flyerInnerbox {
 overflow: auto;
 height: 280px;
}
*/
</style>

