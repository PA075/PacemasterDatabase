<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<meta name="viewport" content="initial-scale=1, maximum-scale=1.5">
<%: Styles.Render("~/Content/forecastIndexCSS") %>
<%--<link href="../../Content/CSS/animate.css" rel="stylesheet" />--%>
<%: Scripts.Render("~/Scripts/forecastIndexScript") %>
<%--<script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>--%>
<style>
    .disabledbutton {
    pointer-events: none;
    opacity: 0.4;
}
    #page-content-wrapper {
    min-height: 560px;
}
</style>

<header id="header" class="generHome">       
    <%Html.RenderAction("RenderHeader", "Header", new { headerType ="ForecastIndex" }); %>
    </header>
       <div id="page-content-wrapper"><!-- Page Content -->
		<div class="container">
			<div class="row">
            <!-- InstanceBeginEditable name="Content Area" -->
				
					 <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 app-bar wow fadeInDown" style="display:flex;">
					
                    <section class="example" id="hpagegrid">
					<div class="col-xs-6  col-sm-4 col-md-4 wow fadeInDown  animated" data-wow-duration="600ms" data-wow-delay="100ms" style="animation-duration: 600ms; animation-delay: 100ms; animation-name: fadeInDown;">
			   			<%if (Session["user"] != null)
                            {if ((Boolean)(Session["GenericTool"]) == true) {
                        %>
                        <div id="genericBox"class="panel panel-default box-shadow--16dp img-zoom">
							<div class="panel-heading">Generic Tool</div>
                                 <div class="panel-body">
	                                   <a id="generic_tool" class="forecast_model" href="<%=Url.Action("ForecastModel", "Forecast",  new { type = 0 })%>"> <img title="Generic Tool" alt="Generic Tool" src="../../Content/img/generic.png" />  </a></div>
                           <%--<%if(int.Parse(Session["RoleId"].ToString())==3){ %>
                                <label style="padding-left:77px;">Try new Version ? <a href="<%=Url.Action("Forecaster", "Forecast",  new { type = 0 })%>"> Click Here </a></label> 
                              <% } %>--%>     
						</div>	
                         <% }
                        else
                         {
                         %>
                          <div  id="genericBox" class="panel panel-default box-shadow--16dp img-zoom opac">
							<div class="panel-heading">Generic Tool</div>
                                 <div class="panel-body">
	                      <a id="generic_tool" class="forecast_model" href="<%=Url.Action("ForecastModel", "Forecast",  new { type = 0 })%>" onclick="return false;"> <img title="Generic Tool" alt="Generic Tool" src="../../Content/img/generic.png" />  </a></div>
                           <%--<%if(int.Parse(Session["RoleId"].ToString())==3){ %>
                                <label style="padding-left:77px;">Try new Version ? <a href="<%=Url.Action("Forecaster", "Forecast",  new { type = 0 })%>"> Click Here </a></label> 
                              <% } %>--%>     
						</div>	

                        <%
                        }
                        }
                        else
                        {%> 
                            <div  id="genericBox" class="panel panel-default box-shadow--16dp img-zoom opac">
							<div class="panel-heading">Generic Tool</div>
                                 <div class="panel-body">
	                      <a id="generic_tool" class="forecast_model" href="<%=Url.Action("ForecastModel", "Forecast",  new { type = 0 })%>" onclick="return false;"> <img title="Generic Tool" alt="Generic Tool" src="../../Content/img/generic.png" />  </a></div>
                           <%--<%if(int.Parse(Session["RoleId"].ToString())==3){ %>
                                <label style="padding-left:77px;">Try new Version ? <a href="<%=Url.Action("Forecaster", "Forecast",  new { type = 0 })%>"> Click Here </a></label> 
                              <% } %>--%>     
						</div>	

                         <%} %>  
                        			
					</div>
                      
					
                    <div class="col-xs-6  col-sm-4 col-md-4 wow fadeInDown  animated" data-wow-duration="600ms" data-wow-delay="100ms" style="animation-duration: 600ms; animation-delay: 100ms; animation-name: fadeInDown;">
			   			
                        <%if (Session["user"] != null)
                                                   {if ((Boolean)(Session["BDLTool"]) == true) {
                                                %>
                        <div id="bdlBox" class="panel panel-default box-shadow--16dp img-zoom">
							<div class="panel-heading">BD&L Tool</div>
							<div class="panel-body"><a id="bdl_tool" class="forecast_model" href="<%=Url.Action("ForecastModel", "Forecast",  new { type = 1 })%>"><img title="BD&L Tool" alt="BD&L Tool" src="../../Content/img/bdev.png"> </a></div>
						</div>

                         <% }
                        else
                            {
                                %>
                             <div id="bdlBox" class="panel panel-default box-shadow--16dp img-zoom opac">
							<div class="panel-heading">BD&L Tool</div>
							<div class="panel-body"><a id="bdl_tool" class="forecast_model" href="<%=Url.Action("ForecastModel", "Forecast",  new { type = 1 })%>" onclick="return false;"><img title="BD&L Tool" alt="BD&L Tool" src="../../Content/img/bdev.png"> </a></div>
						</div>
                         <%
                        }
                        }
                        else
                        {%> 
                           <div id="bdlBox" class="panel panel-default box-shadow--16dp img-zoom opac">
							<div class="panel-heading">BD&L Tool</div>
							<div class="panel-body"><a id="bdl_tool" class="forecast_model" href="<%=Url.Action("ForecastModel", "Forecast",  new { type = 1 })%>" onclick="return false;"><img title="BD&L Tool" alt="BD&L Tool" src="../../Content/img/bdev.png"> </a></div>
						</div>

                          <%} %>  

					</div>
                       
                       
					<div class="col-xs-6  col-sm-4 col-md-4 wow fadeInDown  animated" data-wow-duration="600ms" data-wow-delay="500ms" style="animation-duration: 600ms; animation-delay: 500ms; animation-name: fadeInDown;">
			   		 <%if (Session["user"] != null)
                                                   {if ((Boolean)(Session["PatientFlow"]) == true) {
                                                %>
                        	<div id="patientBox" class="panel panel-default box-shadow--16dp img-zoom">
							<div class="panel-heading">Patient Flow</div>
							<div class="panel-body "> <a id="acthar_tool" class="forecast_model" href="<%=Url.Action("ForecastModel", "Forecast",  new { type = 2 })%>"><img title="Patient Flow" alt="Patient Flow" src="../../Content/img/patient.jpg"></a></div>
						</div>	
                         <% }
                        else
                            {
                                %>
                            <div id="patientBox" class="panel panel-default box-shadow--16dp img-zoom opac">
							<div class="panel-heading">Patient Flow</div>
							<div class="panel-body "> <a id="acthar_tool" class="forecast_model" href="<%=Url.Action("ForecastModel", "Forecast",  new { type = 2 })%>" onclick="return false;"><img title="Patient Flow" alt="Patient Flow" src="../../Content/img/patient.jpg"></a></div>
						</div>	
                         <%
                        }
                        }
                        else
                        {%> 
                            <div id="patientBox" class="panel panel-default box-shadow--16dp img-zoom opac">
							<div class="panel-heading">Patient Flow</div>
							<div class="panel-body "> <a id="acthar_tool" class="forecast_model" href="<%=Url.Action("ForecastModel", "Forecast",  new { type = 2 })%>" onclick="return false;"><img title="Patient Flow" alt="Patient Flow" src="../../Content/img/patient.jpg"></a></div>
						</div>	

                         <%} %>  

                        					 
					</div>
                        </section>
                          				
			                   
                    </div>
                        <div class="tab-content">
                        <div class="tab-pane fade" id="sectionA">
                            <h3>Section A</h3>
                            <p>Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui. Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth.</p>
                        </div>
                        <div class="tab-pane fade" id="sectionB">
                            <h3>Section B</h3>
                            <p>Vestibulum nec erat eu nulla rhoncus fringilla ut non neque. Vivamus nibh urna, ornare id gravida ut, mollis a magna. Aliquam porttitor condimentum nisi, eu viverra ipsum porta ut. Nam hendrerit bibendum turpis, sed molestie mi fermentum id. Aenean volutpat velit sem. Sed consequat ante in rutrum convallis. Nunc facilisis leo at faucibus adipiscing.</p>
                        </div>
						<div class="tab-pane fade active in" id="dropdown1"></div>
                        <div class="tab-pane fade" id="dropdown2">
                            <h3>Dropdown 2</h3>
                            <p>Donec vel placerat quam, ut euismod risus. Sed a mi suscipit, elementum sem a, hendrerit velit. Donec at erat magna. Sed dignissim orci nec eleifend egestas. Donec eget mi consequat massa vestibulum laoreet. Mauris et ultrices nulla, malesuada volutpat ante. Fusce ut orci lorem. Donec molestie libero in tempus imperdiet. Cum sociis natoque penatibus et magnis.</p>
                        </div>
					</div>
			
       
                
                
                
                
                
                
                 </div>       
        </div>
          <%if(int.Parse(Session["RoleId"].ToString())==3){ %>
           <div >
                   <% Html.RenderAction("Index", "SelectFile"); %>
                   <a data-dismiss="modal" class="btn" onclick="UploadExcel();">Upload Excel</a>
           </div>
           <%} %>
            <div style="text-align: center; vertical-align: middle;">
                <img src="../../Content/img/ajax-loader.gif" id="loading-indicator" style="display: none" />
            </div>
       </div>
    <footer class="midnight-blue" id="footer">
       <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    © 2016 <a title="PharmaAce" href="#" target="_blank">PharmaACE</a>. All Rights Reserved.
                </div>
            </div>
        </div>
    </footer>

<script>
    var roleId = '<%=  Session["RoleId"] %>';
    var generictoolAccess = '<%= Session["GenericTool"]%>';
    var BDLToolAccess = '<%= Session["BDLTool"]%>';
    var PatientFlowAccess = '<%= Session["PatientFlow"]%>';
    var firstname = '<%= Session["FirstName"].ToString().Substring(0, 1)%>';
    var lastname = '<%= Session["LastName"].ToString().Substring(0, 1)%>';
    var tooltiptitle = '<%= Session["User"] %>';
</script>