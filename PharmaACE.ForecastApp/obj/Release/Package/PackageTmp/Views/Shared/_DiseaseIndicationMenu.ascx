<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<PharmaACE.ForecastApp.Models.DiseaseIndicationMapper>>" %>

<script type="text/javascript" src="../../Scripts/lib/jquery/jquery.metisMenu.js" defer="defer"></script>
<script type="text/javascript" src="../../Scripts/custom/custom.js" defer="defer"></script>
<script type="text/javascript" src="../../Scripts/custom/template.js" defer="defer"></script>
<style>
    ul.nav-second-level .diesmenuseconitem{display:none !important;}
    .kmBox47{height: 28px!important; border-bottom-right-radius: 0px;
      margin-top: 0px;   
    vertical-align: middle;
    padding: 4px 15px;
    font-weight: bold;
    border-bottom: 0px;}
    .kmBox48{height: 28px!important; border-bottom-left-radius: 0px;}
    .kmBox44 a{padding:0px !important;}
    .kmBox49{width:320px}
    .kmBox50{margin-top:15px;}
    .kmBox51{width:540px}
    #main-menu ul .fa.arrow{position:absolute; top:4px; right:5px; color:#fff;}
    #main-menu .nav-third-level>li>a{padding:4px 15px 4px 60px}
    #main-menu .nav-second-level li.active .fa.arrow::before{content:"\f077";}

</style>
<div class="modal" id="addIndicationModal" tabindex="-1">
      <div class="modal-dialog kmBox49">
         <form id="addIndicationFormId" onsubmit="addNewIndication();return false;" method="post" role="form">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close modclose" data-dismiss="modal" aria-hidden="true" >×</button>
                  <h4 class="modal-title modtitle" id="addIndicationModalLabel">Add Indication</h4>
               </div>
               <div class="modal-body">
                  <input type="text" id="txtFolderNameAddIndication" required="required" name="name" style="width:100%;" onkeypress='return event.charCode!=62 && event.charCode!=60 && event.charCode!=58 && event.charCode!=124 && event.charCode!=63 && event.charCode!=42 && event.charCode!=34 && event.charCode!=92 && event.charCode!=47'maxlength="255"/> 
                  <input type="text" id="txtParentAddIndication" style="display:none;width:100%;" name="name" />
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                  <button type="button" id="btnRenameModalClose" class="btn btn-default" data-dismiss="modal" style="display:none"> Close</button> 
                  <input type="submit"  class="btn btn-primary" value="Add"/>
               </div>
            </div>
         </form>
      </div>
   </div>
 <button type="button" style="display:none" class="btn btn-primary btn-lg" id="btnAddIndication" data-toggle="modal" data-target="#addIndicationModal"></button>

<div class="modal" id="addSubIndicationModal" tabindex="-1">
      <div class="modal-dialog kmBox49">
         <form id="addSubIndicationFormId" onsubmit="addNewSubIndication();return false;" method="post" role="form">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close modclose" data-dismiss="modal" aria-hidden="true" >×</button>
                  <h4 class="modal-title modtitle" id="addSubIndicationModalLabel">Add Sub Indication</h4>
               </div>
               <div class="modal-body">
                  <input type="text" id="txtFolderNameAddSubIndication" required="required" name="name" style="width:100%;" onkeypress='return event.charCode!=62 && event.charCode!=60 && event.charCode!=58 && event.charCode!=124 && event.charCode!=63 && event.charCode!=42 && event.charCode!=34 && event.charCode!=92 && event.charCode!=47'maxlength="255"/> 
                  <input type="text" id="txtParentAddSubIndication" style="display:none;width:100%;" name="name" />
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                  <button type="button" id="btnSubIndicationModalClose" class="btn btn-default" data-dismiss="modal" style="display:none"> Close</button> 
                  <input type="submit" class="btn btn-primary" value="Add"/>
               </div>
            </div>
         </form>
      </div>
   </div>
 <button type="button" style="display:none" class="btn btn-primary btn-lg" id="btnAddSubIndication" data-toggle="modal" data-target="#addSubIndicationModal"></button>


<div class="modal" id="addDiseaseAreaModal" tabindex="-1">
      <div class="modal-dialog kmBox51">
         <form id="addDiseaseAreaFormId" onsubmit="AddNewDiseaseArea();return false;" method="post" role="form">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close modclose" data-dismiss="modal" aria-hidden="true" >×</button>
                  <h4 class="modal-title modtitle" id="addDiseaseAreaModalLabel">Add New Disease Area</h4>
               </div>
               <div class="modal-body">
                   <label  class="control-label">Enter Disease Area</label>
                  <input type="text" id="txtNameDiseaseArea"  name="name" required="required" style="width:100%;" onkeypress='return event.charCode!=62 && event.charCode!=60 && event.charCode!=58 && event.charCode!=124 && event.charCode!=63 && event.charCode!=42 && event.charCode!=34 && event.charCode!=92 && event.charCode!=47'maxlength="255"/> 
                  <input type="text" id="txtParentDiseaseArea" style="display:none;width:100%;" name="name" />

                 <label class="control-label kmBox50">Enter Indication</label>
                   <input type="text" id="txtNameDiseaseIndication" required="required" name="name" style="width:100%;" onkeypress='return event.charCode!=62 && event.charCode!=60 && event.charCode!=58 && event.charCode!=124 && event.charCode!=63 && event.charCode!=42 && event.charCode!=34 && event.charCode!=92 && event.charCode!=47'maxlength="255"/> 
                  <input type="text" id="txtParentDiseaseIndication" style="display:none;width:100%;" name="name" />
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                  <button type="button" id="btnAddDiseaseAreaModalClose" class="btn btn-default" data-dismiss="modal" style="display:none"> Close</button> 
                  <input type="submit" class="btn btn-primary" value="Add"/>
               </div>
            </div>
         </form>
      </div>
   </div>
 <button type="button" style="display:none" class="btn btn-primary btn-lg" id="btnAddDiseaseArea" data-toggle="modal" data-target="#addDiseaseAreaModal"></button>





<div id="leftmenu" class="col-md-3" style="overflow:hidden;">
    <%if (Session["RoleId"].ToString() == "3")
        { %>
    <div class="input-group kmBox46" >
       
        <span class="input-group-btn">
            <button class="btn btn-default kmBox47" type="button" value="Add" onclick="setPopupForDiseaseArea();">
                Add
            </button>
        </span>

    </div>
    <%} %>

    <nav class="navbar-default navbar-side" role="navigation">
        <div class="navbar-header">
            <button data-target=".sidebar-collapse" data-toggle="collapse" class="navbar-toggle" type="button">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="sidebar-collapse">
            
             <ul class="nav" id="main-menu" style=" height:446px;">
                  <% if(Model!=null){%>
                    <% foreach (var item in Model.ToList()) {%>
                  <li>
                     
                      <a href="#"><span class="atext"><%= item.DiseaseName %><% if(item.Indications .Count >=1){ %></span><span class="fa arrow"></span> <%} %></a>
                      <% if(item.Indications.Count > 0){ %>
                      <ul diseaseId="<%=item.DiseaseAreaId%>" class="nav nav-second-level collapse" >
                           <% foreach (var ind in item.Indications) {%>                        
                          <li indicationName="<%=ind%>">
<%--                             <a href="#"><span class="atext"><%=ind %></span><span></span> </a>--%>
                            <a href="#"><span class="atext"><%=ind %></span><span></span> </a>

<%--                              <%: Html.ActionLink(ind , "DiseaseDetail", "DiseaseArea", new { DiseaseName = ind ,SearchType=0}, null) %>--%>
                              <span class="fa arrow" id="'<%="SecondArrow"+ind%>" onclick="ShowSecondaryIndication(<%=item.DiseaseAreaId%>,&quot;<%=ind%>&quot;)"></span>

                                  <%if (Session["RoleId"].ToString() == "3")
                                   { %>                        
                            <div class="kmBox44"><a href="#" title="Add New Subindication" class="kmBox45"><i  class="fa fa-plus kmBox45" aria-hidden="true" onclick="setAddSubIndicationPopup('<%=item.DiseaseAreaId%>','<%=ind%>')" ></i>
                        </a></div>
                               <%} %> 
                          </li> 
                            <%} %>
                      </ul>
                      <%if (Session["RoleId"].ToString() == "3")
                          { %>
                      <div class="kmBox44"><a href="#" title="Add New Indication" class="kmBox45"><i  class="fa fa-plus kmBox45" onclick="setAddIndicationPopup('<%=item.DiseaseAreaId%>');" dis=""aria-hidden="true"></i></a></div>
                
                      <%} %>
                  
                  
                  </li>
                  <%} %>
                 <%} %>
             </ul>
            <%} %>

      
        </div>
    </nav>
</div>
<script>

    var diseaseAreaIdForNewInd = "";
    var primaryIndication = "";

    
    function setPopupForDiseaseArea()
    {
        document.getElementById('txtNameDiseaseArea').value = "";
        document.getElementById('txtNameDiseaseIndication').value = "";
        $('#btnAddDiseaseArea').click();
    }

   function GetDiseaseData(diseaseId, secondIndName, searchType)
    {

       var postData = JSON.stringify({ "diseaseId": diseaseId, "secondIndName": secondIndName, "searchType": searchType });

        PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/DiseaseArea/DiseaseDetailBySecondaryInd", postData,
          function (result) {
              if (result.success) {
               //   appendSecondaryIndication(result.result, diseaseAreaId, primaryIndName);
              }

          },
          function (result) {

          });
      
    }



    function appendSecondaryIndication(secondaryIndications, diseaseAreaId, primaryIndName)
   {
       
        var str = "";
        var ind = $('[indicationName="' + primaryIndName + '"]');

        if ($(ind).children("ul").length == 0) {

            str += "<ul class='nav nav-third-level collapse'>";

            secondaryIndications.forEach(function (SecondIndication) {
                str += '<li indicationName="' + SecondIndication.secondaryIndicationName + '"><a class="mainSubmeu" href="/DiseaseArea/DiseaseDetailBySecondaryInd?diseaseId=' + diseaseAreaId + '&secondIndName=' + SecondIndication.secondaryIndicationName + '" >' + SecondIndication.secondaryIndicationName + '</a></li>';
                                                                                                                    //href="/UserWorkSpace/openFile?objectId={0}&extn={1}"'.replace('{0}', content.ObjectId).replace('{1}', content.Extn.toLowerCase()) + ' target="_blank">' 
            })
            str += '</ul>';
            ind.append(str);

            //  $(ind).toggleClass('active');
            $(ind).addClass('active');
             $(ind).find('.nav-third-level.collapse').toggleClass('in').fadeIn(50);

           
            
        }
    }

    function ShowSecondaryIndication(diseaseAreaId, primaryIndName)
    {
       
        var ind = $('[indicationName="' + primaryIndName + '"]');

        if ($(ind).children("ul").length == 0) {
       

        var postData = JSON.stringify({ "primaryIndication": primaryIndName, "diseaseAreaId": diseaseAreaId });

        PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/DiseaseIndicationMenu/GetSecondaryIndication", postData,
          function (result) {
              if (result.success) {
                  appendSecondaryIndication(result.result, diseaseAreaId, primaryIndName);
              }
                 
          },
          function (result) {
              PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to get data", '');

          });
        }
       
     
    }

    function setAddSubIndicationPopup(diseaseAreaId,primaryIndName)
    {
        document.getElementById("txtFolderNameAddSubIndication").value = "";
        diseaseAreaIdForNewInd = diseaseAreaId;
        primaryIndication = primaryIndName;
        $('#btnAddSubIndication').click();
    }

    function addNewSubIndication() {
        var newSubIndicationName =(document.getElementById("txtFolderNameAddSubIndication").value).trim();


        if (newSubIndicationName == "" || newSubIndicationName == undefined) {
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter new sub indication name", '');

        }
        else {
            var postData = JSON.stringify({ "newSubIndicationName": newSubIndicationName,"primaryIndication":primaryIndication,"diseaseAreaId": diseaseAreaIdForNewInd });

            PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/DiseaseIndicationMenu/AddNewSubIndication", postData,
              function (result) {
                  if (result.success) {
                      if (result.result == 0) {
                          hideModal('addSubIndicationModal');
                          PHARMAACE.FORECASTAPP.UTILITY.popalert("New sub indication added successfully", '');
                      }
                  }
                  else if (result.result == 1) {
                      hideModal('addSubIndicationModal');
                      PHARMAACE.FORECASTAPP.UTILITY.popalert("Sub indication with same name already exists", '');
                  }
                  else {
                      hideModal('addSubIndicationModal');
                      PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to add", '');
                  }
              },
              function (result) {
                  hideModal('addSubIndicationModal');
                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to ádd", '');
              });
        }
        diseaseAreaIdForNewInd = "";
    }


    function addNewIndication()
    {
        var newIndicationName =(document.getElementById("txtFolderNameAddIndication").value).trim();


        if (newIndicationName == "" || newIndicationName == undefined) {
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter new indication name", '');

        }
        else {
            var postData = JSON.stringify({ "newIndicationName": newIndicationName, "diseaseAreaId":diseaseAreaIdForNewInd });

            PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/DiseaseIndicationMenu/AddNewIndication", postData,
              function (result) {
                  if (result.success) {
                      if (result.result == 0) {
                          hideModal('addIndicationModal');
                          var newAdded = '<li><a class="diesmenuseconitem"></a><a href="/DiseaseArea/DiseaseDetail?DiseaseName='+newIndicationName+';SearchType=0">'+newIndicationName+'</a></li>';
                         
                          PHARMAACE.FORECASTAPP.UTILITY.popalert("New indication added successfully", '');
                      }
                  }
                  else if (result.result == 1) {
                      hideModal('addIndicationModal');

                      PHARMAACE.FORECASTAPP.UTILITY.popalert("Indication with same name already exists", '');
                  }
                  else {
                      hideModal('addIndicationModal');
                      PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to add", '');
                  }
              },
              function (result) {
                  hideModal('addIndicationModal');
                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to ádd", '');
              });

        }
        diseaseAreaIdForNewInd = "";
    }

    function setAddIndicationPopup(diseaseAreaId)
    {
        document.getElementById("txtFolderNameAddIndication").value = "";
        diseaseAreaIdForNewInd = diseaseAreaId;
        $('#btnAddIndication').click();
    }

       function AddNewDiseaseArea()
    {
           var newDiseaseAreaName =(document.getElementById('txtNameDiseaseArea').value).trim();
          
           var newIndName =(document.getElementById('txtNameDiseaseIndication').value).trim();

           if (newDiseaseAreaName== "" || newDiseaseAreaName== undefined || newIndName=="" ||newIndName==undefined)

        {
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter required values", '');

        }
        else

        {
               var postData = JSON.stringify({ "newDiseaseAreaName": newDiseaseAreaName, "newIndName": newIndName });

            PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/DiseaseIndicationMenu/AddNewDiseaseArea", postData,
                  function (result) {
                      if (result.success) {
                          if (result.result > 0) {
                              hideModal('addDiseaseAreaModal');
                              $('#sidemenu').load('/DiseaseIndicationMenu/_DiseaseIndicationMenu');
                             
                              PHARMAACE.FORECASTAPP.UTILITY.popalert("Successfully added disease area", '');
                          }
                      }
                      else {
                          if (result.result == -1) {
                              hideModal('addDiseaseAreaModal');
                              PHARMAACE.FORECASTAPP.UTILITY.popalert("Disease area with same name already exists", '');
                          }
                          else {
                              hideModal('addDiseaseAreaModal');
                              PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to add", '');
                          }
                      }
                  },
                  function (result) {
                      hideModal('addDiseaseAreaModal');
                      hideOverlay();
                      PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to add", '');
                  });
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

       function getIndicationsForNewDisease(newDiseaseId)
       {
           PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/DiseaseIndicationMenu/GetIndications", { "newDiseaseId": newDiseaseId },
          function (result) {
              if (result.success) {
                  if (result.result == 0) {
                      var newAdded = '<li><a class="diesmenuseconitem"></a><a href="/DiseaseArea/DiseaseDetail?DiseaseName=' + newIndicationName + ';SearchType=0">' + newIndicationName + '</a></li>';

                      PHARMAACE.FORECASTAPP.UTILITY.popalert("New indication added successfully", '');
                  }
              }
              else if (result.result == 1) {

                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Indication with same name already exists", '');
              }
              else {

                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to add", '');
              }
          },
          function (result) {
              PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to ádd", '');
          });


       }
     


  
    $(document).ready(function () {

        $('#leftmenu .navbar-toggle').click(function () {

            $('#leftmenu').toggleClass('colin');


        });

        //});
        $("#leftmenu #main-menu").niceScroll({
            cursorfixedheight: 70
        });
        
        $('.nav-second-level .arrow').click(function () {
           // if ($(this).parent().hasClass('active'))
           // {
            $(this).parent().toggleClass('active');

            if ($(this).parent().hasClass('active')) {
               $(this).parent().find('.nav-third-level.collapse').toggleClass('in').fadeIn(50);
            
            }
            else {
                $(this).parent().find('.nav-third-level.collapse').toggleClass('in').fadeOut(50);
               

            }
               // $('.nav-second-level li.active .nav-third-level.collapse').toggleClass('in');
           // }
           // else{
               // $('.nav-second-level li').removeClass('active');

            //}
            
        });

    });
   (function ($) {
       $(window).load(function () {
           PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery.nicescroll.min.js", function () {
               //$("#leftmenu #main-menu").mCustomScrollbar({
               //    setHeight: 440,
               //    theme: "dark-3"
               //});
               $("#leftmenu #main-menu").niceScroll({
                   cursorfixedheight: 70
               });
           });
       })
    })(jQuery);
</script>
  <style type="text/css">
/*
    #tab-scroller #botbar {
 overflow: auto;
 height: 440px;
}
*/
</style>
<%--<%: Scripts.Render("~/Scripts/leftMenuLIB") %>--%>