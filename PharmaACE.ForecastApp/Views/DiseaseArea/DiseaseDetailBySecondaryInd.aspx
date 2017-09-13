<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<<PharmaACE.ForecastApp.Models.DiseaseDetails>
    >" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Disease Overview
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%--<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Constants.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.FeedEngine.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Constants.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.NewsFeed.js"></script>
    <script type="text/javascript" src="../../Scripts/lib/bootstrap/bootbox.js" defer></script>--%>
    <%: Scripts.Render("~/Scripts/KMDiseaseDetailScript")%>
 <%--   <script src="../../Scripts/custom/summernote.js"></script>--%>
    <script src="../../Scripts/jssor.slider-24.1.5.min.js"></script>
<%--    <link href="../../Content/CSS/jquery.fancybox.css" rel="stylesheet" />--%>
    <script src="../../Scripts/jquery.fancybox.pack.js"></script>

    <%--<script src="http://fancyapps.com/fancybox/source/jquery.fancybox.pack.js"></script>--%>
    <%--<link href="http://fancyapps.com/fancybox/source/jquery.fancybox.css" rel="stylesheet" />--%>
     <%: Styles.Render("~/Content/KMDieseasindicationCSS") %>
       <link href="../../Content/CSS/summernote.css" rel="stylesheet" />
    <script src="http://summernote.org/bower_components/summernote/dist/summernote.js"></script>
<%--    <link href="http://summernote.org/bower_components/summernote/dist/summernote.css" rel="stylesheet" />--%>
       <script src="../../Scripts/lib/jquery/jquery-ui.js"></script>
    <%--<link href="../../Content/CSS/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="../../Scripts/lib/bootstrap/bootstrap-multiselect.js"></script>--%>
    <script src="../../Scripts/lib/jquery/typeahead.bundle.min.js"></script>
    <script src="../../Scripts/lib/jquery/typeahead.tagging.js"></script>
    <link href="../../Content/CSS/typeahead.tagging.css" rel="stylesheet" />
    <style>
        #add_treatment_regimen i{font-size:2.0em;}
        .dataScroll{ max-height:412px; overflow-y:scroll; border:0px solid red;}
        #TreatmentRegemal2 textarea{height:50px; width:100%}
        .ddDiv11{ text-align:center; vertical-align:middle !important;width:200px}
        .ddDiv12{text-align: center; vertical-align:middle !important;}
        .multiselect-clear-filter{margin:0px;}
        .dropdown-menu {
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}
 
.dropdown-menu a {
   overflow: hidden;
   outline: none;
}
 
.additem input
{
   border:0;
   margin:-3px;
   padding:3px;
   outline: none;
   color: #000;
   width: 99%;
}
 
.additem:hover input
{
   background-color: #f5f5f5;
}
 
.additem .check-mark
{
   opacity: 0;
   z-index: -1000;
}
 
.addnewicon {
   position: relative;
   padding: 4px;
   margin: -8px;
   padding-right: 50px;
   margin-right: -50px;
   color: #aaa;
}
 
.addnewicon:hover {
   color: #222;
}
ul.tagging_ul li.tagging_tag:hover{cursor:pointer;}
.ui-autocomplete li:hover{color: #ffffff!important;background-color:#0097cf!important;}
.ui-autocomplete li:focus, .ui-autocomplete li:active{color: #ffffff!important;background-color:#0097cf!important;}



 .ui-autocomplete > li.ui-state-focus {
  background-color: #0097cf!important;
  color: #ffffff!important;
}

    </style>
    <script>

       
        var isdiseaseOverView=true;
        $(function () {
<%--           $('#DetailedIndication-content').html(PHARMAACE.FORECASTAPP.UTILITY.htmlDecode((PHARMAACE.FORECASTAPP.UTILITY.htmlDecode('<%:Model.diseaseIndicationInfo.DetailedIndication %>'))));--%>
                 
        });

    $(function () {
<%--           $('#DiseaseOverview-content').html(PHARMAACE.FORECASTAPP.UTILITY.htmlDecode((PHARMAACE.FORECASTAPP.UTILITY.htmlDecode('<%:Model.diseaseIndicationInfo.DiseaseOverview %>'))));--%>
<%--        $('#DiseaseOverview-content').htmlDecode('<%:Model.diseaseIndicationInfo.DetailedIndication %>');--%>
                    
        });
        function GetDetailedIndication()
        {
            var diseaseName=document.getElementById("DiseaseName").innerText;
           // var editedData=PHARMAACE.FORECASTAPP.UTILITY.htmlEncode($('.note-editable').html());
            var editedData=$('.note-editable').html();
            if(editedData !="" && editedData!=undefined)
            {
                var postData = JSON.stringify({ "editedData": editedData, "IndicationName" : diseaseName});

                PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/DiseaseArea/SaveEditedDetail", postData,
                  function (result) {
                      if (result.success) {
                          if (result.result==1) {
                              PHARMAACE.FORECASTAPP.UTILITY.popalert("Successfully Saved data", '');
                          }                     
                      }
                      else {
                     
                          PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to save", '');
                      }
                  },
                  function (result) {
                      hideOverlay();
                      PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to save", '');
                  });
            }
            else
            {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please insert data", '');

            }
            editedData="";
        }  

        function GetDiseaseOverview()
        {
            var diseaseName=document.getElementById("DiseaseName").innerText;
           // var editedData=PHARMAACE.FORECASTAPP.UTILITY.htmlEncode($('.note-editable').html());
            var editedData=$('.note-editable').html();
            if(editedData != "" && editedData!=undefined)
            {
            var postData = JSON.stringify({ "editedData": editedData, "IndicationName" : diseaseName});

            PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/DiseaseArea/SaveEditedDiseaseOverView", postData,
              function (result) {
                  if (result.success) {
                      if (result.result==1) {
                          PHARMAACE.FORECASTAPP.UTILITY.popalert("Successfully Saved data", '');
                      }                     
                  }
                  else {
                     
                      PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to save", '');
                  }
              },
              function (result) {
                  hideOverlay();
                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to save", '');
              });
            }
            else
            {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please insert data", '');

            }
            editedData="";
        }  


       
        function clickEditSubmit() {

            $('#edittedSubmit').click();
        }

        function showSection(current)
        {  isdiseaseOverView=true;
           // $('.alnRight .btn').css("display","none");
            $('#forSlider').css("display","none");
            $('.note-editor').css("display","none");
            $('#DieseasScrollspy li').removeClass('active');
            current.parentElement.classList.add('active');
            $('#sectionB').removeClass('active').removeClass("in").css("display","none");
            $('#sectionA').removeAttr('class').css("display","block");
        }
        function showSection1(current)
        {
            isdiseaseOverView=false;
            $('.alnRight .btn').css("display","block");
            $('#forSlider').css("display","block");
            $('#DieseasScrollspy li').removeClass('active');
            current.parentElement.classList.add('active');
            $('#sectionA').removeClass('active').removeClass("in").css("display","none");
            $('#sectionB').removeAttr('class').css("display","block");

        }

        function callSummerEditor(thisid,spanid)
        {
            if(isdiseaseOverView==true)
            {
                summerEditor('DiseaseOverview-content',thisid,spanid);
            }
            else
            {
                summerEditor('DetailedIndication-content',thisid,spanid);
            }




        }
        function callsubmit()
        {
            if(isdiseaseOverView==true)
            {
                GetDiseaseOverview();
            }
            else
            {
                GetDetailedIndication();
            }

        }
        function delCurrentRow(numrow) {
           
            $("#" + (numrow)).remove();
          
            if ($('#TreatmentRegemal2').height() > 380)
                $('#mstreat').addClass('dataScroll');
            else
                $('#mstreat').removeClass('dataScroll');
            
 
        }

        function summerEditor(contentid,thisparam,aid)
        {
            $(thisparam).toggleClass('showEditor');
            $('#'+contentid).toggleClass('toggled');
            if(($('#disarea .showEditor').length)>1)
            {
                $('#disarea .display-label a').removeClass('showEditor');
                $('#disarea .display-field').each(function( index ) {
                    $(this).removeAttr('style');
                    $(this).toggleClass('toggled');
                    $(this).summernote('destroy');
                });
                $('#'+aid).toggleClass('showEditor');
            }
         
            if($(thisparam).hasClass('showEditor'))
            {
                $('#'+contentid).prev().find('.alnRight').find('.btn').css("display","block");
                    

                var $placeholder = $('.placeholder');
                $('#'+contentid).summernote({
                    height: 130,
                    codemirror: {
                        mode: 'text/html',
                        htmlMode: true,
                        lineNumbers: true,
                        theme: 'monokai'
                    },
                    callbacks: {
                        onInit: function () {
                            $placeholder.show();
                        },
                        onFocus: function () {
                            $placeholder.hide();
                        },
                        onBlur: function () {
                            var $self = $(this);
                            setTimeout(function () {
                                if ($self.summernote('isEmpty') && !$self.summernote('codeview.isActivated')) {
                                    $placeholder.show();
                                }
                            }, 100);
                        }
                    }
                        

                   
                });
                
            }
            else
            {
               
                $('#'+contentid).prev().find('.alnRight').find('.btn').css("display","none");
                $('#'+contentid).removeAttr('style');
                $(this).toggleClass('toggled');
                $('#'+contentid).summernote('destroy');
                
            }
        }

        var hideInProgress = false;
        var showModalId = '';
        function showModal(elementId) {
            if (hideInProgress) {
                showModalId = elementId;
            } else {
                $("#" + elementId).modal("show");
            }
        }
        function hideModal(elementId) {
            hideInProgress = true;
            $("#" + elementId).on('hidden.bs.modal', hideCompleted);
            $("#" + elementId).modal("hide");
        }
        function hideCompleted(elementId) {
            hideInProgress = false;
            if (showModalId) {
                showModal(showModalId);
            }
            showModalId = '';
            $(elementId).off('hidden.bs.modal');
        }
       
        function buildtreatmentDetails(treatregId,treatmenRegimen,classSummary,molarr,isNewAddedRow) {
            var treatDetail;
                
            treatDetail = {
                treatRegId:treatregId,
                treatmentRegimen: treatmenRegimen,
                classSummary: classSummary,
                moleculeNames: molarr,
                isNewlyAdded:isNewAddedRow
            };

            return treatDetail;
        }
        function saveTreatmetRegimen()
        {
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are saving data", 'addTreamentRegimen', '15', '');

            var diseaseName=document.getElementById("DiseaseName").innerText;

            treatmentDetailsArray=[];
            var treatmentRegimen="";
            var classSummary="";
            var molecule="";
            $('#TreatmentRegemal2').find('tr').each(function () {
              
                var isNewAddedRow=0;
                var treatregId=0;
                if($(this).hasClass('newAdded'))
                {
                    isNewAddedRow=1;
                    treatregId=0;
                }
                else
                {
                    isNewAddedRow=0;
                    treatregId=$(this).attr('treatRegId');

                }
                if($(this).find('td:first').find('input').val()!=undefined)
                {
                     treatmentRegimen=$(this).find('td:first').find('input').val();

                }
                if (treatmentRegimen!="") {
                    if($(this).find('td:eq(1)').find('textarea').val()!=undefined)
                    {
                        classSummary=$(this).find('td:eq(1)').find('textarea').val();

                    }
                    if (classSummary!="") {
                        var moleculeArr=[];
                        $(this).find('td:eq(2)').find('ul.tagging_ul').find('li.tagging_tag').each(function(){
                            molecule=$(this).text().slice(0,-1);
                            if (molecule!="") {
                                moleculeArr.push(molecule);                               
                            }
                        });
                      if (moleculeArr.length!=0) {
                            treatmentDetailsArray.push(buildtreatmentDetails(treatregId,treatmentRegimen,classSummary,moleculeArr,isNewAddedRow));
                       }                      
              
                    }
                   
                }
              
               
            });

            if (treatmentDetailsArray === undefined || treatmentDetailsArray.length == 0) {
               
            }
            else
                {
                var postData = JSON.stringify({ "ListTreatmentdetails": treatmentDetailsArray,"indication":diseaseName});
               

                PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("/DiseaseArea/SaveTreatmentRegimen", postData,
               function (result) {
                   if (result.success) {
                       if (result.result==1) {
                           hideModal('addTreamentRegimen');
                           PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('addTreamentRegimen');
                           PHARMAACE.FORECASTAPP.UTILITY.popalert("Successfully Saved data", '');
                       }                     
                   }
                   else {
                       PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('addTreamentRegimen');
                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to save", '');
                   }
               },
               function (result) {
                   PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('addTreamentRegimen');
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to save", '');
               });
            }
        }
    </script>

 <div class="modal" id="addTreamentRegimen" tabindex="-1">
      <div class="modal-dialog kmBox43">
         <form id="treatmentDEtailFormId" onsubmit="return false;" method="post" role="form">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close modclose" data-dismiss="modal" aria-hidden="true" >×</button>
                  <h4 class="modal-title modtitle" id="addTreatmentLabel">Add Treatment Regimen</h4>
               </div>
               <div class="modal-body" id="mstreat">
                   <table class=" table table-bordered  dataTable table-striped box-shadow--6dp" role="grid" aria-describedby="example_info" id="TreatmentRegemal2">
                                <thead>
                                    <tr role="row">
                                        <th style="text-align: center; width:20%;">Treatment Regimens</th>
                                        <th style="text-align: center; width:42%">Class Summary</th>
                                        <th style="text-align: center; width:35%;">Molecules</th>
                                        <th style="text-align: center; width:3%"></th>
                                    </tr>
                                   

                                </thead>
                       
                      <tbody>
                                     <%

                                         if (Model.ExistTreatmentListData != null)

                                         {
                                             var cnt=0;
                                            
                                             foreach(var item in Model.ExistTreatmentListData)
                                             {
                                                 
                                                 var MoleCount = item.moleculeNames.Count;

                                                 %>
                           
                                         <tr id='<%="addtreatmentegimen"+ cnt %>' class="oldTreatmentRow" treatRegId='<%=item.treatRegId %>' isnewlyAdded=<%=item.isNewlyAdded %>>
                                         <td class="ddDiv11"><div class="ui-widget"><input id='<%="searchInput"+cnt%>' required="required" type="text" class="form-control  kmBox2" placeholder="Enter here" aria-describedby="ddlsearch" value='<%=item.treatmentRegimen%>' title='<%=item.treatmentRegimen%>'></div></td>
                                         <td class="ddDiv12"><textarea id='<%="classSummarytxt"+cnt%>' required="required"><%=item.classSummary %></textarea></td>
                                             <td style="text-align: center;">
                                                   <div class="ui-widget">
                                                        <input id='<%="searchInputMol"+cnt%>' required="required" class="tags-input" value="" style="display: none;">
                                                  <%--     <ul class="tagging_ul">--%>
                                             <%
                                                     var SearchCount = 1;
                                                 foreach (var molName in item.moleculeNames)
                                                 {
                                                     if (MoleCount!=SearchCount)
                                                     { %>

                                                              <%--<li class="tagging_tag"><%=molName.ToString() %><span class="tag_delete">x</span></li>--%>
                                                   <%  }

                                                     else
                                                     { %>
                                                    <%--        <li class="tagging_tag"><%=molName.ToString() %><span class="tag_delete">x</span></li>
                                                                                                  
    
                                                              <li class="tagging_new">
                                                               <span class="twitter-typeahead" style="position: relative; display: inline-block; direction: ltr;">
                                                                   <input type="text" class="tagging_new_input form-control tt-hint" readonly="" autocomplete="off" spellcheck="false" tabindex="-1" style="position: absolute; top: 0px; left: 0px; border-color: transparent; box-shadow: none; opacity: 1; ">
                                                                   <input type="text" class="tagging_new_input form-control tt-input" autocomplete="off" spellcheck="false" dir="auto" style="position: relative; vertical-align: top; background-color: transparent;">
                                                                   <pre aria-hidden="true" style="position: absolute; visibility: hidden; white-space: pre;  font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; word-spacing: 0px; letter-spacing: 0px; text-indent: 0px; text-rendering: auto; text-transform: none;"></pre>
                                                                   <span class="tt-dropdown-menu" style="position: absolute; top: 100%; left: 0px; z-index: 100; display: none; right: auto;">
                                                                       <div class="tt-dataset-tagging">
                                                                       </div>

                                                                   </span>

                                                               </span>

                                                           </li>--%>

                                                    <% }

                                                            SearchCount++;
                                                        }

                                                       %>
                                                    <%--</ul>--%>
                                                 </div>  </td>
                                               <td style="text-align: center; vertical-align: middle"><a class="btn" style="padding: 6px 4px; color: red;" onclick="delCurrentRow('<%="addtreatmentegimen"+cnt%>')" href="#"><i title="Remove" class="fa fa-times"></i></a></td>
                                            </tr>

                                    <% 



                                                cnt++;

                                            }
                                        }

                                         %>

                                </tbody>


                        
                    </table>

               </div>
               <div class="modal-footer">
                                     <a title="Add treatment regimen" class="pull-left" id="add_treatment_regimen" style="" href="#"><i class="fa fa-plus-circle gi-3x"  aria-hidden="true"></i></a>

                  <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                  <button type="button" id="btnassTreatmentRegimenModalClose" class="btn btn-default" data-dismiss="modal" style="display:none"> Close</button> 
                  <input type="submit" class="btn btn-primary" value="Add" onclick="saveTreatmetRegimen()"/>
               </div>
            </div>
         </form>
      </div>
   </div>

    <div class="container" id="contentbox" data-spy="scroll" data-target="DieseasScrollspy">

        <div class="row" id="SearchResult">
            <div class="kmBox5">

                <h2><span class="kmBox6" id="DiseaseName"><%= ViewData["DiseaseName"] %> </span></h2>
            </div>
            <div class="mw-body" id="DieseasScrollspy">
                <div class="Custom_well" id="overview" data-spy="affix" data-offset-top="30">
                    <ul class="nav nav-tabs kmBox7">
                        <li class="dropdown active">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#" onclick="return showSection(this)"><b>Disease Overview
                            </b></a>
                            <ul class="dropdown-menu">
                                <li><a data-toggle="tab" id="definition" href="#DefinitionQuickFacts">Definition and Quick Facts</a></li>
                                <li><a data-toggle="tab" id="risk" href="#RiskFactors">Risk factors </a></li>
                                <li><a data-toggle="tab" id="symptoms" href="#SymptomsDiagnosis">Symptoms and Diagnosis</a></li>
                                <li><a data-toggle="tab" id="staging" href="#StagingSegmentation">Staging and Segmentation</a></li>
                                <li><a data-toggle="tab" id="treatment" href="#TreatmentOverview">Treatment Overview</a></li>
                                <li><a data-toggle="tab" id="Compliance" href="#divCompliance">Compliance</a></li>
                                <li><a data-toggle="tab" id="DosingAndDot" href="#divDosingAndDot">Dosing And Dot</a></li>
                                <li><a data-toggle="tab" id="Pricing" href="#divPricing">Pricing</a></li>
                                <li><a data-toggle="tab" id="Events" href="#divEvents">Events</a></li>
                                <li><a data-toggle="tab" id="Probability" href="#divProbability">Probability</a></li>
                            </ul>
                        </li>

                        <%if (!string.IsNullOrEmpty(Model.diseaseIndicationInfo.DetailedIndication) && Session["RoleId"].ToString() != "3")
	                { %>
                        <li class="dropdown">
                            <a data-toggle="tab" class="" id="secb" href="#sectionB" onclick="return showSection1(this);"><b>Detailed Indication</b></a>
                        </li>
	                 <%}

                     else if( Session["RoleId"].ToString() == "3")
                     {%>
                        <li class="dropdown">
                            <a data-toggle="tab" class="" id="secb" href="#sectionB" onclick="return showSection1(this);"><b>Detailed Indication</b></a>
                        </li>
                    <%}
                      %>

                     <%--   <li class="dropdown">
                            <a data-toggle="dropdown" class="not-active" href="#"><b>Epidemiology</b></a>
                        </li>
                        <li class="dropdown">
                            <a data-toggle="dropdown" class="not-active" href="#"><b>Market</b></a>
                        </li>--%>
                    </ul>
                    <%if (Session["RoleId"].ToString() == "3")
                        { %>

                    <div style="width:39%; display: inline-block; padding-right: 10px;">
                        <span class="alnRight ">
                            <button type="button" id="submitEdited" onclick="callsubmit();" class="btn btn-default">Submit</button>
</span>
                        <span class="alnRight alignleft" id="secbc">
                 <button type="button" class="btn btn-default" onclick="callSummerEditor(this,'secbc')">Edit</button></span>                    
                                                 
                        
                    <span class="alnRight alignleft" id="treatmentreg">
                        <button type="button" class="btn btn-default" id="btnmodl" data-toggle="modal" data-target="#addTreamentRegimen">Add Treament Regimen</button>
                    </span>

                    </div>

            

                    </div>
                    <%} %>
                </div>
                <div>
                    <fieldset>
                        <div class="col-md-9" style="padding-left: 0px; word-break: keep-all;" id="disarea">
                            <div class="tab-content">
                                <div id="sectionA" class="tab-pane fade in active">
                                    <div class="display-label">
                                       </div>
                                     <div id="DiseaseOverview" class="comforDiv">
                                        <div class="display-field" style="word-break: keep-all;" id="DiseaseOverview-content">
                                            <%:Html.Raw(Model.diseaseIndicationInfo.DiseaseOverview)  %>
                                        </div>
                                    </div>
                               
                                </div>

                            <div>

                            </div>



                                <div id="sectionB" class="tab-pane fade">

                                    <div class="display-label">
                                       </div>
                                    <div id="DetailedIndication" class="comforDiv">

                                        <div class="display-field" style="word-break: keep-all;" id="DetailedIndication-content">
                                            <%: Html.Raw(Model.diseaseIndicationInfo.DetailedIndication)  %>
                                        </div>
                                    </div>
                                </div>



                                <div id="forSlider" class="ddDiv10">

                                    <script type="text/javascript">
                                        jssor_1_slider_init = function() {

                                            var jssor_1_SlideshowTransitions = [
                                              {$Duration:1200,$Opacity:2}
                                            ];

                                            var jssor_1_options = {
                                                $AutoPlay: 1,
                                                $SlideshowOptions: {
                                                    $Class: $JssorSlideshowRunner$,
                                                    $Transitions: jssor_1_SlideshowTransitions,
                                                    $TransitionsOrder: 1
                                                },
                                                $ArrowNavigatorOptions: {
                                                    $Class: $JssorArrowNavigator$
                                                },
                                                $BulletNavigatorOptions: {
                                                    $Class: $JssorBulletNavigator$
                                                }
                                            };

                                            var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);

                                            /*responsive code begin*/
                                            /*remove responsive code if you don't want the slider scales while window resizing*/
                                            function ScaleSlider() {
                                                var refSize = jssor_1_slider.$Elmt.parentNode.clientWidth;
                                                if (refSize) {
                                                    refSize = Math.min(refSize, 800);
                                                    jssor_1_slider.$ScaleWidth(refSize);
                                                }
                                                else {
                                                    window.setTimeout(ScaleSlider, 30);
                                                }
                                            }
                                            ScaleSlider();
                                            $Jssor$.$AddEvent(window, "load", ScaleSlider);
                                            $Jssor$.$AddEvent(window, "resize", ScaleSlider);
                                            $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
                                            /*responsive code end*/
                                        };
		
                                    </script>
                                
                                    <!-- Loading Screen -->
                                    <div id="jssor_1" class="ddDiv1">

                                        <div data-u="loading" class="ddDiv2" style=" background: url('../../sliderImages/loading.gif') no-repeat 50% 50%; "></div>
                                        <div data-u="slides" class="ddDiv3">

                                            <div>
                                                <a class="fancybox-thumb" rel="fancybox-thumb" href="../../sliderImages/1.jpg">
                                                    <img data-u="image" src="../../sliderImages/1.jpg" /></a>
                                            </div>
                                            <div>
                                                <a class="fancybox-thumb" rel="fancybox-thumb" href="../../sliderImages/2.jpg">
                                                    <img data-u="image" src="../../sliderImages/2.jpg" /></a>
                                            </div>
                                            <div>
                                                <a class="fancybox-thumb" rel="fancybox-thumb" href="../../sliderImages/3.jpg">
                                                    <img data-u="image" src="../../sliderImages/3.jpg" /></a>
                                            </div>
                                            <div>
                                                <a class="fancybox-thumb" rel="fancybox-thumb" href="../../sliderImages/4.jpg">
                                                    <img data-u="image" src="../../sliderImages/4.jpg" /></a>
                                            </div>

                                        </div>
                                        <!-- Thumbnail Navigator -->
                                        <!-- Bullet Navigator -->
                                        <div data-u="navigator" class="jssorb05 ddDiv4"  data-autocenter="1">
                                            <!-- bullet navigator item prototype -->
                                            <div data-u="prototype" class="ddDiv5"></div>
                                        </div>
                                        <!-- Arrow Navigator -->
                                        <span data-u="arrowleft" class="jssora12l ddDiv6" style="" data-autocenter="2"></span>
                                        <span data-u="arrowright" class="jssora12r ddDiv7" data-autocenter="2"></span>
                                    </div>
                                    <script type="text/javascript">jssor_1_slider_init();</script>

                                </div>
                            </div>
                            <%--------------------------------- New Changes-----------------------------------------------%>
                        </div>
                        <div class="col-md-3 ddDiv8">
                            <% if (Model.diseaseIndicationInfo.MediaDetails != null)
                                {%>
                            <%if (Model.diseaseIndicationInfo.MediaDetails.ImageByte != null)
                                { %>
                            <%var base64 = Convert.ToBase64String(Model.diseaseIndicationInfo.MediaDetails.ImageByte);%>
                            <div class="imagetd sideimagebox">
                                <img class="indimage" src="data:image/png;base64,<%=base64%>" alt="Image" />
                            </div>
                            <%} %>
                            <%if (Model.diseaseIndicationInfo.MediaDetails.VideoUrl != "NA")
                                { %>
                            <div class="videoid sideimagebox">
                                <%if (Model.diseaseIndicationInfo.MediaDetails.VideoUrl != "NA")
                                    {%>
                                <iframe width="100%" height="" src="<%= System.Web.HttpUtility.UrlDecode(Model.diseaseIndicationInfo.MediaDetails.VideoUrl).Replace("watch?v=", "embed/")%>" allowfullscreen="true" style="display: <%= String.IsNullOrEmpty(Model.diseaseIndicationInfo.MediaDetails.VideoUrl) ? "none" : ""%>"></iframe>
                                <%} %>
                            </div>
                            <%} %>
                            <div class="NewsFeedtd sideimagebox">
                                <div id="feedContainer">
                                    <script type="text/javascript">
                                        var feedParams = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultParams();
                                            <% var Searchword = ViewData["DiseaseName"].ToString().Replace("'", "%27");
                                        string FKeyword = "'";
                                        if (Searchword.Contains(" "))
                                        {
                                            string[] Keywords = Searchword.Split(' ');
                                            FKeyword += Keywords[0];
                                            for (int i = 1; i < Keywords.Length; i++)
                                            {
                                                FKeyword += "+" + Keywords[i];
                                            }
                                        }
                                        else
                                            FKeyword += Searchword;
                                        FKeyword += "'";
                                                %>
                                        var link = "https://news.google.com/news/feeds?pz=1&cf=all&q=" +<%=FKeyword%>.replace(/[^\x00-\x7F]/g, "") + "&qdr=a&ned=en_us&output=rss";
                                        feedParams.url = link;
                                        feedParams.title = "<%=ViewData["DiseaseName"].ToString().Trim()%>";
                                        feedParams.itemDescriptionOn = "off";
                                        if (!feedParams.feedCount || isNaN(feedParams.feedCount) || feedParams.feedCount < 1) {
                                            feedParams.count = PHARMAACE.FORECASTAPP.CONSTANTS.DEFAULT_FEED_COUNT;
                                        }
                                        var productFeedParams = PHARMAACE.FORECASTAPP.NEWSFEED.setCustomParams(feedParams);
                                        feedwind_show_widget_iframe(productFeedParams, 'feedContainer');
                                    </script>
                                </div>
                            </div>
                            <%} %>
                        </div>
                       <table style="width: 100%">
                            <tr style="width: 100%">
                                1
                            </tr>
                            <tr style="width: 100%">
                            </tr>
                            <tr>
                            </tr>
                        </table>
                        <br />
                        <div class="table" id="TreatmentOverview">
                            <h2>Summary</h2>
                            <table class=" table table-bordered  dataTable table-striped box-shadow--6dp table-hover" role="grid" aria-describedby="example_info" id="TreatmentOverview2">
                                <thead>
                                    <tr role="row">
                                        <th style="text-align: center;">Treatment Regimens</th>
                                        <th style="text-align: center;">Class Summary</th>
                                        <th style="text-align: center;">Molecules</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% foreach (var item in Model.diseaseTableData)
                                        { %>
                                    <tr>
                                        <td class="catlogo sorting_1 ddDiv9">
                                            <%: Html.DisplayFor(modelItem => item.TreatmentRegimens) %>
                                        </td>
                                        <td class="ddDiv9">
                                            <%: Html.DisplayFor(modelItem => item.ClassSummary) %>
                                        </td>
                                        <td id="moleculestd" class="ddDiv9">
                                            <%if ((item.ApprovedMolecules != null) && (item.ApprovedMolecules.ToString() != ""))
                                                {
                                                    string indicationName = ViewData["DiseaseName"].ToString();
                                                    for (int i = 0; i < item.ApprovedMolecules.Count; i++)
                                                    {
                                                        string Molecule = item.ApprovedMolecules[i].Molecule.Trim();
                                                        if (item.ApprovedMolecules[i].IsApproved)
                                                        {
                                                            if (i == item.ApprovedMolecules.Count - 1)
                                                            { %>
                                            <%: Html.ActionLink(Molecule, "GetDrugs", "Drugs", new { searchKey = Molecule.Trim(), searchParam = 2, searchCondition = 4, switchView = true, searchModule = 1 }, new { @class = "approved_Molecule", @title = "Approved for " + indicationName })%>
                                            <% }
                                                else
                                                { %>
                                            <%: Html.ActionLink(Molecule, "GetDrugs", "Drugs", new { searchKey = Molecule.Trim(), searchParam = 2, searchCondition = 4, switchView = true, searchModule = 1 }, new { @class = "approved_Molecule", @title = "Approved for " + indicationName })%>,
                                                           <% }
                                                               }
                                                               else
                                                               {
                                                                   if (i == item.ApprovedMolecules.Count - 1)
                                                                   { %>
                                            <%: Html.ActionLink(Molecule, "GetDrugs", "Drugs", new { searchKey = Molecule.Trim(), searchParam = 2, searchCondition = 4, switchView = true, searchModule = 1 }, null)%>
                                            <% }
                                                else
                                                { %>
                                            <%: Html.ActionLink(Molecule, "GetDrugs", "Drugs", new { searchKey = Molecule.Trim(), searchParam = 2, searchCondition = 4, switchView = true, searchModule = 1 }, null)%>,
                                                           <% }  %>
                                            <% } %>
                                            <% } %>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>





                        <%-- references to be checked--%>

                       <%-- <% if (Model.diseaseDetails.References != null)
                            {
                                var refArray = Model.diseaseDetails.References.Split();
                                //var abc = System.Web.HttpUtility.HtmlDecode(Model.diseaseDetails.References);
                                // var refe = Html.Raw(refArray);

                        %>
                        <div class="display-label ddDiv9" >
                            <h2><%: Html.DisplayNameFor(model => model.diseaseDetails.References) %></h2>
                        </div>
                        <div class="display-field ddDiv9">
                            <% 
                                var str = "";
                                int i = 1;
                                foreach (var value in refArray)
                                {

                                    string output = value.Substring(value.IndexOf(".") + 1);

                                    if (i <= refArray.Count())
                                    {
                                        str += ("<div><a href=\"" + output + "\" target=\"_blank\"  title=\"" + output + "\">" + i + "." + output + "</a></div>");
                                        i++;
                                    }

                                   
                                }%>
                            <%: Html.Raw(str)  %>
                        </div>
                        <% } %>
                    </fieldset>
                </div>
            </div>
            <br />
            <br />--%>

            <div id="back-to">
                <% if (Session["DSearchPage"].ToString() == "DiseaseAreaIndex")
                    {%>
                <%if (int.Parse(ViewData["SearchType"].ToString()) == 1)
                    { %>
                <%: Html.ActionLink("Back to Search", "Index", new { ReturnBack = true }) %>
                <%}
                    else
                    { %>
                <%: Html.ActionLink("Back to Search", "Index") %>
                <%} %>

                <%  }
                    else
                    { %>
                <a href="<%=Url.Action("Index", "KM", new { returnBack = true,searchType=1 })%>">
                    <button type="button" class="btn btn-primary btn-arrow-left">Back</button></a>

                <%} %>
            </div>
        </div>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script type="text/javascript">
        var DBArray=[];
        $(document).ready(function () {
            var moleculeArr=[];
           
           <%
        foreach (var item in Model.molecules)
        {
            var str = item.moleculeName;
          
            str = str.Replace("\n", " ");
            
            str = str.TrimStart();
            str = str.TrimEnd();
          
            %>
           
            moleculeArr.push("<%=String.Join("\\\"", str.Split(new char[] { '"' })) %>");

            <%
        }
        foreach (var item in Model.ExistTreatmentListData)
        {

            var str1 = "";
            foreach (var mol in item.moleculeNames)
            {
                if (str1 == "")
                {
                    str1 = mol;
                }
                else
                {
                    str1 =  str1 + ","  + mol.ToString();
                }
               
            }


            str1 = str1.Replace("\n", " ");

            str1 = str1.TrimStart();
            str1 = str1.TrimEnd();

            %>
           
            DBArray.push("<%=String.Join("\\\"", str1.Split(new char[] { '"' })) %>");

            <%
             }
      
        
        %>
           
            
          var treatmentRegimenArr=[];
           <%
        foreach (var item in Model.regimens)
        {
            var str = item.treatmentRegimen;
          
            str = str.Replace("\n", " ");
            
            str = str.TrimStart();
            str = str.TrimEnd();
            
            %>
           
            treatmentRegimenArr.push("<%=String.Join("\\\"", str.Split(new char[] { '"' })) %>");

            <%
             }
            
        %>

            
            var rowCount = $('#TreatmentRegemal2 tr').length;
           
            for (var i = 0; i < rowCount; i++)
            {                
                $('#searchInputMol' + i).tagging(moleculeArr);

            }
            $('#TreatmentRegemal2').find('tr').each(function () {
                
                $(this).find('td:first').find('input').autocomplete({
                    
                    source: treatmentRegimenArr
                    
   
                });
               
                var index =$(this).index();
              
                var fullMol=(DBArray[index]).split(",");
               
                for (var j = 0; j < fullMol.length; j++) {

                    $("<li class='tagging_tag' title='"+ fullMol[j] +"'>" +  fullMol[j] + "<span class='tag_delete'>x</span></li>").appendTo('#' + $(this).attr('id') + ' ul.tagging_ul');
                    }
            });

            $('#getTreatmentRegimen0').selectpicker({
                style: 'btn-info',
                size: 5
            });
            ;
            
            var count=rowCount;
            $("#add_treatment_regimen").click(function () {
                $('#TreatmentRegemal2 tbody').append('<tr id="addtreatmentegimen' + (count) + '" class="newAdded"></tr>');
               
                $('#addtreatmentegimen' + count).html(

                      '<td class="ddDiv11"><div class="ui-widget"><input id="searchInput'+count+'" type="text"  class="form-control  kmBox2" placeholder="Enter here" aria-describedby="ddlsearch"></div></td>'
                      +'<td style="text-align: center;"><textarea id="classSummarytxt'+count+'" ></textarea></td>'
                      +'<td style="text-align: center;"><div class="ui-widget"><input id="searchInputMol'+count+'" class="tags-input" value=""></div></td>'
                      +'<td style="text-align: center; vertical-align: middle"><a class="btn" style="padding: 6px 4px; color: red;" onclick="delCurrentRow('+"'"+"addtreatmentegimen"+count+"'"+')" href="#"><i title="Remove" class="fa fa-times"></i></a></td>'


               );
                $('#TreatmentRegemal2 tbody').append('<tr id="addtreatmentegimen' + (count+1) + '" class="newAdded"></tr>');
               
                $('#searchInputMol'+count+'').tagging(moleculeArr);

                $('#searchInput'+count+'' ).autocomplete({
                    source: treatmentRegimenArr
                });
                 count++;
               
                if ($('#TreatmentRegemal2').height() > 380)
                    $('#mstreat').addClass('dataScroll');
                else
                    $('#mstreat').removeClass('dataScroll');
            });

           


            $('.alnRight .btn').css("display","block");
           

            $(document).on('click', '#overview ul ul a[href^="#"]', function (e) {
                var id = $(this).attr('href');
                var $id = $(id);
              
                if ($id.length === 0) {
                    return;
                }
                e.preventDefault();
                if($('#DieseasScrollspy .Custom_well').hasClass('affix'))
                    var pos = $(id).offset().top -100;
                else
                    var pos = $(id).offset().top -212;
                $('body, html').animate({ scrollTop: pos }, 0);
            });
            
        });

        $(".fancybox-thumb").fancybox({
            prevEffect	: 'none',
            nextEffect	: 'none',
            'loop': false,
            helpers	: {
                title	: {
                    type: 'outside'
                },
                thumbs	: {
                    width	: 50,
                    height	: 50
                }
            }
        });
    </script>
</asp:Content>
