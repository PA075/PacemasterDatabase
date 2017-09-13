<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<PharmaACE.ForecastApp.Models.ShareModel>" %>

<div id="shareModal" class="modal" tabindex="-1">
    <div class="modal-dialog" style="width: 575px;">
        <div id="shareContentId" class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="closebtnShare">×</button>
                <% if (Model.ShareType.ToString() == "Forecast")
                    {%>
                <h4 id="shareModalTitle" class="modal-title">Assign Permission</h4>
                    <%}else
                    {%>
                <h4 id="shareModalTitleUW" class="modal-title">Assign permission for : <%=Model.Name%></h4>
                    <%}
                 %>
                
            </div>
                <form role="form">
                    <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                             <% if (Model.ShareType.ToString() == "Forecast" )
                                 { %>
                        <div class="col-xs-12 col-md-12">
                            <div class="col-xs-4 col-md-4" style="padding-left:0px;">
                                 
                                  <select id="projectList" data-actions-box="true" class="selectpicker divForecast form-control simport"   data-size="5" aria-expanded="false" style="width: 266px;" onchange="updateVersionsForShare();">
                                                    </select>
                                
                                </div>
                            <div class="col-xs-5 col-md-5" id="VersionListid" style="padding-right:0px;">
                                
            <select style="float:right;"   id="VersionList" class="form-control" multiple data-size="5" data-max-options="1" data-header="Select a Version" data-actions-box="true" onchange="showSharePermissions();">
                   </select>
                                </div>
                            <%--<div class="col-xs-3 col-md-3">
                                <input  type="checkbox" id="shareAllProject" name="All-Project" value="All-Project"/><span style="margin-left:14px;">All Version</span>
                            </div>--%>
                        </div>
                            <%}%>
                    </div>
                            <div class="">

                           <table class="table table-striped" id="prdverid" data-toggle="table" data-click-to-select="true">
                               <%-- <thead>
                                    <tr>
                                        
                                        <th data-field="name">Name</th>
                                        <th data-field="stargazers_count">Email</th>
                                         <th style="padding-left: 0px;" data-field="Viewonly">Permission</th>
                                         <th data-field="Share_All"></th>
                                       

                                    </tr>
                                </thead>--%>
                                <tbody>    
                                <tr id="autocompleteSearchBox">
                                    <td colspan="5" style="padding-left:0px; padding-right:0px; padding-bottom:0px;">  
                                 <%-- <input type="text" class="form-control ui-widget" id="inputPassword" placeholder="Name to share with" style="width:100%;">--%>
                                         <input type="text" class="form-control ui-widget" id="inputPassword" onkeydown="pressed();" placeholder="Name to share with" style="width:100%;">
                                    </td></tr>  
                                     <tr id="tableHead">
                                        
                                        <th data-field="name">Name</th>
                                        <th data-field="stargazers_count">Email</th>
                                         <th style="padding-left: 0px;" data-field="Viewonly">Permission</th>
                                         <th data-field="Share_All"></th>
                                    </tr> 
                                </tbody>
                            </table>
                        </div>
                    </div>
                 </div>
                </form>
            <div id="sharePpoupFooterId"class="modal-footer">
                <button type="button" id="closeShare" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                <button id="unsharedoc1" type="button" class="btn btn-primary"  onclick="shareDocumentWithSelectedUsers();">Done</button>
            </div>
        </div>
    </div>
</div>
<style>
    .ui-autocomplete{z-index:9999; max-width:320px !important; width:320px !important; }
   .ui-autocomplete li{width:100% !important;}
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

</style>
