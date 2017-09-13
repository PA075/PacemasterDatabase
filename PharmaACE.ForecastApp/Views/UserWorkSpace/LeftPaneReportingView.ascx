<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<div class="leftBox" id="ReportingFolder">
   <h5 class="titleHeading">By Project</h5>
   <select class="selectpicker" data-live-search="true" data-size="8" id="byproject" multiple data-max-options="1" onchange="getSelProjForReportingDropdown()">
   </select>
</div>
<div class="leftBox">
   <h5 class="titleHeading">Filter Criteria</h5>
   <ul id="filter-criteria" class="ulClass">
      <li class="reportli"><span class="radchek">
         <input type="radio" class="flat1" name="filter-lmodifiied" value="Last 3 days" id="last3daysrep" checked="checked" />
         <span class="rlitext">Last 3 days </span></span>
      </li>
      <li class="reportli"><span class="radchek">
         <input type="radio" class="flat1" name="filter-lmodifiied" value="Last 7 days" id="last7daysrep" />
         <span class="rlitext">Last 7 days </span></span>
      </li>
      <li class="reportli"><span class="radchek">
         <input type="radio" class="flat1" name="filter-lmodifiied" value="Last 30 days" id="last30daysrep" />
         <span class="rlitext">Last 30 days </span></span>
      </li>
      <li class="reportli" id="daterangeidforreport">
         <span class="radchek">
         <input type="radio" class="flat1" name="filter-lmodifiied" id="filter-rangeforreport" />
         <span class="rlitext">Custom </span></span>
         <div class="cards hideClass">
            <ol class="properties ">
               <input id="datepicker-startforreport" name="daterange" type="text" placeholder="From"  />
               <input id="datepicker-endforreport" type="text" placeholder="To" />
            </ol>
         </div>
      </li>
   </ul>
</div>