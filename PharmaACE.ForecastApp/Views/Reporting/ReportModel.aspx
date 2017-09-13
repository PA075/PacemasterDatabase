<%--<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>--%>
<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.ReportingModel>" %>

<%@ Import Namespace="PharmaACE.ForecastApp.Models" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>PACE Homepage Reporting</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge;">

    <%--<link href="../../Content/CSS/font-awesome.css" rel="stylesheet" />
<link href="../../Content/CSS/custom.css" rel="stylesheet" />
    <link href="../../Content/CSS/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/CSS/bootstrap-glyphicons.css" rel="stylesheet" />
    <link href="../../Content/CSS/animate.css" rel="stylesheet" />
    <link href="../../Content/CSS/pharmabi.min.css" rel="stylesheet" />
    <link href="../../Content/CSS/daterangepicker.css" rel="stylesheet" />
    <link href="../../Content/CSS/bootstrap-colorpicker.css" rel="stylesheet" />  --%>
      <link href="../../Content/CSS/pharmabi.min.css" rel="stylesheet" />
    <%: Styles.Render("~/Content/ReportingIndexCSS")  %>
    <%--<script src="../../Scripts/lib/jquery/jquery.min.js"></script>--%>
    <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>-->
    <%--<script src="../../Scripts/lib/bootstrap/bootstrap.min.js"></script>
        <script type="text/javascript" src="../../Scripts/lib/bootstrap/bootbox.js" ></script>
    <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>
    <script  type="text/javascript" src="../../Scripts/lib/jquery/moment.min.js"></script>
    <script  type="text/javascript" src="../../Scripts/lib/jquery/daterangepicker.js"></script>
    <script src="../../Scripts/lib/bootstrap/bootstrap-colorpicker.js"></script>    
    <script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>
    <script src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js" defer="defer"></script>--%>
    <%: Scripts.Render("~/Scripts/ReportingtIndexScript") %>
    <link href="../../Content/CSS/aero.css" rel="stylesheet" />
     <link href="../../Content/CSS/calendarDefault.css" rel="stylesheet" />
<link href="../../Content/CSS/calendarStyle.css" rel="stylesheet" />
    <script src="../../Scripts/lib/jquery/calendar_zebra_datepicker.js"></script>
    <%--<script src="../../Scripts/lib/jquery/jquery-ui.js"></script--%>>
     <script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
    <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
    <script src="../../Scripts/lib/bootstrap/bootstrap-select.min.js"></script>
    <link href="../../Content/CSS/bootstrap-select.min.css" rel="stylesheet" />
<style type="text/css">
    #IframeInner{height:100%; margin-top:22px;

    }
    .custom-dialogue .modal-dialog{width:360px;}
    #dataList {
         height: 362px;
            overflow: auto;
            top:0px !important; position:relative; clear:both; 
    }
  .visual-icon img{ width:22px; opacity:1; }
.ownershipFitlerCollapsibleSection .nav{ width:100%;}
.ownershipFitlerCollapsibleSection .nav a{ width:100%;}
        .paneHeader button {
            border-radius: 0px !important;
        }

        button.Visualization, button.Pane {
            border-radius: 0px !important;
        }

        .h2, h2 {
            font-size: 16px;
        }

        .h3, h3 {
            font-size: 14px;
        }




        #scollableDiv {
            height: 282px;
            overflow: auto;
        }


        .scrollRegion {
            overflow: visible !important;
            height: 514px;
        }


        #divexample2 {
            height: 300px;
        }

        #divexample3 {
            height: 300px;
        }

        .ui-draggable ul.dropdown-menu {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            display: block;
            padding: 2%;
            width: 100%;
        }
         #datepicker-start, #datepicker-end{width:81px; margin-left:0px; font-size:11px;}
        .Zebra_DatePicker_Icon_Wrapper{ 
    bottom: 0 !important;
    
    float: left !important;
    height: 41px;
    left: 0 !important;
    margin: 0;
    padding: 0;
    position: relative !important;
    right: 0 !important;
    top: 0 !important;
    width: 82px !important;}
    button.Zebra_DatePicker_Icon_Inside_Right {
        margin: 0px;
        top: 9px !important;
        left:2px !important;
    }
    /*.explorationContainer .fieldListProperty*/
    iframe{width:100% !important; margin:0 auto;}
    .checkbox .toggle.slow{width:70px !important;}
    .toggle-on.btn-sm{padding-left:11px;}
    .toggle-off.btn-sm,.toggle-on.btn-sm{ font-weight:bold;}
    .toggle-off.btn-sm{padding-left:16px;}
    #resetReport{color:#fff;}
    .chart-type{ font-size:14px;}
    button.visual-icon-container{ background:none; border:0px; border-radius:0px;}
    .sectionHeader input[type=checkbox], .sectionHeader input[type=radio]{ margin:2px 0 0 !important; margin-left:-5px !important;}
    
   .page1_header .banner {
    background-color: #C4C2C2;
    color: #ffffff;
    display: block;
    width: 100%;
    text-align: center;
    float: left;
    font-size: 14px;
    padding: 15px 0 14px;
}
    .page1_header .banner .fa {
        margin-bottom: 10px;
        display: block;
        font-size: 22px;
        line-height: 12px;
    }
    .page1_header .banner:nth-child(2n) {
        /*background-color: #bfbdbd;*/
    }
    /*.page1_header .banner:first-child + .banner + .banner {
  background-color: #00b1ba;
}*/
    .page1_header .banner.maxheight1 .fa {
        margin-bottom: 10px;
    }
    .page1_header .banner:hover {
       /* background-color: #000000 !important;*/
    }
.btn-file {
    position: relative;
    overflow: hidden;
}
    .btn-file input[type=file] {
        position: absolute;
        top: 0;
        right: 0;
        min-width: 100%;
        min-height: 100%;
        font-size: 100px;
        text-align: right;
        filter: alpha(opacity=0);
        opacity: 0;
        outline: none;
        background: white;
        cursor: inherit;
        display: block;
    }
.banner p {
    padding-top: 0px !important;
}
/* Tooltip Css */
.tooltipros {
    display: inline;
    position: relative;
    opacity: 1;
}
    .tooltipros:hover:after {
        background: #00b1ba;
        border-radius: 3px;
        bottom: 32px;
        color: #fff;
        content: attr(tooltip);
        left: 0%;
        padding: 5px 6px;
        position: absolute;
        z-index: 999999;
        width: 170px;
        height: auto;
    }
    .tooltipros:hover:before {
        border: solid;
        border-color: #00b1ba transparent;
        border-width: 6px 6px 0 6px;
        bottom: 26px;
        content: "";
        left: 50%;
        position: absolute;
        z-index: 99;
    }
.version_properties li {
    width: auto;
    margin-right: 0%;
    margin-bottom: 0px;
    padding: 0px;
    min-height: 0px;
    color: #000;
    float: left;
}
.version_properties li a, .version_properties .nav-tabs li a:hover {
        color: #000;
    }
#hova:hover {
    background-color: none !important;
    background: none !important;
}
.page1_header .banner {
    background-color: #fff;
    color: #000;
    display: block;
    width: 100%;
    text-align: center;
    float: left;
    font-size: 14px;
    padding:0px;
}
.page1_header .banner a{ color:#000;}
    .page1_header .banner .fa {
        margin-bottom: 10px;
        display: block;
        font-size: 22px;
        line-height: 12px;
    }
    .page1_header .banner:nth-child(2n) {
       /* background-color: #C4C2C2;
        color:#fff;*/
    }
  .version_properties li a, .version_properties .nav-tabs li a:hover {
        color: #000;
    }
#hova:hover {
    background-color: none !important;
    background: none !important;
}
.page1_header .banner {
    background-color: #fff;
    color: #000;
    display: block;
    width: 100%;
    text-align: center;
    float: left;
    font-size: 14px;
    padding:0px;
}
.page1_header .banner a{ color:#000;}
    .page1_header .banner .fa {
        margin-bottom: 10px;
        display: block;
        font-size: 22px;
        line-height: 12px;
    }
    .page1_header .banner:nth-child(2n) {
       /* background-color: #C4C2C2; */
        /*color:#ff;*/
    }
    /*.page1_header .banner:first-child + .banner + .banner {
  background-color: #00b1ba;
}*/
    .page1_header .banner.maxheight1 .fa {
        margin-bottom: 10px;
    }
    .page1_header .banner:hover {
        /*background-color: #000000 !important;*/
    }
.btn-file {
    position: relative;
    overflow: hidden;
}
    .btn-file input[type=file] {
        position: absolute;
        top: 0;
        right: 0;
        min-width: 100%;
        min-height: 100%;
        font-size: 100px;
        text-align: right;
        filter: alpha(opacity=0);
        opacity: 0;
        outline: none;
        background: white;
        cursor: inherit;
        display: block;
    }
.banner p {
    padding-top: 0px !important;
} 
.editable-div{min-height:40px;}
.section_note_write .panel{margin-bottom:3px;}
.panel-heading{text-align:left;padding-left:8px;padding-top:0;padding-bottom:1px;padding-right:4px;}
  .padding-box .no-padding-left{font-weight:700; padding-left:4px; margin-top:0px; text-align:left;}  
  .previous {
    background-color: #f1f1f1;
    color: black;
}

.next {
    background-color: #4CAF50;
    color: white;
}

.round {
    border-radius: 50%;
}
#CategoryListParent .bootstrap-select.btn-group .dropdown-menu li a{padding:4px;}
.navigationPane, .rightSidePane, #bdlTop, #rightScrollerDiv{display:none !important;}
#IframeInner{margin-top:0px;}
</style>
   <script type="text/javascript">
var frameListener;

function frameLoaded(frameLoaded) {
    //var frame = $('iframe').get(0);
    var frame = $('iframe').get(frameLoaded);

    if (frame != null) {
        var frmHead = $(frame).contents().find('head');
        if (frmHead != null) {
            clearInterval(frameListener); // stop the listener
            frmHead.append($('<link/>', { rel: 'stylesheet', href: '../../Content/CSS/iframe.css', type: 'text/css' })); // clone existing css link
        }
    }
}
    </script> 
</head>
<body class="nav-md">

    <div class="themeYellowDark">
        <div class="landingController">
            <div id="topBar" class="unselectable">

                <%Html.RenderAction("RenderHeader", "Header", new { headerType = "BI" }); %>
            </div>
                <div class="landingContainer">
                    <div id="reportLandingContainer" class="landingRootContent reportContainerContent isActive">
                        <div class="exploreCompatibilityContainer">
                            <div class="explorationContainer explorationWithChrome editing">
                                <div class="explorationHost">
                                    <div class="fillAvailableSpace verticalItemsContainer" id="pvExplorationHost">
                                        <div class="contentMain" style="position:relative; float:left; top:-15px; ">
          <div class="navigationPane unselectable" style="position:relative; display:inline-block;">
                    <div class="innerLayout">

                        <div class="expanderBtn" id="menu_toggle">
                            
<%--                            <span class="glyphicon glyphicon-menu-hamburger" title="Hide the navigation pane"></span>--%>
                            <span class="btnIcon glyphicon glyphicon-menu-left pbi-glyph-chevronrightmedium glyph-mini" title="Hide the navigation pane"></span>
<h2 class="verticalTitle verticalText ng-hide">
                                <span class="collapsedVisualsTitle largeFontSize"><i class="fa fa-bar-chart fa-2" aria-hidden="true"></i></span>
                                <span class="collapsedVisualsTitle largeFontSize">Dashboard</span>
                                <%--<div class="sectionTitle">
      <span class="collapseToggle trimmedTextWithEllipsisFullWidth">Dashboards</span>
        <button class="navigationPaneButton addButton" title="Create dashboard"><i class="glyphicon pbi-glyph-add"></i></button>
       </div>--%>

                                <span class="collapsedFiltersTitle largeFontSize">Reports</span></h2>
                                <%--<div class="sectionTitle">
                                   <span class="collapseToggle trimmedTextWithEllipsisFullWidth">Reports</span>
                                </div>--%>
                                </div>
                        <div class="scrollRegion scroll-view">
                            <div class="collapsibleSection groupCollapsibleSection">
                                <div class="sectionTitle trimmedTextWithEllipsis">
                                    <div class="collapseToggle">
                                        <i class="glyphicon pbi-glyph-chevrondownmedium"></i>
                                        <div class="groupsTitle">
                                            <div title="My Workspace" class="trimmedTextWithEllipsis">My Workspace</div>
                                        </div>
                                    </div>
                                    <button class="navigationPaneButton groupContextMenuButton ng-hide"><i class="glyphicon moreIcon pbi-glyph-more"></i></button>
                                </div>
                               <!-- <ul class="navigationItemList">
                                    <li class="navPaneListItem selected" selected="selected">
                                        <div class="navPaneItemIcon">
                                            <div class="groupsListItemIcon groupsUserPhoto"></div>
                                        </div>
                                        <div class="navPaneListItemName trimmed groupNavPaneListItemName">
                                            <div class="textLabel" title="My Workspace">My Workspace</div>
                                        </div>
                                    </li>
                                </ul>-->
                                <div class="sectionTitle subsectionTitle trimmedTextWithEllipsis">
                                    <div class="subsectionTitleText">
                                        <button class="navigationPaneButton groupAddButton">CREATE A GROUP</button>
                                    </div>
                                    <button class="navigationPaneButton addButton" title="Create group"><i class="glyphicon pbi-glyph-add"></i></button>
                                </div>
                                <ul class="navigationItemList">
                                </ul>
                                <button class="groupsMoreLessButton ng-hide">
                                    <span class="groupsMoreButton">More</span>
                                </button>
                            </div>







                            <div class="freezableScrollRegion">  
                                
                                
                                                              
                              <%--    <div class="collapsibleSection ownershipFitlerCollapsibleSection" style="border:1px dashed;">
                                   <div class="sectionTitle" tabindex="0" title="Show content" style="padding-right:10px;">
                                        <ul class="nav nav-stacked">
 <li>
    <div class="btn-group">
        <a id="content_type_id" class="dropdown-toggle" data-toggle="dropdown" href="#">
        <i class="fa fa-bar-chart fa-2" aria-hidden="true"></i><strong> Show Chart </strong>
        <i class="icon icon-caret-right"></i>
      </a>
      <%--<a id="content_type_id" class="dropdown-toggle" data-toggle="dropdown" href="#">
       style="color:#c00000">Show</span><span style="color:#000000"> Chart</span></strong> <span style="color:#333;"">Only</span>
      </a></span> Note already commited  <span><i class="fa fa-bar-chart fa-2" aria-hidden="true"></i></span><span><a id="content_type_id" class="dropdown-toggle" data-toggle="dropdown" href="#">
        <strong><span
        
      </a>
      <ul id="CTypes" class="dropdown-menu" style="left:213px;">
       
      <li>
         <div class="pbi-input"> <input type="radio" name="contentOption" onclick="onContentChange('Chart Only', 0);" checked="checked" style="margin-top:6px;" ><label class="form-label" style="padding-left:15px;" >Chart Only</label></div>
      </li>
      <li>
         <div class="pbi-input"> <input type="radio" name="contentOption" onclick="onContentChange('Chart with Table', 1);" style="margin-top:6px;" ><label class="form-label" style="padding-left:15px;" >Chart with Table</label></div>
      </li>
      <li>
         <div class="pbi-input"> <input type="radio" name="contentOption" onclick="onContentChange('Table Only', 2);" style="margin-top:6px;" ><label class="form-label" style="padding-left:15px;" >Table Only</label></div>
      </li>
     <li>
         <div class="pbi-input"> <input type="radio" name="contentOption" onclick="onContentChange('Drilldown Only', 3);" style="margin-top:6px;" ><label class="form-label" style="padding-left:15px;" >Drilldown Only</label></div>
      </li>
      <li>
         <div class="pbi-input"> <input type="radio" name="contentOption" onclick="onContentChange('Chart with Drilldown', 4);" style="margin-top:6px;" ><label class="form-label" style="padding-left:15px;" > Chart with Drilldown</label></div>
      </li>

      </ul>

    </div>
  </li>
                                            </ul>
                                        
                                             </div>
                                </div>--%>



<%--                                <div class="collapsibleSection dashboardCollapsibleSection">
                                    <div>
                                        
                                        <div class="panel-group" id="accordion">
                                  <div class="panel panel-default">
                                    <div class="panel-heading">
                                      <h4 class="panel-title">
                                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                          Dashboard
                                        </a>
                                      </h4>
                                    </div>
                                    <div id="collapseOne" class="panel-collapse collapse">
                                      <div class="panel-body">
                                           <input type="text" style="width:100%; margin-left:0px;" id="txtDashboardName" onkeypress="txtDashboardNameKeyPress(event)"/>
                                      </div>
                                    </div>
                                       <ul class="dashboardlistitem dashboardList">
                                           
                                       </ul>
                                  </div>
                                </div>
                               
                                    </div>
                                    
                                
                               
                                <div class="collapsibleSection reportCollapsibleSection isExpanded">
                                    <ul class="navigationItemList">
                                </ul>
                                </div>
                                </div>--%>
                                <div class="collapsibleSection dashboardCollapsibleSection">

                                    
                                        <div class="panel-heading">
                                            <h4 class="panel-title">Version</h4>
                                        </div>
                                    <ul class="navigationItemList versionList" id="insertversions"></ul>
                                    <%--<div class="fieldWellProperty insertinputsFilter" title="Drag data fields here" id="insertversions"></div>--%>
                                   
                                </div>
                                <div class="collapsibleSection dashboardCollapsibleSection">

                                    
                                        <div class="panel-heading">
                                            <h4 class="panel-title">Report</h4>
                                        </div>
                                    <ul class="navigationItemList reportList">
                                       
                                        
                                   </ul>
                                </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="sharebaleBox" style="position:absolute;" class="dropdown-menu">
                     <ul class="openShareDelete" style="border-image: none; display: block;">
                        <li class="image"><a title="Pin to dashboard" href="#" data-title="Pin to dashboard" data-target='#ReporPin' data-toggle="modal"> <i class="fa fa-thumb-tack" aria-hidden="true"></i></a></li>
                           <li class="share"><a href="#" title="Share"><i class="fa fa-share-square-o" aria-hidden="true"></i></a></li>
                          <li class="print"><a href="#" title="Print"><i class="fa fa-print" aria-hidden="true"></i></a></li>

                           <li class="pdf export-format"><a title="Pdf" href="#" target="_blank"><i class="fa fa-file-pdf-o" aria-hidden="true"></i></a></li>
                            <li class="word export-format"><a title="Word" href="#" target="_blank"><i class="fa fa-file-word-o" aria-hidden="true"></i> </a></li> 
                          <li class="excel export-format"><a title="Excel" href="#" target="_blank"><i class="fa fa-file-excel-o" aria-hidden="true"></i></a></li>
                          <li class="image export-format"><a title="Image" href="#" target="_blank"><i class="fa fa-picture-o" aria-hidden="true"></i></a></li>
                         <li class="delete"><a href="#" title="Delete"><i class="fa fa-trash" aria-hidden="true"></i></a></li> 

                      </ul>
                    </div>
</div>
                                        <article class="taskPane sidePane rightSidePane smallFontSize" style="width: 240px;">
                                            <div class="paneHeader">
                                                <button class="toggleBtn" title="Toggle Task Pane" onclick="toggleTaskPane();">
                                                    <div class="expanderBtn">
                                                        <div class="btnIcon glyphicon glyphicon-menu-right pbi-glyph-chevronrightmedium glyph-mini"></div>
                                                    </div>
                                                    <h2 class="sidePaneHorizontalTitle sidePaneTitle unselectable fieldsTab largeFontSize trimmedTextWithEllipsis">Notes</h2>
                                                    <%--<div class="verticalTitle">
                                                        <h2 class="verticalTitle verticalText ng-hide"><span class="collapsedVisualsTitle largeFontSize">Fields</span></h2>
                                                    </div>--%>
                                                </button>
                                            </div>
                                            <div class="paneContents">
                                                <section class="fieldList unselectable">
                                                   <!-- <div class="searchBox" title="Search">
                                                        <i class="glyphicon pbi-glyph-search"></i>
                                                        <input type="text" placeholder="Search" class="ng-pristine ng-untouched ng-valid ng-empty">
                                                    </div>  <hr>-->
                                                   
                                                    <div class="scroll-wrapper scrollbar-inner " style="position: relative;">
                                                        <div class="scrollbar-inner  scroll-content" style="margin-bottom: 0px; margin-right: 0px; height: 100%; display:none;">
                                                            
                                                                        
                                                            <div class="dropdown" id="dataList">
                                                                           
                                                                             <ul class="dropdown-menu" style="top:0px; position:relative; clear:both;">

                                                                              </ul>
                                                                            
                                                                        </div>
                                                                    <div style="position:relative; float:left; clear:both; top:2px; width:96%; margin-left:4px; margin-right:4px;">
                                                                    <div class="fieldListProperty flex property"><div class="propertyText propertyContent item-fill editableLabel"><div class="textLabel" title=""><i class="fa fa-arrows" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;<span class="textLabelspan  ui-draggable ui-draggable-handle" title="Frequency" alt="Frequency">Frequency</span></div></div></div>

                                                               <div class="fieldWellProperty insertinputsFilter" title="Drag data fields here" id="">
                                                                   <form style="color:#000;"><input type="radio" checked="" name="frequency" onclick="selectFrequency()">
                                                                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Monthly<br>
                                                                       <input type="radio" name="frequency" onclick="selectFrequency()"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quarterly<br><input type="radio" name="frequency" onclick="selectFrequency()"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Yearly</form></div>  

                                                                    </div>
                                                            <div style="position:relative; float:left; clear:both; top:5px; width:96%; margin-left:4px; margin-right:4px;">
                                                                      <div class="fieldListProperty flex property"><div class="propertyText propertyContent item-fill editableLabel"><div class="textLabel" title=""><i class="fa fa-arrows" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;<span class="textLabelspan  ui-draggable ui-draggable-handle" title="Frequency" alt="Frequency">Forecast Period</span></div></div></div>

                                                                <div class="cards ">
                                                                                <ol class="properties ">
                                                                                <input id="datepicker-start" name="daterange" type="text" placeholder="From" style="width:87px; height:30px;float:left; position:relative; padding-left:19px;"><input id="datepicker-end" style=" width:87px; float:left; margin-left:1px; height:30px; padding-left:19px;" type="text" placeholder="To" >
                                                                                         
                                                                            </ol>
                                                                        </div>

                                                                    </div>
                                                            <% if (Model.ReportType == ReportModelType.BDL)
                                                                { %>
                                                            <div style="position:relative; float:left; clear:both; top:0px; width:96%; margin-left:4px; margin-right:4px;">
                                                                      <div class="fieldListProperty flex property"><div class="propertyText propertyContent item-fill editableLabel"><div class="textLabel" title=""><i class="fa fa-arrows" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;<span class="textLabelspan  ui-draggable ui-draggable-handle" title="Frequency" alt="Frequency">Country</span></div></div></div>

                                                                 <select class="selectpicker form-control search-filter select-dropdown selectBox " id="select-country" >
                                                                    <option value="1">United States</option>
                                                                </select>
                                                                    </div>
                                                            <% } %>
                                                        </div>

                                                    </div>
                                                </section>
                                            </div>
                                            <div class="verticalTitle">
                                                       <h2 class="verticalTitle verticalText ng-hide" ><a href="" onclick="toggleTaskPane();"><span class="collapsedVisualsTitle largeFontSize">Notes</span></a></h2>
                                                    </div>
                                            <div class="pane-splitter"></div>
                                        </article>
                                        <article class="visualizationPane sidePane rightSidePane smallFontSize panel-resizable" style="width: 240px;">
                                            <div>
                                                <div class="paneHeader">
                                                    <button class="toggleBtn" title="Toggle Visualization Pane" onclick="toggle();">
                                                        <div class="expanderBtn">
                                                            <div class="btnIcon glyphicon glyphicon-menu-right pbi-glyph-chevronrightmedium glyph-mini"></div>
                                                        </div>
                                                        <h2 class="sidePaneHorizontalTitle unselectable sidePaneTitle largeFontSize trimmedTextWithEllipsis">Assumptions</h2>
<%--                                                        <h2 class="verticalTitle verticalText ng-hide"><span class="collapsedVisualsTitle largeFontSize">Visualizations</span><span class="collapsedFiltersTitle largeFontSize">Filters</span></h2>--%>
                                                    </button>
                                                </div>
                                                <div class="paneContents flex">




                                                    <div tabindex="1" style="width:100%;" class="botbar tab-pane fade active in" id="botbar" style="height: 579px; -ms-overflow-x: hidden; -ms-overflow-y: auto; -ms-overflow-style: none;">
                                                <section class="page1_header">
                                                    
                                                        <div id="set_assumptions">
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Epidemiology
                <a class="  assump-epidemiology pull-right" href="#" target="_blank">
                    <img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Epidemiology Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Historical Data
                <a class="  assump-historical-data pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Historical Data Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Conversion Parameters
                <a class="  assump-conversion-parameters pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Conversion Parameters Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Compliance
                <a class="  assump-compliance pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Compliance Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Dosing
                <a class="  assump-dosing pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Dosing Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">DoT
                <a class="  assump-dot pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="DoT Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">GTN
                <a class="  assump-gtn pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="GTN Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Pricing
                <a class="  assump-pricing pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Pricing Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Market Access
                <a class="  assump-market-access pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Market Access Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Patients and Product Shares
                <a class="  assump-patients-and-product-shares pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Patients and Product Shares Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Events
                <a class="  assump-events pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Events Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Output
                <a class="  assump-output pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Output Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Patients
                <a class="  assump-patients pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Patients Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Units
                <a class="  assump-units pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Units Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Gross Revenue
                <a class="  assump-gross-revenue pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Gross Revenue Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Net Revenue
                <a class="  assump-net-revenue pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Net Revenue Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Probability
                <a class="  assump-probability pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Probability Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Prob. Adjustment
                <a class="  assump-prob.-adjustment pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Prob. Adjustment Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Prob Adj Gross Rev
                <a class="  assump-prob-adj-gross-rev pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Prob Adj Gross Rev Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner section_note_write">
        <div class="panel panel-default">
            <div class="panel-heading">Prob Adj Net Revenue
                <a class="  assump-prob-adj-net-revenue pull-right" href="#" target="_blank"><img class="indicationimg" src="../../Content/img/icon-book.png"></a>
            </div>
            <div class="panel-body-assumption">
                <div class="maxheight">
                    <div class="editable-div" contenteditable="true" onclick="expandableDiv();" placeholder="Prob Adj Net Revenue Notes"></div>
                </div>
                <div class="attach-box">
                    <ul class="list-inline attachment_icons"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="banner ">
        <div class="maxheight">
            <div class="padding-box">
                <div class="col-md-12 no-padding-left"><span>Properties</span></div>
            </div>
            <div class="padding-box">
                <div class="col-md-4 no-padding-left">Info</div>
                <div title="DenverV0.0" class="col-md-8 no-padding-right" id="version_detail">Denver V0.0</div>
            </div>
            <div class="padding-box ">
                <div class="col-md-4 no-padding-left">Comment</div>
                <div title="Saved By vinod.kanchankoti@pharmaace.com at Mon Apr 17 2017 12:08 GMT+0530 (India Standard Time)" class="col-md-8 no-padding-right" id="version_desc">
                    <div class="replclass"></div>
                    <br> Saved By vinod.kanchankoti@pharmaace.com at Mon Apr 17 2017 12:08 GMT+0530 (India Standard Time)</div>
            </div>
        </div>
    </div>
    <div class="banner ">
        <div class="maxheight">
            <div class="padding-box">
                <div class="col-md-12 no-padding-left"><span>Related Date</span></div>
            </div>
            <div class="padding-box">
                <div class="col-md-4 no-padding-left">Created</div>
                <div class="col-md-8 no-padding-right" id="created_on">created</div>
            </div>
            <div class="padding-box ">
                <div class="col-md-4 no-padding-left">Modified</div>
                <div class="col-md-8 no-padding-right" id="modified_on">Modified</div>
            </div>
        </div>
    </div>
    <div class="banner ">
        <div class="maxheight">
            <div class="padding-box">
                <div class="col-md-12 no-padding-left"><span>Related People</span></div>
            </div>
            <div class="padding-box">
                <div class="col-md-4 no-padding-left">Author</div>
                <div class="col-md-8 no-padding-right" id="author_id">forecast author</div>
            </div>
            <div class="padding-box ">
                <div class="col-md-4 no-padding-left">Modifier</div>
                <div class="col-md-8 no-padding-right" id="modifier_id">version modifier</div>
            </div>
            <div class="padding-box ">
                <div class="col-md-4 no-padding-left">Shared</div>
                <div class="col-md-8 no-padding-right" id="shared_with">shared with</div>
            </div>
        </div>
    </div>
</div>
</section>
</div>












                                                    <%--<div class="visual-types-container">
                                                        <button title="Bar chart" class="visual-icon-container" onclick="setVisualization(3); imageVisulisation(this);" id="barchart">
                                                            <span class="visual-icon visual-icon-outer clusteredBarChart"><span class="visual-icon-inner"><img src="../../Content/img/reporting/Bar.png" /></span></span>
                                                        </button>
                                                        
                                                        <button title="Line chart" class="visual-icon-container" onclick="setVisualization(2); imageVisulisation(this);" id="linechart">
                                                            <span class="visual-icon visual-icon-outer lineClusteredColumnComboChart">
                                                                <span class="visual-icon-inner"><img src="../../Content/img/reporting/line.png" /></span></span>
                                                        </button>
                                                        <button title="Doughut Chart" class="visual-icon-container" onclick="setVisualization(7); imageVisulisation(this);" id="doughautchart">
                                                            <span class="visual-icon visual-icon-outer DoughutChart"><span class="visual-icon-inner">
                                                                <img src="../../Content/img/reporting/Dounghut.png" /></span></span>
                                                        </button>
                                                        <button title="Column Chart" class="visual-icon-container" onclick="setVisualization(1); imageVisulisation(this);" id="columnchart">
                                                            <span class="visual-icon visual-icon-outer columnchart"><span class="visual-icon-inner">
                                                                <img src="../../Content/img/reporting/columnchart.png" /></span></span>
                                                        </button>
                                                        <button title="Area Chart" class="visual-icon-container" onclick="setVisualization(4); imageVisulisation(this);" id="areachart">
                                                            <span class="visual-icon visual-icon-outer areaChart"><span class="visual-icon-inner">
                                                                <img src="../../Content/img/reporting/Area.png" /></span></span>
                                                        </button>
                                                        <button title="Stacked Column Chart" class="visual-icon-container" onclick="setVisualization(8); imageVisulisation(this);" id="stackedchart">
                                                            <span class="visual-icon visual-icon-outer 3dcolumn"><span class="visual-icon-inner">
                                                        <img src="../../Content/img/reporting/stackedcolumn.png" /></span></span>

                                                        </button>
                                                         <button title="Line With Markup" class="visual-icon-container" onclick="setVisualization(0); imageVisulisation(this);" id="linemarkupchart">
                                                             <span class="visual-icon visual-icon-outer linemarkup"><span class="visual-icon-inner">
                                                                 <img src="../../Content/img/reporting/linewithmarker.png" /></span></span>
                                                        </button>
                                                         <button title="Stacked Bar" class="visual-icon-container" onclick="setVisualization(9); imageVisulisation(this);" id="stackedbarchart">
                                                             <span class="visual-icon visual-icon-outer stackedbar"><span class="visual-icon-inner">
                                                         <img src="../../Content/img/reporting/stackedbar.png" /></span></span>
                                                        </button>
                                                        <button title="Funnel" class="visual-icon-container" onclick="setVisualization(10); imageVisulisation(this);" id="funnelchart">
                                                            <span class="visual-icon visual-icon-outer funnel"><span class="visual-icon-inner">
                                                          <img src="../../Content/img/reporting/funnel.png" /></span></span>
                                                        </button>
                                                        <button title="Scatter Chart" class="visual-icon-container" onclick="setVisualization(6); imageVisulisation(this);" id="scatterchart">
                                                            <span class="visual-icon visual-icon-outer scatter"><span class="visual-icon-inner">
                                                          <img src="../../Content/img/reporting/scatter.png" /></span></span>
                                                        </button>
                                                        <button title="3D Bubble Chart" class="visual-icon-container" onclick="setVisualization(11); imageVisulisation(this);" id="bubblechart">
                                                            <span class="visual-icon visual-icon-outer 3Dbubble"><span class="visual-icon-inner">
                                                            <img src="../../Content/img/reporting/3Dbubble.png" /></span></span>
                                                        </button>
                                                        <button title="100% Stacked Column" class="visual-icon-container" onclick="setVisualization(5); imageVisulisation(this);" id="stackedcolumnchart">
                                                            <span class="visual-icon visual-icon-outer stacked100"><span class="visual-icon-inner">
                                                         <img src="../../Content/img/reporting/stacked100.png" /></span></span>
                                                        </button>
                                                    </div>--%>
                                                   <!-- <nav class="sectionHeader item-auto">
                                                    </nav> -->
                                                   

                                                    <div class="sectionHost item-fill" style="border:0px;">
                                                        <div class="scroll-wrapper scrollbar-inner " style="position: relative;">
                                                            <div class="scrollbar-inner  scroll-content" id="scollableDiv" style="margin-bottom: 0px; margin-right: 0px; height:96%;display:none;">
                                                               <%-- <section class="fieldWell unselectable">                                                                    
                                                                    <ol>
                                                                       
                                                                        <li class="bucket">
                                                                            <h1 class="caption trimmedTextWithEllipsis smallFontSize">Select Products</h1>
                                                                            <ol class="properties ">
                                                                                <li class="fieldWellProperty  can-prepend " title="Drag data fields here" id="insertinputs">
                                                                                    <span id="default-place-value" class="default-place">Select Products here</span></li>
                                                                            </ol>
                                                                        </li>
                                                                    </ol>
                                                                </section>--%>
                                                                <div class="sectionHeader"><%--<span class="sectionTitle sidePaneTitle unselectable largeFontSize">--%>
<%--                                                                    Level: Product SKU</span><span style="padding-left:15px; padding-right:15px;">|</span><span style="float:right; padding-right:15px;">Reset</span></div>--%>
                                                                    <span><strong>Level:&nbsp;</strong></span><span class="radchek">
                                                                        <input type="radio" class="" name="prodskuLevel" id="prodLevel" value="Product"  required ">&nbsp;&nbsp;&nbsp;Product&nbsp;</span>
                                                                   
                                                   <span class="radchek"><input type="radio" class="" name="prodskuLevel" id="skuLevel" value="SKU" checked="checked">&nbsp;&nbsp;&nbsp;<span id="skutext">SKU</span></span>
                                                       <span><a href="#" id="resetReport" style="float:right; color:#9CC2CB; text-decoration:underline;"><strong>Reset</strong></a></span>             
                                                                    
                                                                    <%--</span>--%>
                                                                <section class="filterPane">
                                                                    <div id="visualFilterContainer">
                                                                        <div class="cards ">
                                                                            <ol class="properties ">
                                                                                <li class="fieldWellProperty  can-prepend insertinputsFilter" title="Drag data fields here" id="insertinputsvisual"></li>  
                                                                                <li id="daterangeBox"></li>                                                                                  
                                                                            </ol>
                                                                        </div>
                                                                    </div>
                                                                </section>
                                                                <%--<div>
                                                                    <div id="forecast_period_id">
                                                                 
                                                                        </div>
                                                                    </div>--%>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                    <h2 class="verticalTitle verticalText ng-hide"><a href="" onclick="toggle();"><span class="collapsedVisualsTitle largeFontSize">Assumptions</span><%--<span class="collapsedFiltersTitle largeFontSize">Filters</span>--%></a></h2>
                                            <div class="pane-splitter" style="display: block;"></div>
                                        </article>
                                        <div class="horizontalItemsContainer" id="page-content-wrapper" >
                                            <%--<div id="report_container" class="exploration" style="margin-top:15px;">                                                
                                              
                                            </div>--%>
                                            <div id="IframeInner"></div>
                                            <div id="bdlTop" style="position:absolute; top:3px; left:10px; width:100%;">
                                                <span><strong>Frequency:&nbsp;</strong></span>
                                            <span class="radchek"><input type="radio" class="flat" name="rep-frequency" id="rep-monthly" value="Actual" checked />&nbsp;M&nbsp;</span>
                                            <span class="radchek"><input type="radio" class="flat" name="rep-frequency" id="rep-quarterly" value="Latest"  />&nbsp;Q&nbsp;</span>
                                                 <span class="radchek"><input type="radio" class="flat" name="rep-frequency" id="rep-yearly" value="Actual" />&nbsp;Y&nbsp;</span>
                                         <span><strong>&nbsp;&nbsp;Data:&nbsp;</strong></span>
                                            <span class="radchek"><input type="radio" class="flat" name="rep-data" id="rep-show" value="Actual"  />&nbsp;Show&nbsp;</span>
                                            <span class="radchek"><input type="radio" class="flat" name="rep-data" id="rep-hide" value="Latest"  checked/>&nbsp;Hide&nbsp;</span>
                                            <div style="position:absolute; right:142px; top:-11px;" id="CategoryListParent">
        <select id="CategoryList"  onclick="categoryFilter(this)" data-actions-box="true" class="selectpicker form-control"   data-size="5" aria-expanded="false">
            <option class="item" id="0" >Select Parameters</option>
            <option class="item" id="1">Net Revenue</option>
            <option class="item" id="2">Gross Revenue</option>
            
        </select>
                                                </div>   
                                                <nav aria-label="Page navigation example" style="float:right; margin-right:21px; margin-top:-2px; ">
  <ul class="pagination justify-content-center" >
    <li class="page-item">
      <a class="page-link" href="#" tabindex="-1">Previous</a>
    </li>
    
    <li class="page-item">
      <a class="page-link" href="#">Next</a>
    </li>
  </ul>
</nav>

                                                
                                                 <%--<span class="radchek"><input type="checkbox" class="flat" name="" id="IncludeHistorical" value="Include Historical" checked onchange="showHistoricalData(this)"   />&nbsp;Include Historical&nbsp;</span>--%>
                                                <%--<span class="radchek"><a  href="<%=Url.Action("SampleReportModel", "Reporting")%>" >Try New Version</a></span>

                                                <span class="radchek"><input type="checkbox" class="flat" name="" id="IncludeHistorical" value="Include Historical" checked="checked" />&nbsp;Include Historical&nbsp;</span>
                                                <span>|&nbsp;</span>
                                                <span class="radchek"><input type="checkbox" class="flat" name="ProdConso" id="ProdConso" value="Consolidate"  required />&nbsp;Consolidate&nbsp;</span>
                                                <span>|</span>--%>
                                                <%--<span><strong>&nbsp;Version:&nbsp;</strong></span>
                                            <span class="radchek"><input type="radio" class="flat" name="ProdVer" id="actual-version" value="Actual" />&nbsp;Actual&nbsp;</span>
                                            <span class="radchek"><input type="radio" class="flat" name="ProdVer" id="latest-version" value="Latest" checked />&nbsp;Latest&nbsp;</span>
                                                <span>|</span>--%>
                                                         
                                        </div>
                                         <!--  <div class="forpin" style="right:75px; top:3px;">
                                                <a data-placement="bottom" data-toggle="tooltip" data-original-title="Save" href="#" id="save" class="ctooltip">
                                          
                                                    <i title="Save" class="fa fa-floppy-o" style="color:#337ab7; font-size:1.5em;" aria-hidden="true"></i> 
                                                </a>

                                            </div>-->



                                            <%--<div style="position:absolute; top:-7px; right:103px">
                                                <div class="checkbox">
                                                      
                                                        <input type="checkbox" data-toggle="toggle" id="toggle-event"  data-onstyle="primary" data-offstyle="default" data-style="slow" data-on="Latest" data-off="Original" data-size="small">
                                                       <div id="console-event"></div>
                                                      
                                                    </div>
                                            </div>--%>
                                             <%--<div id="" style=" display:block; right:47px; top:3px;  color:#fff; position:absolute;  text-align:center; padding:0px;"> 
                                               <a href="#" id="reportIcon" data-url='<%=Url.Action(Model.ReportType == ReportModelType.Generic ? "GenericsRenderer":"BDLRenderer", "Reporting")%>' class="js-reload-details" > <i title="Generate Report" class="fa fa-play-circle-o" style="color:#337ab7; font-size:1.5em;" aria-hidden="true"></i> </a>
                                             </div>--%>
                                           <%-- <div style="  right:11px; top:8px;  color:#fff; position:absolute; right:15px;  text-align:center; padding:0px;">
                                            <a href="#" id="resetReport" style="display:none;"><i title="Reset" class="fa fa-reply" aria-hidden="true" style="color:#337ab7; font-size:1.5em;"></i></a>
                                            </div>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="inFocusContainer ng-hide">
                            <div class="inFocusAppBar appBar">
                                <div class="appBarSection left">
                                    <ul>
                                        <li>
                                            <button class="iconBox"><i class="glyphicon pbi-glyph-minicontract glyph-small"></i><span class="dashboardTitle link appBarMenuItem"></span></button>
                                        </li>
                                        <li class="appBarDivider"></li>
                                        <li class="focusTitle appBarTitle"></li>
                                        <li class="focusSubtitle appBarText"></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="on-resize">
                               
                            </div>
                        </div>
                    </div>
                </div>
                <div class="taskPaneSliderView ng-hide">
                    <div class="collapsiblePane hidden largeWidth">
                        <div class="innerLayout">
                            <div class="contentFrameHost">
                            </div>
                            <div class="expandButtonContainer">
                                <div class="expanderBtn" title="Activity pane"><i class="expandIcon glyphicon pbi-glyph-chevronleftmedium glyph-micro"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="marketplaceHost"></div>
        </div>
    </div>
    <input type="text" class="form-control" id="myMainPageInput" />

    <div id="shareReportModal" class="modal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Share Report</h4>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <div class="form-group">
                            <div class="clsPeople" id="idPeopleName">
                                <table id="shared_users_table" data-toggle="table" data-click-to-select="true" class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th data-field="state"></th>
                                            <th data-field="name">Name</th>
                                            <th data-field="stargazers_count">Email</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                   <%-- <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="shareReportWithUsers();">share</button>--%>
                     <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="shareDashboardReportWithUsers();">Share</button>
                   
                </div>
            </div>
        </div>
    </div>

    <div id="ReportNameModal" class="modal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Report Name</h4>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <div class="modal-body">
                Report Name:
                <input type="text" class="form-control" id="myPopupInput" />
            </div>
             <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveReport();">Save</button>
                   
                </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
    
    <div id="ReporPin" class="modal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Pin to dashboard</h4>
                </div>
                <div class="modal-body">
                    <form role="form">
                       

                            <div class="sectionContainer pinToDashboard">
                                
                                <div class="message" >Select an existing dashboard or create a new one.</div>
                                
                                <div class="dashboardChoices tileRadioGroup">
                                    <ul>
                                        <li>
                                        <div class="pbi-input"> <input type="radio" class="existingDashRadio " name="pinradio" ><label class="">Existing dashboard</label></div>
                                        </li>
                                        <li>
                                        <div class="pbi-input" > <input class="newDashRadio" type="radio"  name="pinradio"><label class="">New dashboard</label></div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="existingDashboardDropDown" id="existingDashRadio" style="display:none;">
                                    <select  class="ng-pristine">
                                       
                                    </select>
                                </div>
                                <div class="newNameTextBox" id="newDashRadio" style="display:none;"> <input type="text" class="pinTileText inputDashboardTitle " maxlength="500" ></div>
                             
                                
                              
                            </div>

</form>
                    </div>

                     <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="pinReportToDashboard();">OK</button>
                   
                        </div>
                    
                

            </div>
        </div>
    </div>

     <style>
          .forpin{position:absolute; right:10px; top:2px;}
         .dashboardChoices label{font-weight:normal;}

        .SliderSidebarContent{width:0px; background-color:#444;}
        .SliderSidebar select{ width:100%; font-size:12px;}
        .SliderSidebar .toggleText{
  
    width:32px;
    text-align:left;
    font-weight:400;
    cursor:pointer;
   
    color: #ffffff;
     color: #fff;
    display: block;
    position: relative;
    top: 5px;
    transform: rotate(90deg);
    white-space: nowrap;

        }
        .form-wrapper_right{
   
    padding:  8px;
    border-color: #ebebeb;
	
	height:100%;
    color: #222222;
    background-color: #ffffff;
    -webkit-border-radius: 4px 0 0 4px;
    -moz-border-radius: 4px 0 0 4px;
    border-radius: 4px 0 0 4px;
    border-bottom: 1px solid #dadada;
    border-top: 1px solid #dadada;
    border-left: 1px solid #dadada;
}
        .SliderSidebar .toggleText span{background-color: #c00000;
   -webkit-border-radius: 0px 0 7px 7px;
    -moz-border-radius:0px 0 7px 7px;
    border-radius: 0px 0 10px 10px;
    opacity:0.72;
   
    padding: 8px;}
        .SliderSidebar .control-label{ text-align:left; font-weight:normal; font-size:12px; padding-top:0px;}
        .SliderSidebar .form-control{font-size:12px; color:#000;}
         .SliderSidebar .form-group{ margin-bottom:6px;}
        .SliderSidebar .SliderSidebarContent.isCollapsed{width:240px;}
        .SliderSidebar.isCollapsed{width:300px;}
        .SliderSidebar, .SliderSidebar .SliderSidebarContent{overflow:hidden;}
    </style>
    
<div id="rightScrollerDiv" style="position:fixed; top:239px; right:0px;" >
    <div  class="SliderSidebar">
        <div style="position:relative;float:right;" class="SliderSidebarContent"><div class="form-wrapper_right">

            <form id="formatbox" class="form-horizontal form-label-left">
             <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#axis">Axis</a></li>
    <li><a data-toggle="tab" href="#chart">Chart</a></li>
    
  </ul>
                <div class="tab-content">
                <div id="axis" class="tab-pane fade in active">
                    <div class="item form-group">
                        <label class="control-label col-md-12 col-sm-12 col-xs-12" for="Numaber Format">
                            Number Format <span class="required">*</span>
                        </label>
                        <div class="col-md-12 col-sm-12 col-xs-12">
                           <select id="number_format_id" style="width:100%;" onchange="onNumberFormatChange()">
                              <option>Absolute</option>
                              <option>Thousand</option>
                             <option>Million</option>
                            </select>
                        </div>
                    </div>

                    <div class="item form-group">
                        <label class="control-label col-md-12 col-sm-12 col-xs-12" for="Decimal Precision">
                            Decimal Precision <span class="required">*</span>
                        </label>
                        <div class="col-md-12 col-sm-12 col-xs-12">
                           <select id="decimal_precision_id" style="width:100%;" onchange="onDecimalPrecisionChange()">
                              <option>0</option>
                              <option>1</option>
                              <option selected="selected">2</option>
                              <option>3</option>
                              <option>4</option>
                              <option>5</option>
                            </select>
                        </div>
                    </div>

                    <div class="item form-group">
                        <label class="control-label col-md-12 col-sm-12 col-xs-12" for="Decimal Precision">
                            Currecncy <span class="required">*</span>
                        </label>
                        <div class="col-md-12 col-sm-12 col-xs-12">
                           <select id="currency_id" style="width:100%;" onchange="onCurrencySymbolChange()">
                              <option selected="selected">&#36; English (United States)</option>
                               <option>&euro; Euro (&euro; 123)</option>
                              <option>&pound; English (United Kingdom)</option>                                                            
                            </select>
                        </div>
                    </div>
                
                    <div class="item form-group">
                        <label class="control-label col-md-12 col-sm-12 col-xs-12" for=" Color Theme">
                            Axis Font Size <span class="required">*</span>
                        </label>
                        <div class="col-md-12 col-sm-12 col-xs-12">

                            <select id="axis_font_size_id" style="width:100%" onchange="onAxisFontSizeChange();">

                                <option>8</option>
                                        <option>9</option>
                                       <option> 10</option>
                                       <option>11</option>
                                       <option> 12</option>
                                      <option>13</option>
                                      <option>14</option>
                                    <option>15</option>
                                      <option>16</option>
                                    
                            </select>

                             

                        </div>
                    </div>

                    <div class="item form-group">
                        <label class="control-label col-md-12 col-sm-12 col-xs-12" for="email">
                           Axis Font Color <span class="required">*</span>
                        </label>
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div id="cpaxis" class="input-group colorpicker-component">
                                <input id="axis_font_color_id" type="text" value="#00AABB" class="form-control" onchange="onAxisFontColorChange();" />
                                <span class="input-group-addon"><i></i></span>
                            </div>
                        </div>
                    </div>
                    
                </div>

                 <div id="chart" class="tab-pane fade in ">
                     <div class="item form-group">
                        <label class="control-label col-md-12 col-sm-12 col-xs-12" for=" Color Theme">
                            Color Theme <span class="required">*</span>
                        </label>
                        <div class="col-md-12 col-sm-12 col-xs-12">

                            <select id="color_theme_id" style="width:100%" onchange="onColorThemeChange()">

                                <option>EarthTones</option>
                                        <option>Excel</option>
                                       <option> GrayScale</option>
                                       <option> Light</option>
                                       <option> Pastel</option>
                                      <option>  SemiTransparent</option>
                                      <option selected="selected">  Berry</option>
                                    <option>    Choclate</option>
                                      <option>  Fire</option>
                                     <option>   SeaGreen</option>
                                      <option>  BrightPastel</option>
                            </select>

                             

                        </div>
                    </div>

                      <div class="item form-group">
                        <label class="control-label col-md-12 col-sm-12 col-xs-12" for="email">
                           Chart Background Color <span class="required">*</span>
                        </label>
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div id="cpfont" class="input-group colorpicker-component">
                                <input id="chartbgcolor_id" type="text" value="#00AABB" class="form-control" onchange="onChartBgColorChange();" />
                                <span class="input-group-addon"><i></i></span>
                            </div>
                        </div>
                    </div>

                      <div class="item form-group">
                        <label class="control-label col-md-12 col-sm-3 col-xs-12" for="email">
                            Chart Border Color
                        </label>
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div id="cpborder" class="input-group colorpicker-component">
                                <input id="chartbordercolor_id" type="text" value="#00AABB" class="form-control" onchange="onChartBorderColorChange();" />
                                <span class="input-group-addon"><i></i></span>
                            </div>
                        </div>
                    </div>
                
                    <div class="item form-group">
                        <label class="control-label col-md-12 col-sm-12 col-xs-12" for=" Color Theme">
                            Chart Border Width <span class="required">*</span>
                        </label>
                        <div class="col-md-12 col-sm-12 col-xs-12">

                           <select id="chart_border_width_id" style="width:100%" onchange="onChartBorderWidthChange()">

                                <option>1</option>
                                        <option>2</option>
                                       <option> 3</option>
                                       <option>4</option>
                                       <option> 5</option>
                                  
                                    
                            </select>

                             

                        </div>
                    </div>
                   

                     <div class="item form-group">
                        <label class="control-label col-md-12 col-sm-3 col-xs-12" for="email">
                            Shadow
                        </label>
                        <div class="col-md-12 col-sm-12 col-xs-12">
                             <select id="shadow_id" style="width:100%" onchange="onShadowChange()">

                                <option>1</option>
                                        <option>2</option>
                                       <option> 3</option>
                                       <option>4</option>
                                       <option> 5</option>
                                  
                                    
                            </select>
                        </div>
                    </div>

                     <div class="item form-group">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                             <span><input type="checkbox" id="cboShowLegend" checked="checked" onchange="showHideLegend(this)"/>&nbsp;&nbsp;Show Legend</span>
                        </div>
                    </div>

                 </div>
            </div>
                <%--<div class="form-group">
                        <div class="col-md-12">
                          
                            <input type="submit" class="btn btn-default" value="Submit" style="margin-top:10px;" />
                        </div>
                    </div>--%>
                </form>
        </div></div>
                         <div style="position:relative; float:right; " class="toggleText" onclick="toggleSliderSidebar();"><span>Format Report</span></div>


    </div>
     
</div>
 
</body>
</html>
    <script>
        var reportListSettings = {}; //associative array for all loaded reports' configurations
        var reportSettings = { Country: "United States", NumberFormat: 0, DecimalPrecision: 2, CurrencySymbol: 0, ColorTheme: 6, AxisFontSize: 11, AxisFontColor: "00AABB", ChartBgColor: "FFFFFF", ChartBorderColor: "00AABB", ChartBorderWidth: 2, TitleFontSize: 12, TitleColour: "000000", Shadow: 10, ShowLegend: 1, VersionFlag: 0, ConsolidatorFlag: 0, HistoricalData: 1};
        var model = {};
        var modelType;
        var type = -1;
        var currentReportId = -1;
        var reportContainerIndex = 0;
        var isVersionStatusToggledByUser = true;
        var selectedForecasts = [];
        var target = false;
        var saveAs = false;
        var newDashboard = false;
        var saveAsDash = false;
        function imageVisulisation(target) {

            var tragetid = target.id


            if ($('.visual-icon-inner img.selected').length == 1) {
                $('.visual-icon-inner img').removeClass('selected');
                $('#' + tragetid + ' img').addClass('selected');
            }
            else
                $('#' + tragetid + ' img').addClass('selected');




        }

        $(document).ready(function () {
            localStorage.removeItem('selectedolditem');
            modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
            if (modelType == 1)
                $('#skutext').html('Segment');
            else
                $('#skutext').html('Sku');


            setReportSettingsToDefault();

            $('input.flat').iCheck({
                checkboxClass: 'icheckbox_flat-aero',
                radioClass: 'iradio_flat-aero'
            });
            $(function () {
                $('#toggle-event').bootstrapToggle({
                    on: 'Latest',
                    off: 'Original'
                });
            });

            $('#toggle-event').change(function () {
                //let's not run report if toggled from code, otherwise it will generate multiple charts!
                if (isVersionStatusToggledByUser)
                    runReportFromSelections();
                isVersionStatusToggledByUser = false;
            });
            $('.toggle-group').click(function (ev) {
                //ev.stopPropagation();
                isVersionStatusToggledByUser = true;
            });

            $($('#latest-version, #actual-version').next()).click(function () {
                if (isVersionStatusToggledByUser)
                    runReportFromSelections();
                else
                    isVersionStatusToggledByUser = true;
            });

            $($('#ProdConso').next()).click(function () {
                reportSettings.ConsolidatorFlag = 1;
            });

            $($('#IncludeHistorical').next()).click(function () {
                if(reportSettings.HistoricalData == 0)
                    reportSettings.HistoricalData = 1;
                else
                    reportSettings.HistoricalData = 0;
            });

            $('#prodLevel').click(function () {
                reportSettings.ConsolidatorFlag = 2;
            });

            $('#skuLevel').click(function () {
                reportSettings.ConsolidatorFlag = 0;
            });

            $('#datepicker-start').Zebra_DatePicker({
                view: 'years',
                format: 'm Y',
                pair: $('#datepicker-end'),
                onSelect: function (elements, options, edata, input) {
                    reportSettings.startDate = $(input).val();
                }
            });

            $('#datepicker-end').Zebra_DatePicker({
                direction: 1,
                format: 'm Y',
                view: 'years',
                onSelect: function (elements, options, edata, input) {
                    reportSettings.endDate = $(input).val();
                }
            });


            $('#datepicker-start').change(function () {
                reportSettings.startDate = $(this).val();
            });
            $('#datepicker-end').change(function () {
                reportSettings.endDate = $(this).val();
            });
            $('#reportIcon .fa-play-circle-o').click(function () {
                switchToResetMode();
            });
            
            $('#resetReport').click(function () {
                switchToRunMode();
                setVersionStatus(1);
                clearOnReset();
            });
            function clearOnReset() {
                $('#main-menu ul.nav-third-level input:checked').attr('checked', false);
                $(".insertinputsFilter input[name=frequency]").prop('checked', false);
                $(".insertinputsFilter input[name=frequency]:first").prop('checked', true);
                $(".sectionHeader input[name=prodskuLevel]:last").prop('checked', true);
                $('#ProdConso').parent().removeClass('checked');
                $('#IncludeHistorical').parent().addClass('checked');
                $("#CTypes input[type=radio]").prop('checked', false);
                $("#CTypes input[type=radio]:first").prop('checked', true);
                $("#number_format_id").val($("#number_format_id option:first").val());
                $("#axis_font_size_id").val($("#axis_font_size_id option:first").val());
                $("#currency_id").val($("#currency_id option:first").val());
                $("#chart_border_width_id").val($("#chart_border_width_id option:first").val());
                $("#shadow_id").val($("#shadow_id option:first").val());
                $("#decimal_precision_id").val($("#decimal_precision_id option").eq(2).val());
                $("#color_theme_id").val($("#color_theme_id option").eq(6).val());
                $(".bucket ol.properties #main-menu").remove();
                $(".bucket ol.properties #insertinputs ").html('<span id="default-place-value" class="default-place">Select Products here</span>')
                $('a#content_type_id').html('<i class="fa fa-bar-chart fa-2" aria-hidden="true"></i><strong> Show Chart </strong><i class="icon icon-caret-right"></i>');
                $("#axis_font_color_id").val('#00aabb');
                $("#cpaxis i").css("background-color", '#00aabb');
                $(".visual-types-container img").removeClass("selected");

                $("#chartbgcolor_id").val('#00aabb');
                $("#cpfont i").css("background-color", '#00aabb');

                $("#chartbordercolor_id").val('#00aabb');
                $("#cpborder i").css("background-color", '#00aabb');
              
               
            }
           // $('#chartbgcolor_id').val('#00aabb');
            //$('#chartbordercolor_id').val('#00aabb');
            //start Notification code
            //window.setInterval(function () {
            //    GetNotifications()
            //}, 5000);
            //Ends Notification code

             type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
             model = JSON.parse('<%=Html.Raw(Json.Encode(Model))%>');
            onForecastDimensionDrop();

            $('.landingContainer').click(function () {
                if ($('#sharebaleBox').hasClass('active'))
                    $('#sharebaleBox').toggleClass("active");

            });

            $(document).on('click', '.dashtext', function (ev) {
                ev.stopPropagation();
                $parent_box = $(this).closest('.dashbox');

                $parent_box.toggleClass('active');
                var liwidth = $parent_box.find('.top').width();
                var liheight = $parent_box.find('.top').height();
                var x = $parent_box.position();
                $('#sharebaleBox').css({ 'top': x.top + liheight / 2 });
                $('#sharebaleBox').toggleClass("active");

                if (isDashboard()) {
                    $(".openShareDelete li:first-child").css("display", "None");
                }
                else {
                    $(".openShareDelete li:first-child").css("display", "inline");
                }

                //update open link
                $('.openShareDelete li.open').click(function () {
                    // $('#insertinputs span').html("")
                    runExistingReport(($parent_box).attr("value"));
                });

                //update export links
                var exporters = $('.openShareDelete li.export-format>a');
                currentReportId = ($parent_box).attr("value");

                for (var i = 0; i < exporters.length; i++) {
                    if (isDashboard())
                        exporters[i].href = "/Reporting/DownloadDashboard?DashboardId={0}&format={1}&modelType={2}".replace("{0}", currentReportId).replace("{1}", i).replace("{2}", type);
                    if (isReport())
                        exporters[i].href = "/Reporting/DownloadReport?reportId={0}&format={1}&modelType={2}".replace("{0}", currentReportId).replace("{1}", i).replace("{2}", type);
                }
                // exporters[i].href = "/Reporting/DownloadReport?reportId={0}&format={1}&modelType={2}".replace("{0}", currentReportId).replace("{1}", i).replace("{2}", type);

            });

            $(document).on('click', '.dashtextforchart', function (ev) {
                ev.stopPropagation();
                $parent_box = $(this).closest('.dashbox');

                $parent_box.toggleClass('active');
                var liwidth = $parent_box.find('.top').width();
                //var liheight = $parent_box.find('.top').height();
                var liheight = $parent_box.parent().parent().position().top;
                var x = $parent_box.position();

                var posValue = $("li .navigationItemList").parent().parent().position();
                
                //$('#sharebaleBox').css({ 'top': x.top + liheight / 2 + posValue.top });
                $('#sharebaleBox').css({ 'top': 1.22*(x.top) + liheight });

                $('#sharebaleBox').toggleClass("active");

                if (isDashboard()) {
                    $(".openShareDelete li:first-child").css("display", "None");
                }
                else {
                    $(".openShareDelete li:first-child").css("display", "inline");
                }

                //update open link
                $('.openShareDelete li.open').click(function () {
                    // $('#insertinputs span').html("")
                    runExistingReport(($parent_box).attr("value"));
                });

                //update export links
                var exporters = $('.openShareDelete li.export-format>a');
                currentReportId = ($parent_box).attr("value");

                for (var i = 0; i < exporters.length; i++) {
                    if (isDashboard())
                        exporters[i].href = "/Reporting/DownloadDashboard?DashboardId={0}&format={1}&modelType={2}".replace("{0}", currentReportId).replace("{1}", i).replace("{2}", type);
                    if (isReport())
                        exporters[i].href = "/Reporting/DownloadReport?reportId={0}&format={1}&modelType={2}".replace("{0}", currentReportId).replace("{1}", i).replace("{2}", type);
                }
                // exporters[i].href = "/Reporting/DownloadReport?reportId={0}&format={1}&modelType={2}".replace("{0}", currentReportId).replace("{1}", i).replace("{2}", type);

            });

            $('.existingDashRadio').click(function () {
                if ($(this).is(":checked")) {
                    $('#newDashRadio').css("display", "none");
                    $('#existingDashRadio').css("display", "block");
                    loadDashboardList(model.dashboardList, 'ReporPinModel');
                }
            });
            $('.newDashRadio').click(function () {
                if ($(this).is(":checked")) { 
                    $('#existingDashRadio').css("display", "none");
                    $('#newDashRadio').css("display", "block");

                }
            });

            getReportInfo(model.reportList);
            loadDashboardList(model.dashboardList, 'dashboardLeftPannel');
            loadReportValueParams();
            loadUsers();
            $('.js-reload-details').on('click', function (evt) {
                evt.preventDefault();
                evt.stopPropagation();
                if (validateReportConfigurations()) {
                setVersionStatus(0);
                setHtmlTillVersionHierarchy();
                runReportFromSelections();
                }
            });
            $(".navigationItemList.reportList").niceScroll({
                cursorfixedheight: 70,
                cursorcolor: "#999",
                autohidemode: "fals‌​e"
            });

            $(".navigationItemList.versionList").niceScroll({
                cursorfixedheight: 70,
                cursorcolor: "#999",
                autohidemode: "fals‌​e"
            });
            
            $("#botbar").niceScroll({
                cursorfixedheight: 70,
                cursorcolor: "#999",
                autohidemode: "fals‌​e"
            });
            $("#scollableDiv").niceScroll({
                cursorfixedheight: 70,
                cursorcolor: "#999",
                autohidemode: "fals‌​e"
            });
            $("#dataList").niceScroll({
                cursorfixedheight: 70,
                cursorcolor: "#999",
                autohidemode: "fals‌​e"
            });

            //$(".scrollRegion").niceScroll({
            //    cursorfixedheight: 70,
            //    cursorcolor: "#999",
            //    autohidemode: "fals‌​e"
            //});
            //$("#scollableDiv").niceScroll({
            //    cursorfixedheight: 70,
            //    cursorcolor: "#999",
            //    autohidemode: "fals‌​e"
            //});

            $(function () {
                $('#menu_toggle').click(function () {
                    if ($('body').hasClass('nav-md')) {
                        $('body').removeClass('nav-md').addClass('nav-sm');
                        $('.scrollRegion').removeClass('scroll-view');
                    } else {
                        $('body').removeClass('nav-sm').addClass('nav-md');
                        $('.scrollRegion').addClass('scroll-view');
                    }
                });
            });

            $(function () {
                //$('#cp2').colorpicker();
                //$('#cpbg').colorpicker();
                $('#cpborder').colorpicker().on('changeColor', function () {
                    onChartBorderColorChange();
                });
                $('#cpaxis').colorpicker().on('changeColor', function () {
                    onAxisFontColorChange();
                });
                $('#cpfont').colorpicker().on('changeColor', function () {
                    onChartBgColorChange();
                });
            });

            $('#share').click(function () {
                $('#shareReportModal').modal('show');
               

            });

            $('.openShareDelete li.open').click(function (e) {
               // $('#insertinputs span').html("")
                var selectedId = ($parent_box).attr("value");

                if(isDashboard())
                {
                   
                }
                
                if (isReport()) {
                 
                }
               
            });

            $('.openShareDelete li.share').click(function (e) {
                $('#shareReportModal').modal('show');
               
            });

            $('.openShareDelete li.delete').click(function (e) {
                var selectedId = ($parent_box).attr("value");
                var isBoard = isDashboard();
                var removalItem = "report";
                if (isBoard)
                    removalItem = "dashboard";
                bootbox.dialog({
                    message: "Do you want to remove the {0}?".replace("{0}", removalItem),
                    title: "",
                    closeButton: true,
                    size: 'small',
                    className: "custom-dialogue",
                    buttons: {
                        success: {
                            label: "Yes",
                            className: "btn-diabox",
                            callback: function (result) {
                                if (result) {
                                    if (isBoard) {
                                        removeDashboard(selectedId)
                                    }
                                    else {
                                        removeReport(selectedId)
                                    }
                                }
                            }
                        },
                        main: {
                            label: "No",
                            className: "btn-dacancel",
                            callback: function () {
                                bootbox.hideAll();
                            }
                        }
                    }
                });                

            });

            
                $('li.print>a').click(function () {
                    printFrame();
                    return false;
                });

                if($('.horizontalItemsContainer #IframeInner iframe').length == 0){
                    var prepend = '<iframe style="height:100%;" />';
                    var existing_html = $('.horizontalItemsContainer #IframeInner')[0].innerHTML;
                    $('.horizontalItemsContainer #IframeInner')[0].innerHTML = prepend + existing_html;
                }
                $('.horizontalItemsContainer #IframeInner iframe')[0].src = model.Url;
            
        });

        function setReportSettingsToDefault() {
            reportSettings = { Country: "United States", NumberFormat: 0, DecimalPrecision: 2, CurrencySymbol: 0, ColorTheme: 6, AxisFontSize: 11, AxisFontColor: "00AABB", ChartBgColor: "FFFFFF", ChartBorderColor: "00AABB", ChartBorderWidth: 2, TitleFontSize: 12, TitleColour: "000000", Shadow: 10, ShowLegend: 1, VersionFlag: 0, ConsolidatorFlag: 0, HistoricalData: 1};
            selectedForecasts = [];
        }

        function printFrame() {
            var frm = document.getElementById("iframeid").contentWindow;
            frm.focus();// focus on contentWindow is needed on some ie versions
            frm.print();
        }
        
        function loadUsers() {
            var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetAllUsers", { type: modelType },
            function (result) {
                if (result.success) {
                    populateSharePopup(result.users);
                   
                }
                else
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching user details failed: " + result.errors.join(), '');
            },
            function (result) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching user details failed! " + result.responseText, '');
        });

        }

        function toggleSliderSidebar() {
            $('.SliderSidebar .toggleText').toggleClass("isCollapsed", 800);
            $('.SliderSidebar').toggleClass("isCollapsed", 800);
            $('.SliderSidebar .SliderSidebarContent').toggleClass("isCollapsed", 800);
        }

        function getSelectedParams() {
            var params = [];
            $('.value-parameter:checked').each(function () {
                params.push($(this).next().attr('title'));
            });
            return params;
        }

        function setDefaults() {
            //set start and end dates
            if (!reportSettings.startDate)
                reportSettings.startDate = model.reportAxes.MinStartDate;
            if (!reportSettings.endDate)
                reportSettings.endDate = model.reportAxes.MaxEndDate;
            //set countrys
            if (!reportSettings.Country)
                reportSettings.Country = "United States";
           //reportSettings.Visualization = 2;
            
        }

        function runReportFromSelections() {
            //PHARMAACE.FORECASTAPP.UTILITY.showOverlay($('div#report_container.exploration'), "Getting your report...");
            //first, clear the container
            $('div#report_container.exploration').html("")
              //  PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your report...", 'report_container', "15", "");
          
            setDefaults();
            //set value params
            var params = getSelectedParams();
            if (params.length > 0) {
                //Append multiple div  in report_container 
                //for (var i = 0; i < params.length; i++) {
                    //var reportContainer = $('div#report_container.exploration');
                    //var innerDiv = document.createElement('div');
                    //innerDiv.id = 'report_container_' + i;
                    //innerDiv.className = 'reportdynamidiv';
                    //report_container.appendChild(innerDiv);
                    //PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your report...", 'report_container_' + i, "15", "");
                //}

                for (var i = 0; i < params.length; i++) {
                    var distinctAxisSettings = serializeReportSettings(params[i]);
                    if (distinctAxisSettings && distinctAxisSettings.Axes.length > 0) {
                        var setting = serializeReportSettings(params[i]);
                       runReport(setting,i);
                    }
                    else {
                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('report_container');
                        validateReportConfigurations();
                        break;
                    }
                }
            }
            else {
                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('report_container');
                validateReportConfigurations();
            }
        }

        function getLatestVersion(project) {
            var forecastIndex = model.reportAxes.Forecasts.inArray([{ property: 'Name', searchFor: project }]);
            if (forecastIndex >= 0)
                return model.reportAxes.Forecasts[forecastIndex].Versions[0].Label;

            return null;
        }

        function validateReportConfigurations() {            
            var skuOrSegment;
            if (model.ReportType == 0)
                skuOrSegment = "SKU";
            else if (model.ReportType == 1)
                skuOrSegment = "Segment";

            if(!reportSettings["'Projects'"] || reportSettings["'Projects'"].length == 0)
            {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select Project(s)", '');
                return false;
                    }
            else if (!reportSettings["'Versions'"] || reportSettings["'Versions'"].length == 0)
            {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select Version(s)", '');
                        return false;
                    }
            else if (!reportSettings["'Products'"] || reportSettings["'Products'"].length == 0)
            {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select Product(s)", '');
                return false;
                }
            else if (!reportSettings["'Scenarios'"] || reportSettings["'Scenarios'"].length == 0) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select Scenario(s)", '');
                return false;
            }
            else if (!reportSettings["'SKUs'"] || reportSettings["'SKUs'"].length == 0) { //"SKUs" serves both sku and segment                
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select " + skuOrSegment + "(s)", '');
                return false;
            }

            for (var i = 0; i < reportSettings["'Products'"].length; i++) {
                for (var j = 0; j < reportSettings["'Scenarios'"].length; j++) {
                    if (reportSettings["'Scenarios'"][j].startsWith(reportSettings["'Products'"][i] + '|'))
                        break;
                    if (j == reportSettings["'Scenarios'"].length - 1) {
                        var productParts = reportSettings["'Products'"][i].split('|');
                        var project = productParts[0];
                        var version = productParts[1];
                        var product = productParts[2];
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select Scenario(s) for " + project + " " + version + " (" + product + ")", '');
                return false;
            }
                }
            }

            for (var i = 0; i < reportSettings["'Products'"].length; i++) {
                for (var j = 0; j < reportSettings["'SKUs'"].length; j++) {
                    if (reportSettings["'SKUs'"][j].startsWith(reportSettings["'Products'"][i] + '|'))
                        break;
                    if (j == reportSettings["'SKUs'"].length - 1) {
                        var productParts = reportSettings["'Products'"][i].split('|');
                        var project = productParts[0];
                        var version = productParts[1];
                        var product = productParts[2];
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select " + skuOrSegment + "(s) for " + project + " " + version + " (" + product + ")", '');
                        return false;
                    }
                }
            }
            
            var params = getSelectedParams();
            if (!params || params.length == 0) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select Field(s)", '');
                return false;
            }

            return true;
        }

        function runReport(settingWithSingleParam, reportContainerIndex) {
            if(<%:Html.Raw(PharmaACE.ForecastApp.Business.GenUtil.reportType)%>=="1")
            {
                updateVersionInSetting(settingWithSingleParam);
                var jsonSettingWithSingleParam = JSON.stringify(settingWithSingleParam);
                var url = $('.js-reload-details').data('url');
                PHARMAACE.FORECASTAPP.SERVICE.traditionalPostHtmlData(url, jsonSettingWithSingleParam,
                        function (data) {
                            //var reportContainer = $('div#report_container.exploration');
                            //if (reportContainer.length > 0) {
                            //    $('#report_container_' + reportContainerIndex).append(data);
                            //    $('#report_container_' + reportContainerIndex + ' iframe').on("load", function () { onReportLoad(this, reportContainerIndex); });
                            //}
                            //else {
                            //    $('.horizontalItemsContainer iframe').append(data);
                            //}
                            //if($('.horizontalItemsContainer iframe').length == 0){
                            //    var prepend = '<iframe style="height:100%;" />';
                            //    var existing_html = $('.horizontalItemsContainer')[0].innerHTML;
                            //    $('.horizontalItemsContainer')[0].innerHTML = prepend + existing_html;
                            //}
                            //$('.horizontalItemsContainer iframe')[0].src = model.Url;
                        },
                        function (data) {
                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('report_container');
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not render forecast report.", '');
                        });
            }
           if(<%:Html.Raw(PharmaACE.ForecastApp.Business.GenUtil.reportType)%>=="2")
            {
                updateVersionInSetting(settingWithSingleParam);
                var jsonSettingWithSingleParam = JSON.stringify(settingWithSingleParam);
                var url = $('.js-reload-details').data('url');            
                //PHARMAACE.FORECASTAPP.SERVICE.traditionalPostHtmlData(url, jsonSettingWithSingleParam,
                //        function (data) {
                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Reporting/GetTableauToken", null,
                    function (result) {
                        if (result.success) {
                            var containerDiv;
                            var reportContainer = $('div#report_container.exploration');
                            if (reportContainer.length > 0) {
                                //$('#report_container_' + reportContainerIndex).append(data);
                                //$('#report_container_' + reportContainerIndex + ' iframe').on("load", function () { onReportLoad(this, reportContainerIndex); });
                                containerDiv = $('#report_container_' + reportContainerIndex)[0];
                            }
                            else {
                                //$('.horizontalItemsContainer iframe').append(data);
                                containerDiv = $('.horizontalItemsContainer #IframeInner iframe');
                            }
                            //var containerDiv = document.getElementById("vizContainer"),
                            //var url = "http://127.0.0.1:8000/trusted/{0}/authoring/BDLReport2/Sheet1".replace("{0}", result.token);
                            var url = "http://13.89.232.215:8000/trusted/{0}/authoring/Test/Sheet1".replace("{0}", result.token);
                            var options = {
                                hideTabs: true,
                                hideToolbar: true,
                                onFirstInteractive: function () {
                                    alert(1);
                                }
                            };

                            // Create a viz object and embed it in the container div.
                            var viz = new tableau.Viz(containerDiv, url, options);

                            //},
                            //function (data) {
                            //    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('report_container');
                            //    PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not render forecast report.", '');
                            //});
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Report generated successfully..", '');
                        }
                        else {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not generate report. Try again.", '');
                        }
                    },
               function (result) {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not generate report. Try again.", '');
               });
            }
        }
        function updateVersionInSetting(settingWithSingleParam) {
            for (var i = 0; i < settingWithSingleParam.Axes.length; i++) {
                var settingComponents = settingWithSingleParam.Axes[i].split('|');
                if (getVersionStatus() == 1) //latest
                {
                    var latestVersion = getLatestVersion(settingComponents[0]);
                    if(latestVersion)
                        settingComponents[1] = latestVersion;
                }
                else {                    
                    var versionProjectId = "version_project_" + settingComponents[0].replace(' ', '_');
                    settingComponents[1] = $.trim(($('#insertversions>li[id="{0}"]>ul>li.isActive>span'.replace("{0}", versionProjectId)).text()));
                }
                settingWithSingleParam.Axes[i] = settingComponents.join('|');
            }
        }

        function onReportLoad(objFrame, reportContainerIndex) {
            frameLoaded(reportContainerIndex);
            //$(this).height($(this).contents().outerHeight());
            //this.style.height = this.contentWindow.document.body.scrollHeight + 'px';
            objFrame.height = objFrame.offsetHeight;
            objFrame.width = objFrame.offsetWidth * 1.3;
            // hideLeftRightPanes();
            var reportContainerId = $(objFrame).parent().parent().attr('id');
            var reportContainerIndex = reportContainerId.substr(reportContainerId.length - 1);
            var reportContainerDivCount = ($(objFrame).parent().parent().parent().children().length) - 1;
            if (reportContainerIndex == reportContainerDivCount) {
                hideLeftRightPanes();
            }
            //var dt = new Date();
            //var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
            //console.log($(objFrame).parent().parent().attr('id')+ ' loading Completed at time:' + time);
            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay($(objFrame).parent().parent().attr('id'));
        }

        function hideLeftRightPanes() {
            //hide left pane if visible
            if ($('a#content_type_id')[0].offsetParent)
                $('.expanderBtn')[0].click();
            //hide right panes if visible
            if (!$($('.expanderBtn')[1]).parent().hasClass('isCollapsed'))
                $('.expanderBtn')[1].click();
            if (!$($('.expanderBtn')[2]).parent().hasClass('isCollapsed'))
                $('.expanderBtn')[2].click();
        }

        function getDistinctReportSettings() {
            var distinctReportSettings = [];
            if (reportSettings["'SKUs'"] && reportSettings["'Scenarios'"]) {
            for (var i = 0; i < reportSettings["'SKUs'"].length; i++) {
                var sku = reportSettings["'SKUs'"][i];
                var skuParts = sku.split('|');
                var productOnly = '', skuOnly = '';
                if (skuParts.length == 4) {
                    skuOnly = skuParts.pop();
                }                
                var product = skuParts.join('|');
                for (var j = 0; j < reportSettings["'Scenarios'"].length; j++) {
                    var scenario = reportSettings["'Scenarios'"][j];
                    var scenarioParts = scenario.split('|');
                    var scenarioOnly = '';
                    if (scenarioParts.length == 4) {
                        scenarioOnly = scenarioParts.pop();
                    }                    
                    if (product === scenarioParts.join('|')) {
                        distinctReportSettings.push(product + '|' + skuOnly + '|' + scenarioOnly);
                        }
                    }
                }
            }

            return distinctReportSettings;
        }

        //desirialize reportsettings for existing report before running it
        function deserializeDistinctReportSettings() {
            reportSettings["'Projects'"] = [];
            reportSettings["'Versions'"] = [];
            reportSettings["'Products'"] = [];
            reportSettings["'SKUs'"] = [];
            reportSettings["'Scenarios'"] = [];            
            for (var i = 0; i < reportSettings.Axes.length; i++) {
                var splitArr = reportSettings.Axes[i].split('|');
                if ($.inArray(splitArr[0], reportSettings["'Projects'"]) == -1)
                    reportSettings["'Projects'"].push(splitArr[0]);
                if ($.inArray(splitArr[0] + '|' + splitArr[1], reportSettings["'Versions'"]) == -1)
                    reportSettings["'Versions'"].push(splitArr[0] + '|' + splitArr[1]);
                if ($.inArray(splitArr[0] + '|' + splitArr[1] + '|' + splitArr[2], reportSettings["'Products'"]) == -1)
                    reportSettings["'Products'"].push(splitArr[0] + '|' + splitArr[1] + '|' + splitArr[2]);
                if ($.inArray(splitArr[0] + '|' + splitArr[1] + '|' + splitArr[2] + '|' + splitArr[3], reportSettings["'SKUs'"]) == -1)
                    reportSettings["'SKUs'"].push(splitArr[0] + '|' + splitArr[1] + '|' + splitArr[2] + '|' + splitArr[3]);
                if ($.inArray(splitArr[0] + '|' + splitArr[1] + '|' + splitArr[2] + '|' + splitArr[4], reportSettings["'Scenarios'"]) == -1)
                    reportSettings["'Scenarios'"].push(splitArr[0] + '|' + splitArr[1] + '|' + splitArr[2] + '|' + splitArr[4]);
            }
            //reportSettings["'Projects'"] = reportSettings["'Projects'"];
            //reportSettings["'Versions'"] = reportSettings["'Versions'"];
            //reportSettings["'Products'"] = reportSettings["'Products'"];
            //reportSettings["'SKUs'"] = reportSettings["'SKUs'"];
            //reportSettings["'Scenarios'"] = reportSettings["'Scenarios'"];

            updateTrees();
        }

        function selectScenarioRoot(cboScenarioRoot) {
            $.each($(cboScenarioRoot).parent().siblings("ul").find("input[type='checkbox']"), function () {
                this.checked = cboScenarioRoot.checked;              

                selectScenario(this, true)
            });
        }

        function showHideLegend(cboShowLegend) {
            reportSettings.ShowLegend = cboShowLegend.checked ? 1 : 0;
        }

        function showHistoricalData(IncludeHistorical) {
            reportSettings.HistoricalData = IncludeHistorical.checked ? 1 : 0;
        }

        function selectScenario(cboScenario, fromRoot) {
            var scenario = cboScenario.value;
            var product = $(cboScenario).parent().parent().parent().parent().parent().siblings()[0].text;
            var version = $(cboScenario).parent().parent().parent().parent().parent().parent().parent().parent().parent().siblings()[0].text;
            var project = $(cboScenario).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent().parent().siblings()[0].text
            if (cboScenario.checked)
                updateSettings(project, version, scenario, product, null);
            else
                removeSettings(project, version, scenario, product, null);
            if(!fromRoot)
                checkIndeterminate($(cboScenario));
        }

        function checkIndeterminate(rootCheckbox) {
            var root_ul = rootCheckbox.parent().parent().parent();
            var childCheckBoxes = root_ul.find("input[type='checkbox']");
            var checkedCount = 0;
            $.each(childCheckBoxes, function () {
                if (this.checked == true)
                    checkedCount++;
            });
            var root_cb = rootCheckbox.parent().parent().parent().siblings()[0].children[0];
            if (checkedCount == childCheckBoxes.length) {
                root_cb.indeterminate = false;
                root_cb.checked = true;
            }
            else if (checkedCount == 0) {
                root_cb.indeterminate = false;
                root_cb.checked = false;
            }
            else
                root_cb.indeterminate = true;
        }

        function selectSkuRoot(cboSkuRoot) {
            $.each($(cboSkuRoot).parent().siblings("ul").find("input[type='checkbox']"), function () {
                this.checked = cboSkuRoot.checked;
                selectSku(this, true);
            });
        }

        function selectSku(cboSKU, fromRoot) {
            var sku = cboSKU.value;
            var product = $(cboSKU).parent().parent().parent().parent().parent().siblings()[0].text;
            var version = $(cboSKU).parent().parent().parent().parent().parent().parent().parent().parent().parent().siblings()[0].text;
            var project = $(cboSKU).parent().parent().parent().parent().parent().parent().parent().parent().parent().parent().parent().siblings()[0].text;
            if (cboSKU.checked)
                updateSettings(project, version, null, product, sku);
            else
                removeSettings(project, version, null, product, sku);
            if (!fromRoot)
                checkIndeterminate($(cboSKU));
        }

        function selectSegmentRoot(cboSegmentRoot) {
            $.each($(cboSegmentRoot).parent().siblings("ul").find("input[type='checkbox']"), function () {
                this.checked = cboSegmentRoot.checked;
                selectSku(this, true);
            });
        }

        function updateSettings(selectedProject, selectedVersion, selectedScenario, selectedProduct, selectedSKU) {
            if (selectedProject) {
                updateSetting('Projects', selectedProject);
                if (selectedVersion) {
                    updateSetting('Versions', selectedProject + '|' + selectedVersion);
                    if (selectedProduct) {
                        updateSetting('Products', selectedProject + '|' + selectedVersion + '|' + selectedProduct);
                        if (selectedScenario)
                            updateSetting('Scenarios', selectedProject + '|' + selectedVersion + '|' + selectedProduct + '|' + selectedScenario);
                        if (selectedSKU)
                            updateSetting('SKUs', selectedProject + '|' + selectedVersion + '|' + selectedProduct + '|' + selectedSKU);                        
                    }
                }
            }
            updateSelectedForecasts(selectedProject, selectedVersion, selectedScenario, selectedProduct, selectedSKU);
        }

        function updateSelectedForecasts(selectedProject, selectedVersion, selectedScenario, selectedProduct, selectedSKU) {
            if (selectedProject) {
                //project
                var projectIndex = selectedForecasts.inArray([{ property: 'Name', searchFor: selectedProject }]);
                var project = null;
                if (projectIndex == -1) {
                    project = { Name: selectedProject, Versions: [] };
                    selectedForecasts.push(project);
                }
                else
                    project = selectedForecasts[projectIndex];

                if (selectedVersion) {
                    //version
                    var versionIndex = project.Versions.inArray([{ property: 'Label', searchFor: selectedVersion }]);
                    var version = null;
                    if (versionIndex == -1) {
                        version = { Label: selectedVersion, Scenarios: [], Products: [] };
                        project.Versions.push(version);
                    }
                    else
                        version = project.Versions[versionIndex];

                    if (selectedProduct) {
                        //product
                        var productIndex = version.Products.inArray([{ property: 'Name', searchFor: selectedProduct }]);
                        var product = null;
                        if (productIndex == -1) {
                            product = { Name: selectedProduct };
                            version.Products.push(product);
                        }
                        else
                            product = version.Products[productIndex];

                        if (selectedScenario) {
                            //scenario
                            var scenarioIndex = $.inArray(selectedScenario, version.Scenarios);
                            if (scenarioIndex == -1)
                                version.Scenarios.push(selectedScenario);
                        }

                        //sku
                        if (selectedSKU) {
                            if (modelType == 0) { //generic
                                if (!product.SKUs)
                                    product.SKUs = [];
                                var skuIndex = $.inArray(selectedSKU, product.SKUs);
                                if (skuIndex == -1)
                                    product.SKUs.push(selectedSKU);
                            }
                            else if (modelType == 1) {
                                if (!product.Segments)
                                    product.Segments = [];
                                var segmentIndex = $.inArray(selectedSKU, product.Segments);
                                if (segmentIndex == -1)
                                    product.Segments.push(selectedSKU);
                            }
                        }
                    }
                }
            }

            document.getElementById('insertinputs').innerHTML = getHtmlFromForecastHierarchy(selectedForecasts, "selected_");
        }

        function updateSetting(setting, selectedSetting) {
            if (!reportSettings["'" + setting + "'"])
                reportSettings["'" + setting + "'"] = [];
            var reportIndex = $.inArray(selectedSetting, reportSettings["'" + setting + "'"]);
            if (reportIndex == -1)
                reportSettings["'" + setting + "'"].push(selectedSetting);
        }

        function removeSettings(selectedProject, selectedVersion, selectedScenario, selectedProduct, selectedSKU) {
            var settingToRemove = '';
            var valueToRemove = '';
            if (selectedProject) {
                settingToRemove = 'Projects';
                valueToRemove = selectedProject;
                if (selectedVersion) {
                    settingToRemove = 'Versions';
                    valueToRemove = selectedProject + '|' + selectedVersion;
                    if (selectedProduct) {
                        settingToRemove = 'Products';
                        valueToRemove = selectedProject + '|' + selectedVersion + '|' + selectedProduct;
                        if (selectedScenario) {
                            settingToRemove = 'Scenarios';
                            valueToRemove = selectedProject + '|' + selectedVersion + '|' + selectedProduct + '|' + selectedScenario;
                        }
                        if (selectedSKU) {
                            settingToRemove = 'SKUs';
                            valueToRemove = selectedProject + '|' + selectedVersion + '|' + selectedProduct + '|' + selectedSKU;
                        }                        
                    }
                }
            }
            removeSetting(settingToRemove, valueToRemove);

            removeFromSelectedForecasts(selectedProject, selectedVersion, selectedScenario, selectedProduct, selectedSKU, selectedSegment);
        }

        function removeFromSelectedForecasts(selectedProject, selectedVersion, selectedScenario, selectedProduct, selectedSKU, selectedSegment) {
            if (selectedProject) {
                //project
                var projectIndex = selectedForecasts.inArray([{ property: 'Name', searchFor: selectedProject }]);
                var project = null;
                if (projectIndex == -1)
                    return;
                else
                    project = selectedForecasts[projectIndex];

                if (selectedVersion) {
                    //version
                    var versionIndex = project.Versions.inArray([{ property: 'Label', searchFor: selectedVersion }]);
                    var version = null;
                    if (versionIndex == -1)
                        return;
                    else
                        version = project.Versions[versionIndex];

                        if (selectedProduct) {
                            //product
                            var productIndex = version.Products.inArray([{ property: 'Name', searchFor: selectedProduct }]);
                            var product = null;
                            if (productIndex == -1)
                                return;
                            else
                                product = version.Products[productIndex];

                            if (selectedScenario) {
                                //scenario
                                var scenarioIndex = $.inArray(selectedScenario, version.Scenarios);
                                if (scenarioIndex == -1)
                                    return;
                                version.Scenarios.splice(scenarioIndex, 1); //delete 1 member starting from scenarioIndex in the scenario array
                            }

                            var skuIndex = -1;
                            var segmentIndex = -1;
                            //sku
                            if (selectedSKU)
                                skuIndex = $.inArray(selectedSKU, product.SKUs);

                            //segment
                            if (selectedSegment)
                                segmentIndex = $.inArray(selectedSegment, product.Segments);

                            if (product.SKUs && skuIndex >= 0)
                                product.SKUs.splice(skuIndex, 1)

                            if (product.Segments && segmentIndex >= 0)
                                product.Segments.splice(segmentIndex, 1)
                        }                    
                }
            }

            document.getElementById('insertinputs').innerHTML = getHtmlFromForecastHierarchy(selectedForecasts, "selected_");
        }

        function removeSetting(setting, selectedSetting) {
            if (reportSettings["'" + setting + "'"]) {
                var settingIndex = $.inArray(selectedSetting, reportSettings["'" + setting + "'"]);
                if (settingIndex != -1)
                    reportSettings["'" + setting + "'"].splice(settingIndex, 1);
            }
        }

        function onContentChange(text, index) {
            reportSettings.TableData = index;
            $('a#content_type_id').html('<strong>Show:</strong><span class="chart-type">&nbsp;' + text + '</span><i class="icon icon-caret-right"></i>');
            runReportFromSelections();
        }

        function deserializeReportSettings() {

            //dimensions
            $("input[type=checkbox].cls-dimension").each(function () {
                this.click();
            });

            //parameters            
            $("input[type=checkbox].value-parameter").siblings('span').each(function () {
                if ($.inArray($.trim($(this).text()), reportSettings.Parameters) >= 0)
                    $(this).siblings('input').click();
            });

            //axis
            deserializeDistinctReportSettings();

            //countrys
            var cbos = $("input:checkbox[name='country']");
            if (cbos.length > 0 && reportSettings.Country) {
                var countrys = reportSettings.Country.split('|');
                for (var i = 0; i < cbos.length; i++) {
                    if ($.inArray($(cbos[i]).val(), countrys) >= 0)
                        cbos[i].checked = true;
                }
            }

            //start and end date
            
            var formatedStartDate = reportSettings.MinStartDate;
            var formatedEndDate = reportSettings.MaxEndDate;
            $('input#datepicker-start').val(formatedStartDate);
            reportSettings.startDate = formatedStartDate;
            $('input#datepicker-end').val(formatedEndDate);
            reportSettings.endDate = formatedEndDate;

            //formats
            document.getElementById("number_format_id").selectedIndex = reportSettings.NumberFormat;
            document.getElementById("decimal_precision_id").selectedIndex = reportSettings.DecimalPrecision;
            document.getElementById("currency_id").selectedIndex = reportSettings.CurrencySymbol;
            document.getElementById("color_theme_id").selectedIndex = reportSettings.ColorTheme;
            $("#axis_font_size_id").find("option[text=" + reportSettings.AxisFontSize + "]").attr("selected", true);
            $("#axis_font_color_id").val('#' + reportSettings.AxisFontColor);
            $("chartbgcolor_id").val('#' + reportSettings.ChartBgColor);
            $("chartbordercolor_id").val('#' + reportSettings.ChartBorderColor);
            document.getElementById("chart_border_width_id").value = reportSettings.ChartBorderWidth;
            document.getElementById("shadow_id").selectedIndex = reportSettings.Shadow;
            document.getElementById("cboShowLegend").checked = reportSettings.ShowLegend == 1 ? true : false;

            //consolidator flag
            getConsolidationLevel();


            //Historical data
            document.getElementById("IncludeHistorical").checked = reportSettings.HistoricalData == 1 ? true : false;
        }

        //function getDate(startEndDate) {
        //    var date = startEndDate;
        //    //var month = date.getMonth;
        //    //if (month<10) {
        //    //    month = "0" + month;
        //    //}
        //    //var year = date.getFullYear;
        //    //var newDate = month + " " + year;
        //    //return newDate;
        //    return date;
        //}

        function onNumberFormatChange() {
            reportSettings.NumberFormat = document.getElementById("number_format_id").selectedIndex;
        }

        function onDecimalPrecisionChange() {
            reportSettings.DecimalPrecision = document.getElementById("decimal_precision_id").selectedIndex;
        }

        function onCurrencySymbolChange() {
            reportSettings.CurrencySymbol = document.getElementById("currency_id").selectedIndex;
        }

        function onColorThemeChange() {
            reportSettings.ColorTheme = document.getElementById("color_theme_id").selectedIndex;
        }

        function onAxisFontSizeChange() {
            reportSettings.AxisFontSize = $.trim(document.getElementById("axis_font_size_id").selectedOptions[0].text);
        }

        function onAxisFontColorChange() {
            reportSettings.AxisFontColor = $.trim(document.getElementById("axis_font_color_id").value.replace('#', ''));
        }

        function onChartBgColorChange() {
            reportSettings.ChartBgColor = $.trim(document.getElementById("chartbgcolor_id").value.replace('#', ''));
        }

        function onChartBorderColorChange() {
            reportSettings.ChartBorderColor = $.trim(document.getElementById("chartbordercolor_id").value.replace('#', ''));
        }

        function onChartBorderWidthChange() {
            reportSettings.ChartBorderWidth = $.trim(document.getElementById("chart_border_width_id").value);
        }

        function onShadowChange() {
            reportSettings.Shadow = document.getElementById("shadow_id").selectedIndex;
        }
                
        //function setForecastPeriod() {
        //    var dateRange = $('input[name="daterange"]');
        //    if (dateRange && dateRange.length > 0) {
        //        var dates = dateRange.val().split('-');
        //        reportSettings.startDate = dates[0];
        //        reportSettings.endDate = dates[1];
        //    }
        //}

        function onForecastPeriodDrop() {
        
            var start_date = reportSettings.startDate ? new Date(reportSettings.startDate) : new Date();
            var end_date = reportSettings.endDate ? new Date(reportSettings.endDate) : new Date();
            var m1 = start_date.getMonth() + 1;
            var m2 = end_date.getMonth() + 1;
            ////var str = '<li id="daterangeBox" class="ui-droppable">'
           // str += '<input type="text" name="daterange" class="dropup" value="{0}/{1}/{2} - {3}/{4}/{5}" />'.replace("{0}", m1).replace("{1}", start_date.getDate()).replace("{2}", start_date.getFullYear()).replace("{3}", m2).replace("{4}", end_date.getDate()).replace("{5}", end_date.getFullYear());
            ////str += '<input id="datepicker-start" name="daterange" type="text" placeholder="From"><input id="datepicker-end" type="text" placeholder="To" >';
            ///str += '</li>';
            document.getElementById('insertinputsvisual').innerHTML = str;            
            //$('input[name="daterange"]').daterangepicker(
            

            //    );
            //properties and events of zebra datepicker: http://stefangabos.ro/jquery/zebra-datepicker/
            //$('#datepicker-start').Zebra_DatePicker({               
            //    pair: $('#datepicker-end'),
            //    onSelect: function (elements, options, edata, input) {
            //        reportSettings.startDate = $(input).val();
            //    }
            //});

            //$('#datepicker-end').Zebra_DatePicker({
            //    direction: 1,
            //    onSelect: function (elements, options, edata, input) {
            //        reportSettings.endDate = $(input).val();
            //    }
            //});

            ////$('#applyBtn').click(function () {
            ////    setForecastPeriod();
            ////});

            ////$('input[name="daterange"]').change(function () {
            ////    setForecastPeriod();
            ////});

            //$('#datepicker-start').change(function () {
            //    reportSettings.startDate = $(this).val();
            //});
            //$('#datepicker-end').change(function () {
            //    reportSettings.endDate = $(this).val();
            //});
        }

        function onForecastDimensionDrop() {
            document.getElementById('insertinputsvisual').innerHTML = getHtmlFromForecastHierarchy(model.reportAxes.Forecasts);
        }

        function setHtmlTillVersionHierarchy() {
            for (var i = 0; i < selectedForecasts.length; i++) {
                var project = selectedForecasts[i].Name;
                var projectIndex = model.reportAxes.Forecasts.inArray([{ property: 'Name', searchFor: project }]);
                if (projectIndex >= 0) {
                    var versionProjectId = "version_project_" + project.replace(' ', '_');
                    if ($('#' + versionProjectId).length == 0) {
                        var versionProjectHtml = '<li class="tree-toggle" id="{0}">'.replace("{0}", versionProjectId);
                        versionProjectHtml += '<a onclick="openUi({0})" href="#">{1}<span class="fa arrow"></span> </a>'.replace("{0}", "'" + versionProjectId + "'").replace("{1}", project);
                        versionProjectHtml += '<ul class="nav nav-second-level collapse tree">';
                        versionProjectHtml += '</ul></li>';
                        $("#insertversions").append(versionProjectHtml);

                        var projectVersions = model.reportAxes.Forecasts[projectIndex].Versions;
                        var versionHtml = '';
                        for (var j = 0; j < projectVersions.length; j++) {
                            var isActive = "";
                            if ((getVersionStatus() == 0 && selectedForecasts[i].Versions[0].Label == projectVersions[j].Label) //--actual version
                            || (getVersionStatus() == 1 && j == 0))                                                             //--latest version
                                isActive = 'class="isActive"';
                            versionHtml += '<li {0}><span onclick="setVersionActive(this)">'.replace("{0}", isActive) + projectVersions[j].Label + '</span></li>';
                        }
                        $('#' + versionProjectId + '>ul').append(versionHtml);
                    }
                }
            }
        }

        function setVersionActive(version_span) {
            var $version_li = $(version_span).parent();
            if (!$version_li.hasClass("isActive")) {
                $version_li.siblings().removeClass("isActive");
                $version_li.addClass("isActive");
                setVersionStatus(0);
                runReportFromSelections();
            }
        }

        function getHtmlFromForecastHierarchy(projs, idPrefix) {
            var str = "";
            if (!idPrefix)
                idPrefix = "";
            if (projs && projs.length > 0) {
                //ul for projects
                str = '<ul id="main-menu" class="nav">';
                for (var i = 0; i < projs.length; i++) {
                    var projIndex = i;
                    var projectId = "'" + idPrefix + "project_" + projIndex + "'";
                    //li for each project
                    str += '<li class="tree-toggle" id={1}><a onclick="openUi({1})" href="#" title="{0}">{0}</a>'.replaceAll('{0}', projs[i].Name).replaceAll('{1}', projectId);
                    //ul for versions
                    str += '<ul style="" class="nav nav-second-level collapse  tree">';
                    var versions = projs[i].Versions;
                    if (versions && versions.length > 0) {
                        for (var j = 0; j < versions.length; j++) {
                            var versionIndex = projIndex + "_" + j;
                            var versionId = "'" + idPrefix + "version_" + versionIndex + "'";
                            //li for each version
                            str += '<li id={1} class="tree-toggle"><a class="diesmenuseconitem" onclick="openUi({1})" title="{0}">{0}</a>'.replaceAll('{0}', versions[j].Label).replaceAll('{1}', versionId);
                            //ul for scenario root and product root
                            str += '<ul style="" class="nav nav-third-level collapse tree">';

                            var products = versions[j].Products;
                            if (products && products.length > 0) {
                                var productsId = "'" + idPrefix + "product_root_" + versionIndex + "'";
                                //li for product root
                                str += '<li id={1} class="tree-toggle"><a class="diesmenuseconitem" onclick="openUi({1})" title="{0}">{0}</a>'.replaceAll('{0}', 'Products').replaceAll('{1}', productsId);
                                //ul for products
                                str += '<ul style="" class="nav nav-third-level collapse tree">';
                                for (var k = 0; k < products.length; k++) {
                                    var productIndex = versionIndex + "_" + k;
                                    var productId = "'" + idPrefix + "product_" + productIndex + "'";
                                    //li for each product
                                    str += '<li id={1} class="tree-toggle"><a class="diesmenuseconitem" onclick="openUi({1})" title="{0}">{0}</a>'.replaceAll('{0}', products[k].Name).replaceAll('{1}', productId);

                                    //ul for each scenario root and sku root
                                    str += '<ul style="" class="nav nav-third-level collapse tree">';

                                    var scenarios = versions[j].Scenarios;
                                    if (scenarios && scenarios.length > 0) {
                                        var scenariosId = "'" + idPrefix + "scenario_root_" + productIndex + "'";
                                        //li for scenario root
                                        str += '<li id={1} class="tree-toggle"><span><input type="checkbox" id="cboScenarioRoot" value="{0}" onchange="selectScenarioRoot(this)"/></span><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="diesmenuseconitem" onclick="openUi({1})" title="{0}">{0}</a></span>'.replaceAll('{0}', 'Scenarios').replaceAll('{1}', scenariosId);
                                        //ul for scenarios
                                        str += '<ul style="" class="nav nav-third-level collapse tree">';
                                        for (var s = 0; s < scenarios.length; s++) {
                                            var scenarioId = "'" + idPrefix + "scenario_product_" + productIndex + "_" + s + "'";
                                            var lineageScenario = projs[i].Name + '|' + versions[j].Label + '|' + products[k].Name + '|' + scenarios[s];
                                            var isChecked = "";
                                            if (reportSettings["'Scenarios'"] && $.inArray(lineageScenario, reportSettings["'Scenarios'"]) >= 0)
                                                isChecked = "checked";
                                            //li for each scenario --leaf
                                            str += '<li id={1} class="tree-toggle"><span><input type="checkbox" value="{0}" {2} onchange="selectScenario(this)"/></span><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="diesmenuseconitem" onclick="openUi({1})" title="{0}">{0}</a></span>'.replaceAll('{0}', scenarios[s]).replaceAll('{1}', scenarioId).replaceAll('{2}', isChecked);
                                        }
                                        //ul close and + sign for scenario root
                                        str += '</ul><span onclick="openUi({1})" class="fa arrow"></span>'.replaceAll('{1}', scenariosId);
                                    }

                                    var skus = products[k].SKUs;
                                    if (skus && skus.length > 0) {
                                        var skusId = "'" + idPrefix + "sku_root_" + productIndex + "'";
                                        //li for sku root
                                        str += '<li id={1} class="tree-toggle"><span><input type="checkbox" id="cboSkuRoot" value="{0}" onchange="selectSkuRoot(this)"/></span><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="diesmenuseconitem" onclick="openUi({1})" title="{0}">{0}</a></span>'.replaceAll('{0}', 'SKUs').replaceAll('{1}', skusId);
                                        //ul for skus
                                        str += '<ul style="" class="nav nav-third-level collapse tree">';
                                        for (var n = 0; n < skus.length; n++) {
                                            var skuId = "'" + idPrefix + "sku_product_" + productIndex + "_" + n + "'";
                                            //li for each SKU --leaf
                                            var lineageSku = projs[i].Name + '|' + versions[j].Label + '|' + products[k].Name + '|' + skus[n];
                                            var isChecked = "";
                                            if (reportSettings["'SKUs'"] && $.inArray(lineageSku, reportSettings["'SKUs'"]) >= 0)
                                                isChecked = "checked";
                                            str += '<li id={1} class="tree-toggle"><span><input type="checkbox" value="{0}" {2} onchange="selectSku(this)"/></span><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="diesmenuseconitem" onclick="openUi({1})" title="{0}">{0}</a></span>'.replaceAll('{0}', skus[n]).replaceAll('{1}', skuId).replaceAll('{2}', isChecked);
                                        }
                                        //ul close and + sign for sku root
                                        str += '</ul><span onclick="openUi({1})" class="fa arrow"></span>'.replaceAll('{1}', skusId);
                                    }
                                    var segments = products[k].Segments;
                                    if (segments && segments.length > 0) {
                                        var segmentsId = "'" + idPrefix + "segment_root_" + productIndex + "'";
                                        //li for segment root
                                        str += '<li id={1} class="tree-toggle"><span><input type="checkbox" id="cboSegmentRoot" value="{0}" onchange="selectSegmentRoot(this)"/></span><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="diesmenuseconitem" onclick="openUi({1})" title="{0}">{0}</a></span>'.replaceAll('{0}', 'Segments').replaceAll('{1}', segmentsId);
                                        //ul for segments
                                        str += '<ul style="" class="nav nav-third-level collapse tree">';
                                        for (var n = 0; n < segments.length; n++) {
                                            var segmentId = "'" + idPrefix + "segment_product_" + productIndex + "_" + n + "'";
                                            //li for each segment --leaf
                                            var lineageSegment = projs[i].Name + '|' + versions[j].Label + '|' + products[k].Name + '|' + segments[n];
                                            var isChecked = "";
                                            if (reportSettings["'SKUs'"] && $.inArray(lineageSegment, reportSettings["'SKUs'"]) >= 0)
                                                isChecked = "checked";
                                            str += '<li id={1} class="tree-toggle"><span><input type="checkbox" id="" value="{0}" {2} onchange="selectSku(this)"/></span><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="diesmenuseconitem" onclick="openUi({1})" title="{0}">{0}</a></span>'.replaceAll('{0}', segments[n]).replaceAll('{1}', segmentId).replaceAll('{2}', isChecked);
                                        }
                                        //ul close and + sign for segment root
                                        str += '</ul><span onclick="openUi({1})" class="fa arrow"></span>'.replaceAll('{1}', segmentsId);
                                    }
                                    //ul close and + sign for each product
                                    str += '</ul><span onclick="openUi({1})" class="fa arrow"></span>'.replaceAll('{1}', productId);
                                }
                                //ul close and + sign for product root
                                str += '</ul><span onclick="openUi({1})" class="fa arrow"></span>'.replaceAll('{1}', productsId);
                            }









                            //ul close and + sign for each version
                            str += '</ul><span onclick="openUi({1})" class="fa arrow"></span>'.replaceAll('{1}', versionId);
                        }
                    }
                    //ul close and + sign for each version
                    str += '</ul><span onclick="openUi({1})" class="fa arrow"></span>'.replaceAll('{1}', projectId);
                }
                str += '</ul>';
            }

            return str;
        }

        function setVisualization(option) {
            reportSettings.Visualization = option;
            //runReportWithMultipleParams(reportSettings);
            runReportFromSelections();
        }

        function onFrequencyDrop() {
            var str = '<form>';
            str += '<input type="radio" checked name="frequency" onclick="selectFrequency()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Monthly<br>';
            str += '<input type="radio" name="frequency" onclick="selectFrequency()"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quarterly<br>';
            str += '<input type="radio" name="frequency" onclick="selectFrequency()"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Yearly';
            str += '</form>';
            document.getElementById('insertinputsvisual').innerHTML = str;
        }

        function onCountryDrop() {
            var str = '<form>';
            if (model.countrys && model.countrys.length > 0) {
                for (var i = 0; i < model.countrys.length; i++) {
                    str += '<input type="checkbox" name="country" value="{0}" onclick="selectCountry()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{0}<br>'.replaceAll("{0}", model.countrys[i]);
                }
            }
            str += '</form>';
            document.getElementById('insertinputsvisual').innerHTML = str;
        }

        function selectFrequency() {
            var radioButtons = $("input:radio[name='frequency']");
            for (var i = 0; i < radioButtons.length; i++) {
                if (radioButtons[i].checked)
                    reportSettings.Frequency = i;
            }
        }

        function selectCountry() {
            var cbos = $("input:checkbox[name='country']");
            reportSettings.Country = "";
            for (var i = 0; i < cbos.length; i++) {
                if (cbos[i].checked) {
                    if (reportSettings.Country.length > 0)
                        reportSettings.Country += '|';
                    reportSettings.Country += $(cbos[i]).val();
                }
            }
        }

        function loadReportValueParams() {
            var parameters = model.parameterList;
            var countrys = model.countrys;
            if (parameters && parameters.length > 0) {                
                var str = '';
                for (var i = 0; i < parameters.length; i++) {
                    str += '<li class="fieldListProperty flex  property" id="liid' + i + '" >';
                    str += '<div class="propertyText propertyContent item-fill editableLabel">';
                    str += '<div class="textLabel" title="">';                        
                    str += '<i class="fa fa-random" aria-hidden="true"></i><span class="textLabelspan " title="{1}" alt="{1}">{1}</span>'.replaceAll("{1}", parameters[i]);
                    str += '</div>';
                    str += '</div>';
                    str += '</li>';
                }
                str += '<li class="lastLineBorder"></li>';
                var htmlStr = $('#dataList>ul').html();
                $('#dataList>ul').html(htmlStr + str);

                $('.textLabelspan').click(function(){
                    var url = document.getElementsByTagName('iframe')[0].src;
                    var parameterSplit = url.split('&select=Parameter,');
                    if(parameterSplit.length == 1)
                        url = url + '&select=Parameter,' + $(this).text();
                    else{
                        url
                    }
                });
            }
        }

        function openUi(prjId) {
            if ($('#' + prjId + ' ul').hasClass('tree')) {
                $('#' + prjId).toggleClass('minimize');
                $('#' + prjId + ' .tree').first().toggleClass('in');
                $('#' + prjId + ' .arrow').last().toggleClass('ArrowSelected');
                //if ($('#' + prjId + ' span').hasClass('maximize'))
                //{
                //    if ($('.arrow').css('margin-top') != '-10px') {
                //        $('.arrow').css('margin-top', '-10px');
                //    }
                //    else
                //    {
                //        $('.arrow').css('margin-top', '');
                //    }
                //}
               
               
            }
        }    

        function toggle() {
            var e = window.event;
            e.stopPropagation();
            e.preventDefault();
            $('.visualizationPane .toggleBtn').toggleClass("isCollapsed", 800);
            $('.visualizationPane').toggleClass("isCollapsed", 800);

        }

        function toggleTaskPane() {
            var e = window.event;
            e.stopPropagation();
            e.preventDefault();
            $('.taskPane .toggleBtn').toggleClass("isCollapsed", 800);
            $('.taskPane').toggleClass("isCollapsed", 800);
            return false;
        }

    $('#save').click(function () {    
            if (validateReportConfigurations()) {
        $('#ReportNameModal').modal('show');
            }
    });

        
    function serializeReportSettings(param) {
        var parameters = [];
        if (!param) //for save
            parameters = getSelectedParams();
        else //for run
        {
            parameters.push(param);
            //reportSettings.VersionFlag = getVersionStatus();
        }
        //set default visualization to line chart = 2
        if (reportSettings.Visualization == undefined || reportSettings.Visualization == null) {
            reportSettings.Visualization = 2;
        }
        return { Axes: getDistinctReportSettings(), Parameters: parameters, Countrys: reportSettings.Country, Frequency: reportSettings.Frequency, MinStartDate: reportSettings.startDate, MaxEndDate: reportSettings.endDate, ChartType: reportSettings.Visualization, NumberFormat: reportSettings.NumberFormat, DecimalPrecision: reportSettings.DecimalPrecision, CurrencySymbol: reportSettings.CurrencySymbol, TableData: reportSettings.TableData, ColorTheme: reportSettings.ColorTheme, AxisFontSize: reportSettings.AxisFontSize, AxisFontColor: reportSettings.AxisFontColor, ChartBgColor: reportSettings.ChartBgColor, ChartBorderColor: reportSettings.ChartBorderColor, ChartBorderWidth: reportSettings.ChartBorderWidth, Shadow: reportSettings.Shadow, ShowLegend: reportSettings.ShowLegend, VersionFlag: reportSettings.VersionFlag, ConsolidatorFlag: reportSettings.ConsolidatorFlag, HistoricalData:reportSettings.HistoricalData};
    }

    function updateSettingWithParam(setting, param) {
        var parameters = [];
        parameters.push(param);
        setting.Parameters = parameters;
        return setting;
    }

 //function saveReport() {
 //var reportName = $('#myPopupInput').val();
 //if (reportName != '') {
 //    var serializedSettings = serializeReportSettings();
 //    var jsonSetting = JSON.stringify({ ReportName: reportName, ReportSettings: serializedSettings, Type: type });
   

 //    PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("/Reporting/SaveReport", jsonSetting,
 //       function (result) {
 //           if (result.success) {
 //               addReport(result.reportId, reportName, serializedSettings);
 //               PHARMAACE.FORECASTAPP.UTILITY.popalert("Report saved successfully..", '');
 //           }
 //           else {
 //               PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not save report. Try again.", '');
 //           }
 //       },
 //       function (result) {
 //           PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not save report. Try again.", '');
 //       });
 //}

        //}

    function saveReport(overwrite) {
        var reportName = $('#myPopupInput').val();
        if (reportName != '') {
            var serializedSettings = serializeReportSettings();
            var jsonSetting = JSON.stringify({ ReportName: reportName, ReportSettings: serializedSettings, Type: type, Overwrite: overwrite });


            PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("/Reporting/SaveReport", jsonSetting,
               function (result) {
                   if (result.success) {
                       if (saveReportStatus(result.reportId))
                           if (!saveAs)
                               addReport(result.reportId, reportName, serializedSettings);
                           else
                               saveAs = false;
                      // PHARMAACE.FORECASTAPP.UTILITY.popalert("Report saved successfully..", '');
                   }
                   else {
                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not save report. Try again.", '');
                   }
               },
               function (result) {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not save report. Try again.", '');
               });
        }

    }
    function saveReportStatus(reportId) {
        var overwrite =false;
        if (reportId == 0)
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not save report. Try again.", '');
        else if (reportId > 0) {
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Report saved successfully..", '');
            return true;
        }
        else if (reportId < 0) {
            //PHARMAACE.FORECASTAPP.UTILITY.popalert("Report name already exist..", '');
            bootbox.dialog({
                message: "Report name already exist. Do you want to overwrite it ?",
                title: "",
                closeButton: true,
                size: 'large',
                className: "custom-dialogue",
                buttons: {
                    success: {
                        label: "Yes",
                        className: "btn-diabox",
                        callback: function (result) {
                            if (result) {
                                overwrite = true;
                                saveAs = true;
                                saveReport(overwrite);
                               
                            }
                        }
                    },
                    danger: {
                        label: "No",
                        className: "btn-default",
                        callback: function () {
                           // alert('hello');
                        }
                    },
                }
            });
        }

        return false;
    }


 function isDashboard() {
     if (($parent_box).parent().hasClass('dashboardlistitem'))
         return true;
     return false;
 }

 function isReport() {
     if (($parent_box).parent().find('.navigationItemList'))
         return true;
     return false;
 }


 function shareDashboardReportWithUsers() {
     var selectedId = ($parent_box).attr("value");
     var selectedReportName = $('.navigationItemList[value=' + selectedId + ']').text();
     var selectedDashboardName = $('.dashboardlistitem[value=' + selectedId + ']').text();

     var userArray = [];
     $('input:checkbox[class="shareUser"]:checked').each(function () {
         userArray.push(parseInt($.trim($(this).parent().siblings(0)[2].innerText)));
     });
     if (isDashboard())
         shareDashboardWithUsers(selectedId, userArray, selectedDashboardName);
     if (!isDashboard()) {
     if (isReport())
         shareReportWithUsers(selectedId, userArray, selectedReportName);
     }
 }

 function shareReportWithUsers(reportId, userArray, selectedReportName) {
     type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
     PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Reporting/SaveSharedReportDetails", { ReportName: selectedReportName, ReportId: reportId, SharedWithIDs: userArray.join(","), type:type },
           function (result) {
               if (result.success) {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Report shared successfully..", '');
               }
               else {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not share report. Try again.", '');
               }
           },
           function (result) {
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not share report. Try again.", '');
           });
 }
 function shareDashboardWithUsers(dashboardId, userArray, selectedDashboardName) {

     PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Reporting/SaveSharedDashboard", { DashboardName: selectedDashboardName, DashboardId: dashboardId, SharedWithIDs: userArray.join(","), type: type },
           function (result) {
               if (result.success) {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Dashboard shared successfully..", '');
               }
               else {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not share dashboard.", '');
               }
           },
           function (result) {
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not share dashboard.", '');
           });
 }
 

 function getReportInfo(reportInfoList) {
        //var jsonSetting = {};
        //PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("Reporting/GetReportInformation", {type:type},
        //  function (result) {
        //      if (result.success) {
                  //jsonSetting = result.ReportInfoList;
                  PopulateReports(reportInfoList);
          //    }
          //    else {
          //        PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not found report.", '');
          //    }
          //},
          //function (result) {
          //    PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not found report.", '');
          //});

    }

     function populateSharePopup(users) {

        var tableRef = document.getElementById('shared_users_table').getElementsByTagName('tbody')[0];
        var str = '';
        users.forEach(function (user) {
            str += '<tr data-index="0" class="">';
            str += '<td style=""><input data-index="1" class="shareUser" name="btSelectItem" type="checkbox"></td>';
            str += '<td class="bs-checkbox"> {0} {1} </td>'.replace("{0}", user.FirstName).replace("{1}", user.LastName);
            str += '<td id="shareuseremail" style = ""> ' + user.Email + '</td>';
            str += '<td style = "display:none"> ' + user.UserId + '</td>';

        })

        tableRef.innerHTML = str;
     }

     //Vinod 9july 
     function loadDashboardList(dashboardList, control) {
         //PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("Reporting/GetDashboardList", { type: type },
         //   function (result) {
         //       if (result.success) {
         PopulateDashboard(dashboardList, control);
                    $('.dashboardList>li').click(function () {
                        renderDashboard($(this).val());

                    });
          //      }
          //      else {
          //          PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not found report.", '');
          //      }
          //  },
          //function (result) {
          //    PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not found report.", '');
          //});
           
     }

     function addReport(reportId, reportName, setting) {
         //var reportHtml = '<li class="navigationItemList" value="' + reportId + '"><span >' + reportName + '</span></li><span class="dashbox" value="' + reportId + '"><span class="dashtext" >...</span></span>';
         var arrProjects = [];
         for (var i = 0; i < setting.Axes.length; i++) {
             var project = setting.Axes[i].split('|')[0];
             if ($.inArray(project, arrProjects) == -1)
                 arrProjects.push(project);
         }
         for (var i = 0; i < arrProjects.length; i++) {
             var reportProjectId = "report_project_" + arrProjects[i].replace(' ', '_');
             if ($('#' + reportProjectId).length == 0) {
                 var reportProjectHtml = '<li class="tree-toggle" style="width:85%;" id="{0}">'.replace("{0}", reportProjectId);
                 reportProjectHtml += '<a onclick="openUi({0})" href="#" class="alink">{1}<span class="fa arrow maximize"></span> </a>'.replace("{0}", "'" + reportProjectId + "'").replace("{1}", arrProjects[i]);
                 reportProjectHtml += '<ul class="nav nav-second-level collapse tree " style="margin-right:8px;">';
                 reportProjectHtml += '</ul></li>';
                 $(".navigationItemList.reportList").append(reportProjectHtml);
             }
             var reportHtml = '<li class="navigationItemList" style="margin:0px; "value="' + reportId + '">';
             reportHtml += '<span style="margin-left:15px;">' + reportName + '</span></li>';
             reportHtml += '<span class="dashbox" style="" value="' + reportId + '"><span class="dashtextforchart" >...</span></span>';
             $('#' + reportProjectId + '>ul').append(reportHtml);
             reportListSettings[reportId] = { name: reportName, setting: setting };
             //bind click event with each report
             //$(".navigationItemList.reportList>li").last().unbind("click").click(function () {
             $(".navigationItemList.reportList li.navigationItemList").last().unbind("click").click(function () {
                 setVersionStatus(1);
                 clearSelections();
                 switchToResetMode();
                 runExistingReport($(this).val());
             });
         }
     }

     function updateTrees() {
         if (reportSettings["'Scenarios'"]) {
             for (var i = 0; i < reportSettings["'Scenarios'"].length; i++) {
                 var scenarioLine = reportSettings["'Scenarios'"][i];
                 var scenarioLineComponents = scenarioLine.split('|');
                 var projectElement = $('ul#main-menu a[title="{0}"][class != "diesmenuseconitem"]'.replace("{0}", scenarioLineComponents[0]));
                 var versionElement = projectElement.parent().find('a[title="{0}"]'.replace("{0}", scenarioLineComponents[1]));
                 var productElement = versionElement.parent().find('a[title="{0}"]'.replace("{0}", scenarioLineComponents[2]));
                 var scenarioElement = productElement.parent().find('input[value="{0}"]'.replace("{0}", scenarioLineComponents[3]));
                 //scenarioElement.click();
                 scenarioElement.prop('checked', true);
                 selectScenario(scenarioElement[0]);
             }
         }
         if (reportSettings["'SKUs'"]) { //sku or segment
             for (var i = 0; i < reportSettings["'SKUs'"].length; i++) {
                 var skuLine = reportSettings["'SKUs'"][i];
                 var skuLineComponents = skuLine.split('|');
                 var projectElement = $('ul#main-menu a[title="{0}"][class != "diesmenuseconitem"]'.replace("{0}", skuLineComponents[0]));
                 var versionElement = projectElement.parent().find('a[title="{0}"]'.replace("{0}", skuLineComponents[1]));
                 var productElement = versionElement.parent().find('a[title="{0}"]'.replace("{0}", skuLineComponents[2]));
                 var skuElement = productElement.parent().find('input[value="{0}"]'.replace("{0}", skuLineComponents[3]));
                 //skuElement.click();
                 skuElement.prop('checked', true);
                 selectSku(skuElement[0]);
             }
         }

         //set the project-version tree for dynamically viewing charts for different versions
         setHtmlTillVersionHierarchy();
     }

     function runExistingReport(reportId) {
         $('#insertinputs span').html('');
         $('#linechart img').addClass('selected');
        
         reportSettings = reportListSettings[reportId].setting;         
         if (reportSettings) {
             deserializeReportSettings();
             runReportFromSelections();
             //runReportWithMultipleParams(reportSettings);
         }
     }

     function setVersionStatus(status) {
         //$('#toggle-event').bootstrapToggle(status == 1 ? 'on' : 'off');
         isVersionStatusToggledByUser = false;
         $($(status == 1 ? '#latest-version' : '#actual-version').next()).click();
     }

     function getVersionStatus() {
         //setVersionStatus has been called already, hence get the opposite value
         //return $('#toggle-event').prop('checked') ? 0 : 1;
         return $('#latest-version').prop('checked') ? 1 : 0;
     }

     function setConsolidationLevel(){
         if($('#ProdConso').prop('checked') == true)
             reportSettings.ConsolidatorFlag = 1;
         else if($('#prodLevel').prop('checked') == true)
             reportSettings.ConsolidatorFlag = 2;
         else //if($('#skuLevel').prop('checked') == true)
             reportSettings.ConsolidatorFlag = 0;
     }

     //function setHistoricalData() {
     //    if ($('#IncludeHistorical').prop('checked') == true)
     //        reportSettings.HistoricalData = 1;
     //}

     function switchoffConsolidator() {
         if ($('#ProdConso').prop('checked') == true)
             $($('#ProdConso').next()).click();
     }

     function switchonConsolidator() {
         if ($('#ProdConso').prop('checked') == false)
             $($('#ProdConso').next()).click();
         //$('#skuLevel').prop('checked', true); //default
         $('#skuLevel').click();
     }

     function getConsolidationLevel() {
         if (reportSettings.ConsolidatorFlag == 1)
             switchonConsolidator();
         else {
             switchoffConsolidator();
             if (reportSettings.ConsolidatorFlag == 2) {
                 //$('#prodLevel').prop('checked', true);
                 $('#prodLevel').click();
             }
             else {
                 //$('#prodLevel').prop('checked', false);
                 $('#skuLevel').click();
             }
         }
     }

     function switchToResetMode() {
         $(this).removeClass('fa-play-circle-o');
         $(this).addClass('fa-refresh');
         $(this).attr("title", "Refresh");
         $('#resetReport').css("display", "block");
     }
     function switchToRunMode() {
         $('#reportIcon .fa').removeClass('fa-refresh');
         $('#reportIcon .fa').addClass('fa-play-circle-o');
         $('#reportIcon .fa-play-circle-o').attr("title", "Generate Report");
         $('#resetReport').css("display", "none");

         clearSelections();
     }

     function clearSelections() {
         setReportSettingsToDefault();
         $('#insertinputs').html("");
         $('#main-menu input[type=checkbox]:checked').click();//.attr('checked', false);
         $('input#datepicker-start').val('');
         $('input#datepicker-end').val('');
     }

     function runReportWithMultipleParams(reportSettingsWithMultipleParams) {
         //first, clear the container
         $('div#report_container.exploration').html("");
         //PHARMAACE.FORECASTAPP.UTILITY.showOverlay($('div#report_container.exploration'), "Getting your report...");
       //  PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your report...", 'report_container', "15", "");
         var params;
         if (reportSettingsWithMultipleParams.Parameters && reportSettingsWithMultipleParams.Parameters.length > 0)
             params = reportSettingsWithMultipleParams.Parameters;
         else
             params = getSelectedParams();
         if (params.length > 0) {
             for (var i = 0; i < params.length; i++) {      //Append multiple div  in report_container 
                     //var reportContainer = $('div#report_container.exploration');
                     //var innerDiv = document.createElement('div');
                     //innerDiv.id = 'report_container_' + i;
                     //innerDiv.className = 'reportdynamidiv';
                     //report_container.appendChild(innerDiv);
                     //PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your report...", 'report_container_' + i, "15", "");
                 }

             for (var i = 0; i < params.length; i++) {
                 runReport(updateSettingWithParam(reportSettingsWithMultipleParams, params[i]),i);
             }
         }
     }

     function PopulateReports(reportList) {
         if (reportList != '') {
             for (var i = 0; i < reportList.length; i++) {
                 addReport(reportList[i].ReportId, reportList[i].ReportName, reportList[i].ReportSettings);
             }             
         }
     }

     function PopulateDashboard(dashboardList, Control) {
         if (dashboardList != null) {
             if (Control == 'dashboardLeftPannel') {
                 for (var i = 0; i < dashboardList.length; i++) {
                     addDashboard(dashboardList[i].Id, dashboardList[i].Name);
                 }
             }
             if (Control == 'ReporPinModel') {
                 for (var i = 0; i < dashboardList.length; i++) {
                     $("#existingDashRadio select").append('<option value="' + dashboardList[i].Id + '">' + dashboardList[i].Name + '</option>');
                 }

             }

         }
     }

     function txtDashboardNameKeyPress(e) {
         if (e.keyCode === 13) {
             var dashboardName = $('#txtDashboardName').val();
             //createDashboard(dashboardName);
             pinReportToDashboard(dashboardName);
         }

         return false;
     }

     //Vinod 9jully
    
    //vinod-7/11/16 pinReportToDashboard start

     function pinReportToDashboard(emptyDashName,dashName,overWriteDash) {
         var dashboardName = '';
         if (overWriteDash) {
             overWriteDash = overWriteDash;
         }
         else
             var overWriteDash = false;
         if (emptyDashName) {
             dashboardName = emptyDashName;
         }
         if ($('input.existingDashRadio:checked').length > 0) {
             newDashboard = false;
             dashboardName = $('select.ng-pristine')[0].selectedOptions[0].text;
         }
         if ($('input.newDashRadio:checked').length > 0) {
             newDashboard = true;
             //Creating New Dashboard here
             dashboardName = $("input.pinTileText.inputDashboardTitle").val();
             //createDashboard(dashboardName);
         }
         
         type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
         PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Reporting/CreateDashboard", { DashboardName: dashboardName, ReportIds: currentReportId, type: type, NewDashboard: newDashboard, OverWriteDash:overWriteDash },
            function (result) {
                if (result.success) {
                    if (result.dashbordId ==1) {
                        addDashboard(result.dashbordId, dashboardName);
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Dashbord created and report pinned to dashboard successfully ..", '');
                        //bind click event with each report
                        $(".dashboardList>li").last().unbind("click").click(function () {
                            renderDashboard($(this).val());
                        });
                    }
                    else if (result.dashbordId == -1) {
                        //PHARMAACE.FORECASTAPP.UTILITY.popalert("Dashbord already exist.", '');
                        if (saveAsDash == false) {
                            overWriteDashboard(dashboardName);
                        }
                        else
                            saveAsDash = true;

                    }
                    else if (result.dashbordId == 0) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not create dashboard. Try again..", '');
                    }
                    else if (result.dashbordId == 2) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Report pinned to Dashboard successfully.", '')
                    }
                    else if (result.dashbordId == 3) {
                        addDashboard(result.dashbordId, dashboardName);
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Dashbord created successfully ..", '')
                    }
                    else if (result.dashbordId == 4) {
           
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Dashbord overWritten successfully ..", '')
                    }
                }
                else
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Can't pin report to dashboard. Try again. " + result.errors.join(), '');
            },
            function (result) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Can't pin report to dashboard. Try again. ");
            });
     }

     function overWriteDashboard(dashboardName) {
         bootbox.dialog({
             message: "Dashboard name already exist. Do you want to overwrite it ?",
             title: "",
             closeButton: true,
             size: 'large',
             className: "custom-dialogue",
             buttons: {
                 success: {
                     label: "Yes",
                     className: "btn-diabox",
                     callback: function (result) {
                         if (result) {

                             saveAsDash = true;
                             pinReportToDashboard(undefined, dashboardName, true);

                         }
                     }
                 },
                 danger: {
                     label: "No",
                     className: "btn-default",
                     callback: function () {
                         // alert('hello');
                     }
                 },
             }
         });
     }

     function renderDashboard(dashboardId) {
         setVersionStatus(1);
         clearSelections();
         switchToResetMode();
        // PHARMAACE.FORECASTAPP.UTILITY.showOverlay($('div#report_container.exploration'), "Getting your dashboard...");
        // PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your dashboard...", 'page-content-wrapper', "15", "");
         PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Reporting/GetReportsDetailsByDashboardId", { dashboardId: dashboardId },
           function (result) {
               if (result.success) {
                   if (result.reportSettingsList && result.reportSettingsList.length>=1) {
                       for (var i = 0; i < result.reportSettingsList.length; i++) {
                           var reportSettings = result.reportSettingsList[i];
                           runReportWithMultipleParams(reportSettings.ReportSettings);
                       }
                   }
                   else {
                       PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('page-content-wrapper');
                       PHARMAACE.FORECASTAPP.UTILITY.popalert("There is no report added to this dashboard", '');
                   }
               }
               else {
                   PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('page-content-wrapper');
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not open dashboard", '');                   
               }
           },
           function (result) {
               PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('page-content-wrapper');
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not open dashboard.", '');
           });
     }

     function addDashboard(dashbordId, dashboardName) {
         $(".dashboardList").append('<li value="' + dashbordId + '" class="dashboardlistitem">' + dashboardName + '</li><span class="dashbox" value="' + dashbordId + '" ><span class="dashtext">...</span></span>');
     }

     function removeReport(reportId) {
         PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Reporting/RemoveReport", { ReportId: reportId },
           function (result) {
               if (result.success) {
                   if (result.removeResult == 2)
                   {
                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Report does not exist.", '');
                       if ($parent_box.parent().find('li.navigationItemList').length == 1) {
                           $parent_box.parent().parent().remove();

                       }
                       $('li.navigationItemList[value="' + reportId + '"]').remove();
                       $('span.dashbox[value="' + reportId + '"]').remove();
                       
                   }
                   else if (result.removeResult == 1) {                       
                       var reportRoots = $('li.navigationItemList[value="' + reportId + '"]').parent();
                       if (reportRoots) {
                           for (var i = 0; i < reportRoots.length; i++) {
                               if ($(reportRoots[i]).find('li.navigationItemList').length == 1)
                                   $(reportRoots[i]).find('li.navigationItemList[value="' + reportId + '"]').parent().parent().remove();
                           }
                       }
                       $('li.navigationItemList[value="' + reportId + '"]').remove();
                       $('span.dashbox[value="' + reportId + '"]').remove();

                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Report removed.", '');
                   }
                   else
                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not remove report.", '');
               }
               else {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not remove report.", '');
               }
           },
           function (result) {
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not remove report.", '');
           });
     }

     function removeDashboard(dashboardId) {

         PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Reporting/RemoveDashboard", { DashboardId: dashboardId },
           function (result) {
               if (result.success) {
                   if (result.removeResult == 1) {
                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Dashboard removed.", '');
                       $('li.dashboardlistitem[value="' + dashboardId + '"]').remove();
                       $('span.dashbox[value="' + dashboardId + '"]').remove();
                   }
                   else
                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not remove dashboard.", '');
               }
               else {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not remove dashboard.", '');
               }
           },
           function (result) {
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not remove dashboard.", '');
           });
     }
     //function GetNotifications() {
     //    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/GetUserNotification", null,
     //        function (result) {
     //            if (result.success) {
     //                PHARMAACE.FORECASTAPP.UTILITY.populateNotificationList(result.notifications)
     //            }
     //        });
     //}
    </script>
<script src="../../Scripts/lib/jquery/icheck.min.js"></script>
<%--<script src="../../Scripts/custom/tablue-2.1.2.js"></script>--%>
