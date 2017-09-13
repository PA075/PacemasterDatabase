<%@ Page Title="Disease Overview" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.UserInfo>" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
       UserProfile
</asp:Content>
<asp:Content ID="UserInformation" ContentPlaceHolderID="MainContent" runat="server">
   <html xmlns="http://www.w3.org/1999/xhtml">
<body>
    <div id="popalert" class="modal" style=" overflow:visible;" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"> </h4>
            </div>
            <div class="modal-body">
               <p style=" text-align:center"></p>
            </div>
        </div>
    </div>
</div>
    <form id="form1" runat="server">
     <div class="row">
      <div class="col-md-3  toppad  pull-right col-md-offset-9 ">
          <a href='javascript:;' onclick="EditProfile();" id="editprofile"> Edit Profile </a>
        <A href="../Home/logout" >Logout</A>
       <br>
      </div>
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad" >
          <div class="panel panel-info" >
            <div class="panel-heading">
               <h1 id="UserName"><%: Html.DisplayFor(model => Model.FirstName) %></h1>
            </div>
            <div class="panel-body">
              <div class="row">
                   <div class="col-md-3 col-lg-3 " align="center"> 
                               <button id="btnprofile" type="button"  class=" profile-ava btn-circle" style="height:42px; width:42px;margin-top: 2cm;"><%:Session["User"].ToString().Substring(0,1)%></button>
                  </div>
                <div class=" col-md-6 col-lg-6 "> 
                  <table class="table table-user-information">
                    <tbody>
                      <tr>
                        <td>First Name:</td>   
                        <td id="fname"> <%: Html.DisplayFor(model => Model.FirstName) %> </td>
                      </tr>
                      <tr>
                        <td>Last Name:</td>
                        <td id="lname"><%: Html.DisplayFor(model => Model.LastName) %> </td>
                      </tr>
                      <tr>
                        <td >Email</td>
                        <td id="emailid"><%: Html.DisplayFor(model => Model.Email) %></td>
                      </tr>
                        <tr>
                            <td style="width: 20%"><input type="submit" class="btn" id="saveprofilelink" style="display:none;" value="Save Profile" /> </td>
                            <td style="width: 17%">&nbsp;</td>
                        </tr>
                    </tbody>
                  </table>
                </div>
              </div>
          </div>
          </div>
        </div>
      </div>
    </form>
</body>
</html>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
 <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
<%: Scripts.Render("~/Scripts/serviceLIB") %>
    <script type="text/javascript">
        function EditProfile(){
            document.getElementById("editprofile").style.display = 'none';
            document.getElementById("UserName").innerHTML = "Edit Profile";
            document.getElementById("saveprofilelink").style.display = 'block'
            document.getElementById("fname").innerHTML = "<input type='text'  placeholder='{0}' />".replace('{0}', $('#fname').text());
            document.getElementById("lname").innerHTML = "<input type='text' placeholder='{0}' />".replace('{0}', $('#lname').text());
        };
        $('#form1').submit(function () {
            var fname = $('#fname>input').val();
            var lname = $('#lname>input').val();
            var emailid = $('#emailid>input').val();
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/UpdateUserProfile", { firstname: fname, lastname: lname, email: emailid },
                        function (result) {
                            if (result.success) {
                                window.location.href = "../Home/UserInformation";
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Profile Updated", "UserProfile");
                            }
                            else {
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Updation Failed", "UserProfile");
                            }
                        });
            return false;
        });
    </script>
</asp:Content>
