<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<div class="leftBox" id="treeforadvsearchpartial">
   <h5 class="titleHeading">By Project</h5>
   <%--//onchange="rootFolderListAdvSearch();--%>
   <select class="selectpicker"   data-live-search="true" data-size="8" title="Select Project" id="byfolder" multiple data-max-options="1" onchange="rootFolderListAdvSearch();" >
                          
   </select>
</div>
<div class="leftBox">
   <h5 class="titleHeading">By File Type</h5>
   <ul id="tree3" class="ulClass" >
      <%--<%=@Html.CheckBoxList("chkModels",(ViewBag.CarModel as List<SelectListItem>))%>--%>
      <%--<%=Html.CheckBoxList("chkModels",(ViewBag.CarModel as List<SelectListItem>,)%>--%>
      <%foreach (var folders in ViewBag.ExtensionType)
         {  %>                           
      <li class="reportli">
         <span class="radchek"><input type="checkbox" value=<%=folders.Value%>  name="filter-type" onchange="rootFolderListAdvSearch();"/><span class="rlitext"><%=folders.Text.Trim()%></span>              
         </span>
      </li>
      <%}%>
                           
   </ul>
</div>
<div class="leftBox">
   <h5 class="titleHeading">By Last Modified</h5>
   <ul id="tree4" class="ulClass" >
      <li  class="reportli"><span class="radchek"><input type="radio" class="flat" name="filter-lmodifiied" value="Last 3 days" id="Last3Days" onchange="rootFolderListAdvSearch();" /> <span class="rlitext">Last 3 days </span></span></li>
      <li  class="reportli"><span class="radchek"><input type="radio" class="flat" name="filter-lmodifiied" id="LastMonth" onchange="rootFolderListAdvSearch();" /> <span class="rlitext">Last Month </span></span></li>
      <li  class="reportli" id="daterangeid">
         <span class="radchek">
         <input type="radio" class="flat" name="filter-lmodifiied" id="filter-range" id="customdaterange" /> <span class="rlitext">Custom </span></span>
         <div class="cards hideClass" >
            <ol class="properties ">
               <input id="datepicker-start" name="daterange" type="text" placeholder="From" />
               <input id="datepicker-end" type="text" placeholder="To"  />
            </ol>
         </div>
      </li>
      <li  class="reportli"><span class="radchek"><input type="radio" class="flat" name="filter-lmodifiied" id="DateFilter" onchange="rootFolderListAdvSearch();" /> <span class="rlitext">All </span></span></li>
   </ul>
</div>
<div class="leftBox" >
   <h5 class="titleHeading">Shared With</h5>
   <ul id="tree5" class="ulClass" >
      <%foreach (var User in ViewBag.users)
         {  %>                           
      <li class="reportli">
         <span class="radchek"><input type="checkbox" value=<%=User.UserId%>  name="filter-type" onchange="rootFolderListAdvSearch();"/>
         <span class="rlitext">
         <%=User.FirstName.Trim()%> &nbsp; <%=User.LastName.Trim()%> 
         </span>
         </span>
      </li>
      <%}%>
      </ul>
</div>
