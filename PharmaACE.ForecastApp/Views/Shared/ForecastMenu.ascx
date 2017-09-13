<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<style>

     #header-menu .navbar-nav{margin-top:0px;}
     .navbar-nav > li > .dropdown-menu{margin-top:-2px;}
      .fa-white{color:#ddd !important ;}

    @media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
        #header-icons .top-menu {
            margin-left: 0px;
        }
    }
     
</style>
<div id="breadcrumb">
    <div class="container-fluid">
        <div class="row ">
            <div class="col-md-12 margin-none">
                <div class="col-md-12 vdivide margin-none" id="tabmenu">

                    <nav class="navbar navbar-nav" role="navigation">
	<div class="container-fluid">
		
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
		  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
		    <span class="sr-only">Toggle navigation</span>
		    <span class="icon-bar"></span>
		    <span class="icon-bar"></span>
		    <span class="icon-bar"></span>
		  </button>
		  
		</div>


	
        <script>
            var pageNumber = 1;
            var start1;
            var liLength;
            var showListItems;
            var linext = 0;
            var itemperpage = 20;

            function showPage(page) {

                start1 = (20 * page) - itemperpage;
                showListItems = $(".secondlevel li.secondli").splice(start1, itemperpage);
                $(".secondlevel li.secondli").hide();
                $(showListItems).show();
                linext = liLength - itemperpage * page;


            }
            $(document).ready(function () {
                var maxHeight = 500;
                /* For the Second level Dropdown menu, highlight the parent	*/

                $(function () {

                    $(".dropdown-menu .dropdown-submenu .dropdown-menu .dropdown-submenu").on('mouseenter mouseleave', function (e) {
                        $('ul.submenuFromBottom').removeAttr('style');
                        $('ul').removeClass('submenuFromBottom');
                        if ($('ul', this).length) {
                            var elm = $('ul:first', this);
                            var off = elm.offset();
                            var l = off.top - 50;
                            var w = elm.height();
                            var docH = $(".page-content-wrapper-left").height();
                            //var docW = $(".page-content-wrapper-left").width();

                            var fromTop = w - (docH - l) - 29
                            var isEntirelyVisible = (l + w <= docH);
                            if (!isEntirelyVisible) {
                                $('ul:first', this).addClass('submenuFromBottom');
                                $('.submenuFromBottom').css("top", -fromTop);
                            } else {
                                $(this).removeClass('submenuFromBottom');
                            }
                        }
                    });

                });

                $('.navbar-nav .dropdown').hover(function (ev) {
                    hideEDraw();
                    $(this).find('.dropdown-menu').first().stop(true, true).delay(450).slideDown(600);


                }, function () {
                    $(this).find('.dropdown-menu').first().stop(true, true).delay(200).slideUp(600);
                    pageNumber = 1;

                });


            });
        </script>
		<!-- Collect the nav links, forms, and other content for toggling -->
        <%--/*add the following class to show submenu fro top*/--%>
        <%--/*submenuFropTop*/--%>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		  <ul class="nav navbar-nav">
		   <li class="dropdown">
                           <%-- <a href="#" id="createid" onclick="createNewForecast();">Create</a>--%>
               <a href="#">Create</a>

                <ul id="createMenu" class="dropdown-menu">

                                <li class="createclass" id="createid"><a class="enbdisbl ctooltip" data-original-title="Create forecast" title="Create forecast" data-placement="bottom" href="#" data-title="create" data-target='#createModal' onclick="createNewForecast();">

                                 <div class="toolIcon">
                                        <i class="glyphicon glyphicon-floppy-disk gi-2x"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Create Forecast</div>
                                            <div class="toolDesc">Create forecast</div>
                                        </div> 
                                                      </a></li>

                    <li class="createclass" id="importimsdataid"><a class="disabled enbdisbl ctooltip" data-original-title="Import ims data" title="Import ims data" data-placement="bottom" href="#" data-title="Import Ims data" data-target='#Import_Ims_dataModal'>

                                 <div class="toolIcon">
                                        <i class="glyphicon glyphicon-import" style="font-size:24px;"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Import Ims data</div>
                                            <div class="toolDesc">Import ims data</div>
                                        </div> 
                                                      </a></li>
                    </ul>

                        </li>
                           
		  <li id="ImportParent" class="dropdown">
			  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" >Import <span class="caret"></span></a>
            <ul id="selectForecast" class="dropdown-menu list" role="menu" style="padding-top:34px;">
     </ul>
               <ul class="pagination"></ul>
			</li> <!-- .dropdown -->
              	<li class="dropdown" id="Prdbox" style="display: none;">
                            <a  data-placement="bottom" href="#" data-title="Project Parameter" data-toggle="modal" data-target='#ProjectParameterModal'   onmouseover="hideEDraw();">Project Parameters</a>

                          
                        </li>
              <li class="dropdown bi">
                            <a data-toggle="dropdown" role="button" class="dropdown-toggle" aria-expanded="false" id="cbi"  onmouseover="hideEDraw();" onclick="hideEDraw();">Quick Reports <span class="caret"></span></a>
                            <ul id="bi" class="dropdown-menu" role="menu">
                                <li class="" id="chartbox"><a id="chartid" class="disabled enbdisbl ctooltip" data-original-title="Generate forecast charts" title="Generate forecast charts" data-placement="bottom" href="#" data-title="Chart" data-target='#chartModal'">
                                  <div  class="toolIcon">
                                       <i class="glyphicon glyphicon-stats gi-2x"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Chart</div>
                                            <div class="toolDesc">Generate forecast charts</div>
                                        </div> 
                                </a></li>
                                <li>
                                 <a class="compare disabled enbdisbl" id="conso" href="#" data-original-title="Consolidation" data-placement="bottom" title="Consolidation" data-title="Consolidation" data-target="#consolidatorModel" data-toggle="modal">

                                    <div class="toolIcon">
                                        <i class="fa fa-object-group" style="font-size:21px;"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Consolidator</div>
                                            <div class="toolDesc">Consolidation</div>
                                        </div>   
                                    </a>                              
                                               
                                    </li>
                                <li id="compareversionid">
                                     <a class="compare disabled enbdisbl" href="#" onclick="return false;" data-original-title="Ad-hoc analysis" title="Ad-hoc analysis" data-placement="bottom" data-title="Ad-hoc analysis">
                                    <div class="toolIcon">
                                        <i class="glyphicon glyphicon-refresh gi-2x"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Compare Version</div>
                                            <div class="toolDesc">Ad-hoc analysis</div>
                                        </div>   
                                     </a>
                                        
                                </li>
                                 <li id="assumptionsheetid">
                                     <a class=" disabled enbdisbl ctooltip" href="#" data-original-title="Assumption summary" title="Assumption summary" data-placement="bottom" data-title="Assumption summary" data-target="#AssumptionSheetModel" data-toggle="modal">
                                    <div class="toolIcon">
                                        <i class="fa fa-table" style="font-size:21px;"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Assumption Summary</div>
                                            <div class="toolDesc">Assumption summary</div>
                                        </div>   
                                     </a>
                                        
                                </li>
                                 <li class="" id="npvbox"><a class="disabled enbdisbl ctooltip" data-original-title="Net present value" title="Net present value" data-placement="bottom" href="#" data-title="NPV" data-target='#NPVModal'>
                                  <div  class="toolIcon">
                                       <i class="glyphicon glyphicon-usd" style="font-size:21px;"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">NPV</div>
                                            <div class="toolDesc">Net present value</div>
                                        </div> 
                                </a></li>
                            </ul>
                        </li>
                        <li class="dropdown " id="ToolParent">
                            <a href="#" title="Tools" data-original-title="Tools" data-toggle="dropdown" class="dropdown-toggle" onmouseover="hideEDraw();">Tools <span class="caret"></span></a>
                            <ul id="toolMenu" class="dropdown-menu">

                                <li class="" id="savebox"><a class="disabled enbdisbl ctooltip" data-original-title="Save forecast" title="Save forecast" data-placement="bottom" href="#" data-title="Save" data-target='#saveModal'>

                                 <div class="toolIcon">
                                        <i class="glyphicon glyphicon-floppy-disk gi-2x"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Save</div>
                                            <div class="toolDesc">Save forecast</div>
                                        </div> 
                                                      </a></li>
                                 <li class="" id="editbox"><a class="disabled enbdisbl ctooltip" data-original-title="Edit forecast" title="Edit forecast" data-placement="bottom" data-toggle="tooltip" href="#">
                                
                                

                                <div  class="toolIcon">
                                        <i class="fa fa-pencil-square gi-2x" style="font-size: 1.6em; color: #428BCA;"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Edit</div>
                                            <div class="toolDesc">Edit forecast</div>
                                        </div> 
                                                      </a></li>
   

                                   <%-- <li class="" id="unsharebox"><a class="disabled enbdisbl ctooltip" data-original-title="UnShare forecast" title="UnShare forecast" data-placement="bottom" href="#" data-title="UnShare" data-target='#unShareModal'>
                                 <div  class="toolIcon">
                                        <i class="fa fa-mail-reply" style="font-size:20px;"></i></div>
                                        <div  class="toolContent">
                                            <div class="tooltitle">UnShare</div>
                                            <div class="toolDesc">UnShare forecast</div>
                                        </div> 
                                </a></li>--%>

                                     <li class="" id="formulabox"><a data-original-title="Toggle formula bar" title="Toggle formula bar" data-placement="bottom" data-toggle="tooltip" href="#" class="disabled enbdisbl ctooltip">
                               
                                 <div class="toolIcon">
                                        <img src="../../Content/img/funct.png" style="width: 20px; margin-top: 4px;" onmouseover="this.src='../../Content/img/func-over.png'" onmouseout="this.src='../../Content/img/funct.png'" /></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Formula Bar</div>
                                            <div class="toolDesc">Toggle formula bar</div>
                                        </div> 

                            </a></li>
                                    
                                     

                                     <li class="" id="attdoc"><a class="disabled enbdisbl ctooltip" data-original-title="Attach assumption documents" title="Attach assumption documents" data-placement="bottom" href="#" data-target='#attachmentsModal'>
                                <div  class="toolIcon">
                                         <i class="glyphicon glyphicon-paperclip gi-2x"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Attach Documents</div>
                                            <div class="toolDesc">Attach assumption documents</div>
                                        </div> 
                             </a></li>

                                 <li class="" id="sharebox"><a class="disabled enbdisbl ctooltip" data-original-title="Share your forecast with other users" title="Share your forecast with other users" data-placement="bottom" href="#" data-title="Share" data-target='#shareModal'>
                                 <div  class="toolIcon">
                                        <i class="glyphicon glyphicon-share gi-2x"></i></div>
                                        <div  class="toolContent">
                                            <div class="tooltitle">Share</div>
                                            <div class="toolDesc">Share forecast with other users</div>
                                        </div> 
                                </a></li>

                                    <li class="" id="openofflinebox"><a class=" ctooltip" data-original-title="Open forecast flat file from local" title="Open forecast flat file from local" data-placement="bottom" href="#" data-title="Open forecast flat file from local" data-target='#cloudModal'>
                                <div class="toolIcon">
                                         <i class="glyphicon glyphicon-cloud-upload gi-2x" ></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Open Offline</div>
                                            <div class="toolDesc">Open forecast flat file from local</div>
                                        </div>
                               </a></li>
                               <%-- <li class="" id="openofflinefortemplate"><a class="disabled enbdisbl ctooltip" data-original-title="Open Template from local" title="Open Template from local" data-placement="bottom" href="#" data-target='#OfflineTemplateModal'>
                                <div class="toolIcon">
                                         <i class="glyphicon glyphicon-cloud-upload gi-2x" ></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Open Template Offline</div>
                                            <div class="toolDesc">Open Template from local</div>
                                        </div>
                               </a></li>--%>

                                    <li class="pull-right" id="syncid"><a class=" disabled enbdisbl ctooltip" data-original-title="Upload forecasts from local" title="Upload forecasts from local" data-placement="bottom" href="#" data-target='#attachmentsModal1' data-toggle="modal" onclick="hideEDraw();">
                                       <div  class="toolIcon">
                                        <i class="glyphicon glyphicon-refresh"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Upload Forecasts</div>
                                            <div class="toolDesc">Upload forecasts from local</div>
                                        </div> 
                                     </a></li>

                                     <%--<li class="" id="closebutton">
                                <a data-original-title="Clear all forecast" title="Clear all forecast" data-placement="bottom" data-toggle="tooltip" href="#" class="disabled enbdisbl ctooltip">
                                    <div class="toolIcon">
                                        <i class="fa fa-times-circle-o gi-2x" style="font-size: 1.6em; color: #428BCA;"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Clear All</div>
                                            <div class="toolDesc">Clear all forecast</div>
                                        </div>
                                    </a></li>--%>

                                     <li id="helpid" class="help"><a data-original-title="Forecast help" title="Forecast help" data-placement="bottom" data-toggle="tooltip" href="#" class="disabled enbdisbl ctooltip">
                                        <div class="toolIcon"><i class="fa fa-question-circle  gi-2x" style="font-size: 1.6em; color: #428BCA;"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Help</div>
                                            <div class="toolDesc"> Forecast help</div>
                                        </div>
                                        </a></li>



                            </ul>
                        </li>					
		  </ul> <!-- .nav .navbar-nav -->		 
		</div><!-- /.navbar-collapse -->
		
	</div><!-- /.container-fluid -->
</nav>

                 

                    </div>
            </div>
        </div>
    </div>
</div>
