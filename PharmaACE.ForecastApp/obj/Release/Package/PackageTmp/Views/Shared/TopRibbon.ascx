<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
 <%Html.RenderPartial("_Notification"); %>
<nav class="navbar navbar-inverse fixed affix-top" role="banner" id="headerbar">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-1 logo " id="" style ="display:inline-block;">
                        <div class="pull-left left-bar">
                            <a href="<%=Url.Action("Index", "Home")%>" class="">
                                <img class="user-image img-responsive" src="<%=Model.LogoImagePath%>"></a>
                        </div>
                    </div>
                    <div class="col-md-8 tagline" id="">
                        <h2><span><%=Model.PageHeader %></span></h2>
                    </div>
                    <div class="col-md-3 " id="">
                        <div class=" " >
                            <div>
                             <%Html.RenderPartial("ProfileLogo"); %>
                            <%Html.RenderPartial("_Squares"); %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
     </div>
    </nav>
<%--<div>
<%Html.RenderPartial("Footer"); %>
    </div>--%>
