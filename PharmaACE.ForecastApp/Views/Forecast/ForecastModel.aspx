<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.ForecastEntity>" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<%: Styles.Render("~/Content/forecastModelCSS") %>
<%--<link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet" />--%>
<%--<%: Styles.Render("~/Content/fontawesomeCSS", "~/Content/bootstrapCSS") %>--%>
 <%: Scripts.Render("~/Scripts/forecastModelScript") %>
<%--<script src="../../Scripts/lib/jquery/jquery.nestable.js"></script>--%>
<%--<script src="../../Scripts/lib/jquery/jquery-ui.js"></script>--%>
<%--<script src="../../Scripts/lib/bootstrap/bootstrap-select.min.js"></script>
<script  type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.SharePopup.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Constants.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
<script src="../../Scripts/lib/jquery/list.min.js"></script>--%>
<%--<link href="../../Content/CSS/aero.css" rel="stylesheet" />--%>



<style type="text/css">
    .blink{
        color:#6A5ACD;
    }
    #selectForecast .tooltip .tooltip-inner{ text-align:left ;}
    #selectForecast {min-width:204px; min-height:120px !important; height:auto !important; max-height:743px !important; }
    #page-content-wrapper{display:list-item;}
    #divNotes.isForecastFullVisualisation{ width:1141px !important; padding:4px 3px 0px 3px;}
   .expandSpan { margin-left:16px; color:#c8c8c8;
    }
   .ui-autocomplete{z-index:9999; max-width:320px !important; width:320px !important; }
   .ui-autocomplete li{width:100% !important;}
    .nav-md #divNotes.isFullVisualisation {
        width: 960px !important;
        padding:4px 3px 0px 3px
    }
        #divNotes.hideprodfeed.isForecastFullVisualisation{width:1291px !important;}
        #divNotes.hideprodfeed.isForecastFullVisualisation .maxheight, #divNotes.isForecastFullVisualisation .maxheight, #divNotes.isFullVisualisation .maxheight{padding:3px 8px}
        #divNotes.hideprodfeed.isForecastFullVisualisation .editable-div, #divNotes.isForecastFullVisualisation .editable-div, #divNotes.isFullVisualisation .editable-div{width:100%;}
        
    #divNotes.hideprodfeed.isFullVisualisation{width:1110px !important;}

  #page-content-wrapper.isForecastFullVisualisation,#page-content-wrapper.isFullVisualisation{display:none;}
  .expandSpan:hover{cursor:pointer;}
     .referenceSlider {
    position:relative;
        background-color: #000;
    height:6px !important;
    width:100% !important;
}
                .referenceSlider:hover{ cursor:pointer;}
                    .referenceSlider.isCollapsed {
                        top:0px;
                        z-index:1
                    }
.referenceSlider:after {
    content:'';
    position: absolute;
    top: 70%;
    left: 50%;
    margin-left: -20px;
    width: 0;
    height: 0;
    border-top: solid 10px #000;
    border-left: solid 10px transparent;
    border-right: solid 10px transparent;
    border-bottom:0px;
    z-index:1;
   
}
.referenceSlider.isCollapsed:after {content:'';
    position: absolute;
    top: -100%;
    left: 50%;
    margin-left: -20px;
    width: 0;
    height: 0;
     border-bottom: solid 10px #000;
    border-left: solid 10px transparent;
    border-right: solid 10px transparent;
    border-top:0px;
}
    .description{padding:0px; margin:0px; font-size:13px; line-height:1.2em;  top:0px; font-style:italic; opacity:0.3;}
    #droppable {
       
        border: 1px dashed rgb(204, 204, 204);
        width: 100%;
        position: relative;
        min-height: 60px;
        padding:0px 4px;
        padding-top:2px;
    }
    #droppable.isCollapsed{display:none;}
    #droppable li a{ /*cursor:not-allowed;  pointer-events: none;*/opacity:0.6;}
    #droppable li .dd-handle a{cursor:not-allowed !important;  pointer-events: none !important;}
    .ui-draggable-dragging{display:none !important;}
    .sidebar-nav-left li a{font-size:13px;}
.activatedAssum{}
    .dd-handle a, .no-dd-handle a {
        padding-left: 5px;
    }
    
.cf:after { visibility: hidden; display: block; font-size: 0; content: " "; clear: both; height: 0; }
* html .cf { zoom: 1; }
*:first-child+html .cf { zoom: 1; }

a:hover { text-decoration: none; }

.small { color: #666; font-size: 0.875em; }
.large { font-size: 1.25em; }

/**
 * Nestable
 */

.dd { position: relative; display: block; margin: 0; padding: 0; max-width: 600px; list-style: none; font-size: 13px; line-height: 20px; }

.dd-list { display: block; position: relative; margin: 0; padding: 0; list-style: none; }
.dd-list .dd-list { padding-left: 15px; }
.dd-collapsed .dd-list { display: none; }

.dd-item,.no-dd-item
.dd-empty,
.dd-placeholder { display: block; position: relative; margin: 0; padding: 0; min-height: 20px; font-size: 13px; line-height: 20px; }

.dd-handle, .no-dd-handle { display: block; height: 30px; margin: 5px 0;  color: #333; text-decoration: none; font-weight: bold; border: 1px solid #ccc;
    background: #fafafa;
    background: -webkit-linear-gradient(top, #fafafa 0%, #eee 100%);
    background:    -moz-linear-gradient(top, #fafafa 0%, #eee 100%);
    background:         linear-gradient(top, #fafafa 0%, #eee 100%);
    -webkit-border-radius: 3px;
            border-radius: 3px;
    box-sizing: border-box; -moz-box-sizing: border-box;
}
.dd-handle:hover, .no-dd-handle:hover { color: #2ea8e5; background: #fff; }

.dd-item > button, .no-dd-item > button { display: block; position: relative; cursor: pointer; float: left; width: 14px; height: 20px; margin: 5px 0; padding: 0; text-indent: 100%; white-space: nowrap; overflow: hidden; border: 0; background: transparent; font-size: 12px; line-height: 1; text-align: center; font-weight: bold; }
.dd-item > button:before, .no-dd-item > button:before { content: '+'; display: block; position: absolute; width: 100%; text-align: center; text-indent: 0; }
.dd-item > button[data-action="collapse"]:before, .no-dd-item > button[data-action="collapse"]:before { content: '-'; }

.dd-placeholder,
.dd-empty { margin: 5px 0; padding: 0; min-height: 30px; background: #f2fbff; border: 1px dashed #b6bcbf; box-sizing: border-box; -moz-box-sizing: border-box; }
.dd-empty { border: 1px dashed #bbb; min-height: 100px; background-color: #e5e5e5;
    background-image: -webkit-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff),
                      -webkit-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff);
    background-image:    -moz-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff),
                         -moz-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff);
    background-image:         linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff),
                              linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff);
    background-size: 60px 60px;
    background-position: 0 0, 30px 30px;
}

.dd-dragel { position: absolute; pointer-events: none; z-index: 9999; }
.dd-dragel > .dd-item .dd-handle, .dd-dragel > .dd-item .no-dd-handle { margin-top: 0; }
.dd-dragel .dd-handle, dd-dragel .no-dd-handle {
    -webkit-box-shadow: 2px 4px 6px 0 rgba(0,0,0,.1);
            box-shadow: 2px 4px 6px 0 rgba(0,0,0,.1);
}

/**
 * Nestable Extras
 */

.nestable-lists { display: block; clear: both;  width: 100%; border: 0;  }

#nestable-menu { padding: 0; margin: 20px 0; }

#nestable-output,
#nestable2-output { width: 100%; height: 7em; font-size: 0.75em; line-height: 1.333333em; font-family: Consolas, monospace; padding: 5px; box-sizing: border-box; -moz-box-sizing: border-box; }



@media only screen and (min-width: 700px) {

    .dd { float: left; width: 94%; margin:0% 3%; }
    .dd + .dd { margin-left: 2%; }

}

.dd-hover > .dd-handle, .dd-hover > .no-dd-handle { background: #2ea8e5 !important; }

/**
 * Nestable Draggable Handles
 */

.dd3-content { display: block; height: 30px; margin: 5px 0; padding: 5px 10px 5px 40px; color: #333; text-decoration: none; font-weight: bold; border: 1px solid #ccc;
    background: #fafafa;
    background: -webkit-linear-gradient(top, #fafafa 0%, #eee 100%);
    background:    -moz-linear-gradient(top, #fafafa 0%, #eee 100%);
    background:         linear-gradient(top, #fafafa 0%, #eee 100%);
    -webkit-border-radius: 3px;
            border-radius: 3px;
    box-sizing: border-box; -moz-box-sizing: border-box;
}
.dd3-content:hover { color: #2ea8e5; background: #fff; }

.dd-dragel > .dd3-item > .dd3-content { margin: 0; }

.dd3-item > button { margin-left: 30px; }

.dd3-handle { position: absolute; margin: 0; left: 0; top: 0; cursor: pointer; width: 30px; text-indent: 100%; white-space: nowrap; overflow: hidden;
    border: 1px solid #aaa;
    background: #ddd;
    background: -webkit-linear-gradient(top, #ddd 0%, #bbb 100%);
    background:    -moz-linear-gradient(top, #ddd 0%, #bbb 100%);
    background:         linear-gradient(top, #ddd 0%, #bbb 100%);
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
}
.dd3-handle:before { content: '≡'; display: block; position: absolute; left: 0; top: 3px; width: 100%; text-align: center; text-indent: 0; color: #fff; font-size: 20px; font-weight: normal; }
.dd3-handle:hover { background: #ddd; }
#menu-burger, #header-menu .navbar-toggle{display:none !important;}
    @media screen and (min-width:320px) and (max-width: 1170px) {
        #tabmenu .navbar-collapse {
            display:none !important;
        }
    }

    #droppable a{text-decoration:none;color:#999;font-weight:700;font-style:italic;width:93%;}
    .activatedAssum{float:left; width:100%; height:100%; padding-top:0px;}
#droppable .dd-handle{ padding-top:5px;}
#nestable{height:592px;}
#droppable .activatedAssum{background:none !important; }
 #nestable .sidebar-nav-left{max-height:420px; margin-bottom:10px;}
 #droppable{max-height:172px;  }
  #importSerach{background-color:#222;}
  #importSerach{color:#eee;}

  .ui-autocomplete {
max-height: 50px;
overflow-y: auto;
overflow-x: hidden;
margin:0px; padding:0px;

}
.ui-autocomplete li{overflow:hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  padding-left:5px !important;
 background: #f6f6f6;

}
.ui-autocomplete li:hover{ border:0px solid red !important; padding-left:5px !important; margin:0px;}
/* IE 6 doesn't support max-height
* we use height instead, but this forces the menu to always be this tall
*/
* html .ui-autocomplete {
height: 100px;
max-width:230px !important;
border:1px solid #888;

}
.ui-autocomplete{ font-size:10px; }
/*.setcolor{background-color:red !important;}*/

#ImportParent .pagination{position:absolute; left:146px; top:12px !important; z-index:9999; width:100%; display:none;}
#tabmenu li > .pagination a{color:#000;}
#tabmenu #ImportParent:hover #importSerach{display:block !important; /*width:140px !important; border:1px solid #adadad !important; background-color:#222 !important;*/}
#ImportParent .pagination a.page{ background:none; color:#fff; padding:2px; border:0px; margin-top:6px;}
#ImportParent .pagination li.active a.page{ color:#ed6e6e; }
#importSerach{background-color:#222;}
  #importSerach{color:#eee;}
  .smallFont{font-size:13px;}
  .vcoment p{margin:0px; padding:0px;}
  .tollp {padding: 0px; text-align: center; color: rgb(0, 0, 0); line-height: 18px; font-size: 12px; margin-top: -8px;}
  .iradio_flat-aero{ margin:0px 6px 4px 0px;}
  #vDesc{font-size:12px;}
  #attachmentsModal .multiselect-container{ max-height:300px; overflow:scroll; overflow-x:hidden;}
 #attachmentsModal .multiselect-container > li > a > label{padding:3px 20px 3px 15px;}
 .sectionslist button:nth-child(3), .sectionslist button:nth-child(4), #droppable button{display:none !important;}
 .dd-list .dd-list li.no-dd-item:last-child{ padding-bottom:1px;}
 #droppable .dd-list li{display:none !important;}
 #page-content-wrapper{overflow-y:hidden;}
 #dropdownOfShare button{ 
           float:right; 
       }
       
       #dropdownOfShare .bootstrap-select{background:none;}
      #prdverid .tooltip{z-index:999999999999 !important;  word-break:break-all; width:240px;  }
       #shareModal.in .dropdown-menu.open {
           overflow:visible !important;
       }
       #prdverid td{vertical-align:middle; padding-left:3px !important; padding-right:1px !important;}
       #attachment_sections .multiselect{width:93% !important;} 
       #ImportParent .tooltip-inner{width:200px;}    
       .overlayPopup{ /*to add overlay on sharepopup*/
            height: 100%;
            margin: 0 auto;
            float: left;
            clear: both;
            position: absolute;
            z-index: 99999999;
            top: 0px;
            left: 0px;
            width: 100%;
            opacity: 0.8;
            background-color: rgba(232, 228, 230, 0.24);
       }  
</style>
<body class="nav-sm">
<div id="NoInternet" class="modal bootbox internet-on-of in" tabindex="-1">
    <div class="modal-dialog">
        <div class="bootcustom">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close bootbox-close-button" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">You are offline</h4>
                </div>
                <form role="form">
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <div style="margin-left: 15px;">
                                    <span>Do you want to save your work offline?</span>
                                    <label for="chkYes">
                                        <input type="radio" id="offlineYes" name="ChkInternet" />
                                        Yes
                                    </label>
                                    <label for="chkNo" style="margin-left: 20px;">
                                        <input type="radio" id="offlineNo" name="ChkInternet" checked />
                                        No
                                    </label>
                                    <hr />
                                    <div id="OfflineFile">
                                        <span style="width: 81%; float: left;">
                                            <input type="text" class="form-control" id="OfflineText" disabled required style="width: 93%;"></span><span><label class="btn btn-default btn-file disabled">
                                                Browse
                                                <input type="file" id="OfflineInput"></label></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-default pull-left" type="button" data-dismiss="modal">Cancel</button>
                        <input class="btn btn-primary pull-right" type="submit" value="Save Offline">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
     <%Html.RenderAction("RenderHeader", "Header", new { headerType = Model.MenuType }); %>
    <%-- <%Html.RenderAction("SharePopup", new {  "Forecast" = ViewData["type"] })%>--%>

<div id="overlay_container" class="story">
    <div class="wrapper-left explorationHost " id="wrapper">
          <div class="navigationPane unselectable">
                    <div class="innerLayout">
                        
                        <div class="scrollRegion scroll-view">

                             <div class="headertitle" style="border-image: none;"><a style="margin-right: 16px;" href="#">Forecast Navigation</a><a href="#" id="anchorsectionstagid" onclick="setSectionOrder(true);">
                           <span class="fa fa-tag" id="sectionstagid" aria-hidden="true" style="color: #337ab7; font-size: 15px;" data-toggle="tooltip" title="Tag sections for this version"></span>
                       </a></div>        
                           <div class="sidebar-wrapper-left">
           <div class="cf nestable-lists">

        <div class="dd" id="nestable">
            <ol class="dd-list sidebar-nav-left" style=" height:564px;">
               <% for (int i = 0; Model.Sections != null && i < Model.Sections.Count; i++)
                   { %>

               <li class="dd-item sectionslist" data-id="<%= Model.Sections[i].Id%>">
                    <div class="dd-handle">

 <% if(Model.Sections[i].SubSections != null && Model.Sections[i].SubSections.Count > 0) { %>
                      <a href="#" id ="<%= Model.Sections[i].Name.Replace(" ", "").ToLower()%>" ><%= Model.Sections[i].Name %></a>

                       <%  } 
                          else { %>
                        <a href="#" id ="<%= Model.Sections[i].Name.Replace(" ", "").ToLower()%>" onmousedown="navigateToSection(<%= Model.Sections[i].Start %>, '<%= Model.Sections[i].Name %>','<%=  Model.Sections[i].Name.Replace(" ", "").ToLower()%>')"  ><%= Model.Sections[i].Name %></a>
                   
                       <%  } %>


<%--                        <a href="#" id ="<%= Model.Sections[i].Name.Replace(" ", "").ToLower()%>" onmousedown="navigateToSection(<%= Model.Sections[i].Start %>, '<%= Model.Sections[i].Name %>','<%=  Model.Sections[i].Name.Replace(" ", "").ToLower()%>')"  ><%= Model.Sections[i].Name %></a>--%>
                    </div>
                    <% if(Model.Sections[i].SubSections != null && Model.Sections[i].SubSections.Count > 0) { %>
                    <ol class="dd-list">
                        <% for (int j = 0; j < Model.Sections[i].SubSections.Count; j++)
                   { %>
                        <li class="no-dd-item" data-id="<%= Model.Sections[j].Id%>"><div class="no-dd-handle"><a href="#" class="ui-sortable-helper" id="<%= Model.Sections[i].SubSections[j].Name.Replace(" ", "").ToLower() %>" onmousedown="navigateToSection(<%= Model.Sections[i].SubSections[j].Start %>, '<%= Model.Sections[i].SubSections[j].Name %>','<%= Model.Sections[i].SubSections[j].Name.Replace(" ", "").ToLower()%>')" ><%= Model.Sections[i].SubSections[j].Name %></a></div></li>
                    <% } %>                        
                    </ol>
                    <% } %>
                   <div style="position:absolute; right:10px; top:5px; cursor:pointer;">
                       <a href="#" onclick="return inactiveFunction(event,this)"><i title="Click to remove" class="fa fa-chevron-down" aria-hidden="true"></i></a>
                   </div>
                </li>                
                <% } %>
            </ol>
            
            </div>
               <div style="width: 210px; bottom: 0px; position: fixed;">
<div class="referenceSlider" onclick="toggleSliderSidebar();"></div>
             <ol  id="droppable" class="dd-list" style="margin-bottom:6px; position:relative;">
                <p class="description">Drop forecast navigation here.</p>
                <li class="dd-item" style="height:0px; width:100%; line-height:0px; position:absolute; top:34px;"></li>
            </ol>
                
                </div>

           </div>
        </div>
                          

                        </div>
                    </div>
                   <div class="expanderBtn" id="menu_toggle" onclick="updateScreen(true);" >
                       <a id="menu-toggle-left" class="slideLeft">
                                <span class="fa fa-angle-right" style="padding: 0px; font-size: 24px;"></span>
                            </a>
                      <%-- <a href="#">
                           <span class="fa fa-tag" aria-hidden="true" style="font-size: 15px;"></span>
                       </a>--%>
                            <h2 class="verticalTitle verticalText">
                               <%-- <span class="collapsedVisualsTitle largeFontSize">Forecast</span>
                                <span class="collapsedFiltersTitle largeFontSize">Sections - </span>--%>
                                <span class="collapsedFiltersTitle smallFontSize" id="NameInfo">(Version 5.0)</span>
                                <span class="collapsedFiltersTitle smallFontSize" id="VersionInfo">(Version 5.0)</span>
                            </h2>
                        </div>
                </div>
            
             <%Html.RenderPartial("ForecastRightPane", Model.ForecastAuxiliary); %>
           <div id="page-content-wrapper" class="page-content-wrapper-left imgclickenable horizontalItemsContainer" style="">
            <div class="container-fluid" style="margin-top:-26px;">
                <div class="row">
                    <div class="">
                      <%Html.RenderPartial("ForecastControl", Model); %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

    <script>
        var serverurl = '<%= Session["ServerUrl"]%>' 
        var model = JSON.parse('<%=Html.Raw(new System.Web.Script.Serialization.JavaScriptSerializer { MaxJsonLength = Int32.MaxValue }.Serialize(Model))%>');
        var loginEmail = '<%= Session["User"] %>';
        var accessTypeGT = '<%= Session["AccessTypeGT"]%>';
        var firstname = '<%= Session["FirstName"].ToString().Substring(0, 1)%>';
        var lastname = '<%= Session["LastName"].ToString().Substring(0, 1)%>';
        var roleId = '<%=  Session["RoleId"] %>';
        var basicNews = '<%=Session["Archive"] %>';
        var LoggedFirstname='<%= Session["FirstName"].ToString()%>';
        var LoggedLastname = '<%= Session["LastName"].ToString()%>';
    </script>

<%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">--%>
    </body>
