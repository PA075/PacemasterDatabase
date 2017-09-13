var userPermissionArray = [];
var roleIdtoCheckManager = null;
    function saveOrder() {
        // $("#list1").dragsort();
        var data = $("#list1 li").map(function () { return $(this).children().html(); }).get();
        $("input[name=list1SortOrder]").val(data.join("|"));
    };
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

    $(document).ready(function () {
        localStorage.removeItem('selectedolditem');
        //  $("#list1").dragsort({ dragSelector: "div", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });
        $('.img-zoom').hover(function () {
            $(this).addClass('transition');
        }, function () {
            $(this).removeClass('transition');
        });
        var remember = $.cookie('remember');
        if (remember == 'true') {
            var email = $.cookie('email');
            $('#recipient-name').val(email);
        }
        var user = emailid;
           
        if (user) {
            checkUserinSession();
        }

        $('#signinid').submit(function () {
            // var controllerUrl = "/Home/SignIn?email=" + email + "&password=" + password;
            $('#overlaysigninId').css("display", "block");
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Signing In", 'signinid', "15", "");
            var email = $('#recipient-name').val();
            var password = $('#message-text').val();
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/SignInTest", { email: email, password: password },
                    function (result) {
                        if (result.success) {
                            sessionStorage.clear();//required to remove all saved data across appln
                            $('#overlaysigninId').css("display", "none");
                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('signinid');
                            hideModal('loginform');
                            userPermissionArray = result.userLoginDetails.userPermission;
                            roleIdtoCheckManager=result.userLoginDetails.userInfo.RoleId;
                            checkUsersPermissions(userPermissionArray);
                            if ($('#remember').is(':checked')) {
                                var email = $('#recipient-name').val();
                                $.cookie('email', email, { expires: 365 });
                                $.cookie('remember', true, { expires: 365 });
                            }
                            else {
                                $.cookie('email', null);
                                $.cookie('remember', null);
                            }
                            if (result.userLoginDetails.userInfo) {
                                if (result.userLoginDetails.userInfo.LoginResult == 1) {
                                    var user = result.userLoginDetails.userInfo.Email;
                                    var firstName = result.userLoginDetails.userInfo.FirstName;
                                    var lastName = result.userLoginDetails.userInfo.LastName;
                                    if (user) {
                                        checkUserLogged(firstName, lastName);
                                    }
                                }
                            }
                        }
                        else if (result.userLoginDetails && result.userLoginDetails.userInfo) {
                            if (result.userLoginDetails.userInfo.LoginResult == 0) {
                                hideModal('loginform');
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('signinid');
                                $('#overlaysigninId').css("display", "none");
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("User doesn't exist", '');
                            }

                            else if (result.userLoginDetails.userInfo.LoginResult == 2) {
                                hideModal('loginform');
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('signinid');
                                $('#overlaysigninId').css("display", "none");
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Incorrect password", '');
                            }
                            else if (result.userLoginDetails.userInfo.LoginResult == 3) {
                                hideModal('loginform');
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('signinid');
                                $('#overlaysigninId').css("display", "none");
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Invalid user / Subscription expired", '');
                            }
                        }
                        else {
                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('signinid');
                            hideModal('loginform');
                            $('#overlaysigninId').css("display", "none");
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not log in.", '');
                        }

                    },
                    function (status) {
                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('signinid');
                        hideModal('loginform');
                        $('#overlaysigninId').css("display", "none");
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not log in.", '');
                    });
            return false;
        });

        $('#logout').click(function (e) {
            e.preventDefault();
            var lHref = $('#logout').attr('href');
            // var msg = 'Do You Want To Log Out ?';
            bootbox.confirm({
                size: 'small',
                message: 'Do you want to log out ?',
                buttons: {
                    'confirm': {
                        label: 'Yes',
                        className: 'btn-danger pull-right'
                    },
                    'cancel': {
                        label: 'No',
                        className: 'btn-default pull-left'
                    }
                },
                callback: function (result) {
                    if (result) {
                        window.location.href = lHref;
                    }
                    else {
                    }
                }
            })
        });
        $('#profile').click(function () {
            $('#UserProfile').show();
            var tableRef = document.getElementById('user_table').getElementsByTagName('tbody')[0];
            var str = '';
            str += '<tr class="">';
            str += '<td class="Lable">First Name:</td>';
            str += '<td id="fname"> ' + fname + ' </td></tr>';
            str += '<tr class="">';
            str += '<td class="Lable">Last Name:</td>';
            str += '<td id="lname"> ' + lname + '</td></tr>';
            str += '<tr class="">';
            str += '<td class="Lable" >Email:</td>';
            str += '<td id="emailid"> ' + emailid + '</td></tr>';
            str += '<tr class="">';
            tableRef.innerHTML = str;
            $('#UserProfile').modal('show');
            $('#btnEdit').css("display", "block");
            $('#btnSave').css("display", "block");
            // $('.modal-backdrop').css("display", "none");
            $('#btnSave').prop('disabled', true);
        });

        $('#updatepasswordid').submit(function () {
            var email = $('#recipient-name').val();
            var currentPassword = $('#message-text').val();
            var newPassword = $('#NewPassword').val();
            var confirmedPassword = $('#ConfirmedPassword').val();
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/UpdatePassword", { email: email, currentPassword: currentPassword, newPassword: newPassword },
                        function (result) {
                            if (result.success) {
                                $('#edit1').hide();
                                PHARMAACE.FORECASTAPP.UTILITY.popalert(result.status, "");
                            }
                            else {
                                $('#edit1').hide();
                                PHARMAACE.FORECASTAPP.UTILITY.popalert(result.status, "");
                            }
                        },
                        function (result) {
                            $('#edit1').hide();
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not update password", "");
                        });
            return false;
        });

        $('#formForgotPassword').submit(function () {
            var ToEmail = $('#EmailForgot').val();
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Sending Email", 'formForgotPassword', "15", "");

            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/SendMail", { email: ToEmail },
                        function (result) {
                            if (result.success) {
                                //$('#loginform').hide();
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('formForgotPassword');
                                $('#loginform').modal('hide');
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Email Sent Successfully", "");
                            }
                            else if (result.validStatus == 1) {
                                //$('#loginform').hide();
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('formForgotPassword');
                                $('#loginform').modal('hide');
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("User doesn't exist", "");
                            }
                            else if (result.validStatus == 2) {
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('formForgotPassword');
                                $('#loginform').modal('hide');
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Subscription expired", "")
                            }
                            else {
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('formForgotPassword');
                                $('#loginform').modal('hide');
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to send email", "");
                            }
                        },
                              function (result) {
                                  //$('#loginform').hide();
                                  PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('formForgotPassword');
                                  $('#loginform').modal('hide');
                                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to send email", "");
                              });
            return false;
        });
       
            checkUsersPermissions(userPermissionArray);      
    });
    
function checkUserinSession() {
    //$('.img-zoom').removeClass('opac');
    //checkUsersPermissions(userPermissionArray);
    //$('a.enableanchor').removeAttr("onclick");
    $('#btnlogin').remove();
    $('#btnprofile').css('display', 'block');    
    var userName = fname.charAt(0) + lname.charAt(0);
    $('#btnprofile').html(userName);

}

function checkUserLogged(firstName, lastName) {
    // $('.img-zoom').removeClass('opac');
   // $('a.enableanchor').removeAttr("onclick");
    $('#btnlogin').remove();
    $('#btnprofile').css('display', 'block');
    var userName = firstName.charAt(0) + lastName.charAt(0);
    $('#btnprofile').html(userName);

    
    var strForManager = '';//to append user manager after login
    strForManager = '<a href="../Admin/index"><i class="icon_profile"></i> Manage Users </a>';
    var ab = $('#myprofileid')[0];
    if (roleIdtoCheckManager == 3 || roleIdtoCheckManager == 2)
    ab.children[2].innerHTML = strForManager;
}   
    
function EditProfile() {
    $('#btnSave').prop('disabled', false);
    // $('input[id="btnSave"]').prop('disabled', false);        
    //document.getElementById("btnEdit").style.display = 'block';
    //document.getElementById("btnSave").style.display = 'block';
    document.getElementById("fname").innerHTML = "<input type='text'  placeholder='{0}' />".replace('{0}', $.trim($('#fname').text()));
    document.getElementById("lname").innerHTML = "<input type='text' placeholder='{0}' />".replace('{0}', $.trim($('#lname').text()));
    $('#fname>input').val($.trim($('#fname>input').attr('placeholder')));
    $('#lname>input').val($.trim($('#lname>input').attr('placeholder')));
}
function SaveProfile()
{
    var fname = $('#fname>input').val();
    var lname = $('#lname>input').val();
    
    if(fname!=null && fname!=undefined && fname!=""){
        if (lname != null && lname != undefined && lname!="") {
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/UpdateUserProfile", { firstname: fname, lastname: lname, email: emailid },
                        function (result) {
                            if (result.success) {
                                $('#UserProfile').hide();
                                //var userName = fname.charAt(0) + lname.charAt(0);
                                $('#btnprofile').replaceWith($('#avtar').load("/Home/GetModule?partialName=ProfileLogo.ascx"));
                                //$('#btnprofile').html(userName);
                                //$('#avtar').load("/Home/GetModule?partialName=ProfileLogo.ascx");
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Profile Updated Successfully", "UserProfile");

                            }
                            else {
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Updation Failed", "UserProfile");
                            }
                        },
                             function (result) {
                                 PHARMAACE.FORECASTAPP.UTILITY.popalert(" Please try again.", "");
                                 $('.modal-backdrop').css("display", "none");
                             });
        }else{
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Last Name Can not be blanked", "UserProfile");
        }
    } else {
        PHARMAACE.FORECASTAPP.UTILITY.popalert("First Name Can not be blanked", "UserProfile");
    }
    // return false;
}


function removeSpaces(string) {
    return string.split(' ').join('');
}
function removeSpaces(string) {
    return string.split(' ').join('');
}

function checkUsersPermissions_old()
{    
    if (ForecastAccess == 'False') {
        $("#ForecastBox").children().off('click');
        $("#ForecastBox").addClass("disabledbutton");
    }

    if (KMAccess == 'False') {
        $("#KMBox").attr("disabled", "disabled").off('click');
        $("#KMBox").addClass("disabledbutton");
    }
        
    if (ReportingAccess == 'False') {
        $("#ReportingBox").attr("disabled", "disabled").off('click');
        $("#ReportingBox").addClass("disabledbutton");
    }
        
    if (UtilitiesAccess == 'False') {
        $("#UtilitiesBox").attr("disabled", "disabled").off('click');
        $("#UtilitiesBox").addClass("disabledbutton");
    }
        
    if (CustomFeedAccess == 'False') {
        $("#CustomFeedBox").attr("disabled", "disabled").off('click');
        $("#CustomFeedBox").addClass("disabledbutton");
    }
        
    if (CommunityPracticeAccess == 'False') {
        $("#CommunityPracticeBox").attr("disabled", "disabled").off('click');
        $("#CommunityPracticeBox").addClass("disabledbutton");
    }
        
    if (UserWorkspaceAccess == 'False') {
        $("#UserWorkspaceBox").attr("disabled", "disabled").off('click');
        $("#UserWorkspaceBox").addClass("disabledbutton");
    }
        
    if (HelpDeskAccess == 'False') {
        $("#HelpDeskBox").attr("disabled", "disabled").off('click');
        $("#HelpDeskBox").addClass("disabledbutton");
    }
}



function checkUsersPermissions(userPermissions) {
    if (userPermissions.ForecastPlatform == false) {
        //$("#ForecastBox").children().off('click');
        $("#ForecastBox").addClass("opac");
    }
    else if (userPermissions.ForecastPlatform) {
        $("#ForecastBox").removeClass("opac");
        var module = $("#ForecastBox >p");
        (module[1].firstElementChild).removeAttribute("onclick");
        //hack for IE - clicking on href does not respond; but open link in new tab does!
        $('#ForecastBox').html($('#ForecastBox').html());
    }

    if (userPermissions.KnowledgeManagement == false) {
        // $("#KMBox").attr("disabled", "disabled").off('click');
        $("#KMBox").addClass("opac");
    }
    else if (userPermissions.KnowledgeManagement) {
        $("#KMBox").removeClass("opac");
        var module = $("#KMBox >p");
        (module[1].firstElementChild).removeAttribute("onclick");
        //hack for IE - clicking on href does not respond; but open link in new tab does!
        $('#KMBox').html($('#KMBox').html());
    }

    if (userPermissions.BusinessIntelligence == false) {
        //$("#ReportingBox").attr("disabled", "disabled").off('click');
        $("#ReportingBox").addClass("opac");
    }
    else if (userPermissions.BusinessIntelligence) {
        $("#ReportingBox").removeClass("opac");
        var module = $("#ReportingBox >p");
        (module[1].firstElementChild).removeAttribute("onclick");
        //hack for IE - clicking on href does not respond; but open link in new tab does!
        $('#ReportingBox').html($('#ReportingBox').html());
    }

    if (userPermissions.Utilities == false) {
        //$("#UtilitiesBox").attr("disabled", "disabled").off('click');
        $("#UtilitiesBox").addClass("opac");
    }
    else if (userPermissions.Utilities) {
        $("#UtilitiesBox").removeClass("opac");
        var module = $("#UtilitiesBox >p");
        (module[1].firstElementChild).removeAttribute("onclick");
        //hack for IE - clicking on href does not respond; but open link in new tab does!
        $('#UtilitiesBox').html($('#UtilitiesBox').html());
    }

    if (userPermissions.CustomFeed == false) {
        //$("#CustomFeedBox").attr("disabled", "disabled").off('click');
        $("#CustomFeedBox").addClass("opac");
    }
    else if (userPermissions.CustomFeed) {
        $("#CustomFeedBox").removeClass("opac");
        var module = $("#CustomFeedBox >p");
        (module[1].firstElementChild).removeAttribute("onclick");
        //hack for IE - clicking on href does not respond; but open link in new tab does!
        $('#CustomFeedBox').html($('#CustomFeedBox').html());
    }

    if (userPermissions.CommunityOfPractice == false) {
        //$("#CommunityPracticeBox").attr("disabled", "disabled").off('click');
        $("#CommunityPracticeBox").addClass("opac");
    }
    else if (userPermissions.CommunityOfPractice) {
        $("#CommunityPracticeBox").removeClass("opac");
        var module = $("#CommunityPracticeBox >p");
        (module[1].firstElementChild).removeAttribute("onclick");
        //hack for IE - clicking on href does not respond; but open link in new tab does!
        $('#CommunityPracticeBox').html($('#CommunityPracticeBox').html());
    }

    if (userPermissions.UserWorkspace == false) {
        $("#UserWorkspaceBox").addClass("opac");
    }
    else if (userPermissions.UserWorkspace) {
        $("#UserWorkspaceBox").removeClass("opac");
        var module = $("#UserWorkspaceBox >p");
        (module[1].firstElementChild).removeAttribute("onclick");
        //hack for IE - clicking on href does not respond; but open link in new tab does!
        $('#UserWorkspaceBox').html($('#UserWorkspaceBox').html());
    }

    if (userPermissions.HelpDesk == false) {
        // $("#HelpDeskBox").attr("disabled", "disabled").off('click');
        $("#HelpDeskBox").addClass("opac");
    }
    else if (userPermissions.HelpDesk) {
        $("#HelpDeskBox").removeClass("opac");
        var module = $("#HelpDeskBox >p");
        (module[1].firstElementChild).removeAttribute("onclick");
        //hack for IE - clicking on href does not respond; but open link in new tab does!
        $('#HelpDeskBox').html($('#HelpDeskBox').html());
    }

   /* if (userPermissionArray.GenericTool == false) {
        // $("#HelpDeskBox").attr("disabled", "disabled").off('click');
        $("#generic_tool").addClass("opac");
    }
    else if (userPermissions.GenericTool) {
        $("#generic_tool").removeClass("opac");
        var module = $("#generic_tool >p");
        (module[1].firstElementChild).removeAttribute("onclick");
    }
    if (userPermissionArray.BDLTool == false) {
        // $("#HelpDeskBox").attr("disabled", "disabled").off('click');
        $("#bdl_tool").addClass("opac");
    }
    else if (userPermissionArray.BDLTool) {
        $("#bdl_tool").removeClass("opac");
        var module = $("#bdl_tool >p");
        (module[1].firstElementChild).removeAttribute("onclick");
    }
    if (userPermissionArray.PatientFlow == false) {
        // $("#HelpDeskBox").attr("disabled", "disabled").off('click');
        $("#acthar_tool").addClass("opac");
    }
    else if (userPermissionArray.PatientFlow) {
        $("#acthar_tool").removeClass("opac");
        var module = $("#acthar_tool >p");
        (module[1].firstElementChild).removeAttribute("onclick");
    }  */

}
