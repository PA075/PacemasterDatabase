/// <reference path="../lib/jquery/jquery-1.8.2.min.js" />
(function (PHARMAACE) {
    (function (FORECASTAPP) {
        (function (SHARE) {
            PHARMAACE.FORECASTAPP.SHARE.autocompleteListData = "";
            PHARMAACE.FORECASTAPP.SHARE.usersInformation = "";
            PHARMAACE.FORECASTAPP.SHARE.shareType = "";
            PHARMAACE.FORECASTAPP.SHARE.permissionList = "";
            PHARMAACE.FORECASTAPP.SHARE.permissions = {
                Author: 1, Full: 2, Edit: 3,ReadOnly: 4
            };
            PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser = 0;
            PHARMAACE.FORECASTAPP.SHARE.selectedLineage = "";
            PHARMAACE.FORECASTAPP.SHARE.FlagToclearSearchbox = false;
            PHARMAACE.FORECASTAPP.SHARE.currentAddedUserShareList = [];
            PHARMAACE.FORECASTAPP.SHARE.loadAutocompleteData = function()
            {
                var Users = [];
                var modelType;
               // var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
                if (PHARMAACE.FORECASTAPP.SHARE.shareType == "Forecast") {
                     modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));

                }
                else {
                     modelType = 1;
                }
                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetUserListForAutocomplete", { type: modelType },
                      function (result) {
                          if (result.success) {
                              if (result.data) {
                                  Users = result.data;
                                  PHARMAACE.FORECASTAPP.SHARE.autocompleteListData = Users.UsersList;
                              }
                          }
                          else
                          {
                              //failed to get autocomplete list
                          }
                       },
                           function (result) {
                               //failed to get autocomplete list
                           });
            }

            PHARMAACE.FORECASTAPP.SHARE.autocompleteForUsers = function()
            {        
                   PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery-ui.js", function () {
                        $("#inputPassword").autocomplete({
                         source: function (request, response) {
                                var matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex(request.term), "i");
                                response($.grep(PHARMAACE.FORECASTAPP.SHARE.autocompleteListData, function (item) {
                                    return matcher.test(item.label);
                                }));
                            },
                           
                            minLength: 1,
                            select: function (event, ui) {
                                if(ui.item)
                                    $("#inputPassword").val(ui.item.label);
                            },
                            focus: function (event, ui) {
                                event.preventDefault();
                                if (ui.item)
                                    $("#inputPassword").val(ui.item.label);
                            }
                        });
                        
                   });           
            }


            PHARMAACE.FORECASTAPP.SHARE.loadUsers = function () {

                if (PHARMAACE.FORECASTAPP.SHARE.shareType == "Forecast") {
                    var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));

                }
                else {
                    var modelType = 1;
                }
                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetAllUsers",{ type: modelType},
                        function (result) {
                            if (result.success) {

                                PHARMAACE.FORECASTAPP.SHARE.usersInformation = result.users;
                              
                            }
                            else
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching user details failed: " + result.errors.join(), '');
                        },
                        function (result) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching user details failed! ", '');
                        });


           
            }

         

            PHARMAACE.FORECASTAPP.SHARE.listofPermissions = function (arrofPermissions)
            {
                PHARMAACE.FORECASTAPP.SHARE.permissionList = arrofPermissions;
            }
            PHARMAACE.FORECASTAPP.SHARE.checkShareType = function (shareType)
            {
                PHARMAACE.FORECASTAPP.SHARE.shareType = shareType;
            }
           
            PHARMAACE.FORECASTAPP.SHARE.generalizedPressedFun = function (event) {
                setTimeout(function () {
                  
                    if ($('.ui-autocomplete').last().css("display", "block"))
                        $('.ui-autocomplete li').attr('onclick', 'PHARMAACE.FORECASTAPP.SHARE.autocompleteClick(this)')
                }, 1000);
                if (event != undefined) {
                    if (event.keyCode === 13) {
                        event.preventDefault();
                        var flagforShare = false;
                        $('#prdverid tr.innerTrShareForcast').each(function () {
                          
                            var email = ($(this).find('td:nth-child(2)').text()).toLowerCase().trim();
                         
                            var currentEmail = (event.target.value).toLowerCase().trim();
                      
                           
                            var rtrn = email.localeCompare(currentEmail);
                            if (rtrn == 0) {
                                flagforShare = true;
                            }
                        });
                        if (flagforShare == false)
                            PHARMAACE.FORECASTAPP.SHARE.validate(event, "");
                    }

                }
            }
            PHARMAACE.FORECASTAPP.SHARE.autocompleteClick = function (current) {
                var selectedEmail = undefined;
                var flagforShare = false;
                //PHARMAACE.FORECASTAPP.SHARE.checkShareType(shareType);
                //PHARMAACE.FORECASTAPP.SHARE.listofPermissions(arrofPermissions);
                //if ($('#prdverid tr[class="ShareUsers"]').length > 0) {
                //$('#prdverid tr[class="ShareUsers"]').each(function () {
                if ($('#prdverid tr.innerTrShareForcast').length > 0) {
                    $('#prdverid tr.innerTrShareForcast').each(function () {
                        var email = ($(this).find('td:nth-child(2)').text()).toLowerCase().trim();
                        selectedEmail = (current.innerText).toString();
                        var currentEmail = (selectedEmail).toLowerCase().trim();
                        var rtrn = email.localeCompare(currentEmail);
                        if (rtrn == 0) {
                            flagforShare = true;
                        }
                    });
                }
                else
                    selectedEmail = (current.innerText).toString();
                if (flagforShare == false)
                    PHARMAACE.FORECASTAPP.SHARE.validate(undefined, selectedEmail);
            }
            
            PHARMAACE.FORECASTAPP.SHARE.TooltipForTr = function (i) {
                $('#getpermission' + i).selectpicker();
                $("#getpermission" + i + " option").each(function (index) {
                    var fortitle = $(this).attr('data-title');
                    $('#dropdownOfShare' + i + ' li').eq(index).attr("data-toggle", "tooltip");                
                    $('#dropdownOfShare' + i + ' li').eq(index).attr("title", fortitle);
                });
                $('#dropdownOfShare' + i + '  .multiselect button').click(function (e) {                   
                    e.preventDefault();                   
                    $('#dropdownOfShare' + i + '  [data-toggle="tooltip"]').tooltip('hide');
                    $('#dropdownOfShare' + i + '  [data-toggle="tooltip"]').tooltip('destroy');
                    setTimeout(function () {
                        $('#dropdownOfShare' + i + ' .tooltip').remove();
                        $('#dropdownOfShare' + i + '  [data-toggle="tooltip"]').tooltip({
                            placement: 'right',
                            html: true
                        });
                       
                    }, 1000);
                    $('#dropdownOfShare' + i + '  .multiselect li').click(function (e) {
                       // setTimeout(function () {
                        $('#dropdownOfShare' + i + '  [data-toggle="tooltip"]').tooltip({
                            placement: 'right',
                            html: true
                        });                       
                      // }, 1000);
                    });
                });
                
            }

            PHARMAACE.FORECASTAPP.SHARE.validate = function (e, text) {
                var flagForSharedUserArray = PHARMAACE.FORECASTAPP.SHARE.autocompleteListData;
                if (e != undefined && text == "")
                    text = e.target.value;
                var str = '';
                var str1 = $('#prdverid tbody');
                var flagForSharedUser = false;
                for (var i = 0; i < PHARMAACE.FORECASTAPP.SHARE.usersInformation.length; i++) {
                    if (PHARMAACE.FORECASTAPP.SHARE.usersInformation[i].Email.toLowerCase() == text.toLowerCase()) {
                        flagForSharedUser = true;
                        var count = PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser;
                        var tableRef = document.getElementById('prdverid').getElementsByTagName('tbody')[0];
                        str += '<tr class="ShareUsers innerTrShareForcast" unShareId=' + PHARMAACE.FORECASTAPP.SHARE.usersInformation[i].UserId + '>';
                        str += '<td class="bs-checkbox"> {0} {1} </td>'.replace("{0}", PHARMAACE.FORECASTAPP.SHARE.usersInformation[i].FirstName).replace("{1}", PHARMAACE.FORECASTAPP.SHARE.usersInformation[i].LastName);
                        str += '<td id="shareuseremail" style = ""> ' + PHARMAACE.FORECASTAPP.SHARE.usersInformation[i].Email + '</td>';
                        str += '<td style="display:none;" class="divOne">' + PHARMAACE.FORECASTAPP.SHARE.usersInformation[i].UserId + '</td>';
                        str += '<td><div id="dropdownOfShare' + count + '"><select type="text" id="getpermission' + count + '" class="selectpicker form-control multiselect multiselect-icon" >';
                        PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser++;
                        if (PHARMAACE.FORECASTAPP.SHARE.shareType == "Forecast") {
                            var messagesForTooltip = ["User can edit and share the forecast", "User can edit the forecast but cannot share", "User can view the forecast but cannot edit or share"];
                            for (var j = 0 ; j < PHARMAACE.FORECASTAPP.SHARE.permissionList.length ; j++) {
                                var nameToDisplay = "";
                                var item1 = PHARMAACE.FORECASTAPP.SHARE.permissionList[j];
                                (item1 == "ReadOnly") ? (nameToDisplay = "Read Only"):(nameToDisplay=item1);
                                str += '<option value=' + PHARMAACE.FORECASTAPP.SHARE.permissions[PHARMAACE.FORECASTAPP.SHARE.permissionList[j]] + ' data-title="' + messagesForTooltip[j] + '">' + nameToDisplay + '</option>';
                            }
                        }
                        else if (PHARMAACE.FORECASTAPP.SHARE.shareType == "UserWorkSpace") {
                            if (PHARMAACE.FORECASTAPP.SHARE.permissionMsgFlagFileOrFolder) {
                                var messagesForTooltip = ["User can Copy,Delete,Download,Paste,Rename,Share", "User can Copy,Download,Paste,</br>Rename,Share</br>User can not Delete", "User can Download only</br>User can not Copy,Delete,Paste,Rename,Share ", "User can View only</br>User can not Copy,Delete,</br>Download,Paste,Rename,Share"];
                                for (var k = 0 ; k < PHARMAACE.FORECASTAPP.SHARE.permissionList.length ; k++) {
                                    var nameToDisplay = "";
                                    var item1 = PHARMAACE.FORECASTAPP.SHARE.permissionList[k].Name;
                                    (item1 == "Share") ? (nameToDisplay = "Full") : (item1 == "Download") ? (nameToDisplay = "Share") : (item1 == "Open") ? (nameToDisplay = "Download") : (nameToDisplay = "View");
                                    str += '<option id=' + PHARMAACE.FORECASTAPP.SHARE.permissionList[k].Id + ' value="' + PHARMAACE.FORECASTAPP.SHARE.permissionList[k].Name + '" data-title="' + messagesForTooltip[k] + '">' + nameToDisplay + '</option>';
                                }
                            }
                            else {//indicates folder or project permission
                                if (PHARMAACE.FORECASTAPP.SHARE.selectedLineage == "0") {
                                    var messagesForTooltip = ["User can Create Folder,</br>Delete,Share", "User can Delete,Paste,Share</br>User can not Create Folder"];
                                    for (var k = 0 ; k < PHARMAACE.FORECASTAPP.SHARE.permissionList.length ; k++) {
                                        var nameToDisplay = "";
                                        var item1 = PHARMAACE.FORECASTAPP.SHARE.permissionList[k].Name;
                                        (item1 == "FullControl") ? (nameToDisplay = "Full Control") : (nameToDisplay = item1);
                                        str += '<option id=' + PHARMAACE.FORECASTAPP.SHARE.permissionList[k].Id + ' value="' + PHARMAACE.FORECASTAPP.SHARE.permissionList[k].Name + '" data-title="' + messagesForTooltip[k] + '">' + nameToDisplay + '</option>';
                                    }
                                }
                                else {
                                    var messagesForTooltip = ["User can Create Folder,Copy,Delete,Paste,Rename,Share,Upload File", "User can Copy,Delete,Paste,Rename,Share,Upload File</br>User can not Create Folder"];
                                    for (var k = 0 ; k < PHARMAACE.FORECASTAPP.SHARE.permissionList.length ; k++) {
                                        var nameToDisplay = "";
                                        var item1 = PHARMAACE.FORECASTAPP.SHARE.permissionList[k].Name;
                                        (item1 == "FullControl") ? (nameToDisplay = "Full Control") : (nameToDisplay = item1);
                                        str += '<option id=' + PHARMAACE.FORECASTAPP.SHARE.permissionList[k].Id + ' value="' + PHARMAACE.FORECASTAPP.SHARE.permissionList[k].Name + '" data-title="' + messagesForTooltip[k] + '">' + nameToDisplay + '</option>';
                                    }
                                }
                            }
                        }

                        str += '</select></div>';
                        str += '</td>';
                        str += '<td><i class="fa fa-times" aria-hidden="true" style="cursor:pointer;" title="Unshare"  onclick="unshareForecast(' + PHARMAACE.FORECASTAPP.SHARE.usersInformation[i].UserId + ');"></i></td>';
                        str += '</tr>';
                        // tableRef.innerHTML = str + tableRef.innerHTML;
                        str1.append(str);
                        PHARMAACE.FORECASTAPP.SHARE.currentAddedUserShareList.push(PHARMAACE.FORECASTAPP.SHARE.usersInformation[i].UserId);
                        PHARMAACE.FORECASTAPP.SHARE.TooltipForTr(count);
                        break;
                    }
                }
                if (flagForSharedUser == false) {
                    for (var i = 0; i < flagForSharedUserArray.length; i++)
                    {
                        if (flagForSharedUserArray[i].value == text)
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Project is already shared to this user", '');
                    }
            
                }
                   

                // $('#inputPassword').autocomplete({ source: PHARMAACE.FORECASTAPP.SHARE.autocompleteListData });
                if (PHARMAACE.FORECASTAPP.SHARE.shareType == "Forecast") {
                    $("#VersionList").selectpicker('refresh');
                }                
            }

            PHARMAACE.FORECASTAPP.SHARE.ShowSharePermission = function (item, permissionListofEnum) {
               // var stylestr = "background-color:#800000;";
                //var stylestr = "background-color:#bbe3e2;"
                var selectedStyle = 'selected="selected';
                var str = "";
                if (PHARMAACE.FORECASTAPP.SHARE.shareType == "Forecast") {
                    var messagesForTooltip = ["User can edit and share the forecast", "User can edit the forecast but cannot share", "User can view the forecast but cannot edit or share"];
                    permissionListofEnum = PHARMAACE.FORECASTAPP.SHARE.permissionList;
                    for (var i = 0 ; i < permissionListofEnum.length ; i++) {
                        var nameToDisplay = "";
                        var item1 = permissionListofEnum[i];
                        (item1 == "ReadOnly") ? (nameToDisplay = "Read Only") : (nameToDisplay = item1);
                        if (item == PHARMAACE.FORECASTAPP.SHARE.permissions[permissionListofEnum[i]]) {
                            str += '<option value=' + PHARMAACE.FORECASTAPP.SHARE.permissions[permissionListofEnum[i]] + ' data-title="' + messagesForTooltip[i] + '"  selected=' + selectedStyle + '  >' + nameToDisplay + '</option>';
                            //str += '<option value=' + PHARMAACE.FORECASTAPP.SHARE.permissions[permissionListofEnum[i]] + ' data-title="' + messagesForTooltip[i] + '" style=' + stylestr + '  selected=' + selectedStyle + '>' + permissionListofEnum[i] + '</option>';
                        }
                        else {
                            str += '<option value=' + PHARMAACE.FORECASTAPP.SHARE.permissions[permissionListofEnum[i]] + ' data-title="' + messagesForTooltip[i] + '" >' + nameToDisplay + '</option>';
                        }
                    }
                }
                else if (PHARMAACE.FORECASTAPP.SHARE.shareType == "UserWorkSpace") {
                    if (PHARMAACE.FORECASTAPP.SHARE.permissionMsgFlagFileOrFolder) {
                        var messagesForTooltip = ["User can Copy,Delete,Download,Paste,Rename,Share", "User can Copy,Download,Paste,Rename,Share</br>User can not Delete", "User can Download only</br>User can not Copy,Delete,Paste,Rename,Share ", "User can View only</br>User can not Copy,Delete,</br>Download,Paste,Rename,Share"];
                        for (var i = 0 ; i < permissionListofEnum.length ; i++) {
                            var nameToDisplay = "";
                            var item1 = permissionListofEnum[i].Name;
                            (item1 == "Share") ? (nameToDisplay = "Full") : (item1 == "Download") ? (nameToDisplay = "Share") : (item1 == "Open") ? (nameToDisplay = "Download") : (nameToDisplay = "View");
                            if (item == permissionListofEnum[i].Id) {
                                str += '<option id=' + permissionListofEnum[i].Id + ' value="' + permissionListofEnum[i].Name + '" data-title="' + messagesForTooltip[i] + '" selected="' + selectedStyle + '">' + nameToDisplay + '</option>';
                            }
                            else {

                                str += '<option id=' + permissionListofEnum[i].Id + ' data-title="' + messagesForTooltip[i] + '" value="' + permissionListofEnum[i].Name + '" >' + nameToDisplay + '</option>';
                            }
                        }
                    }
                    else {//indicates folder or project permission
                        if (PHARMAACE.FORECASTAPP.SHARE.selectedLineage == "0") {
                            var messagesForTooltip = ["User can Create Folder,</br>Delete,Share", "User can Delete,Paste,Share</br>User can not Create Folder"];
                            for (var i = 0 ; i < permissionListofEnum.length ; i++) {
                                var nameToDisplay = "";
                                var item1 = permissionListofEnum[i].Name;
                                (item1 == "FullControl") ? (nameToDisplay = "Full Control") : (nameToDisplay = item1);
                                if (item == permissionListofEnum[i].Id) {

                                    str += '<option id=' + permissionListofEnum[i].Id + ' value="' + permissionListofEnum[i].Name + '" data-title="' + messagesForTooltip[i] + '"  selected=' + selectedStyle + '>' + nameToDisplay + '</option>';
                                }
                                else {
                                    str += '<option id=' + permissionListofEnum[i].Id + ' data-title="' + messagesForTooltip[i] + '" value="' + permissionListofEnum[i].Name + '" >' + nameToDisplay + '</option>';
                                }
                            }
                        }
                        else {
                            var messagesForTooltip = ["User can Create Folder,Copy,Delete,Paste,Rename,Share,Upload File", "User can Copy,Delete,Paste,Rename,Share,Upload File</br>User can not Create Folder"];
                            for (var i = 0 ; i < permissionListofEnum.length ; i++) {
                                var nameToDisplay = "";
                                var item1 = permissionListofEnum[i].Name;
                                (item1 == "FullControl") ? (nameToDisplay = "Full Control") : (nameToDisplay = item1);
                                if (item == permissionListofEnum[i].Id) {

                                    str += '<option id=' + permissionListofEnum[i].Id + ' value="' + permissionListofEnum[i].Name + '" data-title="' + messagesForTooltip[i] + '" selected=' + selectedStyle + '>' + nameToDisplay + '</option>';
                                }
                                else {
                                    str += '<option id=' + permissionListofEnum[i].Id + ' data-title="' + messagesForTooltip[i] + '" value="' + permissionListofEnum[i].Name + '" >' + nameToDisplay + '</option>';
                                }
                            }
                        }
                        
                    }
                }

                return str;
            }




        }(window.PHARMAACE.FORECASTAPP.SHARE = window.PHARMAACE.FORECASTAPP.SHARE || {}));
    }(window.PHARMAACE.FORECASTAPP = window.PHARMAACE.FORECASTAPP || {}));
}(window.PHARMAACE = window.PHARMAACE || {}));