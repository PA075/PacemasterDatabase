<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<PharmaACE.ForecastApp.Models.SubscriberRegistrationInfo>>" %>
 <%: Styles.Render( "~/Content/AdminCSS")  %>

<link type="text/css" href="../../Content/CSS/adminuserfont-awesome.min.css" rel="stylesheet" />
<style type="text/css">

    .text-left{text-align:left !important;}
body .container.body .right_col {
    background: #F3F3F3 ;
}
</style>
<table class="table table-user-information table-striped table-condensed" id="user_table11" data-toggle="table" data-click-to-select="true">
<tbody>
<tr class="headings" style="width: 20%" id="hiee">
    <th>
            <%: Html.DisplayNameFor(model => model.Id) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.SubscriberName) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.IsActive) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.SubscriptionStartDate) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.SubscriptionEndDate) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.MaxUserNumber) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.DatabaseName) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.DbServer) %>
        </th>
        <%--<th>
            <%: Html.DisplayNameFor(model => model.DbUser) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.DbPassword) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.SPAccount) %>
        </th>--%>
       <%-- <th>
            <%: Html.DisplayNameFor(model => model.SPPassword) %>
        </th>--%>
        <th>
            <%: Html.DisplayNameFor(model => model.Archive) %>
        </th>
        <th>
            <%: Html.DisplayNameFor(model => model.FeedKeyword) %>
        </th>
       <%-- <th>
            <%: Html.DisplayNameFor(model => model.AdminId) %>
        </th>--%>
        <th></th>
    </tr>

<% foreach (var item in Model) { %>
    <tr>
        <td>
            <%: Html.DisplayFor(modelItem => item.Id) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.SubscriberName) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.IsActive) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.SubscriptionStartDate) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.SubscriptionEndDate) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.MaxUserNumber) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.DatabaseName) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.DbServer) %>
        </td>
        <%--<td>
            <%: Html.DisplayFor(modelItem => item.DbUser) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.DbPassword) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.SPAccount) %>
        </td>--%>
       <%-- <td>
            <%: Html.DisplayFor(modelItem => item.SPPassword) %>
        </td>--%>
        <td>
            <%: Html.DisplayFor(modelItem => item.Archive) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.FeedKeyword) %>
        </td>
       <%-- <td>
            <%: Html.DisplayFor(modelItem => item.AdminId) %>
        </td>--%>
        <td>
            <%PharmaACE.ForecastApp.Models.SubscriberRegistrationInfo subscriber = new PharmaACE.ForecastApp.Models.SubscriberRegistrationInfo();
                subscriber = item;
                 %>
             <%: Html.ActionLink(" ", "EditSubscriber", "Admin", item  ,new { @class="fa fa-pencil" , title="Edit Subscriber"}) %></td>
                            
     <%--   <a id="profile" href="javascript:addRowHandlers(<%: Html.DisplayFor(modelItem => item.UserId) %>)" class="btn  btn-md"><i class="fa fa-folder"></i> </a>--%>
       <%-- <a href="javascript:EditSubscriber(<%:item %>);" class="btn  btn-md"><i class="fa fa-pencil" title="Edit Subscriber"></i> </a></td>--%>
       <td> <a href="javascript:DeleteSubscriberByName('<%: Html.DisplayFor(modelItem => item.SubscriberName ) %>');" class="btn  btn-md" title="Delete Subscriber"><i class="fa fa-trash-o"></i> </a>
    </td>
    </tr>
<% } %>

</table>
