<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/CFSite.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.UWObject>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   User Workspace
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <%: Styles.Render("~/Content/UserworkspaceIndexCSS")%>
   <%--<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
      <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Constants.js"></script>
      <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.FeedEngine.js"></script>
      <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
      <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.NewsFeed.js"></script>
      <script type="text/javascript" src="../../Scripts/custom/bootbox.js"></script>
      <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>
      <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.SharePopup.js"></script>
      <script src="../../Scripts/lib/bootstrap/formValidation.min.js"></script>
      <script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>
      <script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
      <link href="https://swisnl.github.io/jQuery-contextMenu/dist/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
      <script src="https://swisnl.github.io/jQuery-contextMenu/dist/jquery.contextMenu.js" type="text/javascript"></script>
      <script src="https://swisnl.github.io/jQuery-contextMenu/dist/jquery.ui.position.min.js" type="text/javascript"></script>
      <script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
      <link href="../../Content/CSS/dataTables.bootstrap.min.css" rel="stylesheet" />
      <script src="../../Scripts/lib/bootstrap/bootstrap-filestyle.min.js"></script>
      <script src="../../Scripts/lib/jquery/jquery.flot.js"></script>
      <script src="../../Scripts/lib/jquery/jquery.flot.pie.js"></script>
      <link href="../../Content/CSS/aero.css" rel="stylesheet" />
      <script src="../../Scripts/lib/upload/jquery.knob.js"></script>
      <script src="../../Scripts/lib/upload/jquery.ui.widget.js"></script>
      <script src="../../Scripts/lib/upload/jquery.fileupload.js"></script>
      <script src="../../Scripts/lib/upload/script.js"></script>
      <link href="../../Content/CSS/calendarDefault.css" rel="stylesheet" />
      <link href="../../Content/CSS/calendarStyle.css" rel="stylesheet" />
      <link href="../../Content/CSS/userworkspace.css" rel="stylesheet" />
      <script src="../../Scripts/lib/jquery/calendar_zebra_datepicker.js"></script>
      <script src="../../Scripts/lib/bootstrap/bootstrap-select.min.js"></script>
      <link href="../../Content/CSS/bootstrap-select.min.css" rel="stylesheet" />
      <script src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>--%>
   <%-- <script src="../../Scripts/lib/jquery/ColReorderWithResize.js"></script>--%>
   <input type="hidden" value="0" id="lastSelected" />
   <form class="form-horizontal" role="form">
      <div id="addnewproduct" class="modal">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close modclose" data-dismiss="modal" aria-hidden="true" >×</button>
                  <h4 class="modal-title modtitle" >Add New Project</h4>
               </div>
               <div class="modal-body">
                  <div class="form-group">
                     <label for="name" class ="control-label col-sm-4">Project Name</label>
                     <div class="col-sm-8">
                        <input type="text" class="form-control" id="name" placeholder="Enter Project Name" onkeypress='return event.charCode!=62 && event.charCode!=60 && event.charCode!=58 && event.charCode!=124 && event.charCode!=63 && event.charCode!=42 && event.charCode!=34 && event.charCode!=92 && event.charCode!=47' maxlength="255" required>
                     </div>
                  </div>
                  <div class="form-group" id="forbdl">
                     <label for="bdld" class ="control-label col-sm-4">BD&amp;L Lead</label>
                     <div class="col-sm-8">
                        <%-- <%=Html.DropDownList("bdl", (SelectList)ViewBag.users, new { @class = "selectpicker form-control search-filter select-dropdown selectBox",@required = (string)null})%>--%>
                        <select id="bdl" name="bdl" class="selectpicker form-control search-filter select-dropdown selectBox" required>
                           <option value="" selected="selected">Please select</option>
                           <%
                              foreach (var user in ViewBag.users)
                              { %>
                           <option value=<%=user.UserId%> data-email="<%=user.Email %>"><%=user.FullName%></option>
                           <% }
                              %>
                        </select>
                     </div>
                  </div>
                  <div class="form-group" id="dealbox">
                     <label for="bdl" class ="control-label col-sm-4">Project Manager</label>
                     <div class="col-sm-8">
                        <%-- <%=Html.DropDownList("dealchamp", (SelectList)ViewBag.users, new { @class = "selectpicker form-control search-filter select-dropdown selectBox",@required = (string)null })%>
                           --%> 
                        <select id="dealchamp" name="dealchamp" class="selectpicker form-control search-filter select-dropdown selectBox" required>
                           <option value="" selected="selected">Please select</option>
                           <%
                              foreach (var user in ViewBag.users)
                              { %>
                           <option value="<%=user.UserId%>" data-email="<%=user.Email %>"><%=user.FullName%></option>
                           <%-- data-content="<a title='<%=user.FullName%>'><%=user.FullName%></a>"--%>
                           <% }
                              %>
                        </select>
                     </div>
                  </div>
                  <div class="form-group">
                     <label for="status" class ="control-label col-sm-4">Project Stage</label>
                     <div class="col-sm-8">
                        <%=Html.DropDownList("status", (SelectList)ViewBag.stageList, new { @class = "selectpicker form-control search-filter select-dropdown selectBox", @required = (string)null })%>
                     </div>
                  </div>
                  <div class="form-group">
                     <label for="activity" class ="control-label col-sm-4">Type of Deal</label>
                     <div class="col-sm-8">
                        <%=Html.DropDownList("activity", (SelectList)ViewBag.activitiesList, new { @class = "selectpicker form-control search-filter select-dropdown selectBox", @required = (string)null })%>
                     </div>
                  </div>
                  <div class="form-group">
                     <label for="status" class ="control-label col-sm-4">Project Type</label>
                     <div class="col-sm-8">
                        <ul id="addprdli">
                           <li class="addprdli"><span class="radchek"><input type="radio" class="flat" name="selectedProjType" id="hospital" checked="checked" value="0"/><span id="Radio1" class="">&nbsp;Hospital</span></span></li>
                           <li class="addprdli"><span class="radchek"><input type="radio" class="flat" name="selectedProjType" id="ARD" value="1"/><span id="Radio2" class="">&nbsp;ARD</span></span></li>
                          <li class="addprdli"><span class="radchek"><input type="radio" class="flat" name="selectedProjType" id="ARDandHospital" value="2"/><span id="Radio3" class="">&nbsp;Both</span></span></li>

                            
                        </ul>
                     </div>
                  </div>
                  <div class="form-group">
                     <label for="bdl" class ="control-label col-sm-4">Priority</label>
                     <div class="col-sm-8">
                        <%=Html.DropDownList("priority", (SelectList)ViewBag.ProjPriority, new { @class = "selectpicker form-control search-filter select-dropdown selectBox", @required = (string)null })%>
                     </div>
                  </div>
                  <div class="form-group">
                     <label for="deal" class ="control-label col-sm-4">Deal Value</label>
                     <div class="col-sm-8" >
                        <input type="text" id="ownerId" style="display:none" value=""/>
                        <%=Html.DropDownList("currency", (SelectList)ViewBag.CurrencyType, new { @class = "selectpicker form-control search-filter select-dropdown selectBox joined" })%>
                        <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57 ||event.charCode == 46' class="form-control Commafordealvalue" id="deal" placeholder="$ Value" value="" >
                     </div>
                  </div>
                  <div class="form-group">
                     <label for="performance" class ="control-label col-sm-4">Project Highlights</label>
                     <div class="col-sm-8">
                        <textarea row="6" class="form-control ueDiv37" id="performance"  placeholder="Next steps" onkeypress="Insertnewline()&& LimitThousandChar();" required></textarea>
                     </div>
                  </div>
               </div>
               <div class="modal-footer">
                  <span id="lblError" style="color: red; float: left"></span>
                  <input type="text" name="name" style="display:none" id="SelectedProjectId" value="" />
                  <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                  <input type="submit" onclick="SaveProject();" class="btn btn-primary" value="Submit" id="btnNewProduct" />
                  <button type="button" data-dismiss="modal" class="btn btn-primary" style="display:none;cursor: pointer;" id="rempopoup" ></button>
               </div>
            </div>
         </div>
      </div>
   </form>
   <div id="mainDiv">
      <div id="mainInside">
         <div class="col-md-9"></div>
      </div>
      <div id="mainContent">
         <div class="col-md-3" id="leftmenu">
            <div class="leftSection" >
               <div class="col-md-10" id="workspaceCustom">
                  <span style="float:left;">
                  <input type="text" class="form-control uwDiv1" onkeyup="searchFromList(event)" placeholder="Folder Search" id="searchFromList">
                  </span><span style="float:right;"><a id="addnewproject" title="Add new project" onclick="setPopuptitleforAdd();" href="#" data-toggle="modal" data-target='#addnewproduct'>
                  <span class="glyphicon glyphicon-plus-sign uwDiv2" aria-hidden="true" title="Create project" ></span></a></span> 
               </div>
               <div class="col-md-2" id="workspaceSlider">
                  <ul id="sliderArrow">
                     <li> 
                        <i class="fa fa-chevron-left" aria-hidden="true" title="Collapse"></i>
                     </li>
                  </ul>
               </div>
            </div>
            <div id="treeforAdvSearch" class="uwDiv3">
            </div>
            <div id="treeforReporting">
            </div>
            <div id="treeforfolderlist">
               <ul id="tree2">
                  <%
                     int i = 1;
                     %>
                  <%foreach (var folders in ViewBag.rootFolder)
                     { if (folders.permString=="ContetFileShare")
                     {%>
                  <li id=<%=folders.ObjectId%> permission="<%=folders.permission%>" lineageString="<%=folders.Lineage%>" sequence="<%=i%>" class="firstLi">
                     <%--<span class="glyphicon-folder-open" id='<%="Span2" + folders.Id.ToString().Trim()%>'></span>--%>
                     <span class="glyphicon glyphicon glyphicon-folder-close" id='<%="SpanFirst" + folders.ObjectId.ToString().Trim()%>' aria-hidden="true" title="Create New"></span>
                     <span class="fa fa-chevron-down" id='<%="Span" + folders.ObjectId.ToString().Trim()%>' onclick="callLeftPaneFolderViewWithIndex(<%=folders.ObjectId%>,'<%=folders.Lineage%>',<%=i%>,true);" aria-hidden="true" title="Show"></span>
                     <a href="#" title="<%=folders.Name%>" onclick="callEditableWorkSpaceJSON(<%=folders.ObjectId%>, ' ' + '<%=folders.Lineage%>');"><%=i%> <%=folders.Name.Trim()%></a>
                     <span class="badge" id='<%= "SpnFCount" + folders.ObjectId%>' ><%=folders.FileCounts%></span>
                     <span class="uwDiv4" id="editProductIcon">
                     <%
                        if (Convert.ToString(folders.permission)=="FullControl")
                        { %> 
                     <a title="Edit Project" id="editproject" href="#" data-toggle="modal" onclick="setPopuptitle(<%=folders.ObjectId%>);" data-target='#addnewproduct'><i class="fa fa-edit uwDiv5" ></i></a>
                     <% }
                        %> 
                     </span> 
                  </li>
                  <% }
                     else
                     { %>
                  <li id=<%=folders.ObjectId%> permission="<%=folders.permission%>" lineageString="<%=folders.Lineage%>" sequence="<%=i%>" class="firstLi applycontextmenu">
                     <%--<span class="glyphicon-folder-open" id='<%="Span2" + folders.Id.ToString().Trim()%>'></span>--%>
                     <span class="glyphicon glyphicon glyphicon-folder-close" id='<%="SpanFirst" + folders.ObjectId.ToString().Trim()%>' aria-hidden="true" title="Create New"></span>
                     <span class="fa fa-chevron-down" id='<%="Span" + folders.ObjectId.ToString().Trim()%>' onclick="callLeftPaneFolderViewWithIndex(<%=folders.ObjectId%>,'<%=folders.Lineage%>',<%=i%>,true);" aria-hidden="true" title="Show"></span>
                     <a href="#" title="<%=folders.Name%>" onclick="callEditableWorkSpaceJSON(<%=folders.ObjectId%>, ' ' + '<%=folders.Lineage%>');"><%=i%> <%=folders.Name.Trim()%></a>
                     <span class="badge" id='<%= "SpnFCount" + folders.ObjectId%>' ><%=folders.FileCounts%></span>
                     <span class="uwDiv6" id="editProductIcon">
                     <%
                        if (Convert.ToString(folders.permission)=="FullControl")
                        { %> 
                     <a title="Edit Project" id="editproject" href="#" data-toggle="modal" onclick="setPopuptitle(<%=folders.ObjectId%>);" data-target='#addnewproduct'><i class="fa fa-edit" style="font-size:16px;cursor: pointer;padding-left:7px;display:block;"></i></a>
                     <% }
                        %> 
                     </span> 
                  </li>
                  <% }
                     %>
                  <%
                     i = i + 1;
                     
                     }%>
               </ul>
            </div>
            <div id="verticalTitle">
               <h2 class="verticalTitle verticalText"><a href="#"><span style="cursor:pointer" class="collapsedVisualsTitle largeFontSize uwDiv7">Library</span></a></h2>
            </div>
            <div id="dragbar" class="resizer_x"></div>
            <div id="progressbox">
               <ul>
               </ul>
            </div>
         </div>
         <div class="col-md-9" id="editableWorkSpace">
            <!-- -->
            <div class="row uwDiv8" id="headerBox">
               <div class="col-md-6 col-lg-6 collapse navbar-collapse js-navbar-collapse uwDiv9">
                  <ul class="nav nav-pills nav-justified">
                     <li data-target="#myCarousel" data-slide-to="0" class="active"><a href="#" onclick="GetLibraryTab();">Library</a></li>
                     <li id="ASearch" data-target="#myCarousel" data-slide-to="0"><a href="#" onclick="showAdvSearch();">Advance Search</a></li>
                     <li data-target="#myCarousel" data-slide-to="1" ><a href="#" onclick="GetTrackerSummaryTab();">Tracker</a></li>
                     <li id="ActLog" data-target="#myCarousel" data-slide-to="2" >
                        <a href="#" onclick="showReporting();">Activity Log </a>
                     </li>
                  </ul>
               </div>
               <div class="col-md-2">
                  <form id="searchbarForContentsearch" action="#" class="uwDiv10" method="post" onsubmit="rootFolderListAdvSearch();" >
                     <input type="checkbox" disabled style="display:none;" id="enbdisEvent" data-toggle="toggle" data-on="No Filter" data-off="Filter" data-onstyle="primary" data-offstyle="default">
                     <div id="custom-search-input" style="display:none">
                        <div class="input-group col-md-12" id="advFilter">
                           <select class="selectpicker form-control search-filter select-dropdown selectBox " id="searchCriteria" name="searchCriteria" tabindex="-98">
                              <option value="1">File </option>
                              <option value="0">Content </option>
                           </select>
                           <span class="spanText"><input type="text" onmouseover="getInnertext();" class="form-control" title="" placeholder="Text Search" id="filter" ></span>
                           <span class="searchIcon" ><a href="#" onclick="rootFolderListAdvSearch();"><i class="fa fa-search" aria-hidden="true" style="font-size: 1.65em; color:#4e4e4e; margin-left: 4px; margin-top: 6px;"></i></a></span> 
                        </div>
                     </div>
                  </form>
               </div>
               <div class="col-md-4 uwDiv11" >
                  <div class="col-md-12 uwDiv13">
                     <div id="showhide" class="uwDiv14"></div>
                     <div id="showentries"></div>
                     <div id="tabAttr">
                        <div id="docIcons">
                           <div class="active">
                              <ul>                         
                                 <li id="LiUploadDoc">
                                    <form><span id="fileselector"><label class="btn btn-default" for="upload-file-selector">
                                       <input id="upload-file-selector" type="file" onchange="uploadDocument()" multiple accept=".tif,.tiff,.gif,.jpg,.jpeg,.png,.doc,.docx,.pdf,.xls,.xlsb,.xlsm, .xlsx, .csv, .txt,.zip, .jpeg, .png,.ppt,.pptx,.bmp,.rar">
                                       <i class="glyphicon glyphicon-cloud-upload margin-correction" title="Upload"></i>
                                       </label></span>
                                    </form>
                                 </li>
                                 <li id="LiDownloadDoc"> <span class="glyphicon glyphicon-download-alt" aria-hidden="true" title="Download" onclick="downloadSelectedFile()"></span> </li>
                                 <li id="LiCopyDoc"><span class="glyphicon" aria-hidden="true" title="Copy"onclick="copySelectedFile()"><img class="uwDiv15" src="../../Content/img/gly-copy.png" /></span></li>
                                 <li id="LiDeleteDoc"> <span class="glyphicon glyphicon-trash uwDiv17_1" aria-hidden="true" title="Delete" onclick="deleteSelectedFile()"></span> </li>
                              </ul>
                           </div>
                        </div>
                     </div>                
                  </div>
                  <div class="col-md-4 uwDiv16" id="workspaceView">
                     <ul>
                        <li> <span class="glyphicon glyphicon-th-list" aria-hidden="true" title="Icon View"></span> </li>
                        <li> <span class="glyphicon glyphicon-th" aria-hidden="true" title="List View"></span> </li>
                     </ul>
                  </div>
               </div>
            </div>
            <div id="myCarousel" class="carousel slider">
               <a href="#" id="amultiDownload" style="display:none"></a>
               <!-- Wrapper for slides -->
               <div class="carousel-inner">
                  <div class="item active" >
                     <form id="upload" method="post" action="/" enctype="multipart/form-data">
                        <div id="drop" class="context-menu-empty">                        
                           <table id="userworkspaceTable" class="table table-striped select" cellspacing="0" width="100%" >
                              <thead>
                                 <tr>
                                    <th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                    <th><input type="checkbox" name="select_all" value="1" id="example-select-all"></th>
                                    <th>Path</th>
                                    <th >Name</th>
                                    <th>Shared With</th>
                                    <th>Type</th>
                                    <th>Created Date</th>
                                    <th>Size </th>
                                 </tr>
                              </thead>
                              <tbody>                                
                              </tbody>
                           </table>
                        </div>
                     </form>
                  </div>
                  <!-- End Item -->
                  <div class="item uwDiv17" >
                     <div class="uwDiv19">
                        <div class="uwDiv18">
                           <div class="corner-bottom-both-bevel uwDiv20">
                              <a stageId="" stageName="Screen / Profile" href="#" title="Screen/ Profile" onclick="stageWiseProjList('Screen / Profile')">
                                 <%-- <div class="absDiv">Screen / Profile: $<%=ViewData["screenProfileCounts_Price"] %> M (<%= ViewData["screenProfileCounts"] %> deals)</div>--%>
                                 <div class="absDiv">Screen / Profile: $<span id="screenProfileCountsPrice">00.00</span> M<br />(<span id="screenProfileCounts">0</span> deals)</div>
                              </a>
                           </div>
                           <div class="corner-bottom-both-bevel uwDiv21">
                              <a stageId="" stageName="Diligence" title="Diligence" href="#" onclick="stageWiseProjList('Diligence')">
                                 <%-- <div class="absDiv" id="dilligence">Diligence: $<%=ViewData["Dilligence_Price"] %> M ( <%=ViewData["DilligenceCounts"] %> deals)</div>--%>
                                 <div class="absDiv" >Diligence: $<span id="dilligenceCountsPrice">00.00</span> M<br /> (<span id="dilligenceCounts">0</span> deals)</div>
                              </a>
                           </div>
                           <div class="corner-bottom-both-bevel uwDiv22">
                              <a stageId="" stageName="Negotiation" title="Negotiation" href="#" onclick="stageWiseProjList('Negotiation')">
                                 <%-- <div class="absDiv" id="negotiation">Negotiation: $<%=ViewData["Negotiation_Price"] %> M (<%=ViewData["NegotiationCounts"] %> deals)</div>--%>
                                 <div class="absDiv">Negotiation: $<span id="negotiationCountsPrice">00.00</span> M<br /> (<span id="negotiationCounts">0</span> deals)</div>
                              </a>
                           </div>
                           <div class="uwDiv23">
                              <ul class="nav nav-pills uwDiv24">
                                 <li class="active uwDiv25"><a href="#" stageName="total" class="uwDiv26" onclick="stageWiseProjList('total')">Total Opportunity Value 
                                    <%-- <span class="badge" id="totalprice">$<%=ViewData["Total_Price"] %> M </span>--%>
                                    <span class="badge" >$<span id="totalprice">00.00</span> M</span>
                                    </a>
                                 </li>
                                 <li class="active uwDiv27" >
                                    <%-- <a stageId="" stageName="onHoldWithdrwal" href="#" style="margin:0px;" onclick="stageWiseProjList('onHoldWithdrwal')">On Hold / Withdrawn from process (<%=ViewData["onHoldWithdrwalCounts"] %> Projects)
                                       <span class="badge">$<%= ViewData["onHoldWithdrwal_Price"] %> M</span></a></li>--%>
                                    <a stageId="" stageName="onHoldWithdrwal" href="#" class="uwDiv26" onclick="stageWiseProjList('onHoldWithdrwal')">On Hold / Withdrawn from process (<span id="onHoldWithdrwalCounts">0</span> Projects)
                                    <span class="badge">$<span id="onHoldWithdrwalPrice"></span> M</span></a>
                                 </li>
                              </ul>
                           </div>
                        </div>
                        <div class="uwDiv29">
                           <div id="placeholder" class="demo-placeholder uwDiv28" ></div>
                        </div>
                     </div>
                     <div class="uwDiv30">
                        <table id="trackerWorkspaceTable" class="table table-striped select" cellspacing="0" width="100%" >
                           <thead>
                              <tr>
                                 <th>Stage</th>
                                 <th>Type</th>
                                 <th>Deal</th>
                                 <th>Project Manager</th>
                                 <th>BD&amp;L Lead</th>
                                 <th>ProjectHighlights</th>
                              </tr>
                           </thead>
                           <tbody>
                           </tbody>
                        </table>
                     </div>
                  </div>
                  <!-- End Item -->
                  <div class="item uwDiv31" id="ReportDiv" >
                     <table id="ReportworkspaceTable" class="table table-striped select" cellspacing="0" width="100%" >
                        <thead>
                           <tr>
                              <%-- <th>Index</th>--%>
                              <th>User</th>
                              <th>User Artifact</th>
                              <th>Parent</th>
                              <th>Date</th>
                              <th>Action</th>
                           </tr>
                        </thead>
                        <tbody>
                        </tbody>
                     </table>
                  </div>
               </div>
               <!-- End Carousel Inner -->
            </div>
            <!-- End Carousel -->
         </div>
      </div>
   </div>
   <%--</div>--%>
   <div class="modal" id="myModal">
      <div class="modal-dialog uwDiv32" >
         <form id="creatFolderFormId" onsubmit="createFolder(); return false;" method="post" role="form">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close modclose" data-dismiss="modal" aria-hidden="true" >×</button>
                  <h4 class="modal-title modtitle" id="myModalLabel">Create Folder</h4>
               </div>
               <div class="modal-body">
                  <input type="text" class="uwDiv33" placeholder="Enter Folder Name..." id="txtFolderName" name="name" onkeypress='return event.charCode!=62 && event.charCode!=60 && event.charCode!=58 && event.charCode!=124 && event.charCode!=63 && event.charCode!=42 && event.charCode!=34 && event.charCode!=92 && event.charCode!=47' maxlength="255" /> 
                  <input type="text" class="uwDiv34" id="txtParent" style="display:none;" name="name" />
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                  <button type="button" id="btnModalClose" class="btn btn-default" data-dismiss="modal" style="display:none"> Close</button> 
                  <button type="submit" class="btn btn-primary">OK</button>
               </div>
            </div>
         </form>
      </div>
   </div>
   <div class="modal" id="uploadModal" tabindex="-1">
      <div class="modal-dialog uwDiv32">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close modclose" data-dismiss="modal" aria-hidden="true" >×</button>
               <h4 class="modal-title modtitle" id="uploadModalLabel">Upload File</h4>
            </div>
            <div class="modal-body" style="text-align:center;">
               <div class="btn btn-default btn-file">
                  <input type="file" id="BSbtninfo" class="uwDiv35" onchange="uploadDocument();" multiple accept=".tif,.tiff,.gif,.jpg,.jpeg,.png,.doc,.docx,.pdf,.xls,.xlsb,.xlsm, .xlsx, .csv, .txt, .html, .zip, .jpeg, .png,.ppt,.pptx,.bmp,.rar,.htm">
               </div>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
               <button type="button" id="btnuploadModalClose" class="btn btn-default" data-dismiss="modal" style="display:none"> Close</button> 
            </div>
         </div>
      </div>
   </div>
   <div class="modal" id="renameModal" tabindex="-1">
      <div class="modal-dialog uwDiv32">
         <form id="renameFolderFormId" onsubmit="renameFolder();return false;" method="post" role="form">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close modclose" data-dismiss="modal" aria-hidden="true" >×</button>
                  <h4 class="modal-title modtitle" id="renameModalLabel">Rename</h4>
               </div>
               <div class="modal-body"><%--placeholder="Enter New Name..."--%>
                  <input type="text" id="txtFolderNameRename" name="name" style="width:100%;" onkeypress='return event.charCode!=62 && event.charCode!=60 && event.charCode!=58 && event.charCode!=124 && event.charCode!=63 && event.charCode!=42 && event.charCode!=34 && event.charCode!=92 && event.charCode!=47'maxlength="255"/> 
                  <input type="text" id="txtParentRename" style="display:none;width:100%;" name="name" />
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                  <button type="button" id="btnRenameModalClose" class="btn btn-default" data-dismiss="modal" style="display:none"> Close</button> 
                  <input type="submit" class="btn btn-primary" value="Rename"/>
               </div>
            </div>
         </form>
      </div>
   </div>
   <button type="button" style="display:none" class="btn btn-primary btn-lg" id="btnmodl" data-toggle="modal" data-target="#myModal"></button>
   <button type="button" style="display:none" class="btn btn-primary btn-lg" id="btnupload" data-toggle="modal" data-target="#uploadModal"></button>
   <button type="button" style="display:none" class="btn btn-primary btn-lg" id="btnrename" data-toggle="modal" data-target="#renameModal"></button>
   <button type="button" style="display:none" class="btn btn-primary btn-lg" id="btnchangePerm" data-toggle="modal" data-target="#changePermModal"></button>
   <%--<script src="../../Scripts/lib/jquery/icheck.min.js"></script>--%>
   <div id="ShareResult"></div>
   <button type="button" style="display:none" class="btn btn-primary btn-lg" id="btnShowShare" data-toggle="modal" ></button>
   <!--Remove After SomeTime-->
   <form>
      <div class="modal" id="changePermModal">
         <div class="modal-dialog uwDiv36">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close modclose" data-dismiss="modal" aria-hidden="true" >×</button>
                  <h4 class="modal-title modtitle" id="changePermModalLabel">Change Permission</h4>
               </div>
               <div class="modal-body">
                  <div id="bdlchangePermValues">
                     <div class="form-group">
                        <div class="row">
                           <div class="col-md-8">
                              <input type="text" id="BdlId" name="name" readonly/>
                           </div>
                           <div class="col-md-4">
                              <select id="permissarrValuesBDL" name="permissarrValuesBDL" class="form-control search-filter select-dropdown selectBox" required></select>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div id="champChangePermValues">
                     <div class="form-group">
                        <div class="row">
                           <div class="col-md-8">
                              <input type="text" id="ChampId" name="ChampId" readonly/>
                           </div>
                           <div class="col-md-4">
                              <select id="permissarrValuesDealChamp" name="permissarrValuesDealChamp" class="form-control search-filter select-dropdown selectBox" required></select>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="modal-footer"> 
                  <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="PrevUserChangePermission();">OK</button>
               </div>
            </div>
         </div>
      </div>
   </form>
   <%: Scripts.Render("~/Scripts/UserWorkspaceIndexScript") %>
</asp:Content>