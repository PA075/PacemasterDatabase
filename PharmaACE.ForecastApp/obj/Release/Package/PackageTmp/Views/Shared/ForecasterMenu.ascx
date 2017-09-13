<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<style>   
    .Zebra_DatePicker.dp_visible{z-index:99999;} 
     .wizard_content .multiselect-container{overflow-x: hidden; max-height: 300px; max-width: 328px;}
    .modal-dialog .form_wizard  .actionBar .btn{float:right;}
    .sleeve .bootstrap-tagsinput input{width:14em !important;}
    #pstep-4 #accordion .radchek{display:inline; margin-right:20px; width:auto;}
     .form_wizard .datepicker-years .year, .form_wizard .datepicker-months .month{display:inline-block; width:36px; padding:8px;}
    .form_wizard .datepicker-years, .form_wizard .datepicker-months{max-width:170px;}
    .tbl_bdl .form-control{padding:6px 4px}
     .tbl_bdl td{padding:8px 2px !important;}
     .tbl_bdl .icheckbox_flat-aero, .iradio_flat-aero{margin-left:18px;}
     .gi-3x{ font-size:2.1em;}
    #c_country .bootstrap-select.show-tick  {display:none;}
.radchek {
            width: 50%;
            text-align: center;
            float: left;
        }
        #tab_product td{text-align:center;}
         #tab_product th{ vertical-align:text-top;}
         #tab_product .checkbox, #tab_product .radio { margin-top:0px; margin-bottom:0px;}
         #tab_product .iradio_flat-aero{ margin-top:7px; margin-bottom:0px;}
         
        .table-hover > tbody > tr td:hover, .table-hover > tbody > tr:hover{ background:none; color:#333333;}
        #tab_product.table-hover > tbody > tr td a:hover, #tab_product.table-hover > tbody > tr td:hover a{color:#999;}
         [data-toggle="buttons"] > .btn input[type="radio"],[data-toggle="buttons"] > .btn-group > .btn input[type="radio"]
         {position:static;}
        .input-group.date .input-group-addon {
    cursor: pointer;
}
        .form-group{margin-bottom:12px;}
        .form-group .form-control, input[type="text"], button, textarea, select{box-shadow:0 1px 1px 1px rgba(0, 0, 0, 0.024) inset}
        .no-padding-left{padding-left:0px;}
        .form-horizontal .control-label {
            text-align: left;
            padding-bottom:4px;
        }
        .form-horizontal .form-group{ margin-left:0px; margin-right:0px;}
        .form_wizard .stepContainer {
    border: 0 solid #ccc;
    display: block;
    margin: 0;
    /*overflow-x: hidden;*/
    padding: 0;
    position: relative;
    margin-top:30px;
}
.wizard_horizontal ul.wizard_steps {
    display: table;
    list-style: outside none none;
    margin: 0 0 20px;
    position: relative;
    width: 100%;
    padding:0px;
}
.wizard_horizontal ul.wizard_steps li {
    display: table-cell;
    text-align: center;
}
.wizard_horizontal ul.wizard_steps li a, .wizard_horizontal ul.wizard_steps li:hover {
    color: #666;
    display: block;
    opacity: 1;
    position: relative;
}
.wizard_horizontal ul.wizard_steps li a::before {
    background: #ccc none repeat scroll 0 0;
    content: "";
    height: 4px;
    left: 0;
    position: absolute;
    top: 20px;
    width: 100%;
    z-index: 4;
}
.wizard_horizontal ul.wizard_steps li a.disabled .step_no {
    background: #ccc none repeat scroll 0 0;
}
.wizard_horizontal ul.wizard_steps li a .step_no {
    border-radius: 100px;
    display: block;
    font-size: 16px;
    height: 40px;
    line-height: 40px;
    margin: 0 auto 5px;
    position: relative;
    text-align: center;
    width: 40px;
    z-index: 5;
}
.wizard_horizontal ul.wizard_steps li a.selected::before, .step_no {
    /*background: #34495e none repeat scroll 0 0;*/
    background: #000 none repeat scroll 0 0;
    color: #fff;
}
.wizard_horizontal ul.wizard_steps li a.done::before, .wizard_horizontal ul.wizard_steps li a.done .step_no {
    background: #2a6496 none repeat scroll 0 0;
    color: #fff;
}
.wizard_horizontal ul.wizard_steps li:first-child a::before {
    left: 50%;
}
.wizard_horizontal ul.wizard_steps li:last-child a::before {
    left: auto;
    right: 50%;
    width: 50%;
}
.wizard_verticle .stepContainer {
    float: left;
    padding: 0 10px;
    width: 80%;
}
.form_wizard .stepContainer div.content {
    clear: both;
    color: #5a5655;
    display: block;
    float: left;
    font: 12px Verdana,Arial,Helvetica,sans-serif;
   
    margin: 0;
    overflow: auto;
    padding: 5px;
    position: absolute;
    text-align: left;
    z-index: 88;
}
.actionBar {
    border-top: 0px solid #ddd;
    margin-top: 10px;
    padding: 10px 5px;
    text-align: right;
    width: 100%;
}
.actionBar .buttonDisabled {
    box-shadow: none;
    cursor: not-allowed;
    opacity: 0.65;
    pointer-events: none;
}
.actionBar a {
    margin: 0 3px;
}
#tab_product .tollp{padding:0px; margin:0px;}
 #creatNewForecast .modal-body .form-group, #creatNewBDL .modal-body .form-group {
    margin-top: 16px !important;
    width:100%;display:inline-block;
}
 #creatNewForecast .modal-dialog, #creatNewBDL .modal-dialog{width:68%;}
.tollp .bootstrap-tagsinput{ min-width:238px; width:auto;}
.tollp .bootstrap-tagsinput .tag{ font-size:11px; padding-left:4px; padding-right:4px; display:inline-block; margin-bottom:3px;}  
#add_product{ margin-top:15px;}
#add_product img{ width:74%;}
.btn-active
{
     background-color:rgba(0, 0, 0, .2);
     color:#000;
     border:1px solid rgba(0, 0, 0, .12);
}
.btn-active:hover, .btn-success:focus, .focus.btn-active, .btn-active:active, .active.btn-active, .open > .btn-active.dropdown-toggle
{
     background-color:rgba(0, 0, 0, .12);
     color:#000;
     border:1px solid rgba(0, 0, 0, .2);
}
#imsModal .form-group{ margin-bottom:15px; float:left; width:100%;}
#add_product img, #add_scenario img{width:74%;}

     #header-menu .navbar-nav{margin-top:0px;}
     .navbar-nav > li > .dropdown-menu{margin-top:-2px;}
    @media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
        #header-icons .top-menu {
            margin-left: 0px;
        }
    }
         .Zebra_DatePicker_Icon_Inside_Right{ top:9px !important;}

       /* #addproduct0 .checkbox .iCheck-helper:nth-child(2){display:none !important;}*/

    /*div.iradio_flat-aero + .flat, div.iradio_flat-aero + .iCheck-helper, 
        div.icheckbox_flat-aero + .iCheck-helper, .iradio_flat-aero .iradio_flat-aero, .icheckbox_flat-aero .icheckbox_flat-aero, 
        .bootstrap-select .bootstrap-select{display:none !important;}*/
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

        <div id="customCss">
 <style>

     #popalert {
  -webkit-animation: seconds 2.0s forwards;
  -webkit-animation-iteration-count: 1;
  -webkit-animation-delay: 5s;
  animation: seconds 2.0s forwards;
  animation-iteration-count: 1;
  animation-delay: 5s;

  
}
    
@-webkit-keyframes seconds {
  0% {
    opacity: 1;
  }
  100% {
    opacity: 0;
    left: -9999px; 
  }
}
@keyframes seconds {
  0% {
    opacity: 1;
  }
  100% {
    opacity: 0;
    left: -9999px; 
  }
}
 </style>
 </div>
	    
		<!-- Collect the nav links, forms, and other content for toggling -->
        <%--/*add the following class to show submenu fro top*/--%>
        <%--/*submenuFropTop*/--%>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		  <ul class="nav navbar-nav">
		   <li class="dropdown">
                           <%-- <a href="#" id="createid" onclick="createNewForecast();">Create</a>--%>
               <a href="#">Create</a>

                <ul id="createMenu" class="dropdown-menu">

                                <li class="createclass" id="createid"><a class="enbdisbl ctooltip"  onclick="openModal()" data-original-title="Create Forecast" title="Create Forecast" data-placement="bottom" href="#" data-title="create" data-target='#createModal'">

                                 <div class="toolIcon">
                                        <i class="glyphicon glyphicon-floppy-disk gi-2x"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Create Forecast</div>
                                            <div class="toolDesc">Create Forecast</div>
                                        </div> 
                                                      </a></li>

                    <li class="createclass" id=""><%--<a class="enbdisbl ctooltip" data-original-title="Import IMS data" title="Import IMS data" data-placement="bottom" href="#" data-title="Import IMS data" data-target='#Import_IMS_dataModal'>--%>
     <a  data-placement="bottom" href="#" data-title="Import IMS Data" data-toggle="modal" data-target='#imsModal'>


                                 <div class="toolIcon">
                                        <i class="glyphicon glyphicon-import" style="font-size:24px;"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Import Ims data</div>
                                            <div class="toolDesc">Import Ims data</div>
                                        </div> 
                                                      </a></li>
                    </ul>

                        </li>
                           
		    <li id="ImportParent" class="dropdown">
			   <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" >Import <span class="caret"></span></a>
			  <ul id="selectForecast" class="dropdown-menu" role="menu">				          
			   
			  </ul>
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
                                            <div class="toolDesc">Charts</div>
                                        </div> 
                                </a></li>
                                <li>
                                 <a class="compare disabled enbdisbl" id="conso" href="#" data-original-title="Consolidator" data-placement="bottom" data-title="Consolidator" data-target="#consolidatorModel" data-toggle="modal">

                                    <div class="toolIcon">
                                        <i class="glyphicon glyphicon-refresh gi-2x"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Consolidator</div>
                                            <div class="toolDesc">Consolidation</div>
                                        </div>   
                                    </a>                              
                                               
                                    </li>
                                <li>
                                     <a class="compare disabled" href="#" onclick="return false;">
                                    <div class="toolIcon">
                                        <i class="glyphicon glyphicon-refresh gi-2x"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Compare Version</div>
                                            <div class="toolDesc">Ad-hoc Analysis</div>
                                        </div>   
                                     </a>
                                        
                                </li>
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

                                     <li class="" id="sharebox"><a class="disabled enbdisbl ctooltip" data-original-title="Share your forecast with other users" title="Share your forecast with other users" data-placement="bottom" href="#" data-title="Share" data-target='#shareModal'>
                                 <div  class="toolIcon">
                                        <i class="glyphicon glyphicon-share gi-2x"></i></div>
                                        <div  class="toolContent">
                                            <div class="tooltitle">Share</div>
                                            <div class="toolDesc">Share forecast with other users</div>
                                        </div> 
                                </a></li>

                                    <li class="" id="unsharebox"><a class="disabled enbdisbl ctooltip" data-original-title="UnShare forecast" title="UnShare forecast" data-placement="bottom" href="#" data-title="UnShare" data-target='#unShareModal'>
                                 <div  class="toolIcon">
                                        <i class="fa fa-mail-reply" style="font-size:20px;"></i></div>
                                        <div  class="toolContent">
                                            <div class="tooltitle">UnShare</div>
                                            <div class="toolDesc">UnShare forecast</div>
                                        </div> 
                                </a></li>

                                     <li class="" id="formulabox"><a data-original-title="Toggle formula bar" title="Toggle formula bar" data-placement="bottom" data-toggle="tooltip" href="#" class="disabled enbdisbl ctooltip">
                               
                                 <div class="toolIcon">
                                        <img src="../../Content/img/funct.png" style="width: 20px; margin-top: 4px;" onmouseover="this.src='../../Content/img/func-over.png'" onmouseout="this.src='../../Content/img/funct.png'" /></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Formula Bar</div>
                                            <div class="toolDesc">Toggle formula bar</div>
                                        </div> 

                            </a></li>
                                     <li class="" id="npvbox" style="display:none;"><a class="disabled enbdisbl ctooltip" data-original-title="Net Present Value" title="Net Present Value" data-placement="bottom" href="#" data-title="NPV" data-target='#NPVModal'>
                                  <div  class="toolIcon">
                                       <i class="glyphicon glyphicon-usd" style="font-size:21px;"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">NPV</div>
                                            <div class="toolDesc">Net Present Value</div>
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

                                    <li class="" id="openofflinebox"><a class=" ctooltip" data-original-title="Open forecast from local" title="Open forecast from local" data-placement="bottom" href="#" data-title="Open Offline" data-target='#cloudModal'>
                                <div class="toolIcon">
                                         <i class="glyphicon glyphicon-cloud-upload gi-2x" ></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Open Offline</div>
                                            <div class="toolDesc">Open forecast from local</div>
                                        </div>
                               </a></li>

                                    <li class="pull-right" id="syncid"><a class=" ctooltip" data-original-title="Upload forecasts from local" title="Upload forecasts from local" data-placement="bottom" href="#" data-target='#attachmentsModal1' data-toggle="modal" onclick="hideEDraw();">
                                       <div  class="toolIcon">
                                        <i class="glyphicon glyphicon-refresh"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Upload Forecasts</div>
                                            <div class="toolDesc">Upload forecasts from local</div>
                                        </div> 
                                     </a></li>

                                     <li class="" id="closebutton">
                                <a data-original-title="Close forecast" title="Close forecast" data-placement="bottom" data-toggle="tooltip" href="#" class="ctooltip">
                                    <div class="toolIcon">
                                        <i class="fa fa-times-circle-o gi-2x" style="font-size: 1.6em; color: #428BCA;"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Close</div>
                                            <div class="toolDesc">Close forecast</div>
                                        </div>
                                    </a></li>

                                     <li class=""><a data-original-title="Help" title="Help" data-placement="bottom" data-toggle="tooltip" href="#" class="ctooltip">
                                        <div class="toolIcon"><i class="fa fa-question-circle  gi-2x" style="font-size: 1.6em; color: #428BCA;"></i></div>
                                        <div class="toolContent">
                                            <div class="tooltitle">Help</div>
                                            <div class="toolDesc">Generic forecast help</div>
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
