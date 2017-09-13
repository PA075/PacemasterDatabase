<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<PharmaACE.ForecastApp.Models.TopHeader>" %>
<%: Styles.Render( "~/Content/GlobalPaceCSS")  %>  
<div id="bodyOverlay"></div>
<div id="nav-wrapper">
   <nav id="headerbar" role="banner" class="navbar navbar-inverse fixed " data-spy="affix" data-offset-top="70">
      <div class="container-fluid">
         <div class="row">
            <nav class="col-md-12 col-sm-12 col-xs-12 ">
               <div  class="col-md-2 col-sm-3 col-xs-4 logo margin-none " id="header-logo">
                  <a href="<%=Url.Action("Index", "Home")%>" class="">
                  <img class="user-image img-responsive-logo rhDiv1" src="../../Content/img/logos.png">
                  </a>
                  <a href="<%=Model.LogoImageHref%>">
                  <img class="user-image img-responsive" src="<%=Model.LogoImagePath%>" >
                  </a>
               </div>
               <div  class="col-md-3 col-sm-3 col-xs-1 margin-none " id="page-heading" >
                  <div id="mainheading">
                     <h2><%=Model.PageHeader %></h2>
                  </div>
               </div>
               <div class="col-md-6 col-sm-2 col-xs-1 " id="header-menu">
                  <%if (Model.PageMenu!=null){ %>
                  <nav role="navigation" class="navbar navbar-default" id="menu-burger">
                     <div class="navbar-header">
                        <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        </button>
                     </div>
                  </nav>
                  <%} %>   
                  <%if (Model.PageMenu == "KMHeaderMenu"){ %>
                  <div id="MenuDiv" ><%Html.RenderPartial("HeaderViews/KMHeaderMenu");%>
                  </div>
                  <%}
                     else if (Model.PageMenu == "ForecastMenu")
                     {%>
                  <div id="MenuDiv2" ><%Html.RenderPartial("ForecastMenu");%>
                  </div>
                  <%}
                     else if (Model.PageMenu == "ForecasterMenu")
                     {%>
                  <div id="MenuDiv2" ><%Html.RenderPartial("ForecasterMenu");%>
                  </div>
                  <%}
                     else if (Model.PageMenu == "CFHeaderMenu")
                     {%>
                  <div id="MenuDiv2" ><%Html.RenderPartial("HeaderViews/CFHeaderMenu");%>
                  </div>
                  <%} %>
               </div>
               <div class="col-md-1 col-sm-4 col-xs-6 pull-right  margin-none" id="header-icons" >
                  <%Html.RenderPartial("HeaderViews/ProfileLogo"); %>
                  <%Html.RenderPartial("HeaderViews/_Squares"); %>
                  <%Html.RenderPartial("HeaderViews/_Notification"); %>
               </div>
               <%if (Model.PopalertDisplay)
                  {%>
               <div id="popalert" class="alert-info" style="display: none;">
                  <span class="close" data-dismiss="alert">&times;</span>
                  <p class="rhDiv2"></p>
               </div>
               <%} %>
            </nav>
         </div>
      </div>
   </nav>
</div>
<%if (Model.BreadcrumbDisplay)
   { %>
<div class="col-md-12" id="breadcrumb">
   <div class="container">
      <div class="row">
         <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="col-md-7 col-sm-7 col-xs-6">
               <div id="breadcrumb-title"><%: Html.MvcSiteMap().SiteMapPath() %></div>
            </div>
         </div>
      </div>
   </div>
</div>
<%} %>
<div id="navbarCollapse" class="collapse navbar-collapse">
   <div class="container">
      <%if (Model.PageMenu == "KMHeaderMenu"){ %>
      <div id="inMenuDiv"><%Html.RenderPartial("HeaderViews/KMHeaderMenu");%>
      </div>
      <%}
         else if (Model.PageMenu == "ForecastMenu")
         {%>
      <div id="inMenuDiv2"><%Html.RenderPartial("ForecastMenu");%>
      </div>
      <%} %>
   </div>
</div>
<!-- Collection of nav links and other content for toggling -->