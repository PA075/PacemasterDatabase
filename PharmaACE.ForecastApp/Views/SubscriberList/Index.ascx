<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<PharmaACE.ForecastApp.Models.SubscriberListModel>" %>
 <script src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
    <div class="item form-group">
            <%: Html.LabelFor(model=> model.SubscriberList) %>
            <%: Html.DropDownListFor(model => model.SubscriberList, Model.SubscriberList, new {@id = "SubscriberId",@test = "SubscriberName", @class="selectpicker", onchange = "SubscriberSelected();", style = "Text-align:left; padding:0px 5px 0px 5px; border:1px solid #7D7D7D; border-radius:5px;" })%>
               </div>
<script type="text/javascript">
    function SubscriberSelected() {
        var ele = document.getElementById('SubscriberId');
        var subscriberId = ele.options[ele.selectedIndex].value;       
        getUsersList(subscriberId);
        return false;
    }
    function table1(UsersList) {
    }
</script>
    