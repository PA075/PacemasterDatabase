<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>PharmaACE Document Portal</title>
<%: Styles.Render("~/Content/glyphiconCSS", "~/Content/bootstrapCSS", "~/Content/fontawesomeCSS", "~/Content/homeIndexCSS") %>
<link href="../../Content/CSS/animate.css" rel="stylesheet" />
<%--<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
 <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
<%: Scripts.Render("~/Scripts/jqueryLIB", "~/Scripts/bootstrapLIB") %>
<script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script> 
 <script src="../../Scripts/lib/bootstrap/bootbox.js"></script>--%>
<%: Scripts.Render("~/Scripts/forecastIndexScript") %>
 <script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
<style>
    .disabledbutton {
    pointer-events: none;
    opacity: 0.4;
}
    #backforproduct, #backforhome{position:absolute; right:23px; bottom:8px;}
    #backforproduct a, #backforhome a, #backforproduct a:hover, #backforhome a:hover{color:#fff;}
    #thirdLoad .panel-body, #secondLoad .panel-body{min-height:140px; line-height:6em;}


  .basic-style > h1 {
    color: #ac2222; }

p.simple-card {
  margin: 0;
  background-color: #fff;
  color: #000;
  font-weight:bold;
  padding: 30px;
  border-radius: 7px;
  min-width: 100px;
  text-align: center;
  box-shadow: 0 3px 6px rgba(204, 131, 103, 0.22); }

.hv-item-parent p {
  font-weight: bold;
  color: #000; }
.hv-wrapper {
  display: flex; }
  .hv-wrapper .hv-item {
    display: flex;
    flex-direction: column;
    margin: auto; }
    .hv-wrapper .hv-item .hv-item-parent {
      margin-bottom: 50px;
      position: relative;
      display: flex;
      justify-content: center; }
      .hv-wrapper .hv-item .hv-item-parent:after {
        position: absolute;
        content: '';
        width: 1px;
        height: 25px;
        bottom: 0;
        left: 47.5%;
        background-color: rgba(255, 255, 255, 0.7);
        transform: translateY(100%); }
    .hv-wrapper .hv-item .hv-item-children {
      display: flex;
      justify-content: center; }
      .hv-wrapper .hv-item .hv-item-children .hv-item-child {
        padding: 0 15px;
        position: relative; }
        .hv-wrapper .hv-item .hv-item-children .hv-item-child:before, .hv-wrapper .hv-item .hv-item-children .hv-item-child:after {
          content: '';
          position: absolute;
          background-color: rgba(255, 255, 255, 0.7);
          left: 0; }
        .hv-wrapper .hv-item .hv-item-children .hv-item-child:before {
          left: 50%;
          top: 0;
          transform: translateY(-100%);
          width: 2px;
          height: 25px; }
        .hv-wrapper .hv-item .hv-item-children .hv-item-child:after {
          top: -25px;
          transform: translateY(-100%);
          height: 2px;
          width: 100%; }
        .hv-wrapper .hv-item .hv-item-children .hv-item-child:first-child:after {
          left: 50%;
          width: 50%; }
        .hv-wrapper .hv-item .hv-item-children .hv-item-child:last-child:after {
          width: calc(50% + 1px); }

        .hv-wrapper .hv-item #secondlevel:after{display:none;}
        .displayTree{display:block !important;}
        #bdl_tool{cursor:pointer;}
        .app-bar #secondLoad .panel-heading {
    font-size: 15px;
    font-weight: bold;
    text-align: center;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    width: 100%;
}

</style>
<script>
var roleId = '<%=  Session["RoleId"] %>';
    var generictoolAccess = '<%= Session["GenericTool"]%>';
    var BDLToolAccess = '<%= Session["BDLTool"]%>';
    var PatientFlowAccess = '<%= Session["PatientFlow"]%>';
    var firstname = '<%= Session["FirstName"].ToString().Substring(0, 1)%>';
    var lastname = '<%= Session["LastName"].ToString().Substring(0, 1)%>';
    var tooltiptitle = '<%= Session["User"] %>';
    function secondLoad() {
        $('#firstLoad').css("display", "none");
        $('#thirdLoad').css("display", "none");
        ('.basic-style').css("display", "none");
        $('#secondLoad').css("display", "block");
        $('#backforhome').css("display", "block");
        $('#backforproduct').css("display", "none");
       
    }
    function thirdLoad() {
        $('#firstLoad').css("display", "none");
        $('#secondLoad').css("display", "none");
        $('#thirdLoad').css("display", "block");
        $('#backforhome').css("display", "none");
        $('#backforproduct').css("display", "block");
    }
    
    $(document).ready(function () {
        var hashdiv = $(location).attr('hash');
        if (hashdiv == '#secondLoad')
            secondLoad()
        else if (hashdiv == '#thirdLoad')
            thirdLoad();
        $('.secondLoad').click(function () {
            //$('#firstLoad').css("display", "none");
            thirdLoad();
            //alert($(location).attr('hash'))
        });
    //start Notification code
         //window.setInterval(function () {
         //       GetNotifications()
         //   }, 5000);
        //Ends Notification code
        var generictoolAccess = '<%= Session["GenericTool"]%>';
        if (generictoolAccess == 0) {
            $("#generic_tool").children().off('click');
            $("#generic_tool").addClass("disabledbutton");
        }

        var BDLToolAccess = '<%= Session["BDLTool"]%>';
        if (BDLToolAccess == 0) {
            $("#bdl_tool").attr("disabled", "disabled").off('click');
            $("#bdl_tool").addClass("disabledbutton");
        }

        var PatientFlowAccess = '<%= Session["PatientFlow"]%>';
        if (PatientFlowAccess == 0) {
            $("#acthar_tool").attr("disabled", "disabled").off('click');
            $("#acthar_tool").addClass("disabledbutton");
        }

        var firstname = '<%= Session["FirstName"].ToString().Substring(0, 1)%>';
			        var lastname = '<%= Session["LastName"].ToString().Substring(0, 1)%>';
			        $("#btnprofile").html(firstname + "" + lastname);
			        var tooltiptitle = '<%= Session["User"] %>';
			        $("#btnprofile").attr("title", tooltiptitle);
			        $('.img-zoom').hover(function () {
			            $(this).addClass('transition');
			        }, function () {
			            $(this).removeClass('transition');
			        });
			    });
    
    function loadDiv()
    {
        $('#firstLoad').css("display", "none");
        $('.basic-style').css("display", "none");
        $('#secondLoad').css("display", "block");
        $('#backforhome').css("display", "block");

        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Reporting/GetProjectNameForForcastReport", {},
       function (result) {
           if (result.success) 
           {
               addProjectsOfForcast(result.projectNames);
           }
           else
           {

           }
       },
       function (result) {

       });
        
    }
    function addProjectsOfForcast(projectNames)
    {
        var str = "";
        var ele = document.getElementById('secondLoad');
        
        projectNames.forEach(function (content, index) {
          
            var projectReportLink = "<%=Url.Action("ReportModel", "Reporting",  new { type = 1 })%>";
            str += '<a id=' + content + "_" + index + ' class="secondLoad" href="' + projectReportLink + '" title="' + content + '">';
                str += '<div class="col-md-3" data-wow-duration="600ms" data-wow-delay="100ms" style="animation-duration: 600ms; animation-delay: 100ms; animation-name: fadeInDown; visibility:visible;">';
                str += '<div class="panel panel-default box-shadow--16dp img-zoom">';
                str += '<div class="panel-heading">' + content + '</div>';
                str += '<div class="panel-body">     <img title="' + content + '" alt="' + content + '" src="../../Content/img/icons-financial-modeling-forecasting.png" /></div>';
                str += '</div>';
                str += '</div>';
                str += '</div>';
                str += '</a>';
                     

        });
        ele.innerHTML = str;

        }
    
    function loadTree()
    {
        //$('.basic-style').toggleClass('displayTree');
        $('.basic-style').fadeToggle( "slow", "linear" );
    }

</script>

<header id="header" class="generHome">       
    <%Html.RenderAction("RenderHeader", "Header", new { headerType ="BI" }); %>
    </header>
       <div id="page-content-wrapper"><!-- Page Content -->
		<div class="container">
			<div class="row">
            <!-- InstanceBeginEditable name="Content Area" -->
				<div class="col-lg-12">
					<div class="col-lg-12 app-bar">
					<div class="row">
                <div id="firstLoad" >

                    <a id="generic_tool" href="<%=Url.Action("ReportModel", "Reporting",  new { type = 0 })%>">
					<div class="col-md-3 wow fadeInDown  animated" data-wow-duration="600ms" data-wow-delay="100ms" style="animation-duration: 600ms; animation-delay: 100ms; animation-name: fadeInDown;">
			   			<div class="panel panel-default box-shadow--16dp img-zoom">
							<div class="panel-heading">Generic Tool</div>
                                 <div class="panel-body">
	                       <img title="Generic Tool" alt="Generic Tool" src="../../Content/img/generic.png" /></div>
						</div>						
					</div>
                        </a>
<%--					<a id="bdl_tool" href="#secondLoad" onclick="loadDiv()">--%>
<%--                      <a id="bdl_tool"  href="<%=Url.Action("ReportModel", "Reporting",  new { type = 1 })%>" <%--onclick="loadTree()"--%> 
                          <a id="bdl_tool"  href="#" onclick="loadTree()" >
                    <div class="col-md-3 wow fadeInDown  animated" data-wow-duration="600ms" data-wow-delay="100ms" style="animation-duration: 600ms; animation-delay: 100ms; animation-name: fadeInDown;">
			   			<div class="panel panel-default box-shadow--16dp img-zoom">
							<div class="panel-heading">BD&L Tool</div>
							<div class="panel-body"><img title="BD&L Tool" alt="BD&L Tool" src="../../Content/img/bdev.png"></div>
						</div>

                        



					</div>
                        </a>
                        <a id="acthar_tool" href="<%=Url.Action("ReportModel", "Reporting",  new {  type = 2 })%>">
					<div class="col-md-3 wow fadeInDown  animated" data-wow-duration="600ms" data-wow-delay="500ms" style="animation-duration: 600ms; animation-delay: 500ms; animation-name: fadeInDown;">
			   			<div class="panel panel-default box-shadow--16dp img-zoom">
							<div class="panel-heading">Inline</div>
							<div class="panel-body "><img title="Patient Flow" alt="Patient Flow" src="../../Content/img/patient.jpg"></div>
						</div>						 
					</div>
                            </a>
                        </div>

<section class="basic-style" id="basic-style" style="float:left;width:77%; display:none; ">
        
        <div class="hv-container">
            <div class="hv-wrapper">

                <!-- Key component -->
                <div class="hv-item">

                    <div class="hv-item-parent">
                        <%--<p class="simple-card"> Parent </p>--%>
                    </div>

                    <div class="hv-item-children">

                        <div class="hv-item-child">
                            <!-- Key component -->
                            <div class="hv-item">

                                <div class="hv-item-parent" id="secondlevel">
<%--                                    <p class="simple-card"><a  href="#secondLoad" onclick="loadDiv()" style="color:#000;">Forecast reporting</a></p>--%>
<a  href="#secondLoad" onclick="loadDiv()" >
                                    <div  style="visibility: visible; width:250px; ">

         <div class="panel panel-default box-shadow--16dp ">
       <div class="panel-heading">Forecast reporting</div>
                                 <div class="panel-body">
                        <img title="Forecast reporting" alt="Forecast reporting" src="../../Content/img/icons-financial-modeling-forecasting.png"></div>
      </div>      
     </div>
    </a>
                                </div>

                              

                            </div>
                        </div>


                        <div class="hv-item-child">
<%--                            <p class="simple-card">As-is analysis</p>--%>
                            <a  href="<%=Url.Action("AsIsAnalysis", "Reporting",  new { type = 1 })%>">

                             <div  style="visibility: visible; width:250px; ">
                             <div class="panel panel-default box-shadow--16dp ">
       <div class="panel-heading">As-is analysis</div>
                                 <div class="panel-body">
                        <img  style=" padding-bottom:15px;padding-top:15px;" title="As-is analysis" alt="As-is analysis" src="../../Content/img/analyze-analyze-icon.png"></div>
      </div>      
     </div>
                                </a>
                            </div>

                        <%--<div class="hv-item-child">
                            <p class="simple-card">Consolidation </p>
                        </div>--%>

                    </div>

                </div>

            </div>
        </div>
    </section>

                        <div id="secondLoad">

                           
                        </div>	
                        
                        <div id="thirdLoad" style="display:none;">

                            <a id="generic_tool2" class="thirdLoad"  href="#">
					<div class="col-md-3 wow fadeInDown  animated" data-wow-duration="600ms" data-wow-delay="100ms" style="animation-duration: 600ms; animation-delay: 100ms; animation-name: fadeInDown;">
			   			<div class="panel panel-default box-shadow--16dp img-zoom">
							<div class="panel-heading">Project 31</div>
                                 <div class="panel-body">Project 31
	                       <%--<img title="Generic Tool" alt="Generic Tool" src="../../Content/img/generic.png" />--%></div>
						</div>						
					</div>
                        </a>
					<a id="bdl_tool2" href="#" class="thirdLoad">
                    <div class="col-md-3 wow fadeInDown  animated" data-wow-duration="600ms" data-wow-delay="100ms" style="animation-duration: 600ms; animation-delay: 100ms; animation-name: fadeInDown;">
			   			<div class="panel panel-default box-shadow--16dp img-zoom">
							<div class="panel-heading">Project 33</div>
							<div class="panel-body">Project 33<%--<img title="BD&L Tool" alt="BD&L Tool" src="../../Content/img/bdev.png">--%></div>
						</div>
					</div>
                        </a>
                        <a id="acthar_tool2" href="#" class="thirdLoad">
					<div class="col-md-3 wow fadeInDown  animated" data-wow-duration="600ms" data-wow-delay="500ms" style="animation-duration: 600ms; animation-delay: 500ms; animation-name: fadeInDown;">
			   			<div class="panel panel-default box-shadow--16dp img-zoom">
							<div class="panel-heading">Project 32</div>
							<div class="panel-body ">Project 32<%--<img title="Patient Flow" alt="Patient Flow" src="../../Content/img/patient.jpg">--%></div>
						</div>						 
					</div>
                            </a>	

                        </div>					
			</div>                    
                    </div>
                       <!-- <div class="tab-content">
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
					</div>-->
				</div>
        </div>       
        </div>
         
            <div style="text-align: center; vertical-align: middle;">
                <img src="../../Content/img/ajax-loader.gif" id="loading-indicator" style="display: none" />
            </div>

           <div id="backforhome" style="display:none;">
               <a href="/Reporting" target="_self"><button type="button" class="btn btn-primary btn-arrow-left">Back</button></a> 
            </div>
           <div id="backforproduct" style="display:none;">
               <a href="Reporting/#secondLoad" target="_self"><button type="button" class="btn btn-primary btn-arrow-left">Back</button></a> 
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
<%: Scripts.Render("~/Scripts/commonLIB") %>
