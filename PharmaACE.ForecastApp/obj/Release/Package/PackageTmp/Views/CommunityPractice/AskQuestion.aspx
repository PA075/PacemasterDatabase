<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/CFSite.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.CommunityPractice>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   Ask Question
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <div class="modal-dialog cmaDiv1" >
      <div class="modal-content">
         <div class="modal-header">
            <h2 class="modal-title custom_align" id="Heading">Ask Question</h2>
         </div>
         <form class="form" role="form" id="addquestionid" name="form1" >
            <div class="modal-body">
               <div class="form-group">
                  <div class="row">
                     <div class="col-md-2">
                        <label class="control-label">Question Title:</label>
                     </div>
                     <div class="col-md-10">
                        <input class="form-control " placeholder="Question Title" type="text" id="question-title" title="Question Title" required />
                     </div>
                  </div>
               </div>
               <div class="form-group">
                  <div class="row">
                     <div class="col-md-2">
                        <label class="control-label">Category:</label>
                     </div>
                     <div class="col-md-10">
                        <select id="questionCategory" class="selectpicker form-control search-filter select-dropdown selectBox">
                           <option value="">Select a Category</option>
                           <option value="1" selected="selected">Basic</option>
                           <option value="2">Forecast</option>
                           <option value="3">Knowledgebase</option>
                           <option value="4">Guides</option>
                           <%-- <option value="5">Privacy</option>--%>
                        </select>
                     </div>
                  </div>
               </div>
               <div class="form-group">
                  <div class="row">
                     <div class="col-md-2">
                        <label class="control-label">Attachment:</label>
                     </div>
                     <div class="col-md-10">
                        <input class="file_write" id="file_attachment" type="file" multiple="multiple" accept=".tif,.tiff,.gif,.jpg,.jpeg,.png,.doc,.docx,.pdf,.xls,.xlsb,.xlsm, .xlsx, .csv, .txt, .rtf,.zip, .jpeg, .png,.ppt,.pptx,.bmp,.rar">
                     </div>
                  </div>
               </div>
               <div class="form-group">
                  <div class="row">
                     <div class="col-md-2">
                        <label class="control-label">Details:</label>
                     </div>
                     <div class="col-md-10">
                        <div class="index-section-1">
                           <div id="">
                              <textarea name="a_content" rows="12" cols="40" class="qa-form-tall-text" id="question-details"></textarea>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="modal-footer ">
               <div class="cmaDiv2">
                  <input id="AddQuestion" type="submit" class="btn btn-primary cmaDiv2" value="Submit" />
               </div>
               <div>
                  <a class="btn btn-danger backtocommunitypractice cmaDiv3" href="<%=Url.Action("Index", "CommunityPractice")%>" role="button" >Cancel</a>
               </div>
            </div>
         </form>
      </div>
   </div>
   <div class="col-md-3 ">
      <div id="popalert" class="alert-info" style="display:none;">
         <span class="close" data-dismiss="alert">&times;</span>
         <p class="cmaDiv4"></p>
      </div>
   </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
   <link href="../../Content/CSS/qa-styles.css" rel="stylesheet" />
    <%--<script src="../../Scripts/custom/summernote.js"></script>--%>
   <link href="../../Content/CSS/summernote.css" rel="stylesheet" />
      
    <%--<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>--%>
    <%: Scripts.Render( "~/Scripts/COPAskQuestionScript")%>
</asp:Content>
