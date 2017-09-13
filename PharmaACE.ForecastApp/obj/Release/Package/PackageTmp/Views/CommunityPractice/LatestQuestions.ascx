<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<PharmaACE.ForecastApp.Models.CommunityPractice>" %>
<div class="form-wrapper1"><a role="button" id="community" href='<%=Url.Action("AskQuestion", "CommunityPractice")%>'>Ask a Question</a></div>
<div class="cmqDiv1">Filter by&nbsp;&nbsp;&nbsp;</div>
<div class="cmqDiv2" id="CategoryListParent">
   <%if (Model.questionList.Count() <= 0)
      { %>
   <select id="CategoryList" data-actions-box="true" class="selectpicker form-control" data-size="5" aria-expanded="false">
   <%}
      else
      { %>
   <select id="CategoryList" onclick="categoryFilter(this)" data-actions-box="true" class="selectpicker form-control" data-size="5" aria-expanded="false">
      <%} %>
      <option class="item" id="0" >Select Categories</option>
      <option class="item" id="1"><a>Basics<span class="grey-arrow"></span></a> </option>
      <option class="item" id="2"><a>Forecasting<span class="grey-arrow"></span></a></option>
      <option class="item" id="3"><a>Knowledge Base<span class="grey-arrow"></span></a></option>
      <option class="item " id="4"><a>Market Monitor<span class="grey-arrow"></span></a></option>
   </select>
</div>
<table id="questionlistBox" class="table-striped table-bordered" cellspacing="0" width="100%">
   <thead style="display:none;">
      <tr>
         <th>First name</th>
      </tr>
   </thead>
   <tbody>
      <%if(Model.questionList .Count() >0){ %>
      <% foreach (var item in Model.questionList)
         { %>
      <tr>
         <td class="qa-q-list-item" id="<%item.QuestionId.ToString(); %>" >
            <div class="qa-q-item-main">
               <%
                  if (item.AnswerCount == 0)
                  { %>
               <span title="Open" class="dwqa-status dwqa-status-open">Open</span>
               <% }
                  else
                  {
                  
                  %>
               <span title="Answered" class="dwqa-status dwqa-status-answered">Answered</span>
               <% }
                  %>
               <span class="qa-a-count qa-a-count-zero">
               <span class="qa-a-count-data"><%:item.AnswerCount%></span><span class="qa-a-count-pad"> answers</span>
               </span>
               <div class="qa-q-item-title">
                  <a href="CommunityPractice/ViewAnswer/<%:item.QuestionId%>"><span title=''><%:item.QuestionTitle%></span></a>
               </div>
               <span class="qa-q-item-avatar-meta" >
               <span class="qa-q-item-meta" >
               <span class="qa-q-item-what">asked on</span>
               <span class="qa-q-item-when">
               <span class="qa-q-item-when-data"><b><span class="questionPostTimetxt value-title" title="">
               <%var dateStr = (item.PostDate).Month + "/" + (item.PostDate).Day + "/" + (item.PostDate).Year + " " + (item.PostDate).Hour + ":" + (item.PostDate).Minute + ":" + (item.PostDate).Second; %> <%--common date format mm/dd/yyyy(JS not takes dd-mm-yy)--%>
               <%:dateStr%>
               </span></b><%--<span class="qa-q-item-when-pad">ago</span>--%>
               </span>
               <span class="qa-q-item-where">
               <% string QuestionCategory = string.Empty;
                  if (item.QuestionCategory == 1)
                  QuestionCategory = "Basics";
                  else if (item.QuestionCategory == 2)
                  QuestionCategory = "Forecasting";
                  else if (item.QuestionCategory == 3)
                  QuestionCategory = "Knowledgebase";
                  else if (item.QuestionCategory == 4)
                  QuestionCategory = "Market Monitor";
                  %>
               <span class="qa-q-item-where-pad">in </span><span class="qa-q-item-where-data"><a data-value="<%:item.QuestionCategory %>" id="myLink" href="#" onclick="GetQuestionsListByCategory('<%:item.QuestionCategory %>');" class="qa-category-link"><%:QuestionCategory%></a></span>
               </span>
               </span>
               </span>
               </span>
            </div>
            <div class="qa-q-item-clear">
            </div>
         </td>
      </tr>
      <%} %>
      <%} %>
   </tbody>
</table>
