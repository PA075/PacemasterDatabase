<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/CFSite.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    HelpDesk
   

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <%--   <link href="../../Content/CSS/font-awesome.css" rel="stylesheet" />
<link href="../../Content/CSS/bootstrap.css" rel="stylesheet" />
<link href="../../Content/CSS/simple-sidebar-min.css" rel="stylesheet" />
<link href="../../Content/CSS/animate.min.css" rel="stylesheet" />--%>
      <%: Styles .Render("~/Content/HelpDeskCSS") %>
<%--<script src="../../Scripts/lib/jquery/jquery.min.js"></script>
<script src="../../Scripts/lib/jquery/bootstrap.min.js"></script>
<script src="../../Scripts/custom/bootbox.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
 <script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>  
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Validator.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Constants.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>--%>
    <%--<%: Scripts.Render ("~/Scripts/HelpDeskScript") %>--%>
<%--    <link href="../../Content/CSS/helpdesk.css" rel="stylesheet" />--%>
   
    <div id="page-content-wrapper">
        <div class="row">
            <div class="container">
                <div>
                    <div class="col-md-7 hdDiv1"  id="formsection">
                        <div class="form-group">
                            <div class="form-top">
                            </div>
                            <form role="form" action="" method="post" class="registration-form" id="helpid" >
                                <div class="form-bottom">
                                    <div class="form-group">
                                        <label class="sr-only" for="form-email">Issue</label>
                                        <input type="text" name="form-email" placeholder="Issue..." class="form-email form-control" id="issueid" required>
                                    </div>
                                    <div class="form-group">
                                        <label class="sr-only" for="form-about-yourself">Issue Description</label>
                                        <textarea name="form-about-yourself" placeholder="Issue Description..." rows="10"
                                            class="form-about-yourself form-control panel-resizable" id="form-about-yourself" required></textarea>
                                    </div>
                                    <div class="row">
                                        <div class="hdDiv2">
                                            <input id="attachments_local_path" type="text" class=" " placeholder="" data-toggle="tooltip" title="" readonly>
                                            <span class="btn btn-default btn-file">Browse File
                                <input id="file_attachment" type="file"  class="file_write"  accept=".tif,.tiff,.gif,.jpg,.jpeg,.png,.doc,.docx,.pdf,.xls,.xlsb,.xlsm, .xlsx, .csv, .txt, .rtf,.zip, .jpeg, .png,.ppt,.pptx,.bmp,.rar" multiple="multiple">
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer pull-center hdDiv3">
                                    <input type="submit" class="btn btn-primary hdDiv4" value="Submit" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script type="text/javascript">
    $(document).ready(function () {
        //$("#btnprofile").tooltip({ selector: '[data-tool-tip=tooltip]' });
        var tooltiptitle = '<%= Session["User"] %>';
        $("#btnprofile").attr("title", tooltiptitle);
        $("#flyerInnerbox").niceScroll({
            cursorfixedheight: 70
        });
    });
    $("#file_attachment").change(function () {
        var val = $(this).val().toLowerCase();
        var ext = val.substr(val.lastIndexOf('.') + 1);
        if (PHARMAACE.FORECASTAPP.FILETYPE.indexOf(ext) == -1) {
            $(this).val('');
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Sorry, this file type is not permitted for security reasons...", '');
            return;
        }
        var localFullPaths = this.value;
        if (localFullPaths) {
            localFullPaths = localFullPaths.split(',');
            $('#attachments_local_path').val(localFullPaths);
            $('#attachments_local_path').attr("title", localFullPaths);
        }
    });
    $('#helpid').submit(function () {
        var fileInput = document.getElementById('file_attachment');
        var notValidFileSize = PHARMAACE.FORECASTAPP.UTILITY.checkFileSize(fileInput.files);
        if (notValidFileSize) {
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to send mail : " + "file size exceeded.", "");
        }
        else {
            $.ajax({
                url: "/Home/SendMailHelpDesk",
                type: "POST",
                contentType: false,
                processData: false,
                data: function () {
                    var data = new FormData();
                    data.append("issue", jQuery("#issueid").val());
                    data.append("loginEmail", '<%= Session["User"] %>');
                    data.append("toEmail", 'pacehomepageadmin@PharmaACE.com');
                    data.append("issuedesc", jQuery("#form-about-yourself").val());
                    data.append("file", jQuery("#file_attachment").val());
                    for (i = 0; i < fileInput.files.length; i++) {
                        data.append(fileInput.files[i].name, fileInput.files[i]);
                    }
                    return data;
                }(),

                success: function (data) {
                    if (data.success) {
                        //alert(data.fileclass);
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Mail sent successfully.", "");
                    }
                    else if (data.allfield == 1) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter all field.", "");
                    }else
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to send mail : " + data.errors.join(), "");
                },
                error: function (jqXHR, textStatus, errorMessage) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to send mail.", "");
                }
            });
        }
    });
</script>
</asp:Content>
