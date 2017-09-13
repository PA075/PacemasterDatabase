<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/CFSite.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.ForumQuestionDetails>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    View Answer
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <%--  <script src="../../Scripts/custom/summernote.js"></script>--%>
    
    
   <%-- <link href="../../Content/CSS/qa-styles.css" rel="stylesheet" />--%>
     <%: Styles.Render( "~/Content/qa-stylesCSS")  %>
   
    <div class="container">
        <div class="">
            <%int i = 0; %>
            <div id="content-box" class="col-md-12">
                <div class="row">
                    <div class="main-content-box">
                        <div class="qa-main">
                            <div class="qa-part-q-view">
                                <div class="qa-q-view  hentry question" id="<%:Model.forumQuestion.QuestionId%>">
                                    <form method="post" action="">
                                        <div class="qa-q-view-stats">
                                        </div>
                                    </form>
                                    <div class="qa-q-view-main" style="padding-left:0px; width:100%;">
                                        <form  id="QuestionInViewAnswer"method="post" action="">
                                            <div id="" class="entry-title">
                                                <h2><%:Model.forumQuestion.QuestionTitle  %></h2>
                                            </div>
                                            <span class="qa-q-view-avatar-meta">
                                                <span class="qa-q-view-meta">
                                                    <span class="qa-q-view-when">
                                                        <span class="qa-q-view-when-data">asked on <span class="published updated">
                                                            <b><span id="questionPostTimetxt" class="value-title" title="">
                                                         <%var dateStr = (Model.forumQuestion.PostDate).Month + "/" + (Model.forumQuestion.PostDate).Day + "/" + (Model.forumQuestion.PostDate).Year + " " + (Model.forumQuestion.PostDate).Hour + ":" + (Model.forumQuestion.PostDate).Minute + ":" + (Model.forumQuestion.PostDate).Second; %> <%--common date format mm/dd/yyyy(JS not takes dd-mm-yy)--%>
                                                                <%:dateStr%>
                                                            </span></b>
                                                        </span>
                                                        </span>
                                                        <%--<span class="qa-q-view-when-pad">ago</span>--%>
                                                    </span>
                                                    <span class="qa-q-view-where">
                                                        <% string QuestionCategory = string.Empty;
                                                            if (Model.forumQuestion.QuestionCategory == 1)
                                                                QuestionCategory = "Basics";
                                                            else if (Model.forumQuestion.QuestionCategory == 2)
                                                                QuestionCategory = "Forecasting";
                                                            else if (Model.forumQuestion.QuestionCategory == 3)
                                                                QuestionCategory = "Knowledgebase";
                                                            else if (Model.forumQuestion.QuestionCategory == 4)
                                                                QuestionCategory = "Guides";
                                                            //else if (Model.forumQuestion.QuestionCategory == 5)
                                                            //    QuestionCategory = "Privacy";
                                                        %>
                                                        <span class="qa-q-view-where-pad">in <%:QuestionCategory%></span>
                                                  
                                                </span>
                                            </span>
                                            <div class="qa-q-view-content">
                                                <a name="51940"></a>
                                                <div id="idQuestionTxt" class="entry-content">
                                                </div>
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-md-10">
                                                            <label class="control-label">Attachment:</label>
                                                            <% if (Model.forumQuestion.Attachments != null)
                                                               {%> 
                                                            <%var j = 0; %>
                                                            <%  foreach (PharmaACE.ForecastApp.Models.Attachment Qattachment in Model.forumQuestion.Attachments)
                                                                { %>
                                                          <%  var total = Model.forumQuestion.Attachments.Count();%>
                                                            <%if(j != total-1 || total == 1)
                                                                {%>
                                                            <a  href="/CommunityPractice/DownloadFile?attstreamId=<%:Qattachment.AttachmentPath%> &attName=<%:Qattachment.AttachmentName%>"> <%:Qattachment.AttachmentName%></a>
                                                           <% }
                                                                else
                                                               { %>
                                                            <a  href="/CommunityPractice/DownloadFile?attstreamId=<%:Qattachment.AttachmentPath%> &attName=<%:Qattachment.AttachmentName%>">, <%:Qattachment.AttachmentName%></a>
                                                                <% }   %>
                                                                <%j++; %>
                                                             <%}
                                                                   }
                                                               else
                                                               { %>
                                                                   None
                                                                   <% } %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="qa-q-view-buttons">
                                                <button name="q_doanswer" id="q_doanswer" onclick="return false;" value="answer" title="Answer this question" class="btn btn-primary" data-toggle="collapse" data-target="#community-answer">Answer this question</button>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- END qa-q-view-main -->
                                    <div class="qa-q-view-clear">
                                    </div>
                                </div>
                                <!-- END qa-q-view -->
                            </div>
                            <div class="qa-part-a-form collapse" id="community-answer">
                                <div class="qa-a-form" id="anew">
                                    <h2>Your answer</h2>
                                    
                                        <div class="qa-form-tall-table">
                                            <textarea name="a_content" rows="12" cols="40" class="qa-form-tall-text" id="qa-form-textarea"></textarea>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-2">
                                                        <label class="control-label">Attachment:</label>
                                                    </div>
                                                    <div class="col-md-10">
                                                        <input class="file_write" id="file_attachment" type="file" multiple="" accept=".tif,.tiff,.gif,.jpg,.jpeg,.png,.doc,.docx,.pdf,.xls,.xlsb,.xlsm, .xlsx, .csv, .txt,.rtf, .zip, .jpeg, .png,.ppt,.pptx,.bmp,.rar" />
                                                    </div>
                                                </div>
                                            </div>
                                            <input type="button" onclick="AddAnswer();" value="Add answer" title="" class="btn btn-primary"/><span id="null" class="qa-waiting">...</span>
<%--                                            <input type="button" name="docancel" onclick="return qa_toggle_element();" value="Cancel" title="" class="btn btn-danger"/>--%>
                                       <input type="button" name="docancel" onclick="setAnswerDivToDefault();" value="Cancel" title="" class="btn btn-danger"/>

                                            </div>
                                   
                                </div>
                                <!-- END qa-a-form -->
                            </div>
                            <%if (Model.forumAnswers.Count >= 1 && Model.forumAnswers[0].AnswerId != -1)
                              { %>
                            <div class="qa-part-a-list">
                                <h2 id="a_list_title"><%:Model.forumAnswers.Count %> Answers</h2>
                               
                                 <div class="qa-a-list table-striped table-bordered dataTable no-footer" id="a_list">
                                    <% foreach (var item in Model.forumAnswers)
                                       { %>
                                    <% i++; %>

                                    <div class="qa-a-list-item  hentry answer" style=" margin:0px; padding:0px 15px;">
                                        <div class="qa-a-item-main">
                                            <span class="qa-a-item-avatar-meta">
                                                <span class="qa-a-item-meta">
                                                    <span class="qa-a-item-when">
                                                        <span class="qa-a-item-when-data"><span class="published updated">answered on 
                                                             <b><span class="answerPostTimetxt value-title" title="">
                                                              <%var dateStr1 = (item.PostDate).Month + "/" + (item.PostDate).Day + "/" + (item.PostDate).Year + " " + (item.PostDate).Hour + ":" + (item.PostDate).Minute + ":" + (item.PostDate).Second; %> <%--common date format mm/dd/yyyy(JS not takes dd-mm-yy)--%>
                                                                 <%:dateStr1%>
                                                             </span></b></span></span><%--<span class="qa-a-item-when-pad">ago</span>--%>
                                                    </span>
                                                </span>
                                            </span>
                                            <form method="post" action="#">
                                                <div class="qa-a-selection">
                                                </div>
                                                <div class="qa-a-item-content">
                                                     <div class="entry-content">
                                                             <% 
                                                                 var s="<p>No Comments</p>";
                                                                 if ((item.AnswerText.ToString()).Trim() == "<p><br></p>")
                                                                 {%>
                                                           
                                                          <%:Html.Raw(s)%>

                                                          <%  }
                                                         else
                                                        {%>

                                                           
                                                        <%:Html.Raw(item.AnswerText)%>

                                                       <% }   %>
                                                         </div>
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-md-10">
                                                                <label class="control-label">Attachment:</label>
                                                                <%if (item.Attachments != null)
                                                                  {%>
                                                                 <%var j = 0; %>

                                                                <% foreach (PharmaACE.ForecastApp.Models.Attachment att in item.Attachments)
                                                                   { %>
                                                                 <%  var total = item.Attachments.Count();%>
                                                                 <%if(j != total-1 || total == 1)
                                                                {%>
                                                            <a  href="/CommunityPractice/DownloadFile?attstreamId=<%:att.AttachmentPath%> &attName=<%:att.AttachmentName%>"> <%:att.AttachmentName%></a>
                                                           <% }
                                                                else
                                                               { %>
                                                            <a  href="/CommunityPractice/DownloadFile?attstreamId=<%:att.AttachmentPath%> &attName=<%:att.AttachmentName%>">, <%:att.AttachmentName%></a>
                                                                <% }   %>
                                                                <%j++; %>
                                                                <%}
                                                                     }
                                                                  else
                                                                  { %>
                                                                   None
                                                                   <% } %>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                            <div class="qa-c-form">
                                            </div>
                                        </div>
                                        <!-- END qa-a-item-main -->
                                        <div class="qa-a-item-clear"></div>
                                    </div>
                                    <%} %>
                                </div>
                            
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <br />
                    <br />

                    <a class="backtoaskqustion" href="<%=Url.Action("Index", "CommunityPractice")%>" style="margin-top:8px;">
                        <button type="button" class="btn btn-primary">Back</button></a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
    
    <link href="../../Content/CSS/summernote.css" rel="stylesheet" />

    <script type="text/javascript">
        $(function () {
            $('#idQuestionTxt')[0].innerHTML = PHARMAACE.FORECASTAPP.UTILITY.htmlDecode(PHARMAACE.FORECASTAPP.UTILITY.htmlDecode('<%:Model.forumQuestion.QuestionText %>'));
            var pDate =  $('#questionPostTimetxt')[0].innerHTML;           
            var date1 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(pDate));
            var formattedDate = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(date1));
            $('#questionPostTimetxt')[0].innerHTML = formattedDate;
            var answers = $('.answerPostTimetxt');
            for (var i = 0; i < answers.length; i++) {
                var pDate = answers[i].innerHTML;
                var date2 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(pDate));
                var formattedDate1 = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(date2));
                answers[i].innerHTML = formattedDate1;
                //answers[i].innerHTML = PHARMAACE.FORECASTAPP.UTILITY.dateDifference((date2), "mmddyyyy");
            }
            var $placeholder = $('.placeholder');
            $('#qa-form-textarea').summernote({
                height: 150,
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
                        }, 300);
                    }
                }
            });
        });
        function decodeText(value){
            return  PHARMAACE.FORECASTAPP.UTILITY.htmlDecode(PHARMAACE.FORECASTAPP.UTILITY.htmlDecode(value));
        }

        $("#file_attachment").change(function () {
            var val = $(this).val().toLowerCase();
            var ext = val.substr(val.lastIndexOf('.') + 1);
            if (PHARMAACE.FORECASTAPP.FILETYPE.indexOf(ext) == -1) {
                $(this).val('');
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Sorry, this file type is not permitted for security reasons...", '');
                return;
            }
        });
        function setAnswerDivToDefault(){
            $('#q_doanswer').click();
            $('#file_attachment').val("");
            $('.note-editable').text("");
        }
        function AddAnswer()
        {
            var formdata = new FormData();
            var questionid = <%:Model.forumQuestion .QuestionId%>;
            var answerText=PHARMAACE.FORECASTAPP.UTILITY.htmlEncode($('.note-editable').html());
            var answerTextWithoutHtml = $('.note-editable').text();
            if(answerTextWithoutHtml != "")
            {
                if( $('#file_attachment').length > 0)
                {
                    var attachment = $('#file_attachment').val();                    
                    var fileInput = $('#file_attachment')[0];
                    if (fileInput.files != null && fileInput.files.length > 0) {
                        var notValidFileSize = PHARMAACE.FORECASTAPP.UTILITY.checkFileSize(fileInput.files);
                        if (notValidFileSize)
                        {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to add question : file size exceeded.", '');
                            return;
                        }
                        else{
                            for (var i = 0; i < fileInput.files.length; i++) {
                                var fileStream = fileInput.files[i];
                                formdata.append(fileInput.files[i].name, fileInput.files[i]);
                            }
                        }
                    }
                }
                formdata.append('AnswerText', answerText);
                var controllerUrl = "/CommunityPractice/AddAnswer?QuestionId=" + questionid  ;
                var xhr = new XMLHttpRequest();
                xhr.open('POST', controllerUrl);
                xhr.send(formdata);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        if (xhr.responseText == 1) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Answer Added", '');
                            $('#q_doanswer').click();
                            $('#QuestionInViewAnswer').submit();
                        }
                        else if (xhr.responseText == 2)
                        {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Invalid file extension", '');                       
                        }
                        else
                        {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Fail to add answer", '');
                        }
                    
                    }
                }   
            }
            else
            {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please add answer", '');
            }
        }
    </script>
</asp:Content>
