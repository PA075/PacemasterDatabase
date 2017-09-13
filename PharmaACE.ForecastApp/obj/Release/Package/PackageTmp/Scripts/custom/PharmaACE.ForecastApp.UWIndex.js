
//****************************************************LeftPaneReportingView.ascx**********************************************************************
var scrollerFolder='';
var scrollerSearch='';
var scrollerReport='';
$(document).on('ifUnchecked', '#filter-range', function () {
    $('#daterangeid .cards').removeClass('ShowClass');
    $('#daterangeid .cards').addClass('hideClass');
});

function leftPaneReportingViewReady() {

    $("#tree6").niceScroll({
        cursorfixedheight: 150
    });

    $('input.flat1').iCheck({
        checkboxClass: 'icheckbox_flat-aero',
        radioClass: 'iradio_flat-aero'

    });
   

    $('#last3daysrep').on('ifChecked', function (event) {
        dayFilterForReporting();
    });

    $('#last7daysrep').on('ifChecked', function (event) {
        dayFilterForReporting();
    });

    $('#last30daysrep').on('ifChecked', function (event) {
        dayFilterForReporting();
    });

    $('#filter-rangeforreport').on('ifChecked', function (event) {

        $('#daterangeidforreport .cards').removeClass('hideClass');
        $('#daterangeidforreport .cards').addClass('ShowClass');


    });
    $(document).on('ifUnchecked', '#filter-rangeforreport', function () {
        $('#daterangeidforreport .cards').removeClass('ShowClass');
        $('#daterangeidforreport .cards').addClass('hideClass');
    });


    $('#datepicker-startforreport').Zebra_DatePicker({
        view: 'years',
        format: 'M d, Y',
        pair: $('#datepicker-endforreport'),
        onSelect: function (elements, options, edata, input) {
            //   reportSettings.startDate = $(input).val();

            dayFilterForReporting();

        }
    });

    $('#datepicker-endforreport').Zebra_DatePicker({
        direction: 1,
        format: 'M d, Y',
        view: 'years',
        onSelect: function (elements, options, edata, input) {
            //  reportSettings.endDate = $(input).val();

            dayFilterForReporting();

        }
    });

    $('#datepicker-startforreport').change(function () {

        dayFilterForReporting();
        //reportSettings.startDate = $(this).val();
    });
    $('#datepicker-endforreport').change(function () {
        dayFilterForReporting();
    });

    $('#filter-range').on('ifChecked', function (event) {
        $('#daterangeid .cards').removeClass('hideClass');
        $('#daterangeid .cards').addClass('ShowClass');
    });

    $('#byproject').selectpicker();

    $('input.flat').iCheck({
        checkboxClass: 'icheckbox_flat-aero',
        radioClass: 'iradio_flat-aero'
    });

    $('#datepicker-start').Zebra_DatePicker({
        view: 'years',
        format: 'M d, Y',
        pair: $('#datepicker-end'),
        onSelect: function (elements, options, edata, input) {
            reportSettings.startDate = $(input).val();
        }
    });

    $('#datepicker-end').Zebra_DatePicker({
        direction: 1,
        format: 'M d, Y',
        view: 'years',
        onSelect: function (elements, options, edata, input) {
            reportSettings.endDate = $(input).val();
        }
    });

    $('#datepicker-start').change(function () {
        reportSettings.startDate = $(this).val();
    });
    $('#datepicker-end').change(function () {
        reportSettings.endDate = $(this).val();
    });

}
//****************************************************LeftPaneReportingView.ascx**********************************************************************

//****************************************************LeftPaneSearchView.ascx*************************************************************************

$(document).on('ifUnchecked', '#filter-range', function () {
    $('#daterangeid .cards').removeClass('ShowClass');
    $('#daterangeid .cards').addClass('hideClass');
});


$('#hospital').on('ifChecked', function (event) {

    
    $('#ARD').removeClass('checked');
    $('#hospital').addClass('checked');


});


$('#ARD').on('ifChecked', function (event) {

    $('#hospital').removeClass('checked');
    $('#ARD').addClass('checked');


});



function leftPaneSearchViewReady() {
    $('#Last3Days').on('ifChecked', function (event) {
        rootFolderListAdvSearch();
    });

    $('#LastMonth').on('ifChecked', function (event) {
        rootFolderListAdvSearch();

    });

    $('#DateFilter').on('ifChecked', function (event) {
        rootFolderListAdvSearch();

    });

    $('#treeforfolderlist #tree0').treed({ openedClass: 'glyphicon-folder-open', closedClass: 'glyphicon-folder-close' });
    $("#tree0").niceScroll({
        cursorfixedheight: 70
    });
    $("#tree3").niceScroll({
        cursorfixedheight: 70
    });
    $("#tree5").niceScroll({
        cursorfixedheight: 70
    });

    $('input.flat').iCheck({
        checkboxClass: 'icheckbox_flat-aero',
        radioClass: 'iradio_flat-aero'

    });
    //$('#byfolder').selectpicker();

    $('#filter-range').on('ifChecked', function (event) {
        $('#daterangeid .cards').removeClass('hideClass');
        $('#daterangeid .cards').addClass('ShowClass');
    });

    $('#datepicker-start').Zebra_DatePicker({
        view: 'years',
        format: 'M d, Y',
        pair: $('#datepicker-end'),
        onSelect: function (elements, options, edata, input) {
            rootFolderListAdvSearch();
            //   reportSettings.startDate = $(input).val();
        }
    });

    $('#datepicker-end').Zebra_DatePicker({
        direction: 1,
        format: 'M d, Y',
        view: 'years',
        onSelect: function (elements, options, edata, input) {

            rootFolderListAdvSearch();
            //  reportSettings.endDate = $(input).val();
        }
    });

    $('#datepicker-start').change(function () {

        rootFolderListAdvSearch();

        //reportSettings.startDate = $(this).val();
    });

    $('#datepicker-end').change(function () {

        rootFolderListAdvSearch();

    });
}

//****************************************************LeftPaneSearchView.ascx*************************************************************************

//*****************************************************UserWorkspaceIndex.aspx*************************************************************************
        
        var AVselectedProj = 0;
        var shareType = "UserWorkSpace";
        var PreText = "";
        var selectedTypeForRename = "";
        var menuns = [];
        preDealDetailsOfCurrentProj = null;


        function Insertnewline() {
            var key = window.event.keyCode;
            if (key == 13) {
                document.getElementById("performance").value = document.getElementById("performance").value ;
                return false;

            }
            else
                return true;
        }
        function LimitThousandChar()
        {
            var charcount = document.getElementById("performance").value;
            if (charcount.length > 1000)
            {
                //document.getElementById("performance").checkValidity("Char length should be less than 1000");
                alert("Char length should be less than 1000");
                return false;
            }
            else {
                return true;
            }
        }
         function uploadDocument() {
             
            parentdSelectedlineage = lineageForSpan;
            var Lineage = parentdSelectedlineage;
            if (lineageForSpan.toString().includes(" "))
            {
                lineageForSpan = selectedLineage.trim();

            }
            if (lineageForSpan.toString().trim() == "0") {
                lineageForSpan = selectedFolderId;
            }           
            else {
                if (lineageForSpan.toString().includes(selectedFolderId)) {

                }
                else {
                    Lineage = Lineage + PHARMAACE.FORECASTAPP.CONSTANTS.LINEAGE_SPLITTER + selectedFolderId;
                }               
            }      

            //<%--<%:Html.Raw(PharmaACE.ForecastApp.Business.GenUtil.LINEAGE_SPLITTER)%> --%>+selectedFolderId;
        
            var uploader = document.getElementById('upload-file-selector');
            
            
            var formdata = new FormData(); //FormData object
          

            if (uploader.files == null || uploader.files.length == 0) {
                var uploader = document.getElementById('BSbtninfo');
                var notValidFileSize = PHARMAACE.FORECASTAPP.UTILITY.checkFileSize(uploader.files);
                if (notValidFileSize) {
                    document.getElementById('BSbtninfo').value = "";
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to upload : " + "file size exceeded.", '');
                   
                    return;
                }
                else {
                    for (var i = 0; i < uploader.files.length; i++) {
                        var val = uploader.files[i].name.toLowerCase();
                        var ext = val.substr(val.lastIndexOf('.') + 1);
                        if (PHARMAACE.FORECASTAPP.FILETYPE.indexOf(ext) == -1) {
                            document.getElementById('BSbtninfo').value = "";
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Sorry, this file type is not permitted for security reasons...", '');
                            
                            return;
                        }
                        formdata.append(uploader.files[i].name, uploader.files[i]);
                    }
                }
            }
            else {
                var notValidFileSize = PHARMAACE.FORECASTAPP.UTILITY.checkFileSize(uploader.files);
                if (notValidFileSize) {
                    document.getElementById('upload-file-selector').value="";
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to upload : " + "file size exceeded.", '');
                    
                    return;
                }
                else {
                    for (var i = 0; i < uploader.files.length; i++) {
                        var val = uploader.files[i].name.toLowerCase();
                        var ext = val.substr(val.lastIndexOf('.') + 1);
                        if (PHARMAACE.FORECASTAPP.FILETYPE.indexOf(ext) == -1) {
                            document.getElementById('upload-file-selector').value="";
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Sorry, this file type is not permitted for security reasons...", '');
                          
                            return;
                        }
                        formdata.append(uploader.files[i].name, uploader.files[i]);
                    }
                }
            }
           
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are uploading document...", 'editableWorkSpace', '15', '');

            var controllerUrl = "/UserWorkSpace/UploadDocuments?lineage={0}&parentId={1}".replace('{0}', Lineage).replace('{1}', selectedFolderId);
           
            var xhr = new XMLHttpRequest();
            xhr.open('POST', controllerUrl);
            xhr.send(formdata);
            xhr.onreadystatechange = function () {

                
                if (xhr.readyState == 4 && xhr.status == 200) {
                    if (xhr.responseText.includes("true") != true)
                    {
                        var r = xhr.responseText.split('[');
                        r[1].replace('"', "");
                        r[1].replace(']', "");
                        r[1].replace('}', "");
                        if (r[1].includes("already")) {
                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                            document.getElementById('upload-file-selector').value = "";
                            document.getElementById('BSbtninfo').value = "";
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Uploadig Failed : " + r[1]);

                        }
                        else {
                            if (xhr.responseText.includes("uploadedFileCount") == true)
                            {
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                document.getElementById('upload-file-selector').value= "";
                                document.getElementById('BSbtninfo').value = "";
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Document uploading failed.");
                            } else {
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                document.getElementById('upload-file-selector').value = "";
                                document.getElementById('BSbtninfo').value = "";
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to upload : " + ",one of the selected file has invalid extension");
                            }         
                        }                  
                    }
                    else {
                        $('#btnuploadModalClose').click();
                        callEditableWorkSpaceJSON(selectedFolderId, Lineage);
                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                        document.getElementById('upload-file-selector').value = "";
                        document.getElementById('BSbtninfo').value = "";
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Documents uploaded successfully", '');
                       // document.getElementsByClassName('bootstrap-filestyle input-group')[0].firstChild.value = "";
                       
                        var split = xhr.responseText.split(',')[1].replace('"', "").split(':');
                        var fileCount = parseInt(split[1]);
                        if (fileCount > 0)
                        {
                            if (lineageForSpan.toString().trim() == "0") {
                                var ids = selectedFolderId;
                                var span = document.getElementById("SpnFCount" + ids);
                                var prevCount = span.innerHTML;
                                span.innerHTML = parseInt(parseInt(prevCount) + fileCount);

                            }
                            else {
                                var ids = lineageForSpan.toString().split(PHARMAACE.FORECASTAPP.CONSTANTS.LINEAGE_SPLITTER);

                                for (var i = 0; i < ids.length; i++) {

                                    var span = document.getElementById("SpnFCount" + ids[i]);
                                    var prevCount = span.innerHTML;
                                    span.innerHTML = parseInt(parseInt(prevCount) + fileCount);
                                }
                            }
                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                            document.getElementById('upload-file-selector').value = "";
                            document.getElementById('BSbtninfo').value = "";
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Documents uploaded successfully.", '');
                        }
                        else {
                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                            document.getElementById('BSbtninfo').value = "";
                            document.getElementById('upload-file-selector').value = "";
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Document uploading failed.", '');                            

                        }


                        
                       
                    }
                    
                }
                
                
            }
            
        }
              

        /*function contentFilterByEnter(e) {
            if (e.keyCode === 13) {
                ContentFilterSearch();
            }
        }*/
        

        function getColumnIndex(name) {
            // columnArr - holds all the name of columns in array
            var colname = name.split(' ')[1];
            for (var i = 0; i < columnArr.length; i++) {
                if (columnArr[i] === colname) {
                    return i;
                }
            }
            return 0;
        };
       
        function addContextMenu() {
            var tableid = $('#drop table').attr('id');
            $.contextMenu({

                //selector: '#userworkspaceTable tbody tr',
                selector: '#' + tableid + ' tbody tr[class*=addMenu]',
              
                


                build: function ($trigger, e) {
                    // this callback is executed every time the menu is to be shown
                    // its results are destroyed every time the menu is hidden
                    // e is the original contextmenu event, containing e.pageX and e.pageY (amongst other data)
                    // $trigger is the element that was rightclicked on - get its id here
                    var permission = $trigger.attr('assignedpermission');
                    // build the menu items
                    if (permission == "Share") {
                        var menus = {
                            "download": { name: "Download", icon: "fa-download" },
                            "copy": { name: "Copy", icon: "fa-files-o" },
                            "Share": { name: "Permission", icon: "fa-share-square-o" },
                            "rename": { name: "Rename", icon: "fa-pencil-square-o" },
                            "delete": { name: "Delete", icon: "fa-trash-o" }
                        }
                    }

                    if (permission == "Download") {
                        var menus = {
                            "download": { name: "Download", icon: "fa-download" },
                            "copy": { name: "Copy", icon: "fa-files-o" },
                            "Share": { name: "Permission", icon: "fa-share-square-o" },
                            "rename": { name: "Rename", icon: "fa-pencil-square-o" }
                        }
                    }
                    else if (permission == "Open") {
                        var menus = {                           
                            
                            "download": { name: "Download", icon: "fa-download" }
                        }
                    }

                    else if (permission == "Moderator") {
                        var menus = {
                            "download": { name: "Download", icon: "fa-download" },
                            "copy": { name: "Copy", icon: "fa-files-o" },
                            "Share": { name: "Permission", icon: "fa-share-square-o" },
                            "rename": { name: "Rename", icon: "fa-pencil-square-o" }
                        }
                    }


                    else if (permission == "FullControl") {
                        var menus = {
                            "download": { name: "Download", icon: "fa-download" },
                            "copy": { name: "Copy", icon: "fa-files-o" },
                            "Share": { name: "Permission", icon: "fa-share-square-o" },
                            "rename": { name: "Rename", icon: "fa-pencil-square-o" },
                            "delete": { name: "Delete", icon: "fa-trash-o" }
                        }
                    }



                    else if (permission == "View") {
                        var menus = {

                        }
                    }


                    else if (permission == "NoAccess") {
                        var menus = {

                        }
                    }
                    return {
                        callback: function (key, options) {

                            var x, ParentId;

                            var ListItem = $("li[class*='context-menu-active']");
                            var pid = $(ListItem).attr('id');
                           
                            if (typeof pid != 'undefined') {
                                document.getElementById("txtParent").value = pid;
                            }

                            trRow = $("tr[class*='context-menu-active']");
                            
                            var PrevName = trRow.find('#contentName').text();

                            ParentId = $(trRow).attr('folderId');
                            var lineageForAlreadyShare = $(trRow).attr('filelineage');
                            var CopyFileId = ParentId;
                            var deletFileId = ParentId;
                            selectedFileIdForReporting = ParentId;
                            if (typeof ParentId != 'undefined') {
                                document.getElementById("txtParent").value = ParentId;
                            }
                            if (typeof selectedFileIdForReporting != 'undefined') {
                                document.getElementById("txtParentRename").value = selectedFileIdForReporting;
                            }
                            var tableid = $('#drop table').attr('id');
                            //var values = $('#userworkspaceTable tr.context-menu-active td').map(function (index, td) {
                            var values = $('#' + tableid + ' tr.context-menu-active td').map(function (index, td) {

                                var ret = {};
                                if (index == 8) {
                                    x = $(td).text();
                                }
                                if (index == 2) {

                                    ParentId = $(td).text();
                                    var newpid = $(x).attr('folderId ');


                                }
                                ret[index] = $(td).text();
                                return ret;
                            }).get();

                            if (x == "File") {
                                alert("The directry or file can not be created under file");
                            }
                            else {

                                if (key == "new") {
                                    $('#btnmodl').click();

                                    var s = document.getElementById('txtFolderName').value
                                }
                                if (key == "uploadfile") {
                                    $('#btnupload').click();

                                    var s = document.getElementById('txtFolderName').value
                                }
                                if (key == "rename") {

                                    renameFile(PrevName);
                                }
                                if (key == "download")
                                {
                                    downloadFile(trRow);
                                }
                                if (key == "copy") {
                                    objectIdsForMultiCopy = [];
                                    LineageSForMultiCopy = [];
                                    arrayOfNamesForCopy = [];
                                    noOfFileCopy = 1;
                                    objectIdForCopy = CopyFileId;
                                    lineageForCopy = "";
                                    objectIdsForMultiCopy.push(objectIdForCopy);
                                    LineageSForMultiCopy.push(lineageForCopy);
                                    isFileCopy = true;
                                    itemsDisabled["pasteli"] = false;
                                    itemsDisabled["pasteRightPane"] = false;
                                    var tableid = $('#drop table').attr('id');
                                    var tableRef = $('#' + tableid);
                                    var folderNameForCopy = (tableRef).find(trRow).find('#contentName').text();
                                    arrayOfNamesForCopy.push(folderNameForCopy);
                                }

                                if (key == "delete")
                                {
                                    var isProceedDelete = "";
                                    var fileLineage = $(trRow).attr('fileLineage');
                                    var FileNameForDelete = trRow.find('#contentName').text();
                                    bootbox.confirm({
                                        size: 'small',
                                        message: 'Are you sure you want to delete file(s) ?',
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

                                                objectIdForDelete = deletFileId;
                                                var objectIdStringForDelete = objectIdForDelete.toString();
                                                lineageForDelete = "";
                                                PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are deleting file(s)...", 'editableWorkSpace', '15', '');



                                                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/delete", {
                                                    'objectIdStringForDelete': objectIdStringForDelete,
                                                    'lineageStringForDelete': lineageForDelete
                                                },
                                               function (result) {
                                                   if (result.result == 2) {
                                                       PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                       PHARMAACE.FORECASTAPP.UTILITY.popalert("File deleted successfully.");
                                                       trRow.remove();
                                                       if (fileLineage.toString().trim() == "0") {
                                                           var ids = selectedFolderId;
                                                           var span = document.getElementById("SpnFCount" + ids);
                                                           var prevCount = span.innerHTML;
                                                           span.innerHTML = parseInt(parseInt(prevCount) - 1);
                                                       }

                                                       else {
                                                           var ids = fileLineage.toString().split(PHARMAACE.FORECASTAPP.CONSTANTS.LINEAGE_SPLITTER);

                                                           for (var i = 0; i < ids.length; i++) {


                                                               var span = document.getElementById("SpnFCount" + ids[i]);
                                                               if (span != null) {
                                                                   var prevCount = span.innerHTML;
                                                                   span.innerHTML = parseInt(parseInt(prevCount) - 1);

                                                               }
                                                           }
                                                       }

                                                   }
                                                   else if (result.result == 1) {
                                                       PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                       PHARMAACE.FORECASTAPP.UTILITY.popalert("File already deleted");

                                                   }
                                                   else {
                                                       PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to delete file");
                                                   }
                                               },
                                               function (result) {
                                                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                                               });

                                            }
                                            else {

                                            }
                                        }
                                    });

                                    objectIdForDelete = "";
                                    lineageForDelete = "";

                                }

                                if (key == "Share") {
                                    PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait", 'editableWorkSpace', '15', '');

                                    typeOfObjectShare = "File";
                                    ObjectIdForShare = $(trRow).attr('folderId');
                                    var fileForShare = PrevName;
                                    fileNameForUnshare = PrevName;
                                    var fileLineage = $(trRow).attr('fileLineage');
                                    PHARMAACE.FORECASTAPP.SHARE.autocompleteForUsers();
  
                                    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/ProjCreators", {
                                        objectId: ObjectIdForShare, lineageForsharePopUp: fileLineage,

                                    },
                                   function (result) {
                                       if (result.success) {
                                           PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                           removeBDLDealChampOwner(result.value);


                                       }
                                       else {
                                           PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                           PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching project creators failed: " + result.errors.join(), '');
                                       }

                                   },
                              function (result) {
                                  PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching project creators failed: " + result.responseText, '');
                              });
                                    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/FecthAlreadyShared", { ObjectId: ObjectIdForShare, lineageForAlreadyShare: lineageForAlreadyShare },
                     function (result) {
                        if (result.success) {
                            if (result.userForShare.length == 0) {
                                $("#btnShowShare").click();
                                populateSharePopup(fileForShare, fileLineage);
                                $('#prdverid tr').remove();

                            }
                            else if (result.userForShare.length > 0) {

                                $("#btnShowShare").click();
                                populateSharePopupWithFetchedData(result.userForShare, fileForShare, fileLineage);

                            }
                        }

                        else
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                    },
                    function (result) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                    });
                                    lineageForAlreadyShare = "";
                                }


                            }
                        },
                        items: menus
                    };
                }



                //    callback: function (key, options) {

                //        var x, ParentId;

                //        var ListItem = $("li[class*='context-menu-active']");
                //        var pid = $(ListItem).attr('id');
                //        selectedLineage = $(ListItem).attr('lineageString');
                //        if (typeof pid != 'undefined') {
                //            document.getElementById("txtParent").value = pid;
                //        }

                //        trRow = $("tr[class*='context-menu-active']");

                //        ParentId = $(trRow).attr('folderId');
                //        var CopyFileId = ParentId;
                //        selectedFileIdForReporting = ParentId;
                //        if (typeof ParentId != 'undefined') {
                //            document.getElementById("txtParent").value = ParentId;
                //        }
                //        if (typeof selectedFileIdForReporting != 'undefined') {
                //            document.getElementById("txtParentRename").value = selectedFileIdForReporting;
                //        }
                //        var tableid = $('#drop table').attr('id');
                //        //var values = $('#userworkspaceTable tr.context-menu-active td').map(function (index, td) {
                //        var values = $('#' + tableid + ' tr.context-menu-active td').map(function (index, td) {

                //            var ret = {};
                //            if (index == 8)
                //            {
                //                x = $(td).text();
                //            }
                //            if (index == 2) {

                //                ParentId = $(td).text();
                //                var newpid = $(x).attr('folderId ');


                //            }
                //            ret[index] = $(td).text();
                //            return ret;
                //        }).get();

                //        // alert(x);

                //        if (x == "File") {
                //            alert("The directry or file can not be created under file..!!");
                //        }
                //        else {

                //            if (key == "new") {
                //                $('#btnmodl').click();

                //                var s = document.getElementById('txtFolderName').value
                //            }
                //            if (key == "uploadfile") {
                //                $('#btnupload').click();

                //                var s = document.getElementById('txtFolderName').value
                //            }
                //            if (key == "rename") {

                //                $('#btnrename').click();

                //            }
                //            if (key == "copy") {

                //                objectIdForCopy = CopyFileId;
                //                lineageForCopy = "";
                //                itemsDisabled["paste"] = false;

                //            }

                //            if (key == "share") {

                //                typeOfObjectShare = "File";
                //                ObjectIdForShare = $(trRow).attr('folderId');

                //                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/FecthAlreadyShared", { ObjectId: ObjectIdForShare },
                //function (result) {
                //    if (result.success) {
                //        if (result.userForShare.length == 0) {
                //            $("#btnShowShare").click();
                //            populateSharePopup();
                //            $('#prdverid tr').remove();

                //        }
                //        else if (result.userForShare.length > 0) {

                //            $("#btnShowShare").click();
                //            populateSharePopupWithFetchedData(result.userForShare);

                //        }
                //    }

                //    else
                //        PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                //},
                //function (result) {
                //    PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                //});

                //            }


                //        }

                //        /// var m = "clicked: " + key;

                //    },
                //    items: {

                //        "new": {
                //            name: "Create Folder", icon: "fa-folder-o", disabled:
                //                function (key, opt) {
                //                    return !!itemsDisabled[key];
                //                }
                //        },
                //        "uploadfile": {
                //            name: "Upload File", icon: "fa-files-o", disabled: function (key, opt) {
                //                return !!itemsDisabled[key];
                //            }
                //        },
                //        "rename": { name: "Rename", icon: "fa-pencil-square-o" },
                //        "download": { name: "Download", icon: "fa-download" },
                //        "share": { name: "share", icon: "fa-share-square-o" },
                //        "copy": { name: "copy", icon: "fa-share-square-o" }

                //        //"paste": {name: "Certificate", icon: "fa-certificate"},
                //        //"sep1": "---------",
                //        //"quit": {
                //        //    name: "Quit", icon: function () {
                //        //        return 'context-menu-icon context-menu-icon-quit';
                //        //    }
                //        //},

                //        //"folder": {
                //        //    name: "Create New", icon: function (opt, $itemElement, itemKey, item) {
                //        //        // Set the content to the menu trigger selector and add an bootstrap icon to the item.
                //        //        $itemElement.html('<span class="glyphicon glyphicon-star" aria-hidden="true"></span> ' + "Create New");

                //        //        // Add the context-menu-icon-updated class to the item
                //        //        return 'context-menu-icon-updated';
                //        //    }
                //        //}

                //    }

            });
        }
        function renameFile(PrevName) {
            selectedTypeForRename = "File";

            document.getElementById('txtFolderNameRename').placeholder = PrevName;
            $('#btnrename').click();
            document.getElementById('renameModalLabel').innerHTML = "Rename File";
        }
        function downloadFile(trRow) {
            $(".addMenu").off("click");

            var DownloadAnchor = trRow[0].getElementsByClassName("DownloadFile");
            DownloadAnchor[0].click();
            $('tr.addMenu').click(function () {
                var target = $(this).find('a').attr('target');
                if (target != undefined) {
                    window.open($(this).find('a').attr('href'), '_blank');
                }
                else {
                    window.location = $(this).find('a').attr('href');
                }

            });
        }
        function removeBDLDealChampOwner(value) {
            if (PHARMAACE.FORECASTAPP.SHARE.usersInformation != null) {
                var b = value[0];
                for (var i = 0; i < PHARMAACE.FORECASTAPP.SHARE.usersInformation.length; i++) {

                    if (PHARMAACE.FORECASTAPP.SHARE.usersInformation[i].UserId == value[0] || PHARMAACE.FORECASTAPP.SHARE.usersInformation[i].UserId == value[1]
                        || PHARMAACE.FORECASTAPP.SHARE.usersInformation[i].UserId == value[2]) {

                        (PHARMAACE.FORECASTAPP.SHARE.usersInformation).splice(i, 1);
                        i = i-1;
                    }
                }

            }

        }
        function isImage(extension)
        {
            if (extension == "jpg" || extension == "jpeg" || extension == "png" || extension == "bmp" || extension == "tif" || extension == "xml" || extension == "GIF" || extension == "dif")
                return true;
            return false;
        }
       
        function enableDisableMultiOperTab()
        {
            var isChecked = $("#example-select-all:checked").val() ? true : false;
            var isindeterminateActive = $("#example-select-all:indeterminate").val() ? true : false;
            if (isChecked == true || isindeterminateActive == true) {
                $('#LiDownloadDoc').removeClass('deactivateUploadDoc');
                $('#LiDeleteDoc').removeClass('deactivateUploadDoc');
                $('#LiCopyDoc').removeClass('deactivateUploadDoc');
            }
            else {
                $('#LiDownloadDoc').addClass('deactivateUploadDoc');
                $('#LiDeleteDoc').addClass('deactivateUploadDoc');
                $('#LiCopyDoc').addClass('deactivateUploadDoc');
            }
            

        }
       
        function enableMultiDocDownload() {

            var tableid = $('#drop table').attr('id');
            var checkBoxCount = 0;
            $('#' + tableid).find('tr').find('input:checkbox:checked').each(function () {
                    checkBoxCount++;
            });
            var checkboxes = 0;
            $('#' + tableid).find('tr.checkboxtr').each(function () {
                checkboxes++;
            });
            var isChecked = $("#example-select-all:checked").val() ? true : false;
            if (!(isChecked) && checkBoxCount == checkboxes - 1) {
                $("#example-select-all").prop("indeterminate", false);
                $("#example-select-all").prop("checked", true);
            }

            else if (isChecked && checkBoxCount == 1) {
                $("#example-select-all").prop("indeterminate", false);
                $("#example-select-all").prop("checked", false);
            }
            else if (checkBoxCount > 0 && checkBoxCount < checkboxes-1) {
                $("#example-select-all").prop("checked", false);
                $("#example-select-all").prop("indeterminate", true);
                 
            }
            else 
            {
                $("#example-select-all").prop("indeterminate", false);
              
            }
            enableDisableMultiOperTab();
        }

        function addFileAdvSearch(contents) {

            scrollerSearch = '';

            var tableRef = document.getElementById('drop');

            var str = '';
            var str2 = '';
            var str3 = '';
            var i = 1;
            var yoursystemday = new Date(new Date().getTime() - (120000 * 60 + new Date().getTimezoneOffset() * 60000));
            var random = Math.round(Math.round(yoursystemday));
            satr2 = '<table id="userworkspaceTable' + random + '" class="table table-striped select" cellspacing="0" width="100%" ><thead><tr class="checkboxtr"><th></th><th style=text-align:left;"><input type="checkbox" name="select_all" value="1" id="example-select-all"  ></th><th>Path</th><th>Name</th><th>Shared With</th><th>Type</th><th>Created Date</th><th>Size</th></tr></thead>';

            satr3 = '</tbody></table>';


            contents.forEach(function (content) {
                var creationDate = content.creationDate;
                var Moddate = content.Moddate;
                var NewcreationDate = new Date(parseInt(creationDate.substr(6)));
                var NewModdate = new Date(parseInt(Moddate.substr(6)));
                var date1 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(NewcreationDate));
                var formattedCreatedDate = PHARMAACE.FORECASTAPP.UTILITY.formatDateForDataTable(new Date(date1));
                var date2 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(NewModdate));
                var formattedModDate = PHARMAACE.FORECASTAPP.UTILITY.formatDateForDataTable(new Date(date2));
                /* var NewcreationDate = new Date(parseInt(creationDate.substr(6)));
                 var NewModdate = new Date(parseInt(Moddate.substr(6)));
                 var formattedCreatedDate = NewcreationDate.getDate() + "-" + (NewcreationDate.getMonth() + 1) + "-" + NewcreationDate.getFullYear();
                 var formattedModDate = NewModdate.getDate() + "-" + (NewModdate.getMonth() + 1) + "-" + NewModdate.getFullYear();*/
                var SharedWithTitle = "";

                if (content.SharedWithUsers == "-") {
                    SharedWithTitle = "";
                }
                else {
                    var SharedWithTitle = content.SharedWithUsers;
                }


                if (content.Size == null) {
                    content.Size = "-";
                }
                var isImageExtn = isImage(content.Extn.toLowerCase());
                if (content.ContentSearch == null || content.ContentSearch == "") {

                    str += '<tr class="checkboxtr" folderId="' + content.ObjectId + '"  AssignedPermission="' + content.permString + '"   folderName = "' + content.Name + '" fileLineage="' + content.Lineage + '"  >';

                }
                else {
                    str += '<tr class="checkboxtr" folderId="' + content.ObjectId + '"  AssignedPermission="' + content.permString + '"   folderName = "' + content.Name + '" fileLineage="' + content.Lineage + '" searchedText="' + content.ContentSearch + '">';

                }

                if (content.ContentSearch == "") {

                    str += '<td style="text-align:center;"></td>';
                }
                else {

                    str += '<td class=" details-control" style="text-align:center;">&nbsp;&nbsp;&nbsp;</td>';
                }

                str += '<td class="NotClickable" style=text-align:left;"><input type="checkbox" name="id[]" value="" onchange="enableMultiDocDownload()"></td>';
                var IndexPath = content.IndexPath;
                str += '<td class="contentName" title="' + content.IndexPath + '">' + IndexPath + '</td>';
                if (content.permString == "Open") {
                    str += '<td class="contentName" id="contentName" title="' + content.Name + '">' + '<a class="DownloadLinkClass DownloadFile" href="/UserWorkSpace/DownloadFile?objectId=' + content.ObjectId + '">' + content.Name + '</a></td>';

                } else if (content.permString == "View") {
                    str += '<td class="contentName" id="contentName" title="' + content.Name + '">' + content.Name + '</td>';

                }
                else if (content.Extn == "PDF" || isImageExtn == true) {
                    str += '<td class="contentName" id="contentName" title="' + content.Name + '">' + '<a class="DownloadLinkClass" href="/UserWorkSpace/openFile?objectId={0}&extn={1}"'.replace('{0}', content.ObjectId).replace('{1}', content.Extn.toLowerCase()) + ' target="_blank">' + content.Name + '</a>' +
                          '<a  allowDownload = "true"  class="DownloadLinkClass DownloadFile" href="/UserWorkSpace/DownloadFile?objectId=' + content.ObjectId + '">'
                                                        +
                        '</a><a  multipleDownload = "true"  class="DownloadLinkClass" href="/UserWorkSpace/downloadSelectedFile?objectIdString=' + objectIdString + '"></a><a multipleDelete = "true"  class="DownloadLinkClass" href="/UserWorkSpace/downloadSelectedFile?objectIdString=' + objectIdString + '"></a></td>';

                }
                else {
                    str += '<td id="contentName" class="contentName" title="' + content.Name + '">' + '<a class="DownloadLinkClass DownloadFile" href="/UserWorkSpace/DownloadFile?objectId=' + content.ObjectId + '">'
                                                             + content.Name + '</a><a  multipleDownload = "true"  class="DownloadLinkClass" href="/UserWorkSpace/downloadSelectedFile?objectIdString=' + objectIdString + '"></a><a multipleDelete = "true"  class="DownloadLinkClass" href="/UserWorkSpace/downloadSelectedFile?objectIdString=' + objectIdString + '"></a></td>';

                }
                var ShareWithUser = content.SharedWithUsers;
                str += '<td Title="' + SharedWithTitle + '" class="contentName">' + ShareWithUser + '</td>';
                var imageLink = PHARMAACE.FORECASTAPP.UTILITY.getImageForFileType(content.Extn.toLowerCase());
                str += '<td style="text-align:center">' + '<img src="' + imageLink + '" class="img-thumbnail"  style="height:32px;" title="' + content.Extn.toLowerCase() + '"><div class="hidtext">' + content.Extn.toLowerCase() + '</div></td>';
                str += '<td style="text-align:center">' + formattedCreatedDate + '</td>';
                var sizeInKb = addKbToSize(content.Size);
                str += '<td style="text-align:center">' +sizeInKb+ '</td>';
                str += '</tr>';
                i = i + 1;
                if (i == 12)
                    scrollerSearch = 1;

            })


            //tableRef.innerHTML = "";
            tableRef.innerHTML = satr2 + str + str3;
            $('#enbdisEvent').bootstrapToggle('enable');
            //$('#enbdisEvent').removeAttr('disabled');
            // tableRef.draw();
            //$('tr[AssignedPermission]').click(function () {
            //    var target = $(this).find('a').attr('target');
            //    if (target != undefined) {
            //        window.open($(this).find('a').attr('href'), '_blank');
            //    }
            //    else {
            //        window.location = $(this).find('a').attr('href');
            //    }
            //}).hover(function () {
            //    $(this).toggleClass('hover');
            //});


            //$("tr td.NotClickable").click(function (e) {
            //    e.stopPropagation();
             

            //});

            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');

            function format(d, ContentSearch) {
                // `d` is the original data object for the row
                if (ContentSearch != null) {
                    return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +

                   '<tr folderid=""1>' +
                       '<td></td>' +
                       '<td style="font-style:italic">' + ContentSearch + '</td>' +
                   '</tr>' +
               '</table>';
                }
                else {
                    return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +

                   '<tr folderid=""1>' +
                       '<td></td>' +
                       '<td style="font-style:italic"></td>' +
                   '</tr>' +
               '</table>';
                }

            }

            // loadingUserworkspaceTable();
            addContextMenu();
            var columnList;
            var table = $('#userworkspaceTable' + random).DataTable({
                //"bPaginate": false,                   
                //"bInfo": false,
                "bFilter": true,
                //"scrollY": "420px",
                // "scrollCollapse": true,


            });


            var mytable = $('#drop table');
            mytable.find('tr').each(function () {
                var tr = $(this).closest('tr');
                var contentSearch = tr[0].getAttribute("searchedText")
                var row = table.row(tr);


                if (row.child.isShown()) {

                    row.child.hide();
                    tr.removeClass('shown');
                }
                else {
                    if (contentSearch != null) {
                        row.child(format(row.data(), contentSearch)).show();
                        tr.addClass('shown');
                    }

                }

            }
            );

            if (scrollerSearch == 1)
                $('.dataTables_wrapper.no-footer').addClass('ScrollerDiv');
            else
                $('.dataTables_wrapper.no-footer').removeClass('ScrollerDiv');


            $('#userworkspaceTable' + random + ' thead th').each(function (e) {
                var title = $(this).text();
                var index = $(this).index();
                if (!((index == 0) || (index == 1))) {
                    columnList += "<option class='toggle-vis' data-column='" + (index) + "'>" + title + "</option>";
                }

                if (!((index == 1) || (index == 0) || (index == 2) || (index == 6) || (index == 7) || (index == 5)))
                    $(this).html(title + "<br>" + '<input type="text" style="width:120px;height:28px; display:none;"  placeholder="Search" onclick="PHARMAACE.FORECASTAPP.UTILITY.stopPropagation(event);" onmousedown="PHARMAACE.FORECASTAPP.UTILITY.stopPropagation(event)" />');
            });
            table.columns(':gt(1)').eq(0).each(function (t) {
                $('input', table.column(t).header()).on('keyup change', function () {
                    table.column(t)
                            .search(this.value.replace(/(;|,)\s?/g, "|"), true, false)
                            .draw();
                });
            });
            //$('.dataTables_length:contains("entries")').each(function () {
            //    $(this).html($(this).html().split("entries").join(""));
            //});

            $('#showhide').html('<select class="selectpicker"   title="Hide column" id="byshowhide" multiple>' + columnList + '</select>');
            $('#example-select-all').on('click', function () {
                //$('input[type="checkbox"]').prop('checked', this.checked);
                $("#drop").find('input[type=checkbox]').prop('checked', this.checked);
                enableMultiDocDownload();
            });
            $('#userworkspaceTable' + random + ' tbody').on('click', 'td.details-control', function () {
                var tr = $(this).closest('tr');
                // searchedText

                var contentSearch = tr[0].getAttribute("searchedText")
                var row = table.row(tr);


                if (row.child.isShown()) {
                    // This row is already open - close it
                    row.child.hide();
                    tr.removeClass('shown');
                }
                else {
                    // Open this row                       
                    row.child(format(row.data(), contentSearch)).show();
                    tr.addClass('shown');
                }

                //  row.child.isShown()
            });
            // $('#userworkspaceTable' + random + ' tbody tr').addClass('shown');

            $('#byshowhide').selectpicker();
            setTimeout(function () {
                // Do something after 5 seconds
                $('#showhide .bootstrap-select li').attr('onclick', 'fnshowhide(event,this)');
                // fnshowhide(event, this)

            }, 3000);
            //$('#userworkspaceTable thead').on('click', 'input[type="checkbox"]', function () {
            //    if (this.checked) {
            //        $('#userworkspaceTable input[type="checkbox"]').prop('checked', this.checked);
            //    }
            //});
            $('#userworkspaceTable' + random + ' tbody').on('change', 'input[type="checkbox"]', function () {
                // If checkbox is not checked
                if (!this.checked) {

                    var el = $('#example-select-all').get(0);
                    // If "Select all" control is checked and has 'indeterminate' property
                    if (el && el.checked && ('indeterminate' in el)) {
                        // Set visual state of "Select all" control 
                        // as 'indeterminate'
                        el.indeterminate = true;
                    }
                }
            });
            var entry = document.getElementById("showentries");
            if (entry.innerText)
            {
                $('#showentries').empty();
                $('#showentries').append($('.dataTables_length'));
            }
            else
                $('#showentries').append($('.dataTables_length'));

            //$(".dataTables_filter").css("display", "none");
            //$(".dataTables_length").css("display", "none");
            //applyColumnFilter(table, 'userworkspaceTable');
        }
        function addKbToSize(size)
        {
           
            var my_string = '';

            var b=6-(size.toString().length);
            for(var i=0;i<b;i++)
            {
                my_string = '0' + my_string;
            }
                
           
                return '<span class="hidezero">'+my_string+'</span>'+size+"KB";
        }

        function addFileFolders(contents) {

            scrollerFolder = '';
          
                var tableRef = document.getElementById('drop');
            
                var str = '';
                var str2 = '';
                var str3 = '';
                var i = 1;
                var yoursystemday = new Date(new Date().getTime() - (120000 * 60 + new Date().getTimezoneOffset() * 60000));
                var random = Math.round(Math.round(yoursystemday));
                satr2 = '<table id="userworkspaceTable' + random + '" class="table table-striped select" cellspacing="0" width="100%" ><thead><tr class="checkboxtr"><th><input type="checkbox" name="select_all"  value="1" id="example-select-all"></th><th>Path</th><th>Name</th><th>Shared With</th><th>Type</th><th>Created Date</th><th>Size</th></tr></thead>';

                satr3 = '</tbody></table>';
        
                contents.forEach(function (content) {
                    var creationDate = content.creationDate;
                    var Moddate = content.Moddate;
                    var NewcreationDate = new Date(parseInt(creationDate.substr(6)));
                    var NewModdate = new Date(parseInt(Moddate.substr(6)));
                    var date1 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(NewcreationDate));
                    var formattedCreatedDate = PHARMAACE.FORECASTAPP.UTILITY.formatDateForDataTable(new Date(date1));
                    var date2 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(NewModdate));
                    var formattedModDate = PHARMAACE.FORECASTAPP.UTILITY.formatDateForDataTable(new Date(date2));
                   
                    var SharedWithTitle = "";

                    if (content.SharedWithUsers == "-") {
                        SharedWithTitle = "";
                    }
                    else {
                        var SharedWithTitle = content.SharedWithUsers;
                    }
                    

                    if (content.Size == null) {
                        content.Size = "-";
                    }
                    var isImageExtn = isImage(content.Extn.toLowerCase());

                    if (content.permString == "View") {
                        str += '<tr class="checkboxtr" folderId="' + content.ObjectId + '"  AssignedPermission="' + content.permString + '"   folderName = "' + content.Name + '" fileLineage="' + content.Lineage + '">';
                    }
                    else {
                        str += '<tr folderId="' + content.ObjectId + '"  class="addMenu checkboxtr"  AssignedPermission="' + content.permString + '"   folderName = "' + content.Name + '" fileLineage="' + content.Lineage + '">';
                    }

                   // str += '<td style="text-align:center;"></td>';
                    str += '<td class="NotClickable" style="text-align:center;"><input type="checkbox" name="id[]" value="" onchange="enableMultiDocDownload()"></td>';
                    var IndexPath = content.IndexPath;
                    str += '<td  class="contentName" title="' + content.IndexPath + '" style="font-style: italic;">' + IndexPath + '</td>';
                    if (content.permString== "View") {
                        str += '<td id="contentName" class="contentName" title="' + content.Name + '">' + content.Name + '</td>';

                    }
                    else
                    {
                        if (content.Extn == "PDF" || isImageExtn == true) {
                            str += '<td id="contentName" class="contentName" title="' + content.Name + '">' + '<a allowDownload = "true"  href="/UserWorkSpace/openFile?objectId={0}&extn={1}"'.replace('{0}', content.ObjectId).replace('{1}', content.Extn.toLowerCase()) + 'target="_blank">'
                                                                                        + content.Name + '</a>' +
                                                        '<a    class="DownloadLinkClass DownloadFile" href="/UserWorkSpace/DownloadFile?objectId=' + content.ObjectId + '">' +
                                                        '</a></td>';
                        }
                        else {
                            str += '<td id="contentName" class="contentName" title="' + content.Name + '">' + '<a allowDownload = "true" class="DownloadLinkClass DownloadFile" href="/UserWorkSpace/DownloadFile?objectId=' + content.ObjectId + '">'
                                                                                 + content.Name + '</a></td>';
                        }
                    }
                    var ShareWithUser = content.SharedWithUsers;
                    str += '<td Title="' + SharedWithTitle + '" class="contentName"> ' + ShareWithUser + '</td>';
                    var imageLink = PHARMAACE.FORECASTAPP.UTILITY.getImageForFileType(content.Extn.toLowerCase());
                    str += '<td style="text-align:center;">' + '<img src="' + imageLink + '" class="img-thumbnail"  style="height:28px;" title="' + content.Extn.toLowerCase() + '"><div class="hidtext">' + content.Extn.toLowerCase() + '</div> </td>'
                    str += '<td style="text-align:center"> ' + formattedCreatedDate + '</td>';

                    var sizeInKb = addKbToSize(content.Size);
                    str += '<td style="text-align:center;">' + sizeInKb + '</td>';
                    str += '</tr>';
                    i = i + 1;
					if(i==12)
					scrollerFolder=1;
                })
                
                tableRef.innerHTML = satr2 + str + str3;
                $('#enbdisEvent').bootstrapToggle('enable');
                //$('#enbdisEvent').removeAttr('disabled');
            // tableRef.draw

            $('tr.addMenu').click(function () {
                   
                //window.location = $(this).find('a').attr('href');


                var target = $(this).find('a').attr('target');
                if (target!=undefined) {
                    window.open($(this).find('a').attr('href'), '_blank');
                }
                else {
                window.location = $(this).find('a').attr('href');
                }
                        
                }).hover(function () {
                    $(this).toggleClass('hover');
                });

            $("tr td.NotClickable").click(function (e) {
                e.stopPropagation();

            });
                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                function format(d, folderId) {
                    return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
                       
                        '<tr ParentId="'+ folderId +'">' +
                            '<td>Extra info:</td>' +
                            '<td>And any further details here (images etc)...</td>' +
                        '</tr>' +
                    '</table>';
                }
                // loadingUserworkspaceTable();
                addContextMenu();
                var columnList;
                                var table = $('#userworkspaceTable' + random).DataTable({
                    "bPaginate": false,
                    "retrieve": true,
                    "bLengthChange": false,
                    "bInfo": false,
                    "bFilter": true,
                    
                    "dom": 'Rl<"top"i>rt<"custom-filter-bottom"flp><"clear">',
                    'columnDefs': [{
               
                     "bSortable": false, 
                     "aTargets": [0] ,
                        'searchable': false,
                        'orderable': false,
                        'className': 'dt-body-center',
                        'render': function (data, type, full, meta) {
                            return '<input type="checkbox" name="id[]" value="' + $('<div/>').text(data).html() + '">';
                        }
                    }],
                    "initComplete": function () {
                        $('.dataTables_scrollBody thead tr').addClass('hidden');
                    }
                });

                  if(scrollerFolder==1)    
                      $('.dataTables_wrapper.no-footer').addClass('ScrollerDiv');
                  else
                      $('.dataTables_wrapper.no-footer').removeClass('ScrollerDiv');
                
                $('#userworkspaceTable' + random+' thead th').each(function (e) {
                    var title = $(this).text();
                    var index = $(this).index();
                    if (!((index == 0) || (index == 1)))
                    {
                        columnList += "<option class='toggle-vis' data-column='" + (index) + "'>" + title + "</option>";
                    }
                    
                    if (!((index == 1) || (index == 0) || (index == 4) || (index == 6)  || (index == 5)))
                        $(this).html(title + "<br>" + '<input type="text" style="width:120px;height:28px;display:none;"  placeholder="Search" onclick="PHARMAACE.FORECASTAPP.UTILITY.stopPropagation(event);" onmousedown="PHARMAACE.FORECASTAPP.UTILITY.stopPropagation(event)" />');
                });
                table.columns(':gt(1)').eq(0).each(function (t) {
                    $('input', table.column(t).header()).on('keyup change', function () {
                        table.column(t)
                                .search(this.value.replace(/(;|,)\s?/g, "|"), true, false)
                                .draw();
                    });
                });
                $('.dataTables_length:contains("entries")').each(function () {
                    $(this).html($(this).html().split("entries").join(""));
                });
                $('#showhide').html('<select class="selectpicker"   title="Hide column" id="byshowhide" multiple>' + columnList + '</select>');
                $('#example-select-all').on('click', function () {
                  
                    $('input[type="checkbox"]').prop('checked', this.checked);
                    enableMultiDocDownload();
                   // $(this).find('input:checkbox').attr("checked", true);
                });
                $('#userworkspaceTable' + random + ' tbody').on('click', 'td.details-control', function () {
                    var tr = $(this).closest('tr');
                    var folderId= tr[0].getAttribute("folderid")
                    var row = table.row(tr);

                    if (row.child.isShown()) {
                        // This row is already open - close it
                        row.child.hide();
                        tr.removeClass('shown');
                    }
                    else {
                        // Open this row                       
                        row.child(format(row.data(), folderId)).show();
                        tr.addClass('shown');
                    }
                });
                
                $('#byshowhide').selectpicker();
                setTimeout(function () {
                    // Do something after 5 seconds
                    $('#showhide .bootstrap-select li').attr('onclick', 'fnshowhide(event,this)');
                   // fnshowhide(event, this)
                  
                }, 3000);
                //$('#userworkspaceTable thead').on('click', 'input[type="checkbox"]', function () {
                //    if (this.checked) {
                //        $('#userworkspaceTable input[type="checkbox"]').prop('checked', this.checked);
                //    }
                //});
                $('#userworkspaceTable' + random + ' tbody').on('change', 'input[type="checkbox"]', function () {
                    // If checkbox is not checked
                    if (!this.checked) {
                        var el = $('#example-select-all').get(0);
                        // If "Select all" control is checked and has 'indeterminate' property
                        if (el && el.checked && ('indeterminate' in el)) {
                            // Set visual state of "Select all" control 
                            // as 'indeterminate'
                            el.indeterminate = true;
                        }
                    }
                });


                //applyColumnFilter(table, 'userworkspaceTable');
            }

        function dayFilterForReporting() {

            if ($('#last3daysrep').is(':checked') == true) {
                var days = 3; // Days you want to subtract
                var date = new Date();
                var Startlast = new Date(date.getTime() - (days * 24 * 60 * 60 * 1000));
                var Endlast = new Date(date.getTime());
                applyDaysForReporting(Startlast, Endlast);

            }

            if ($('#last7daysrep').is(':checked') == true) {
                var days = 7; // Days you want to subtract
                var date = new Date();
                var currentdate = new Date(date.getTime);
                var Startlast = new Date(date.getTime() - (days * 24 * 60 * 60 * 1000));
                var Endlast = new Date(date.getTime());
                var Endday = Endlast.getDate();
                applyDaysForReporting(Startlast, Endlast);

            }
            if ($('#last30daysrep').is(':checked') == true) {

                var days = 30; // Days you want to subtract
                var date = new Date();
                var Startlast = new Date(date.getTime() - (days * 24 * 60 * 60 * 1000));
                var Endlast = new Date(date.getTime());
                applyDaysForReporting(Startlast, Endlast);

            }
            if ($('#filter-rangeforreport').is(':checked') == true) {

                var StartDate = document.getElementById("datepicker-startforreport").value;
                var StartLast ="";
                if (StartDate == "") {
                    StartLast = "";
                }
                else {
                    StartLast = new Date(StartDate);
                }
                var EndDate = document.getElementById("datepicker-endforreport").value;
                var EndLast = "";
                if (EndDate=="") {
                        
                    var date = new Date();
                     Endlast = new Date(date.getTime());
                        
              }
                else {

                    Endlast = new Date(EndDate);

                }
                applyDaysForReporting(StartLast, Endlast);

            }


        }

       
        function fetchFilesFromReporting(contents) {
            scrollerReport = '';
                var tableRef = document.getElementById('ReportDiv');

                var str = '';
                var str2 = '';
                var str3 = '';
                var i = 1;
                var yoursystemday = new Date(new Date().getTime() - (120000 * 60 + new Date().getTimezoneOffset() * 60000));
                var random = Math.round(Math.round(yoursystemday));

                satr2 = '<table id="ReportworkspaceTable' + random + '" class="table table-striped select" cellspacing="0" width="100%" ><thead><tr><th style="width:15%">User</th><th style="width:20%">User Artifact</th><th style="width:15%">Parent</th><th style="width:20%">Date</th><th style="width:30%">Action</th></tr></thead>';
                satr3 = '</tbody></table>';

                contents.forEach(function (content) {
                    var mainName = "";
                    if (content.MainFolderName == null) {
                        mainName = "-";
                    }
                    else {
                        mainName = content.MainFolderName;
                    }
                    var msgTitle = "";
                    if (content.CustomMessage == null) {
                        msgTitle = "-";
                    }
                    else {
                        msgTitle = "title = " + content.CustomMessage;
                    }
                    
                    var ext = content.Extn;
                    var extension = content.type;
                    var actdate = content.ActivityDate;
                    var NewActDate = new Date(parseInt(actdate.substr(6)));
                    /*var minutes = NewActDate.getMinutes().toString();
                    if (minutes.length == 1)
                    {
                        minutes = "0" + minutes;
                    }
                    var Hours = NewActDate.getHours().toString();
                    if (Hours.length == 1) {
                        Hours == "0" + Hours;
                    }

                    var formattedActDate = NewActDate.getDate() + "-" + (NewActDate.getMonth() + 1) + "-" + NewActDate.getFullYear() + " " + "[" + NewActDate.getHours() + ":" + minutes + "]";
                    */
                    var date1 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(NewActDate));
                    var formattedActDate = PHARMAACE.FORECASTAPP.UTILITY.formatDateForDataTable(new Date(date1));
                    str += '<tr actdate="' + NewActDate + '">';
                    // str += '<td>' + i + '</td>';
                    str += '<td style="width:15%">' + content.FullName + '</td>';
                    str += '<td style="width:20%" id="contentName" class="contentName">' +  content.Name + content.Extn + '</td>';
                    str += '<td style="width:15%" class="contentName">' + mainName + '</td>';
                    str += '<td style="width:20%">' + formattedActDate + '</td>';
                    str += '<td style="width:30%" title="' + (content.CustomMessage).toString() + '" class="contentName">' + content.CustomMessage + '</td>';
                   
                    str += '</tr>';
                    i = i + 1;
					if(i==12)
					scrollerReport=1;
                });
               

                tableRef.innerHTML = satr2 + str + str3;
                var columnList;
                var table = $('#ReportworkspaceTable' + random).DataTable({
                    "bPaginate": false,                   
                    "bInfo": false,
                    "bFilter": false,
                    //"scrollY": "420px",
                   // "scrollCollapse": true,
                    
                    
                });
                if (scrollerReport==1)
                $('.dataTables_wrapper.no-footer').addClass('ScrollerDiv');
            else
							    $('.dataTables_wrapper.no-footer').removeClass('ScrollerDiv');
                $('.dataTables_length:contains("entries")').each(function () {
                    $(this).html($(this).html().split("entries").join(""));
                });
                dayFilterForReporting();
            }


        function callEditableWorkSpaceJSON(objectId, lineage)
        {
                if (lineage.toString().trim() == "0")
                {
                    var ProjectLi = document.getElementById("LiUploadDoc");
                   
                    $('#LiUploadDoc').addClass('deactivateUploadDoc');
                    var fileUploader = document.getElementById("upload-file-selector");
                    fileUploader.type = "";
                }
                else {
                    var liElemt = document.getElementById(objectId);
                    if (liElemt.getAttribute("permission") != "ContetFileShare") {
                        var ProjectLi = document.getElementById("LiUploadDoc");
                        $('#LiUploadDoc').removeClass('deactivateUploadDoc');
                        var fileUploader = document.getElementById("upload-file-selector");
                        fileUploader.type = "file";
                    }
                    else {
                        $('#LiUploadDoc').addClass('deactivateUploadDoc');
                        var fileUploader = document.getElementById("upload-file-selector");
                        fileUploader.type = "";
                    }
                }
                $('#tree2 li').removeClass('selected');
                $('#' + objectId).addClass('selected');
                if (lineage != 0) {
                    $.each(lineage.split(/\|/), function (i, val) {

                        $('#' + val).addClass('selected');
                    })
                }
                
                //if ($('#tree2' + ' #' + objectId).parent().parent().hasClass('firstLi'))
                //    $('#tree2' + ' #' + objectId).parent().parent().addClass('selected');
                //if ($('#tree2' + ' #' + objectId).parent().parent().parent().parent().hasClass('firstLi'))
                
               selectedFolderId = objectId;  //for testing
                selectedLineage = lineage;
                lineageForSpan = lineage;              
                PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait fetching the project content...", 'editableWorkSpace', '15', '');
                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/GetEditableWorkSpaceJSON", { ObjectId: objectId, lineage: lineage },
                        function (result) {
                            if (result.success) {
                                addFileFolders(result.ContentFolderList);
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');

                            }
                            else
                            {
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                                
                            }
                               
                               
                        },
                        function (result) {

                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                           
                        });
                
            }
            
        function getSelProjForReportingDropdown() {
            if ($('#byproject').val()) {
                var objectId = $("#byproject option:selected").attr("objId");
                var lineage = $("#byproject option:selected").attr("lineageId");

                if (objectId != undefined && lineage != undefined) {
                    getFilesForReporting(objectId, lineage);
                }
            }
            else {

                var tableid = $('#ReportDiv table').attr('id');

                $('#' + tableid).find('tr').each(function () {
                    var attr = $(this).attr('actdate');
                    if (typeof attr !== typeof undefined && attr !== false) {
                        $(this).remove();
                    }
                });
            }
        }
           
        function getFilesForReporting(objectId, lineage) {

            $("#tree6 li").each(function () {

                var r = $(this).attr('objid')
                if (r == objectId) {

                    PreText = $(this).text();
                }
            });

            $("#tree6 li").each(function () {

                if ($(this).text() == PreText) {
                    $(this).css("background-color", "#d4d4d4");
                }
                if ($(this).text() != PreText) {
                    $(this).css("background-color", "#fff");

                }
            });
            //selectedFolderId = objectId;
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are fetching activity log ...", 'editableWorkSpace', '15', '');
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/GetActivityDetailJSON", { ObjectId: objectId, lineage: lineage },
                    function (result) {
                        if (result.success) {
                            // PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                            fetchFilesFromReporting(result.ContentFileList);
                            dayFilterForReporting();
                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');

                        }
                        else {
                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');

                        }
                    },
                    function (result) {
                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                    });
            // dayFilterForReporting();
        }

            function applyDaysForReporting(startdate, enddate) {

                var tableid = $('#ReportDiv table').attr('id');
                var tableRef = $('#' + tableid);
                var  isStartDateNull=false;
                if(startdate=="")
                {
                    isStartDateNull =true;
                }
                // var tableRef = $('#ReportworkspaceTable')
                tableRef.find('tr').each(function () {
                    $(this).show();

                });

                tableRef.find('tr').each(function () {
                   // $(trow).css("display", "none");
                    var startDate = new Date(startdate);
                    var endDate = new Date(enddate);
                    var trow = $(this);
                    var activityDate = new Date($(this).attr("actdate"));
                    if (isStartDateNull ==true)
                    {
                        if (activityDate > endDate) {
                            $(trow).css("display", "none");
                        }
                    }
                    else if(activityDate < startDate || activityDate > endDate)
                    {
                        $(trow).css("display", "none");
                    }

                });
            }

            function AddProjectInReporting() {
                var StrProjOption = "";

                var li = document.getElementById("tree2");
                var ul = li.getElementsByTagName("li");
                for (i = 0; i < ul.length; i++) {
                    if (ul[i].getAttribute("lineageString") == "0") {
                        if (i == 0) {
                            StrProjOption += "<option selected=selected objid='" + ul[i].getAttribute("id") + "' class=firstLi lineageid='" + ul[i].getAttribute("lineageString") + "' >";
                        }
                        else {
                            StrProjOption += "<option objid='" + ul[i].getAttribute("id") + "' class=firstLi lineageid='" + ul[i].getAttribute("lineageString") + "' >";
                        }
                        StrProjOption += ul[i].getElementsByTagName("a")[0].title;
                        StrProjOption += "</option>";
                    }
                
                    }

                $("#byproject").html(StrProjOption);
                $('#byproject').selectpicker();

            }

        function showReporting()
            {
            $('#searchbarForContentsearch .toggle.btn').css('display', 'none');
			scrollerFolder='';
	scrollerSearch='';
            $('#treeforReporting').addClass('ShiftTop');
            $('#treeforAdvSearch').addClass('ShiftTop');
            $('.leftSection').addClass('cngArwColor');
           $('#headerBox').addClass('widthHalf')
            $('#showhide').css("display", "none");
            $('#custom-search-input').css("display", "none");
            $('#treeforfolderlist').css("display", "none");
            $('#treeforAdvSearch').css("display", "none");
            $('#searchFromList').css("display", "none");
            $('#leftmenu').css("display", "block");
            $('#tabAttr').css("display", "none");
            $('#treeforReporting').css("display", "block");
            if ($("#leftmenu").hasClass('toggled')) {
                $("#leftmenu").toggleClass("toggled");
                $("#editableWorkSpace").toggleClass("toggled");
                $('#workspaceSlider i.fa').removeClass('fa-chevron-right').addClass('fa-chevron-left');
                $('#workspaceSlider i.fa').attr('title', 'Collapse');
            }
            $('#addnewproject').css("display", "none");
            $('#searchButton').css("display", "none");
            $('#showentries').css("display", "none");
            document.getElementById("editableWorkSpace").className = "col-md-9";
            document.getElementById("leftmenu").className = "col-md-3";
            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/UserWorkSpace/LeftPaneReportingView", {},
                              function (result) {
                                  if (result) {
                                      $('#treeforReporting').html(result);

                                      AddProjectInReporting();

                                      var a = document.getElementById('byproject');
                                      var objectId = a.firstElementChild.getAttribute('objid');
                                      var Lineage = a.firstElementChild.getAttribute('lineageid');
                                      getFilesForReporting(objectId, Lineage);
                                      leftPaneReportingViewReady();
                                  }
                                  else
                                      PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                              },
                                function (result) {
                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                                }
                              );

        }

        function addProjectInAdvSearch() {
            var StrProjOption = "";

            var li = document.getElementById("tree2");
            var ul = li.getElementsByTagName("li");
            for (i = 0; i < ul.length; i++) {
                if (ul[i].getAttribute("lineageString") == "0")
                    {
                StrProjOption += "<option objid='" + ul[i].getAttribute("id") + "' id='byFolder" + ul[i].getAttribute("id") + "' class=firstLi lineageid='" + ul[i].getAttribute("lineageString") + "' >";
                StrProjOption += ul[i].getElementsByTagName("a")[0].title;
                StrProjOption += "</option>";
                    }
            }

            $("#byfolder").html(StrProjOption);
            $('#byfolder').selectpicker();

        }

        function setAdvSearchToDefault() {
            $('#filter')[0].value = "";

            $('#searchCriteria').val(1);
            var parentElmt = document.getElementById('advFilter');
            var btn = parentElmt.getElementsByTagName('button')[0];
            var spanElmt = btn.getElementsByTagName('span');
            var aa = $('#searchCriteria')[0];
            spanElmt[0].innerText = aa.options[0].text;
            btn.setAttribute('title', spanElmt[0].innerText);

            var liElmt = btn.nextElementSibling.firstElementChild.children;
            liElmt[1].className = "";
            liElmt[0].className = "selected";

        }
        function showAdvSearch() {
            setAdvSearchToDefault();

            // $('#enbdisEvent').cs('display', 'block');
            if ($("#drop").hasClass('context-menu-empty') == true) {
                $('#drop').removeClass("context-menu-empty");
            }
            $('#searchbarForContentsearch .toggle.btn').css('display', 'block');
            $('.dataTables_wrapper input[type=text]').css('display', 'none');
            //setTimeout(function () {  
            $('#searchbarForContentsearch .toggle.btn').removeClass('btn-primary');
            $('#searchbarForContentsearch .toggle.btn').addClass('btn-default').addClass('off');
            $('#searchbarForContentsearch .toggle.btn').attr('disabled');
           // }, 3000);
		scrollerFolder='';
		scrollerReport=='';
            $('#ReportingFolder').addClass('ShiftTop');
            $('#treeforAdvSearch').addClass('ShiftTop');
            $('.leftSection').addClass('cngArwColor');
            $("#example-select-all").prop("indeterminate", false);
            $("#example-select-all").prop("checked", false);
            enableDisableMultiOperTab();
            $('#LiUploadDoc').addClass('deactivateUploadDoc');
            var fileUploader = document.getElementById("upload-file-selector");
            fileUploader.type = "";
            var copyTab = document.getElementById('LiCopyDoc');
            copyTab.style.display = 'none';
            $('#LiUploadDoc').css("display", "none");
            var tableid = $('#drop table').attr('id');
            $('#' + tableid).find('tr').each(function () {
                var attr = $(this).attr('folderid');
                if (typeof attr !== typeof undefined && attr !== false) {
                    $(this).remove();
                }
            });
            //$('#showhide').css("display", "block");
            $('#searchButton').css("display", "block");
            $('#treeforfolderlist').css("display", "none");
            $('#treeforAdvSearch').css("display", "block");
            if ($("#leftmenu").hasClass('toggled')) {
                $("#leftmenu").toggleClass("toggled");
                $("#editableWorkSpace").toggleClass("toggled");
                $('#workspaceSlider i.fa').removeClass('fa-chevron-right').addClass('fa-chevron-left');
                $('#workspaceSlider i.fa').attr('title', 'Collapse');
            }

            $('#treeforReporting').css("display", "none");
            $('#searchFromList').css("display", "block");
            $('#tabAttr').removeAttr('style');
            $('#addnewproject').css("display", "none");
            $('#searchFromList').css("display", "none");
             $('#custom-search-input').css("display", "block");
            $('#treeforAdvSearch').html('');
            $('#leftmenu').css("display", "block");
            $('.leftBox').css("display", "none");
            $('#advFilter').css("display", "block");
            $('#showentries').css("display", "block");
            document.getElementById("leftmenu").className = "col-md-3";
            document.getElementById("editableWorkSpace").className = "col-md-9";



         /*   $.ajax({
                "url": "UserWorkSpace/LeftPaneSearchView",
                "success": function (result) {
                    $('#treeforAdvSearch').html(result);
                    // $('#searchcheckbox').css("display", "block");
                }
            });*/

            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/UserWorkSpace/LeftPaneSearchView", {},
                              function (result) {
                                  if (result) {
                                      $('#treeforAdvSearch').html(result);
                                      leftPaneSearchViewReady();
                                      addProjectInAdvSearch();
                                  }
                                  else
                                      PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                              },
                                function (result) {
                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                                }
                              );

          
        }

       /* function callLeftPaneFolderView(objectId, lineage, isSearchView) {
            var SpanId = "Span" + objectId;
            var fisrSpanId = "SpanFirst" + objectId;
            var spanEl = document.getElementById(SpanId);
            var SpanFirst = document.getElementById(fisrSpanId);
            var selectedLi = document.getElementById(objectId);
            sequenceSet = $(selectedLi).attr('sequence');


            var SpanClassName = spanEl.className;
        
            if (SpanClassName == "fa fa-chevron-down") {
              
                $.ajax({
                    "url": "UserWorkSpace/LeftPaneFolderView",
                    "data":
                        {
                            'ObjectId': objectId,
                            'lineage': lineage,
                            'isSearchView': isSearchView
                        },
                    "success": function (result) {
                        $("#" + objectId).append(result);
                        
            
                    }
                });

                spanEl.className = "fa fa-chevron-up";
                SpanFirst.className = "glyphicon glyphicon glyphicon-folder-open";

            }
            else if (SpanClassName == "fa fa-chevron-up") {
                var x;
                var li = document.getElementById(objectId);
                var ul = li.getElementsByTagName(
                    "ul")
                for (i = 0; i < ul.length; i++) {
                    x = ul[i];
                    // x.style.display = "none";
                    
                   x.parentNode.removeChild(x);
                }
                //foldericon();

                spanEl.className = "fa fa-chevron-down";
                SpanFirst.className = "glyphicon glyphicon glyphicon-folder-close";

            }
        }  */
        
        function callLeftPaneFolderViewWithIndex(objectId, lineage, parentIndex,isProject) {
          
            var SpanId = "Span" + objectId;
            var fisrSpanId = "SpanFirst" + objectId;
            var spanEl = document.getElementById(SpanId);
            var SpanFirst = document.getElementById(fisrSpanId);
            var selectedLi = document.getElementById(objectId);
            
            sequenceSet = $(selectedLi).attr('sequence');
            
            var SpanClassName = spanEl.className;

            if (SpanClassName == "fa fa-chevron-down") {
                $('#' + SpanId).prop('title', 'Hide');
                var li = document.getElementById(objectId);
                var ul = li.getElementsByTagName(
                    "ul")

                if (ul.length > 0) {
                    for (i = 0; i < ul.length; i++) {
                        x = ul[i];
                        x.style.display = "block";
                                         
                    }
                }
                else {
                 

                    PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/UserWorkSpace/LeftPaneFolderViewWithIndex",
                        {
                            'ObjectId': objectId,
                            'lineage': lineage,
                            'parentIndex': sequenceSet,
                            'isProject' : isProject

                        },
                        function (result) {
                            if (ul.length <= 0) {
                                $("#" + objectId).append(result);
                            }
                        },
                        function (status) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                        });
                }
                
                spanEl.className = "fa fa-chevron-up";
                SpanFirst.className = "glyphicon glyphicon glyphicon-folder-open";

            }
            else if (SpanClassName == "fa fa-chevron-up") {
                $('#' + SpanId).prop('title', 'Show');
                var x;
                var li = document.getElementById(objectId);
                var ul = li.getElementsByTagName(
                    "ul")
                for (i = 0; i < ul.length; i++) {
                    x = ul[i];
                    x.style.display = "none";                                       
                  // x.parentNode.removeChild(x)                  
                }                
                spanEl.className = "fa fa-chevron-down";
                SpanFirst.className = "glyphicon glyphicon glyphicon-folder-close";

            }
        }
        function listOfPermissions() {
          
            permissionsArr = [];

            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/fetchPermission", {},
                               function (result) {

                                   if (result.success) {
                                       var permsn = result.Permission;

                                       for (var j = 0 ; j < permsn.length ; j++) {
                                           var act = { Name: "", Id: "" }
                                           act.Name = permsn[j].Name;
                                           act.Id = permsn[j].ID;
                                           permissionsArr.push(act);
                                       }
                                       PHARMAACE.FORECASTAPP.SHARE.checkShareType(shareType);                                       
                                       PHARMAACE.FORECASTAPP.SHARE.validate(e);
                                   }
                                   else
                                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                               },
                                 function (result) {
                                     PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                                 }
                               );           
            return permissionsArr;
        }
           
        function getPathForSendMail(){
            var pathStr = "";
            if (selectedLineage == "0") {//if only Project
                var elmtId = document.getElementById(selectedFolderId);
                var elmt = elmtId.getElementsByTagName("a")[0].innerText;
                pathStr += (elmt.substr(elmt.indexOf(" ") + 1, elmt.length))
            }
            else {
                if (PHARMAACE.FORECASTAPP.SHARE.permissionMsgFlagFileOrFolder) {//indicates file path
                    var elmt = document.getElementById('contentName');
                    var pathColumn = (elmt.previousElementSibling).innerText;
                    pathStr = pathColumn + ">";
                }
                else {//indicates folder/project path
                    var folderIds = selectedLineage.split('|');
                    for (var i = 0; i < folderIds.length; i++) {
                        var elmtId = document.getElementById(folderIds[i]);
                        var elmt = elmtId.getElementsByTagName("a")[0].innerText;
                        pathStr += (elmt.substr(elmt.indexOf(" ") + 1, elmt.length)) + ">";
                    }
                }
            }
            return pathStr;
        }
        function buildUserForecastMappingForShare() {
            var allowShare = true;
            //var shareModalTitle = document.getElementById('shareModalTitleUW');
            //var projectTitle = ((shareModalTitle.innerText).substr((shareModalTitle.innerText).indexOf(':') + 1)).trim();
            userForecastMappingForShare = [];
            //var ObjectId = 0;
            var pathStr= getPathForSendMail();
            
            $('#prdverid tr.innerTrShareForcast').each(function () {
                var UserId = $(this).find('td:nth-child(3)').text();
                var UserEmail = $(this).find('td:nth-child(2)').text();
                var authLevel = $(this).find('select option:selected').attr('id');                
                //pathStr = pathStr.substring(0,pathStr.lastIndexOf("<"));
                userForecastMappingForShare.push(buildUserForecastToShare(UserId, authLevel, ObjectIdForShare, UserEmail, pathStr));
            });

            if (userForecastMappingForShare.length>0) {
                allowShare = true;
            }
            else {
                allowShare = false;
            }
            return allowShare;
        }

        function unshareForecast(UserId,unshareUserName) {
            if (UserId != undefined && unshareUserName != undefined)
            {
                var folderForUnShare = "";
                var folderNameForNotification="";
                if (typeOfObjectShare == "Folder") {
                    var li = document.getElementById(ObjectIdForShare);
                    var Name = li.getElementsByTagName("a");
                    var tempNameForShare = Name[0].innerHTML;
                    folderForUnShare = "folder '" + tempNameForShare.substr(tempNameForShare.indexOf(' ') + 1) + "'";
                    folderNameForNotification = tempNameForShare.substr(tempNameForShare.indexOf(' ') + 1);
                }
                if (typeOfObjectShare == "File")
                {
                    folderForUnShare = "file '" + fileNameForUnshare + "'";
                    folderNameForNotification = fileNameForUnshare;
                }

                bootbox.confirm({
                    size: 'small',
                    message: 'Are you sure you want to unshare ' + folderForUnShare + ' from ' + unshareUserName + '?',
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
                            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/UnshareItem", {
                                objectId: ObjectIdForShare,
                                userId: UserId,
                                folderNameForNotification: folderNameForNotification
                            },
                          function (result) {
                              if (result.success) {

                                  if (result.value == "1") {
                                      var mytable = $('#prdverid');
                                      mytable.find('tr').each(function () {
                                          var trow = $(this);
                                          if ($(this).attr("unShareId") == UserId) {
                                              $(this).remove();
                                          }
                                      });
                                  }
                                  else if (result.value == "2") {
                                      var mytable = $('#prdverid');
                                      mytable.find('tr').each(function () {
                                          var trow = $(this);
                                          if ($(this).attr("unShareId") == UserId) {
                                              $(this).remove();
                                          }
                                      });
                                  }
                              }

                              else
                                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to assigned permission " + result.errors.join(), '');
                          },
                                     function (result) {
                                         PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to assigned permission" + result.responseText, '');
                                     });
                       
                  

                        }

                        else {
                             
                        }
                               

                    }
                         
                });
               // fileNameForUnshare = "";
            }
            else
            {
                var mytable = $('#prdverid');
                mytable.find('tr').each(function () {
                    var trow = $(this);
                    if ($(this).attr("unShareId") == UserId) {
                        $(this).remove();
                    }
                });
            }
        
        }

        function shareDocumentWithSelectedUsers()
        {
            var newSharedRowCout = 0;
            $('#prdverid tbody').find('tr').each(function () {
                var attr = $(this).attr('unshareid');


                if (typeof attr !== typeof undefined && attr !== false) {
                    newSharedRowCout++;
                }

            });


            var allowShare = true;
             var   allowSharey=  buildUserForecastMappingForShare();
                if (allowShare == true)
                {
                    shareDocumentWithUsers(userForecastMappingForShare);
                }
                else {

                  //  $("unsharedoc1").attr("data-dismiss", "false");
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select user(s) to share file/folder", '');
                }
              
            }


        function buildUserForecastToShare(UserId,Permission,ObjectId,UserEmail,pathStr) {
                var userForecast;
                
                userForecast = {
                    Permission: Permission,
                    ObjectId: ObjectId,
                    UserId: UserId,
                    UserEmail: UserEmail,
                    PathString: pathStr
                };

                return userForecast;
            }


        function GoToSendMail(sendmailinfo) {
            var postData = JSON.stringify({ "smi": sendmailinfo });
            PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/UserWorkSpace/SendMail", postData,
            function (result) {
                if (result.success) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Mail sent successfully", '');
                }
                else {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to send mail", '');
                }
            },
            function (result) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to send mail", '');
            });
        }
            function shareDocumentWithUsers(userForShare) {

               
                var folderNameForNotification = "";
                if (typeOfObjectShare == "Folder") {
                   var li = document.getElementById(selectedFolderId);
                    var Name = li.getElementsByTagName("a");
                    var tempNameForShare = Name[0].innerHTML;
                    folderNameForNotification = tempNameForShare.substr(tempNameForShare.indexOf(' ') + 1);
                }
                if (typeOfObjectShare == "File") {
                 folderNameForNotification = fileNameForUnshare;
                }
                PHARMAACE.FORECASTAPP.UTILITY.showOverlay("", 'shareContentId', '15', '');
                var overlayDiv = $('#sharePpoupFooterId').next();
                overlayDiv.addClass('overlayPopup');
                var postData = JSON.stringify({ "userForShare": userForShare,"folderNameForNotification": folderNameForNotification});
              PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/UserWorkSpace/Share", postData,
            function (result) {
           if (result.success) {
               PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('shareContentId');
               $("unsharedoc1").attr("data-dismiss", "modal");
               $("#closeShare").click();
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Successfully assigned permission", '');
               overlayDiv.removeClass('overlayPopup');
               var sendmailusers=result.SendMailUsers;
               var sendmailinfo = {
                   SendMailInfoValue: sendmailusers.SendMailInfoValue,
               CommonSendInfoValue:sendmailusers.CommonSendInfoValue
               };

               if (sendmailinfo != null)
                   GoToSendMail(sendmailinfo);
           }
           else {
               //hideOverlay();
               PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('shareContentId');
               $("#closeShare").click();
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to assigned permission", '');
           }
       },
            function (result) {
           //hideOverlay();
           PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('shareContentId');
           $("#closeShare").click();
           PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to assigned permission", '');
       });
                fileNameForUnshare = "";
            }
            function autocompleteClick(current)//dynamically added function to autocomplete list


            {
                var selectedEmail = undefined;
                var flagForShare = false;
                if ($('#prdverid tr.innerTrShareForcast').length > 0) {
                    var flagForShare = PHARMAACE.FORECASTAPP.SHARE.checkUserAlreadyAdded(current);
                }
                else
                    selectedEmail = (current.innerText).toString();
                if (flagForShare == false)
                    PHARMAACE.FORECASTAPP.SHARE.validate(undefined, selectedEmail);
            }
            function pressed() {
                if (typeOfObjectShare == "Folder") {
                    PHARMAACE.FORECASTAPP.SHARE.permissionMsgFlagFileOrFolder = false;
                    PHARMAACE.FORECASTAPP.SHARE.listofPermissions(folderpermissionsArr);
                }
                else if ((typeOfObjectShare == "File")) {
                    PHARMAACE.FORECASTAPP.SHARE.permissionMsgFlagFileOrFolder = true;
                    PHARMAACE.FORECASTAPP.SHARE.listofPermissions(filepermissionArr);
                }

                PHARMAACE.FORECASTAPP.SHARE.checkShareType(shareType);
                PHARMAACE.FORECASTAPP.SHARE.generalizedPressedFun(event);
                /* PHARMAACE.FORECASTAPP.SHARE.addAutocompleteFunctionForClick(e);
 
                 if (e.keyCode === 13) {
                 e.preventDefault();
                 
                 var flagForShare = PHARMAACE.FORECASTAPP.SHARE.checkUserAlreadyAdded(e);
                 if (flagForShare==false)
                 PHARMAACE.FORECASTAPP.SHARE.validate(e,"");                               
             }*/
            }
        function searchFromList(e) {
               
            var searchonId = "searchFromList";
            var searchById = "tree2";
            PHARMAACE.FORECASTAPP.UTILITY.searchFromList(searchonId, searchById);
        }
             


        $(document).ready(function () {
            $(function () {

                // $('#enbdisEvent').tooltip();
                $('#searchbarForContentsearch .toggle-group .btn').attr('title', 'Click for advance search');

                $('#enbdisEvent').change(function () {
                    //$('#console-event').html('Toggle: ' + $(this).prop('checked'))
                    if ($(this).prop('checked') == true) {
                        //alert('hello');
                        $('.dataTables_wrapper input[type=text]').css('display', 'block');
                    }
                    else {
                        $('.dataTables_wrapper input[type=text]').css('display', 'none');
                    }
                })
                // $('#searchbarForContentsearch .toggle.btn').cs('display', 'none');
            });

            leftPaneReportingViewReady();
            leftPaneSearchViewReady();
            //$("#creatFolderFormId").submit(function () {
            //    createFolder();
            //    return false;
            //});
           

            //$("#renameFolderFormId").submit(function () {
            //    renameFolder();
            //   return false;
            //});
            
                    $('#showhide .bootstrap-select li:last-child').click().addClass('selected');
                    $('#LiUploadDoc').addClass('deactivateUploadDoc');
                    var fileUploader = document.getElementById("upload-file-selector");
                    fileUploader.type = "";

                    $('#LiDownloadDoc').addClass('deactivateUploadDoc');
                   
                    $('#LiShareDoc').addClass('deactivateUploadDoc');
                    
                    $('#LiDeleteDoc').addClass('deactivateUploadDoc');

                    $('#LiCopyDoc').addClass('deactivateUploadDoc');

                   
                    $("#currency").bind("change", function ()
                    {
                        var currency = $("#currency option:selected").text();

                        if (currency=="$") {

                            document.getElementById('deal').placeholder = "$ Value";

                        }
                        else if (currency == "£") {
                            document.getElementById('deal').placeholder = "£ Value";

                        }
                        else if (currency == "€") {
                            document.getElementById('deal').placeholder = "€ Value";
                        }
                        //else if (currency == "Rupee")
                        //{
                        //    document.getElementById('deal').placeholder = "₹ Value";
                        //}
                    });


                    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/fetchPermission", {},
                             function (result) {
                                 if (result.success) {
                                     var permsn = result.Permission;

                                     for (var j = 0 ; j < permsn.length ; j++) {
                                         var act = { Name: "", Id: "" }
                                         act.Name = permsn[j].Name;
                                         act.Id = permsn[j].ID;
                                         permissionsArr.push(act);
                                     }                                    

                                 }
                                 else
                                     PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                             },
                               function (result) {
                                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                               }
                             );
                    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/fetchFilePermission", {},
                            function (result) {
                                if (result.success) {
                                    var permsn = result.Permission;

                                    for (var j = 0 ; j < permsn.length ; j++) {
                                        var act = { Name: "", Id: "" }
                                        act.Name = permsn[j].Name;
                                        act.Id = permsn[j].ID;
                                        filepermissionArr.push(act);
                                    }

                                }
                                else
                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                            },
                              function (result) {
                                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                              }
                            );
                    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/fetchFolderPermission", {},
                            function (result) {
                                if (result.success) {
                                    var permsn = result.Permission;

                                    for (var j = 0 ; j < permsn.length ; j++) {
                                        var act = { Name: "", Id: "" }
                                        act.Name = permsn[j].Name;
                                        act.Id = permsn[j].ID;
                                        folderpermissionsArr.push(act);
                                    }

                                }
                                else
                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                            },
                              function (result) {
                                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                              }
                            );







                    $("#last3daysrep").click(function () {
                        dayFilterForReporting();
                    });

                    $("#last7daysrep").click(function () {
                        dayFilterForReporting();
                    });

                    $("#last30daysrep").click(function () {
                        dayFilterForReporting();
                    });

                    $("#customdaterangerep").click(function () {
                        dayFilterForReporting();
                    });

                    PHARMAACE.FORECASTAPP.SHARE.loadAutocompleteData();
                    PHARMAACE.FORECASTAPP.SHARE.shareType = "UserWorkSpace";
                    PHARMAACE.FORECASTAPP.SHARE.loadUsers();
                   // PHARMAACE.FORECASTAPP.SHARE.autocompleteForUsers();
                   //  $(document).bind('keypress', pressed);
                    //$('#autocompleteSearchBox').bind('keypress', pressed);


                    $(".icon-input-btn").each(function () {
                        var btnFont = $(this).find(".btn").css("font-size");
                        var btnColor = $(this).find(".btn").css("color");
                        $(this).find(".glyphicon").css("font-size", btnFont);
                        $(this).find(".glyphicon").css("color", btnColor);
                        if ($(this).find(".btn-xs").length) {
                            $(this).find(".glyphicon").css("top", "24%");
                        }
                    });

                    
                    var clickEvent = false;
                    $('#myCarousel').on('click', '.nav a', function () {
                        clickEvent = true;
                        $('.nav li').removeClass('active');
                        $(this).parent().addClass('active');
                    });
                    //$('#BSbtninfo').filestyle({
                    //    buttonName: 'btn-info',
                    //    buttonText: ' Select a File'
                    //});
                    

            $('#editableWorkSpace .nav li a').click(function () {
                $('.nav li').removeClass('active');
                $(this).parent().addClass('active');
            });

            var i = 0;
            var dragging = false;
            $('#dragbar').mousedown(function (e) {
                e.preventDefault();
               
                dragging = true;
                var main = $('#editableWorkSpace');
                var ghostbar = $('<div>',
                                 {
                                     id: 'ghostbar',
                                     css: {
                                         //height: main.outerHeight(),
                                         top: main.offset().top,
                                         left: main.offset().left
                                     }
                                 }).appendTo('body');
             
                $(document).mousemove(function (e) {
                    ghostbar.css("left", e.pageX + 2);
                });

            });

            $(document).mouseup(function (e) {
                if (dragging) {
                    var percentage = (e.pageX / window.innerWidth) * 100;
                    var mainPercentage = 100 - percentage;

                    // $('#console').text("side:" + percentage + " main:" + mainPercentage);
                    if (percentage > 2.4) {
                        if (percentage <= 10) {

                           
                            if (!$('#leftmenu').hasClass("toggled")) {
                                $("#leftmenu").toggleClass("toggled");
                                $("#editableWorkSpace").toggleClass("toggled");
                                $('#workspaceSlider i.fa').removeClass('fa-chevron-left').addClass('fa-chevron-right');
                                $('#workspaceSlider i.fa').attr('title', 'Expand');
                            }
                           
                        }
                        else {
                            if ($('#leftmenu').hasClass("toggled")) {
                                $("#leftmenu").toggleClass("toggled");
                                $("#editableWorkSpace").toggleClass("toggled");
                                $('#workspaceSlider i.fa').removeClass('fa-chevron-right').addClass('fa-chevron-left');
                                $('#workspaceSlider i.fa').attr('title', 'Collapse');
                            }
                        }
                        if (percentage < 40) {
                            if (percentage > 27) {
                                $('#leftmenu').css("width", percentage + "%");
                                $('#editableWorkSpace').css("width", mainPercentage + "%");
                            }
                        }
                        //$('#leftmenu').css("width", percentage + "%");
                        //$('#editableWorkSpace').css("width", mainPercentage + "%");
                    }
                    
                    $('#ghostbar').remove();
                    $(document).unbind('mousemove');
                    dragging = false;
                }
            });


            $("#tree2").niceScroll({
                cursorfixedheight: 70,
                cursorcolor: "#F00",
                autohidemode: false
            });
            //$("#treeforAdvSearch").niceScroll({
            //    cursorfixedheight: 70
            //});
            
            
            $("#workspaceView li").on("click", function () {
                //$("#workspaceView li").removeClass("active");
                //$(this).addClass("active");
            });
            
            $("#workspaceSlider li i.fa").on("click", function (e) {
                e.preventDefault();

                if ($('#workspaceSlider i.fa').attr('title') == "Collapse") {
                    $('#workspaceSlider i.fa').removeClass('fa-chevron-left').addClass('fa-chevron-right');
                    $('#workspaceSlider i.fa').attr('title', 'Expand');
                }
                else {
                    $('#workspaceSlider i.fa').removeClass('fa-chevron-right').addClass('fa-chevron-left');
                    $('#workspaceSlider i.fa').attr('title', 'Collapse');
                }
                $("#leftmenu").toggleClass("toggled").removeAttr('style');
                $("#editableWorkSpace").toggleClass("toggled").removeAttr('style');
                
            });
            $('#verticalTitle a').click(function () {
                $("#leftmenu").toggleClass("toggled").removeAttr('style');
                $("#editableWorkSpace").toggleClass("toggled").removeAttr('style');
            })
           
            
            $('#tree2').treed({ openedClass: 'glyphicon-folder-open', closedClass: 'glyphicon-folder-close' });
            $('ul ul ul li.branch .glyphicon-folder-close').click(function (e) {
                e.preventDefault();
                $('li').removeClass('liselected');
                $(this).parent().addClass('liselected');
            });            
                });            
       
        function fnshowhide(e, current) {
            // e.preventDefault();
            var tableid = $('#drop table').attr('id');
            var table = $('#' + tableid).DataTable();
            // alert(current.selectedIndex);
            //var column = table.column(current.selectedIndex + 1);
            var column = table.column(parseInt(current.getAttribute('data-original-index')) + 2);
            column.visible(!column.visible());

            //if (($('#lastSelected').val() != (current.getAttribute('data-original-index') + 1))) {

            //    if ($('option[data-column]').hasClass('active'))
            //        if ($('option[data-column=' + (current.getAttribute('data-original-index') + 1) + ']').hasClass('active'))
            //            $('option[data-column=' + (current.getAttribute('data-original-index') + 1) + ']').removeClass('active');
            //        else
            //            $('option[data-column=' + (current.getAttribute('data-original-index') + 1) + ']').addClass('active');
            //    else
            //        $('option[data-column=' + (current.getAttribute('data-original-index') + 1) + ']').addClass('active');
            //}

            $('#lastSelected').val(current.getAttribute('data-original-index') + 1);
        }
        function getInnertext() {         
            $("#filter").attr("title", $("#filter").val());
        }
        var selectedFolderId="";
        var lineageForSpan = "";
        var selectedLineage = "";
        var parentdSelectedlineage = "";
        var currentCaption = { PopupName: "" };
        var userForecastMappingForShare;
        var ObjectIdForShare;
        var permissionsArr = [];
        var typeOfObjectShare = "";

        var folderpermissionsArr = [];
        var filepermissionArr = [];

        var selectedFolderIdForReporting = "";
        var selectedFileIdForReporting = "";
        var trRow = ""
        var fileNameForUnshare = "";

        objectIdForDelete ="";
        lineageForDelete= "";

        var objectIdForCopy= "";
        var lineageForCopy = "";
        var arrayOfNamesForCopy=[];
        var isFileCopy = false;
        var isMultiCopy = false;
        var noOfFileCopy=0;
        var objectIdForPaste = "";
        var lineageForPaste = "";
        var sequenceSet = "";



        var preBDLValue = "";
        var preDealChampValue = "";
        var preBDLText = "";
        var preDealChampText = "";
        var preProjectID = "";

       
        var itemsDisabled = {};

        var objectIdString = "";

        var objectIdsForMultiCopy = [];
        var LineageSForMultiCopy = [];


        var sharedRowrCout = 0;

        function ContentFilterSearch() {

            event.preventDefault();
            var selProjId = $("#byfolder").find('option:selected').attr('objid');
            if (selProjId == undefined)
            {
                selProjId = "null";
            }
            var Projname;
            $("#byfolder > option").each(function () {
             
                if ($(this).attr('objid') == selProjId) {
                    Projname = this.text;                    
                }
               
            });

            var contentKeyWord = $('#filter').val();
            var mytable = $('#drop table');            

            mytable.find('tr').each(function () {
                $(this).show();
                var trow = $(this);
                

                    if ($(this).find('td:last').attr("string"))
                    {
                        $(this).find('td:last').text("SearchedText");
                    }
                    if ($(this).find('td:last').attr("string") == "SearchedText") {
                        
                    }     
              
                    if ($(this).find('td:last').attr("string") == "result")
                    {
                        $(this).find('td:last').text("-");
                    }
               
            });

            if (contentKeyWord != "") {
                var isFullTextSearch = true;   
                if (Projname == null || Projname == "") {
                    PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Searching " + contentKeyWord.italics() + " in all Projects", 'editableWorkSpace', '15', '');

                }
                else {
                    PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Searching " + contentKeyWord.italics() + " in " + Projname.italics(), 'editableWorkSpace', '15', '');

                }
                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/ContentFilterSearch", {

                    contentKeyWord: $('#filter').val(),
                    isFullTextSearch: isFullTextSearch,
                    selectedFolder: selProjId
                },
                                 function (result) {
                                     if (result.success) {
                                         PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                         if (selProjId == "null" ) {
                                             addFileFolders(result.FileIds);
                                         }
                                         else {
                                             contentFileIds(result.FileIds);
                                         }
                                         
                                     }
                                     else {
                                         PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                         PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                                     }

                                 },
                                 function (result) {
                                     PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                     PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                                 });

            }
        }

        function contentFileIds(content) {
            var tableid=$('#drop table').attr('id');
            var mytable = $('#' + tableid);

            mytable.find('tr').each(function () {
                var trow = $(this);
                
              if (trow.index() === 0)
                {
                    if ($(this).find('td:last').attr("string") == "SearchedText") {

                    }
                    else if(($(this).find('td:last').html() != "Size"))
                        {
                        trow.append('<td string="SearchedText" style="width: 65px">Searched Result</td>');
                    }
                    
                }

                else {
                    if ($(this).find('td:last').attr("string") == "result") {

                }
                else {
                    trow.append('<td string="result" >value</td>');
                }                    
                }
            });
            var tableid = $('#drop table').attr('id');
            //var mytable = $('#' + tableid);

            var table = document.getElementById(tableid);
            var isdisplay = false;          

            for (var i = 1, row; row = table.rows[i]; i++) {
              
                for (var j = 0; j < content.objectIds.length; j++) {                   

                    isdisplay = false;
                    if ($(row).attr('folderid') == content.objectIds[j]) {                      

                        $(row).find('td:last').text (content.SearchedText[j]);                       
                        isdisplay = true;
                        break;
                    }
                }
                if (isdisplay == false) {
                    $(row).css("display", "none");
                }
            }
        }
     

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



        function downloadSelectedFile() {
         
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are download file ...", 'editableWorkSpace', '15', '');

            var tableid = $('#drop table').attr('id');
            var isNoPermFordownload = 0;
              $('#' + tableid).find('tr').find('input:checkbox:checked').each(function () {

                  
                  var value = $(this).parent().parent().attr('folderId');
                  var permission = $(this).parent().parent().attr('assignedpermission');

                  if (permission == "View") {
                      isNoPermFordownload++;

                  }
                  
                  else
                  if (value != null) {
                      
                      objectIdString = objectIdString + value + "|";
                      trRowid = $(this);
                  }
              });
            
              if (objectIdString != "") {
                  if (isNoPermFordownload == 0) {
                        var b = $('#amultiDownload').attr('href','/UserWorkSpace/downloadSelectedFile?objectIdString=' + objectIdString);
                                  b[0].click();
                               objectIdString = "";
                    
                  }
                  else
                  {
                      bootbox.confirm({
                          size: 'small',
                          message: 'You do not have permission to delete some of the file(s).Do you want to continue with other file(s)',
                          buttons: {
                              'confirm': {
                                  label: 'Yes',
                                  className: 'btn-danger pull-right',

                              },
                              'cancel': {
                                  label: 'No',
                                  className: 'btn-default pull-left'
                              }
                          },
                          callback: function (result) {
                              if (result) {

                                  var b = $('#amultiDownload').attr('href','/UserWorkSpace/downloadSelectedFile?objectIdString=' + objectIdString);
                                  b[0].click();
                                  objectIdString = "";
                              }
                              else {

                              }


                          }

                      });
                  }
              }
              else if (objectIdString == "" && isNoPermFordownload > 0)
              {
                  PHARMAACE.FORECASTAPP.UTILITY.popalert("You don't have permission to download");

              }
              
               isNoPermFordownload = 0;
               PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                       
        }
   

        function copySelectedFile()
        {
            var tableid = $('#drop table').attr('id');
            objectIdsForMultiCopy = [];
            LineageSForMultiCopy = [];
            arrayOfNamesForCopy = [];
            noOfFileCopy = 0;
            var isNoPermForCopy =0;
            $('#' + tableid).find('tr').find('input:checkbox:checked').each(function (){

                var objectIdForMulCopy = $(this).parent().parent().attr('folderId');
                var fileLineageForMulCopy = $(this).parent().parent().attr('fileLineage');
                var permission=$(this).parent().parent().attr('assignedpermission');
                var  folderNameForCopy = $(this).parent().parent().find('#contentName').text();
                if (permission == "View" || permission == "Open")
                {
                    isNoPermForCopy++;

                }
                else if (objectIdForMulCopy != null && fileLineageForMulCopy != null)
                {
                    if (permission == "Share" || permission == "Download")
                    {
                       objectIdsForMultiCopy.push(objectIdForMulCopy);
                       LineageSForMultiCopy.push(fileLineageForMulCopy);
                       arrayOfNamesForCopy.push(folderNameForCopy);
                       noOfFileCopy++;
                   }
                }
            });
            if (isNoPermForCopy > 0 && noOfFileCopy>0)
            {
                bootbox.confirm({
                    size: 'small',
                    message: 'You do not have permission to copy for some of the file(s).Do you want to continue with other file(s)',
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
                        if (result)
                        {
                            isMultiCopy = true;
                            isFileCopy = true;
                            itemsDisabled["pasteli"] = false;
                            itemsDisabled["pasteRightPane"] = false;

                            PHARMAACE.FORECASTAPP.UTILITY.popalert("File(s) are copied");
                        }
                        else
                        {

                        }


                    }

                });

            }
            /*if file are selected then allow copying files*/
            else if (noOfFileCopy > 0)
            {
                isMultiCopy = true;
                isFileCopy = true;
                itemsDisabled["pasteli"] = false;
                itemsDisabled["pasteRightPane"] = false;

                PHARMAACE.FORECASTAPP.UTILITY.popalert("File(s) are copied");
            }
            else if (isNoPermForCopy>0)
            {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("You don't have permission to copy file(s)");

            }
            else
            {

            }
           
       
        }

        function deleteSelectedFile() {
           
            var tableid = $('#drop table').attr('id');
            var objectIdsForMultiDel = [];
            var LineageSForMultiDel = [];
            var deletecount = 0;
            var isNoPermForDelete = 0;
            $('#' + tableid).find('tr').find('input:checkbox:checked').each(function () {


                var objectIdForMulDelete = $(this).parent().parent().attr('folderId');
                var fileLineageForMulDelete = $(this).parent().parent().attr('fileLineage');
                var permission = $(this).parent().parent().attr('assignedpermission');
                var folderNameForCopy = $(this).parent().parent().find('#contentName').text();
                if (permission == "View" || permission == "Open" || permission == "Download") {
                    isNoPermForDelete++;

                }

                if (objectIdForMulDelete != null && fileLineageForMulDelete != null && permission == "Share") {
                 
                        objectIdsForMultiDel.push(objectIdForMulDelete);
                        LineageSForMultiDel.push(fileLineageForMulDelete);
                        deletecount++;
                   
                }

            });
            if (deletecount > 0 && isNoPermForDelete==0 ) {
            bootbox.confirm({
                size: 'small',
                message: 'Are you sure you want to delete file(s) ?',
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

                       
                            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are deleting file(s)...", 'editableWorkSpace', '15', '');


                            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/delete", {
                                'objectIdStringForDelete': objectIdsForMultiDel.join('|'),
                                'lineageStringForDelete': LineageSForMultiDel.join(',')
                            },
                                                            function (result) {
                                                                if (result.result == 2) {
                                                                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("File(s) deleted successfully.");
                                                                    // callEditableWorkSpaceJSON(selectedFolderId, selectedLineage);
                                                                    $('#' + tableid).find('tr').find('input:checkbox:checked').each(function () {
                                                                        var value = $(this).parent().parent().attr('folderId');
                                                                        if (value != null) {
                                                                            $(this).parent().parent().remove();

                                                                        }

                                                                        var fileLineage = $(this).parent().parent().attr('fileLineage');
                                                                        if (fileLineage != null) {
                                                                            if (fileLineage.toString().trim() == "0") {
                                                                                var ids = selectedFolderId;
                                                                                var span = document.getElementById("SpnFCount" + ids);
                                                                                if (span != null) {
                                                                                    var prevCount = span.innerHTML;
                                                                                    span.innerHTML = parseInt(parseInt(prevCount) - 1);
                                                                                }
                                                                            }
                                                                            else
                                                                                var ids = fileLineage.toString().split(PHARMAACE.FORECASTAPP.CONSTANTS.LINEAGE_SPLITTER);

                                                                            for (var i = 0; i < ids.length; i++) {


                                                                                var span = document.getElementById("SpnFCount" + ids[i]);
                                                                                if (span != null) {
                                                                                    var prevCount = span.innerHTML;
                                                                                    span.innerHTML = parseInt(parseInt(prevCount) - 1);
                                                                                }
                                                                            }
                                                                        }

                                                                    });
                                                                    $("#example-select-all").prop("indeterminate", false);
                                                                    $("#example-select-all").prop("checked", false);
                                                                    enableDisableMultiOperTab();

                                                                }
                                                                else if (result.result == 1) {
                                                                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("File(s) already deleted");
                                                                }
                                                                else {
                                                                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to delete file(s).");
                                                                }
                                                            },
                                                            function (result) {
                                                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                                                            });

                        

                    }
                    else {

                    }
                }

            });
            }
            else if (deletecount > 0 && isNoPermForDelete>0)
            {
                bootbox.confirm({
                    size: 'small',
                    message: 'You do not have permission to delete some of file(s).Are you sure you want to delete other file(s) ?',
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


                            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are deleting file(s)...", 'editableWorkSpace', '15', '');


                            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/delete", {
                                'objectIdStringForDelete': objectIdsForMultiDel.join('|'),
                                'lineageStringForDelete': LineageSForMultiDel.join(',')
                            },
                                                            function (result) {
                                                                if (result.result == 2) {
                                                                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("File(s) deleted successfully.");
                                                                    // callEditableWorkSpaceJSON(selectedFolderId, selectedLineage);
                                                                    $('#' + tableid).find('tr').find('input:checkbox:checked').each(function () {

                                                                        var value = $(this).parent().parent().attr('folderId');
                                                                        if ($(this).parent().parent().attr('assignedpermission') == "Share") {
                                                                            if (value != null) {
                                                                                $(this).parent().parent().remove();

                                                                            }

                                                                            var fileLineage = $(this).parent().parent().attr('fileLineage');
                                                                            if (fileLineage != null) {
                                                                                if (fileLineage.toString().trim() == "0") {
                                                                                    var ids = selectedFolderId;
                                                                                    var span = document.getElementById("SpnFCount" + ids);
                                                                                    if (span != null) {
                                                                                        var prevCount = span.innerHTML;
                                                                                        span.innerHTML = parseInt(parseInt(prevCount) - 1);
                                                                                    }
                                                                                }
                                                                                else
                                                                                    var ids = fileLineage.toString().split(PHARMAACE.FORECASTAPP.CONSTANTS.LINEAGE_SPLITTER);

                                                                                for (var i = 0; i < ids.length; i++) {


                                                                                    var span = document.getElementById("SpnFCount" + ids[i]);
                                                                                    if (span != null) {
                                                                                        var prevCount = span.innerHTML;
                                                                                        span.innerHTML = parseInt(parseInt(prevCount) - 1);
                                                                                    }
                                                                                }


                                                                            }
                                                                        }

                                                                    });

                                                                }
                                                                else if (result.result == 1) {
                                                                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("File(s) already deleted");
                                                                }
                                                                else {
                                                                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to delete file(s).");
                                                                }
                                                            },
                                                            function (result) {
                                                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                                                            });





                        }
                        else {

                        }
                    }

                });

            }

            else if (deletecount == 0 && isNoPermForDelete > 0)
            {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("You don't have permission to delete file(s)");
                }
            else
            {

            }

            deletecount = 0;
            isNoPermForDelete = 0;
            
      }
       
       
        function selectedFileType(fileExtnType)
        { var array=[];
        if (fileExtnType == 0)
        {
            array.push(0,1, 2, 23,24,25,26,28,29,37);
        }
        if (fileExtnType == 1) {
            array.push(3,4,5,6,17,19,20,21,22,38,39);
        }
        if (fileExtnType == 2) {
            array.push(9,27);
        }
        if (fileExtnType == 3) {
            array.push(10,11,12,13,14,15,16);
        }
        if (fileExtnType == 4) {
            array.push(7,8,30,31,32,33,34,35,36,40);
        }
        if (fileExtnType == 5) {
            array.push(41,42,43,44,45,46);
        }
        return array;
                
        }
        


        function createAdvSearchObj(listSelFileType1, listLineage1, contentKeyWord, Startlast1, Endlast1, listSelUserIds1, isFullTextSearch, SelectedOpt,isAllUser)
        {
            var advSearchObj={              
                SelFileTypeList: listSelFileType1,
                ListLineage:listLineage1,
                ContentKeyWord: contentKeyWord,
                StartDate: Startlast1,
                EndDate: Endlast1,
                ListSelUserIds: listSelUserIds1,
                IsFullTextSearch: isFullTextSearch,
                SelectedOpt:SelectedOpt,
                isAllUser:isAllUser

            }
            return advSearchObj;

        }

        function rootFolderListAdvSearch()
        {
            event.preventDefault();
            var  isAllUser=0;
            var SelectedOpt = $("#searchCriteria").val();

            var listSelFolderAdvSearech = [];
            var listSelFileType = [];
            var StartDate, EndDate;
            var Startlast = new Date(0);
            var Endlast =new Date();
            var listLineage = [];            
            var listSelUserIds = [];
            var isFullTextSearch = true;
            
            if ($('#Last3Days').is(':checked'))  {
                var days = 3; // Days you want to subtract
                var date = new Date();
                Startlast = new Date(date.getTime() - (days * 24 * 60 * 60 * 1000));
                Endlast = new Date(date.getTime());
            }
            if ($('#LastMonth').is(':checked')) {
                var days = 30; // Days you want to subtract
                var date = new Date();
                Startlast = new Date(date.getTime() - (days * 24 * 60 * 60 * 1000));
                Endlast = new Date(date.getTime());
            }
            if ($('#filter-range').is(':checked')) {
                var StartDate = document.getElementById("datepicker-start").value;
                if (StartDate == "")
                {
                    Startlast = new Date(0);
                }
                else {
                    Startlast = new Date(StartDate);
                    Startlast.setHours(0, 0, 0, 0);
                }
                var EndDate = document.getElementById("datepicker-end").value;
                if (EndDate == "")
                {
                    var date = new Date();
                    Endlast = new Date(date.getTime());
                }
                else
                {
                    Endlast = new Date(EndDate);
                    Endlast.setHours(23, 59, 59, 999);
                }
            }
            
            var objectIdForAdvSearch = $("#byfolder option:selected").attr("objid");
            var lineageForAdvSearch = $("#byfolder option:selected").attr("lineageid");

            listSelFolderAdvSearech.push(objectIdForAdvSearch);

            if (objectIdForAdvSearch != undefined && lineageForAdvSearch != undefined) {
                if (lineageForAdvSearch == "0") {
                    listLineage.push(objectIdForAdvSearch);
                }
                else {
                    var li = lineageForAdvSearch + PHARMAACE.FORECASTAPP.CONSTANTS.LINEAGE_SPLITTER;
                    listLineage.push(li);
                }
            }
            else {
                listLineage.push('null');
            }
                      
           
            $("#tree3").find("input:checkbox:checked").each(function () {
              var fileType=  selectedFileType($(this).val());

              listSelFileType.push(fileType);
            }); 
                 
            if (listSelFileType.length == 0)
            {
                $("#tree3").find("input:checkbox").each(function () {
                    var fileType = selectedFileType($(this).val());

                    listSelFileType.push(fileType);
                });
            }
          
            $("#tree5").find("input:checkbox:checked").each(function () {
                listSelUserIds.push($(this).val());
            });

            if (listSelUserIds.length == 0) {
                $("#tree5").find("input:checkbox").each(function () {
                    listSelUserIds.push($(this).val());
                    isAllUser=1;
                });
            }


            var contentKeyWord = $('#filter').val();
          
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("", 'editableWorkSpace', '15', '');
            var listSelFileType1 = listSelFileType.join(',');
            var listLineage1 = listLineage.join(',');
            var Startlast1 = Startlast.toUTCString();
            var Endlast1 = Endlast.toUTCString();
            var listSelUserIds1 = listSelUserIds.join(',');
             

            var createdAdvSearchObj = createAdvSearchObj(listSelFileType1, listLineage1, contentKeyWord, Startlast1, Endlast1, listSelUserIds1, isFullTextSearch, SelectedOpt,isAllUser);
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/AdvSearch", createdAdvSearchObj,
                  function (result) {
                      if (result.success) {
                          addFileAdvSearch(result.ContentFolderList);
                          PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                      }
                      else
                      {
                          PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                          PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors, '');                      }
                     },
                  function (result) {
                      PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                      PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                  });
        }        




        function PrevUserChangePermission() {
            var preBDLUserPerm = $('#permissarrValuesBDL option:selected').val();
            var preDealChampIdPerm=$('#permissarrValuesDealChamp option:selected').val();
       

            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/PrevUserChangePermission", {
                'ProjectID': preProjectID,
                'BDLUserId': preBDLValue,
                'DealChampId': preDealChampValue,
                'BDLUserPerm': preBDLUserPerm,
                'DealChampIdPerm': preDealChampIdPerm
            },
                                                function (result) {
                                                    if (result.result == 1) {
                                                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Permission changed successfully");
                                                        preProjectID = 0;
                                                        $('#btnOkModalClose').click();
                                                    }
                                                    if (result.result == 0) {
                                                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to change permission");
                                                    }
                                                    preBDLText = "";
                                                    preDealChampText = "";
                                                    preBDLValue = "";
                                                    preDealChampValue = "";
                      
                                                },
                                                function (result) {
                                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed : " + result.responseText, '');
                                                });

        }

        function renameFolder() {
            var Name = document.getElementById("txtFolderNameRename").value;
            if (!Name.trim()) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Enter name");
                    return false;
            }
            else {

                var folderId = document.getElementById("txtParentRename").value;

                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/renameObject", {
                    'objectId': folderId,
                    'newName': Name
                },
                function (result) {
                    
                    if (selectedTypeForRename == "Folder") {
                        if (result.result == 1) {
                            var li = document.getElementById(folderId);
                            var aTag = li.getElementsByTagName("a");
                            var prevFolderName = aTag[0].innerHTML;
                            var r = prevFolderName.substr(0, prevFolderName.indexOf(' '));
                            var newFolderName = r + '  ' + Name;
                            aTag[0].innerHTML = newFolderName;
                            aTag[0].title = newFolderName;
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Folder renamed successfully");
                        }
                        else
                        if (result.result == 3) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Folder name already present");

                        }
                        else
                        if(result.result==4)
                        {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Folder is not available");

                        }
                        else
                        if (result.result ==5) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("You do not have permission to rename a folder");

                        } else  if(result.result == 0)
                            {
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to rename folder ");

                            }
                    }
                    else if (selectedTypeForRename == "File") {
                        if (result.result == 1) {

                            var tableid = $('#drop table').attr('id');
                            var tableRef = $('#' + tableid);
                            
                            $(tableRef).find(trRow).find('a[allowdownload]')[0].text = Name;
                            $(tableRef).find(trRow).find('a[allowdownload]')[0].title = Name;
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("File renamed successfully");
                        }
                        else
                            if (result.result == 3) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("File name already present");

                        }
                        else
                        if (result.result == 4) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("File is not available");

                        }
                        else
                        if (result.result == 5) {

                            PHARMAACE.FORECASTAPP.UTILITY.popalert("You do not have permission to rename a file");

                        }
                        else if (result.result == 0) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to rename ");
                        }
                    }

                    $('#btnRenameModalClose').click();

                    document.getElementById("txtParentRename").value = "";
                    document.getElementById('txtFolderNameRename').value = "";
                },
                function (result) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                });


            }
        }








        function setPopuptitle(objectId) {
            
            $('#addnewproduct h4.modal-title').html('Edit Project');
          
          
            $("#bdl option").each(function (index) {
                var fortitle = $(this).attr('data-email');
                //$(this).attr("title", fortitle);
                $('#forbdl li').eq(index).attr("title", fortitle);

            });
            $("#dealchamp option").each(function (index) {
                var fortitle = $(this).attr('data-email');
                //$(this).attr("title", fortitle);
                $('#dealbox li').eq(index).attr("title", fortitle);

            });



            $('#deal').val(0);



            document.getElementById('name').disabled = "disabled";
            
            document.getElementById('SelectedProjectId').value = objectId;

           
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait fetching project data...", 'editableWorkSpace', '15', '');
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/fetchProjectData", { ObjectId: objectId },
                    function (result) {
                        if (result.success) {
                            preDealDetailsOfCurrentProj = result.dealDetails;
                            setDetails(result.dealDetails);
                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                        }
                        else {
                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                        }

                    },
                    function (result) {
                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                    });
        }

        function setPopuptitleforAdd() {
         
            document.getElementById('name').disabled = false;
            document.getElementById('deal').value = 0;
            $('#addnewproduct h4.modal-title').html('Add New Project');
            $("#bdl option").each(function (index) {
                var fortitle = $(this).attr('data-email');
                //$(this).attr("title", fortitle);
                $('#forbdl li').eq(index).attr("title", fortitle);

            });
            $("#dealchamp option").each(function (index) {
                var fortitle = $(this).attr('data-email');
                //$(this).attr("title", fortitle);
                $('#dealbox li').eq(index).attr("title", fortitle);

            });
            $('#deal').val(0);

          

            if ($("#ARD").parent().hasClass('checked')) {
                $("#ARD").parent().removeClass('checked');
            }
            
            else if ($("#ARDandHospital").parent().hasClass('checked')) {
                $("#ARDandHospital").parent().removeClass('checked');
            }
            $("#hospital").parent().addClass('checked');


           // clearControls();

        }

        function ValidateCreateProject() {
            var valid = true;
            var name = document.getElementById('name').value;
            //var deal = document.getElementById('deal').value;
            var currency = document.getElementById('currency').value;
            if (currency == "")
            {
                currency = $('#currency')[0].options.selectedIndex = 1;
                
            }
            var performance = document.getElementById('performance').value;
            var status = document.getElementById('status').value;
            var bdl = document.getElementById('bdl').value;
            var dealchamp = document.getElementById('dealchamp').value;
            var activity = document.getElementById('activity').value;
            var priority = document.getElementById('priority').value;
           

            if (!name || !bdl || !dealchamp || !status || !activity || !priority || !performance||!currency)
            {
               
                valid = false;
            }

            return valid;

        }

        //function showOverlay(loadmessage, divid, loaderSize, fromTop) {
        //    $('#versionmsg').css("display", "none");
        //    if ($("body").overlay) {
        //        $('#bodyOverlay').css("display", "block");

        //        $("body").overlay(loadmessage, divid, loaderSize, fromTop);
        //    }

        //}
        //function hideOverlay(keepEDrawHidden, divid) {
        //    if ($("body").overlayout) {
        //        $('#bodyOverlay').css("display", "none");
        //        $("body").overlayout(divid);
        //    }
            
               
        //}

        function createDealDataObj(name, deal, currency, performance, status, bdl, dealchamp, activity, projectType, priority, operationType, projectId, ownerId, modifiedString) {

            var dealDataObject={
                Name: name,
                Value: deal,
                Currency: currency,
                Objective: performance,
                StageID: status,
                BDL_Lead: bdl,
                DealChampion: dealchamp,
                ActivityID: activity,
                ProjectType:projectType,
                Priority: priority,
                OperationType: operationType,
                projectId: projectId,
                Owner: ownerId,
                ModifiedField: modifiedString
            }
            return dealDataObject;
        }
        function compareDealDetailsWithPrev(currentDealDetails) {
            var str = '';

            if (currentDealDetails.BDL_Lead != preDealDetailsOfCurrentProj.BDL_Lead)
                str += "BD&L Lead changed from " + $("#bdl option[value=" + preDealDetailsOfCurrentProj.BDL_Lead + "]").text() + " to " + $("#bdl option[value=" + currentDealDetails.BDL_Lead + "]").text() + ".";

            if (currentDealDetails.DealChampion != preDealDetailsOfCurrentProj.DealChampion)
                str += "Deal Champion changed from " + $("#dealchamp option[value=" + preDealDetailsOfCurrentProj.DealChampion + "]").text() + " to " + $("#dealchamp option[value=" + currentDealDetails.DealChampion + "]").text() + ".";

            if (currentDealDetails.StageID != preDealDetailsOfCurrentProj.StageID)
                str += "Project Stage changed from " + $("#status option[value=" + preDealDetailsOfCurrentProj.StageID + "]").text() + " to " + $("#status option[value=" + currentDealDetails.StageID + "]").text() + ".";

            if (currentDealDetails.ActivityID != preDealDetailsOfCurrentProj.ActivityID)
                str += "Types of Activity changed from " + $("#activity option[value=" + preDealDetailsOfCurrentProj.ActivityID + "]").text() + " to " + $("#activity option[value=" + currentDealDetails.ActivityID + "]").text() + ".";

            if (currentDealDetails.ProjectType != preDealDetailsOfCurrentProj.ProjectType) 
            {
                var fromProjectType = "";
                var toProjectType = "";
                if (preDealDetailsOfCurrentProj.ProjectType == 0)
                {
                    fromProjectType = $("li.addprdli").children('span').eq(0).text();
                }
                else if (preDealDetailsOfCurrentProj.ProjectType == 1)
                {
                    fromProjectType = $("li.addprdli").children('span').eq(1).text();
                }
                else if (preDealDetailsOfCurrentProj.ProjectType == 2) {
                    fromProjectType = $("li.addprdli").children('span').eq(2).text();
                } if (currentDealDetails.ProjectType == 0) {
                    toProjectType = $("li.addprdli").children('span').eq(0).text();
                }
                else if (currentDealDetails.ProjectType ==1) 
                    {
                    toProjectType = $("li.addprdli").children('span').eq(1).text();
                }
                else if (currentDealDetails.ProjectType == 2) {
                    toProjectType = $("li.addprdli").children('span').eq(2).text();
                }
                str += "Project type changed from " + fromProjectType + " to " + toProjectType + ".";
            }

            if (currentDealDetails.Priority != preDealDetailsOfCurrentProj.Priority)

                str += "Priority changed from " + preDealDetailsOfCurrentProj.Priority + " to " + currentDealDetails.Priority + ".";

            if (currentDealDetails.Value != preDealDetailsOfCurrentProj.Value)
                str += "Deal Value changed from " + preDealDetailsOfCurrentProj.Value + " to " + currentDealDetails.Value + ".";

            if (currentDealDetails.Currency != preDealDetailsOfCurrentProj.Currency)
                str += "Currency changed from " + $("#currency option[value=" + preDealDetailsOfCurrentProj.Currency + "]").text() + " to " + $("#currency option[value=" + currentDealDetails.Currency + "]").text() + ".";

            if (currentDealDetails.Objective != preDealDetailsOfCurrentProj.Objective)
                str += "Performance changed from " + preDealDetailsOfCurrentProj.Objective + " to " + currentDealDetails.Objective + ".";

            return str;
        }

        function SaveProject() {
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are saving the project...", 'editableWorkSpace', '15', '');

            var isValidate = ValidateCreateProject();
            var flag = false;
            $("#btnNewProduct").attr("type", "submit");

            if (isValidate == false) {

                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace'); return false;
            }
            else {
                // document.getElementById("btnNewProduct").removeAttribute("type");
                $("#btnNewProduct").attr("type", "button");
                if ($('#addnewproduct h4.modal-title').html() == "Add New Project") {
                    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/CheckSameProjNameExist", { 'ProjName': document.getElementById('name').value },
                            function (result) {
                                if (result.success) {
                                    if (result.result == 1) {

                                        var projectId = document.getElementById('SelectedProjectId').value;
                                        if (projectId == null || projectId == '') {
                                            var projectId = 0;

                                        }

                                        var name = document.getElementById('name').value;
                                        var dealvalue = document.getElementById('deal').value;
                                        if (dealvalue==undefined) {
                                            deal = 0;
                                        }
                                        var deal = convertToWholeNo(dealvalue);
                                        var currency = document.getElementById('currency').value;
                                        if (currency == "") {
                                            currency = $('#currency')[0].options.selectedIndex = 1;

                                        }
                                        var performance = document.getElementById('performance').value;
                                        var status = document.getElementById('status').value;
                                        var bdl = document.getElementById('bdl').value;
                                        var dealchamp = document.getElementById('dealchamp').value;
                                        var activity = document.getElementById('activity').value;
                                        var projectType = "";
                                        if ($("#hospital").parent().hasClass('checked')) {
                                            projectType = document.getElementById('hospital').value;
                                        }
                                        else if($("#ARD").parent().hasClass('checked'))
                                        {
                                                projectType = document.getElementById('ARD').value;
                                        }
                                        else if ($("#ARDandHospital").parent().hasClass('checked'))
                                        {
                                            projectType = document.getElementById('ARDandHospital').value;

                                        }
                                        var priority = document.getElementById('priority').value;
                                        var ownerId = document.getElementById('ownerId').value;
                                        modifiedString = "";
                                        var operationType;
                                        var ProjectStatus;


                                        if ($('#addnewproduct h4.modal-title').html() == "Add New Project") {
                                            operationType = 1;
                                            ProjectStatus = "Project added successfully";


                                        }
                                        var createdDealData = createDealDataObj(name, deal, currency, performance, status, bdl, dealchamp, activity, projectType, priority, operationType, projectId, ownerId, modifiedString);
                                        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/SaveProject", createdDealData,
                                                    function (result) {
                                                        if (result.success) {
                                                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                            hideModal('addnewproduct');
                                                            $("#rempopoup").click();
                                                            PHARMAACE.FORECASTAPP.UTILITY.popalert(ProjectStatus);
                                                            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/UserWorkSpace/LeftPaneFolderRoot", {},
                                                                        function (result) {
                                                                            $('#tree2').html(result);
                                                                        },
                                                                        function (status) {
                                                                            PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                                                                        });
                                                        }
                                                    },
                                                    function (result) {
                                                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed! " + result.responseText, '');
                                                    });

                                    }
                                    if (result.result == 0) {
                                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Project name entered already exist");

                                    }
                                    else {

                                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                    }
                                }
                            });
                }

                if ($('#addnewproduct h4.modal-title').html() == "Edit Project") {

                    var projectId = document.getElementById('SelectedProjectId').value;
                    var name = document.getElementById('name').value;
                    var dealValue = document.getElementById('deal').value;
                    var deal = convertToWholeNo(dealValue);
                    var currency = document.getElementById('currency').value;
                    var performance = document.getElementById('performance').value;
                    var status = document.getElementById('status').value;
                    var bdl = document.getElementById('bdl').value;
                    var dealchamp = document.getElementById('dealchamp').value;
                    var activity = document.getElementById('activity').value;
                    var projectType = "";
                    if ($("#hospital").parent().hasClass('checked')) {
                        projectType = document.getElementById('hospital').value;
                    }
                    else if ($("#ARD").parent().hasClass('checked')) {
                            projectType = document.getElementById('ARD').value;
                    }
                    else if ($("#ARDandHospital").parent().hasClass('checked')) {
                        projectType = document.getElementById('ARDandHospital').value;

                    }
                    var priority = document.getElementById('priority').value;
                    var ownerId = document.getElementById('ownerId').value;
                    var operationType;
                    var ProjectStatus;


                    if ($('#addnewproduct h4.modal-title').html() == "Edit Project") {
                        operationType = 0;
                        ProjectStatus = "Project modified successfully! ";
                        var countForChange = 0;
                        if (preBDLValue != bdl && preDealChampValue != dealchamp && preBDLValue == preDealChampValue) {
                            countForChange = 1;//indicates BD& L lead 
                            editPermissionPopup(countForChange, projectId);
                        }
                        if (preBDLValue != bdl && preDealChampValue == dealchamp) {
                            countForChange = 1;//indicates BD& L lead 
                            editPermissionPopup(countForChange, projectId);
                        }
                        if (preDealChampValue != dealchamp && preBDLValue == bdl) {
                            countForChange = 2;//indicates Deal Champion            
                            editPermissionPopup(countForChange, projectId);
                        }
                        if (preBDLValue != bdl && preDealChampValue != dealchamp && preBDLValue != preDealChampValue) {
                            countForChange = 3;//indicates BD& L lead and Deal Champion 
                            editPermissionPopup(countForChange, projectId);
                        }
                    }
                    var currentDealDetails = createDealDataObj(name, deal, currency, performance, status, bdl, dealchamp, activity,projectType,priority, operationType, projectId, ownerId, "");
                    var modifiedString = compareDealDetailsWithPrev(currentDealDetails);
                    var createdDealData = createDealDataObj(name, deal, currency, performance, status, bdl, dealchamp,activity,projectType,priority, operationType, projectId, ownerId, modifiedString);
                    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/SaveProject", createdDealData,
                    function (result) {
                        if (result.success) {
                            if (result.result == 1) {
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                //document.getElementById("btnNewProduct").removeAttribute("data-dismiss");
                                $("#rempopoup").click();
                                PHARMAACE.FORECASTAPP.UTILITY.popalert(ProjectStatus);
                                PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/UserWorkSpace/LeftPaneFolderRoot", {},
                                        function (result) {
                                            $('#tree2').html(result);
                                        },
                                        function (status) {
                                            PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                                        });
                            }
                        }
                    },
                    function (result) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed! " + result.responseText, '');
                    });

                }
            }
        }
       

       


        function editPermissionPopup(countForChange, projectId) {
            preProjectID = projectId;
            if (countForChange == 1)
            {
                $('#BdlId').val(preBDLText);
                $('#champChangePermValues').css("display", "none");
                $('#bdlchangePermValues').css("display", "block");
                
                for (i = 0; i < permissionsArr.length;i++)
                {
                    
                    if ((permissionsArr[i].Name) == "Creator") {
                        $('#permissarrValuesBDL').append('<option value="' + permissionsArr[i].Id + '" selected>' + (permissionsArr[i].Name) + '</option>');

                    }
                    else {
                        $('#permissarrValuesBDL').append('<option value="' + permissionsArr[i].Id + '">' + (permissionsArr[i].Name) + '</option>');

                    }
                }
                $('#permissarrValuesBDL').selectpicker();
                $('#btnchangePerm').click();
            }
            if (countForChange == 2) {
                $('#ChampId').val(preDealChampText);
                $('#bdlchangePermValues').css("display", "none");
                $('#champChangePermValues').css("display", "block");
                for (i = 0; i < permissionsArr.length; i++) {
                    if ((permissionsArr[i].Name)=="Creator") {
                        $('#permissarrValuesDealChamp').append('<option value="' + permissionsArr[i].Id + '" selected>' + (permissionsArr[i].Name) + '</option>');

                    }
                    else {
                        $('#permissarrValuesDealChamp').append('<option value="' + permissionsArr[i].Id + '">' + (permissionsArr[i].Name) + '</option>');

                    }
                }
                $('#permissarrValuesDealChamp').selectpicker();
                $('#btnchangePerm').click();
            }
            if (countForChange == 3) {
                $('#BdlId').val(preBDLText);
                $('#ChampId').val(preDealChampText);
                $('#bdlchangePermValues').css("display", "block");
                $('#champChangePermValues').css("display", "block");
                for (i = 0; i < permissionsArr.length; i++) {
                    if ((permissionsArr[i].Name) == "Creator") {
                        $('#permissarrValuesBDL').append('<option value="' + permissionsArr[i].Id + '" selected>' + (permissionsArr[i].Name) + '</option>');

                    }
                    else {
                        $('#permissarrValuesBDL').append('<option value="' + permissionsArr[i].Id + '">' + (permissionsArr[i].Name) + '</option>');

                    }
                }
                $('#permissarrValuesBDL').selectpicker();
                for (i = 0; i < permissionsArr.length; i++) {
                    if ((permissionsArr[i].Name) == "Creator") {
                        $('#permissarrValuesDealChamp').append('<option value="' + permissionsArr[i].Id + '" selected>' + (permissionsArr[i].Name) + '</option>');

                    }
                    else {
                        $('#permissarrValuesDealChamp').append('<option value="' + permissionsArr[i].Id + '">' + (permissionsArr[i].Name) + '</option>');

                    }
                }
                $('#permissarrValuesDealChamp').selectpicker();
                $('#btnchangePerm').click();
            }
                   
        }

        function clearControls() {

            $('#name').val('');
            $('#performance').val('');
          //  $('#deal').val('');
            $("#status").val('');
            $("#bdl").val('');
            $("#dealchamp").val('');
            $("#activity").val('');
            $("#priority").val('');
            $("#currency").val('');



            var bdluser = document.getElementsByName("bdl");
            var parentEl = bdluser[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");
            var spanElement = secButtonParent[0].getElementsByTagName("span");
            spanElement[0].innerText = "Please Select";
            /////////////////////////////////////////////////////////
            var actuser = document.getElementsByName("activity");
            var parentEl = actuser[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");
            var spanElement = secButtonParent[0].getElementsByTagName("span");
            spanElement[0].innerText = "Please Select";

            ////////////////////////////////////////////////////////            
            var dchamp = document.getElementsByName("dealchamp");
            var parentEl = dchamp[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");
            var spanElement = secButtonParent[0].getElementsByTagName("span");
            spanElement[0].innerText = "Please Select";
            ///////////////////////////////////////////////
            var statusele = document.getElementsByName("status");
            var parentEl = statusele[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");
            var spanElement = secButtonParent[0].getElementsByTagName("span");
            spanElement[0].innerText = "Please Select";
            ///////////////////////////
            var priorityele = document.getElementsByName("priority");
            var parentEl = priorityele[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");
            var spanElement = secButtonParent[0].getElementsByTagName("span");
            spanElement[0].innerText = "Please Select";
            ////////////////////////////////////////////////////////
            var currencyval = document.getElementsByName("currency");
            var parentEl = currencyval[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");
            var spanElement = secButtonParent[0].getElementsByTagName("span");
            spanElement[0].innerText = "$";

        }
        function IncCountAfterPaste(isFileCopy, lineageForPaste, objectIdForPaste, objectIdForCopy) {
            
             if (isFileCopy == true) {
                 if (lineageForPaste.toString().trim() == "0") {
                     var ids = selectedFolderId;
                     var span = document.getElementById("SpnFCount" + ids);
                     if (span != null) {
                         var prevCount = span.innerHTML;
                         span.innerHTML = parseInt(parseInt(prevCount) + parseInt(noOfFileCopy));
                     }

                 }
                 else {
                     var lineageAfterAppendObjId = lineageForPaste + PHARMAACE.FORECASTAPP.CONSTANTS.LINEAGE_SPLITTER + objectIdForPaste;
                     var ids = lineageAfterAppendObjId.toString().split(PHARMAACE.FORECASTAPP.CONSTANTS.LINEAGE_SPLITTER);
                     for (var i = 0; i < ids.length; i++) {
                         var span = document.getElementById("SpnFCount" + ids[i]);
                         if (span != null) {
                             var prevCount = span.innerHTML;
                             span.innerHTML = parseInt(parseInt(prevCount) + parseInt(noOfFileCopy));
                         }
                     }

                 }
             }
             else
             {
                 var copySpan = document.getElementById("SpnFCount" + objectIdForCopy);
                 if (copySpan != null) {
                     var fileCountInFolder =parseInt(copySpan.innerHTML);
                 }
                 if (lineageForPaste.toString().trim() == "0") {
                     var ids = selectedFolderId;
                     var span = document.getElementById("SpnFCount" + ids);
                     if (span != null) {
                         var prevCount = span.innerHTML;
                         span.innerHTML = parseInt(parseInt(prevCount) + parseInt(fileCountInFolder));
                     }
                     }
                 else {
                     var lineageAfterAppendObjId = lineageForPaste + PHARMAACE.FORECASTAPP.CONSTANTS.LINEAGE_SPLITTER + objectIdForPaste;
                     var ids = lineageAfterAppendObjId.toString().split(PHARMAACE.FORECASTAPP.CONSTANTS.LINEAGE_SPLITTER);
                     for (var i = 0; i < ids.length; i++) {
                         var span = document.getElementById("SpnFCount" + ids[i]);
                         if (span != null) {
                             var prevCount = span.innerHTML;
                             span.innerHTML = parseInt(parseInt(prevCount) + parseInt(fileCountInFolder));
                         }
                         
                         }

                 }


             }

           
            
        }

        function setDetails(dealDetails) {
          
            $('#ownerId').val(dealDetails.Owner);
            $('#name').val(dealDetails.Name);
            $('#performance').val(dealDetails.Objective);
            var deal = convertToMillion(dealDetails.Value);
            $('#deal').val(deal);
            $("#status").val(dealDetails.StageID);
            $("#bdl").val(dealDetails.BDL_Lead);
            $("#dealchamp").val(dealDetails.DealChampion);
            $("#activity").val(dealDetails.ActivityID);
            $("#priority").val(dealDetails.Priority);
            $("#currency").val(dealDetails.Currency);
            if (dealDetails.ProjectType == 0)
            {
                if ($("#ARD").parent().hasClass('checked')) {
                    $("#ARD").parent().removeClass('checked');
                }
                else
                if ($("#ARDandHospital").parent().hasClass('checked')) {
                    $("#ARDandHospital").parent().removeClass('checked');
                }

                 $("#hospital").parent().addClass('checked');
              
            }
            else if (dealDetails.ProjectType == 1) {
                if ($("#hospital").parent().hasClass('checked')) {

                    $("#hospital").parent().removeClass('checked');
                }
                else
                if ($("#ARDandHospital").parent().hasClass('checked')) {
                    $("#ARDandHospital").parent().removeClass('checked');
                }
                $("#ARD").parent().addClass('checked');

            }
            else if (dealDetails.ProjectType == 2)
            {
                if ($("#ARD").parent().hasClass('checked')) {
                    $("#ARD").parent().removeClass('checked');
                }
                if ($("#hospital").parent().hasClass('checked')) {

                    $("#hospital").parent().removeClass('checked');
                }
                $("#ARDandHospital").parent().addClass('checked');


            }

                
            var bdluser = document.getElementsByName("bdl");
            var bdlSelIndex = $("#bdl")[0].selectedIndex;

            var parentEl = bdluser[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");
            var spanElement = secButtonParent[0].getElementsByTagName("span");
            spanElement[0].innerText = bdluser[0].options[bdlSelIndex].text;
            /////////////////////////////////////////////////////////
            var actSelIndex = $("#activity")[0].selectedIndex;
            var actuser = document.getElementsByName("activity");
            var parentEl = actuser[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");

            var spanElement = secButtonParent[0].getElementsByTagName("span");
            spanElement[0].innerText = actuser[0].options[actSelIndex].text;

            ////////////////////////////////////////////////////////
            var dchampSelIndex = $("#dealchamp")[0].selectedIndex;
            var dchamp = document.getElementsByName("dealchamp");
            var parentEl = dchamp[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");

            var spanElement = secButtonParent[0].getElementsByTagName("span");
            spanElement[0].innerText = dchamp[0].options[dchampSelIndex].text;
            ///////////////////////////////////////////////
            var statusSelIndex = $("#status")[0].selectedIndex;
            var statusele = document.getElementsByName("status");
            var parentEl = statusele[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");

            var spanElement = secButtonParent[0].getElementsByTagName("span");
            spanElement[0].innerText = statusele[0].options[statusSelIndex].text;
            ///////////////////////////
            var priSelIndex = $("#priority")[0].selectedIndex;
            var priorityele = document.getElementsByName("priority");
            var parentEl = priorityele[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");

            var spanElement = secButtonParent[0].getElementsByTagName("span");
           //spanElement[0].innerText = priorityele[0].options[priSelIndex].text;
            spanElement[0].innerText = priorityele[0].options[priSelIndex].text;
            ////////////////////////////////////////////////////////
            var curSelIndex = $("#currency")[0].selectedIndex;
            var currencyval = document.getElementsByName("currency");
            var parentEl = currencyval[0].parentElement;
            var secParent = parentEl.getElementsByTagName("div");
            var secButtonParent = parentEl.getElementsByTagName("button");

            var spanElement = secButtonParent[0].getElementsByTagName("span");
            spanElement[0].innerText = currencyval[0].options[curSelIndex].text;

            preBDLText = $('#bdl option:selected').text();
            preDealChampText = $('#dealchamp option:selected').text();
            preBDLValue = dealDetails.BDL_Lead;
            preDealChampValue=dealDetails.DealChampion;
        }

        function stageWiseProjList(stageName) {
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("", 'editableWorkSpace', '15', '');
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/GetStageWiseProjList", { stageName: stageName },
                              function (result) {
                                  if (result.success) {
                                      PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                      actProjectList(result.actProjList);
                                  }
                                  else
                                  {
                                      PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                      PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');

                                  }
                              },
                              function (result) {
                                  PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                              });

        }

       
        function ActivitiesProjList(activityId, projIds) {
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("", 'editableWorkSpace', '15', '');

            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/GetActivityWiseProjList",
                {
                    'activityId': activityId,
                    'projIds': projIds

                },
                   function (result) {
                       if (result.success) {
                           PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                           actProjectList(result.actProjList);
                       }
                       else {
                           PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                           PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                       }
                   },
                   function (result) {
                       PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                   });

        }

        function actProjectList(actProjList)
        {
            var tableRef = document.getElementById('trackerWorkspaceTable').getElementsByTagName('tbody')[0];
            var str = '';           
            actProjList.forEach(function (actProjList) {                         
                str += '<tr>';
                str += '<td>' + actProjList.StageName+ '</td>';
                str += '<td>'+ actProjList.ActivityName + '</td>';                
                str += '<td>' + actProjList.Name + '</a></td>';               
                str += '<td> ' + actProjList.DealChampUserName  + '</td>';              
                str += '<td> ' + actProjList.BDLUserName + '</td>';
                str += '<td>' + actProjList.Objective + '</td>';
              
                str += '</tr>';
               
            })
            tableRef.innerHTML = "";
            tableRef.innerHTML = str;                      
        }       
       
        function FillStageFunnel(trackerdata) {

            document.getElementById("screenProfileCountsPrice").innerHTML = convertToMillion(trackerdata.screenProfileCounts_Price);
            document.getElementById("screenProfileCounts").innerHTML = trackerdata.screenProfileCounts;
            document.getElementById("dilligenceCountsPrice").innerHTML =convertToMillion(trackerdata.Dilligence_Price);
            document.getElementById("dilligenceCounts").innerHTML = trackerdata.DilligenceCounts;
            document.getElementById("negotiationCountsPrice").innerHTML =convertToMillion(trackerdata.Negotiation_Price);
            document.getElementById("negotiationCounts").innerHTML = trackerdata.NegotiationCounts;
            document.getElementById("totalprice").innerHTML = convertToMillion(trackerdata.Total_Price);
            document.getElementById("onHoldWithdrwalCounts").innerHTML = trackerdata.onHoldWithdrwalCounts;
            document.getElementById("onHoldWithdrwalPrice").innerHTML =convertToMillion(trackerdata.onHoldWithdrwal_Price);


        }

        function FillActivityPieChart(activities)
        {
            var data = [];
            for (var j = 0 ; j < activities.length ; j++) {
                var act = { label: "", data: "", actId: "" }
                act.label = activities[j].Name;
                act.data = activities[j].projCounts;
                act.actId = activities[j].ID;
                act.ProjIds = activities[j].ProjIds;
                data.push(act);
            }
            $.plot('#placeholder', data, {
                series: {
                    pie: {
                        show: true,
                        offset: {top: -20},
                        
                        label: {
                            show: true,
                            formatter: function (label, series) {
                                var element = '<div style="font-size:9pt;text-align:center;padding:2px;"><a ProjIds="' + series.ProjIds + '" actId="' + series.actId + '" title="' + label + '" style="color:#fff; padding:20px;" onclick=ActivitiesProjList(' + series.actId + ',\'' + series.ProjIds + '\')>' + series.data[0][1] + '</a></div>';
                                return element;
                            },
                            radius: 2 / 4,
                        }
                    }
                },
                grid: {
                    hoverable: true,
                    clickable: true
                }
            });
        }


        function addScripts() {
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("", 'editableWorkSpace', '15', '');
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/getActivityData", {},
                               function (result) {

                                   if (result.success)
                                   {
                                       $('#leftmenu').css("display", "none");
                                       $('#editableWorkSpace').removeClass("col-md-9").css("padding", "0px 15px");
                                       document.getElementById("advFilter").style.display = "none";                                       
                                       FillStageFunnel(result.trackerdata);
                                       FillActivityPieChart(result.trackerdata.TrackerDataList);
                                       PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
               // var data = [
               //{ label: "M&A", data: 1800 },
               //{ label: "Product Acquisition/ Divestiture", data: 1200 },
               //{ label: "Product Licensing", data: 800 },
                                       //{ label: "Authorised Generics", data: 500 } ];                                      
                                   }
                                   else
                                   {
                                       PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                                   }
                               },
                               function (result) {
                                   PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                               });      
        }

        function GetLibraryTab() {
            if($("#drop").hasClass('context-menu-empty')==false) {
                     $('#drop').addClass("context-menu-empty");
                    }
            $('#searchbarForContentsearch .toggle.btn').css('display', 'block');
            $('.dataTables_wrapper input[type=text]').css('display', 'none');
            $('#searchbarForContentsearch .toggle.btn').removeClass('btn-primary');
            $('#searchbarForContentsearch .toggle.btn').addClass('btn-default').addClass('off');
		scrollerSearch='';
		scrollerReport='';
            if ((selectedFolderId !="") && (selectedLineage!=""))
                callEditableWorkSpaceJSON(selectedFolderId, selectedLineage);

            var copyTab = document.getElementById('LiCopyDoc');
            copyTab.style.display = 'block';
          
            $('#LiUploadDoc').css("display", "block");
            $('#ReportingFolder').removeClass('ShiftTop');
            $('#treeforAdvSearch').removeClass('ShiftTop');
            $('.leftSection').removeClass('cngArwColor');
            $("#example-select-all").prop("indeterminate", false);
            $("#example-select-all").prop("checked", false);
            enableDisableMultiOperTab();
            var tableid = $('#drop table').attr('id');
            $('#' + tableid).find('tr').each(function () {

                var attr = $(this).attr('folderid');
                if (typeof attr !== typeof undefined && attr !== false) {
                    $(this).remove();
                }
            });
            
            $('.dataTables_info').css("display", "none");
            $('.dataTables_paginate').css("display", "none");
            $('#showhide').show();
            $('#custom-search-input').show();
            $('#searchButton').css("display", "none");
            $('#leftmenu').css("display", "block");
            $('#treeforfolderlist').css("display", "block");
            if ($("#leftmenu").hasClass('toggled')) {
                $("#leftmenu").toggleClass("toggled");
                $("#editableWorkSpace").toggleClass("toggled");
                $('#workspaceSlider i.fa').removeClass('fa-chevron-right').addClass('fa-chevron-left');
                $('#workspaceSlider i.fa').attr('title', 'Collapse');
            }
            $('#treeforAdvSearch').html('');
            $('.leftBox').css("display", "none");
            $('#tabAttr').removeAttr('style');
            $('#showhide').show();
            $('#addnewproject').css("display", "block");
            $('#searchFromList').css("display", "block");
            $('#treeforReporting').css("display", "none");
            //$('#leftmenu').css("display", "block");
            //$('#tree2').css("display", "block");
            $('#showentries').css("display", "none");
            document.getElementById("leftmenu").className = "col-md-3";
            document.getElementById("editableWorkSpace").className = "col-md-9";
            document.getElementById("sliderArrow").style.display = "block";
            document.getElementById("advFilter").style.display = "none";
            //document.getElementById("workspaceView").style.display = "block";
           
        }
        function GetReportsTab() {
           
            document.getElementById("leftmenu").className = "col-md-3";
            document.getElementById("editableWorkSpace").className = "col-md-9";
            document.getElementById("sliderArrow").style.display = "block";
            document.getElementById("advFilter").style.display = "block";
            //document.getElementById("workspaceView").style.display = "block";
            //document.getElementById("workspaceView").style.visibility = "visible";
            $("#byproject").val($("#byproject option:first").val())
        }               
        function GetTrackerSummaryTab() {
            // $('#enbdisEvent').cs('display', 'none');
            $('#searchbarForContentsearch .toggle.btn').css('display', 'none');
		scrollerFolder='';
		scrollerSearch='';
		scrollerReport='';
            $('#tabAttr').css('display',"none");
            $('#showentries').css("display", "none");
          /*  $.ajax({
                "url": "UserWorkSpace/ProjectSummary",
                "data":
                    {},
              
                "success": function (result) {

                    $('#leftmenu').css("display", "none");
                    $('#showhide').css("display", "none");
                    $('#editableWorkSpace').removeClass("col-md-9").css("padding","0px 15px");
                    document.getElementById("advFilter").style.display = "none";
                    addScripts();
                }

            }); */
            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/UserWorkSpace/ProjectSummary", {},
                 function (result) {
                         $('#leftmenu').css("display", "none");
                         $('#showhide').css("display", "none");
                         $('#editableWorkSpace').removeClass("col-md-9").css("padding", "0px 15px");
                         document.getElementById("advFilter").style.display = "none";
                         addScripts();
                 },
                        function (status) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                        });

        }
        

        function populateSharePopup(folderForShare, lineageForsharePopUp) {

            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/UserWorkSpace/SharePopup",
{ ObjectId: document.getElementById("txtParent").value, folderForShare: folderForShare, lineageForsharePopUp: lineageForsharePopUp },
function (data) {
                     PHARMAACE.FORECASTAPP.SHARE.autocompleteForUsers();
                     var element = document.getElementById('ShareResult');
                     element.innerHTML = data;
                   //  $('#inputPassword').autocomplete({ source: PHARMAACE.FORECASTAPP.SHARE.autocompleteListData });
                     //$('#shareModal').modal('show');
                     $('#shareModal').modal({
                         backdrop: 'static'                        
                     });
                 },
                        function (status) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                        });

          
            $('#prdverid tbody').find('tr').each(function () {
                var attr = $(this).attr('unshareid');


                if (typeof attr !== typeof undefined && attr !== false) {
                    sharedRowrCout++;
                }

            });

        }

        //function FillSharePopUp_old(userForShare) {
        //    var str = '';
        //    //var str1 = "";
        //    var str1 = $('#prdverid tbody');
        //    var tableRef = document.getElementById('prdverid').getElementsByTagName('tbody')[0];

        //    //tableRef.innerHTML = "";
        //    //str1 += '<tr><td colspan="5" style="padding-left:0px; padding-right:0px; padding-bottom:0px;">';
        //    //str1 += '<input type="text" class="form-control ui-widget" id="inputPassword"  style="width:100%;">';
        //    //str1 += '</td></tr>';
        //    var populatedSelectBox;
        //    userForShare.forEach(function (userForShare) {
        //        var count = PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser;
        //        str += '<tr class="ShareUsers innerTrShareForcast" data-index="0" unShareId=' + userForShare.UserId + ' class="ShareUsers">';
        //        str += '<td class="bs-checkbox"> ' + userForShare.FullName + ' </td>';
        //        str += '<td id="shareuseremail" style = ""> ' + userForShare.EmailId + '</td>';
        //        str += ' <td style="display:none;" class="divOne">' + userForShare.UserId + '</td>';
        //        str += '<td><div id="dropdownOfShare' + count + '"><select type="text" id="getpermission' + count + '"  class="selectpicker form-control multiselect multiselect-icon" >';
        //        PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser++;
        //        PHARMAACE.FORECASTAPP.SHARE.checkShareType(shareType);
        //        if (typeOfObjectShare == "Folder") {
        //            populatedSelectBox = PHARMAACE.FORECASTAPP.SHARE.ShowSharePermission(userForShare.Permission, folderpermissionsArr);
        //        }
        //        else if (typeOfObjectShare == "File") {
        //            PHARMAACE.FORECASTAPP.SHARE.permissionMsgFlagFileOrFolder = true;//indicates file permission
        //            populatedSelectBox = PHARMAACE.FORECASTAPP.SHARE.ShowSharePermission(userForShare.Permission, filepermissionArr);
        //        }

        //        str += populatedSelectBox;
        //        str += '</select></div>';
        //        str += '</td>';
        //        str += '<td class="unshareicon"><i class="fa fa-times" aria-hidden="true"  style="cursor:pointer;" onclick="unshareForecast(' + userForShare.UserId + ',\'' + userForShare.FullName + '\');"></i></td>';
        //        str += '</tr>';
        //        populateTooltipForDropDown(count);
        //    })

        //    // tableRef.innerHTML = str + str1;
        //    str1.append(str);
            
        //    //$('#inputPassword').autocomplete({ source: PHARMAACE.FORECASTAPP.SHARE.autocompleteListData });

        //}

        function FillSharePopUp(userForShare) {
            var str = '';
            //var str1 = "";
            var str1 = $('#prdverid tbody');
            var tableRef = document.getElementById('prdverid').getElementsByTagName('tbody')[0];

            //tableRef.innerHTML = "";
            //str1 += '<tr><td colspan="5" style="padding-left:0px; padding-right:0px; padding-bottom:0px;">';
            //str1 += '<input type="text" class="form-control ui-widget" id="inputPassword"  style="width:100%;">';
            //str1 += '</td></tr>';
            var populatedSelectBox;
            var count = PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser;
            userForShare.forEach(function (userForShare) {
                count = PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser;
                str += '<tr class="ShareUsers innerTrShareForcast" data-index="0" unShareId=' + userForShare.UserId + ' class="ShareUsers">';
                str += '<td class="bs-checkbox"> ' + userForShare.FullName + ' </td>';
                str += '<td id="shareuseremail" style = ""> ' + userForShare.EmailId + '</td>';
                str += ' <td style="display:none;" class="divOne">' + userForShare.UserId + '</td>';
                str += '<td><div id="dropdownOfShare' + count + '"><select type="text" id ="getpermission' + count + '" class="selectpicker form-control multiselect multiselect-icon" >';
                PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser++;
                PHARMAACE.FORECASTAPP.SHARE.checkShareType(shareType);
                if (typeOfObjectShare == "Folder") {
                    PHARMAACE.FORECASTAPP.SHARE.selectedLineage = selectedLineage;
                    PHARMAACE.FORECASTAPP.SHARE.permissionMsgFlagFileOrFolder = false;//indicates folder or project permission
                    populatedSelectBox = PHARMAACE.FORECASTAPP.SHARE.ShowSharePermission(userForShare.Permission, folderpermissionsArr);
                }
                else if (typeOfObjectShare == "File") {
                    PHARMAACE.FORECASTAPP.SHARE.permissionMsgFlagFileOrFolder = true;//indicates files permission
                    populatedSelectBox = PHARMAACE.FORECASTAPP.SHARE.ShowSharePermission(userForShare.Permission, filepermissionArr);
                }

                str += populatedSelectBox;
                str += '</select></div>';
                str += '</td>';
                str += '<td class="unshareicon"><i class="fa fa-times" aria-hidden="true" title="Unshare" style="cursor:pointer;" onclick="unshareForecast(' + userForShare.UserId + ',\'' + userForShare.FullName + '\');"></i></td>';
                str += '</tr>';


            });

            // tableRef.innerHTML = str + str1;
            str1.append(str);
            for(var p=0;p<=count;p++)
            {
               // populateTooltipForDropDown(p);
                PHARMAACE.FORECASTAPP.SHARE.TooltipForTr(p);
               // $('#getpermission' + p + '').selectpicker();
            }
            //$('#inputPassword').autocomplete({ source: PHARMAACE.FORECASTAPP.SHARE.autocompleteListData });

        }

        function populateSharePopupWithFetchedData(userForShare, folderForShare, lineageForsharePopup) {

            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/UserWorkSpace/SharePopup",
{ ObjectId: document.getElementById("txtParent").value, folderForShare: folderForShare, lineageForsharePopup: lineageForsharePopup },
function (data) {
                     PHARMAACE.FORECASTAPP.SHARE.autocompleteForUsers();
                     var element = document.getElementById('ShareResult');
                     element.innerHTML = data;
                     PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser = 0;//used in .js file
                     FillSharePopUp(userForShare);
                     //dynamicInputTextboxShare();
                     // $('#inputPassword').autocomplete({ source: PHARMAACE.FORECASTAPP.SHARE.autocompleteListData });
                    // populateTooltipForDropDown();
                   // $('#shareModal').modal('show');
                    $('#shareModal').modal({   /*To stop =>removes popup onclick outside*/
                        backdrop: 'static'
        
                    });
                 },
                        function (status) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                        });
        }
       
        function createFolder() {
           
            var Name = document.getElementById("txtFolderName").value;
            if (!Name.trim()) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Enter folder name");
                return false;
            }
            else {

                var parentId = selectedFolderId;
                $('#btnModalClose').click();
                PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are creating folder...", 'editableWorkSpace', '15', '');
             
                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/CreateFolder", {
                    'parentId': parentId,
                    'ChildName': Name,
                },
                        function (result) {
                            if (result.result == 1) {
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Folder created successfully");
                                var objectId = parentId;
                                var lineage = document.getElementById(parentId).getAttribute("lineagestring");
                                var sequence = document.getElementById(parentId).getAttribute("sequence");
                                callLeftPaneFolderViewWithIndexForCreatedFolder(objectId, lineage, sequence);
                            } else
                            if (result.result == 2) {
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Folder name already exists ");

                            }
                            else
                            if (result.result == 0) {
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to create folder");
                            }
                           

                            document.getElementById("txtParent").value = "";
                            document.getElementById('txtFolderName').value = "";
                        },
                        function (result) {

                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed : " + result.responseText, '');

                        });

            }
        }
        function callPasteFile(objectIdForPaste, lineageForPaste, arrayOfNamesForCopy)
        {
           
                PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are copying...", 'editableWorkSpace', '15', '');
                var postData = JSON.stringify({
                    'objectIdsForCopy': objectIdsForMultiCopy.join('|'),
                    'lineagesForCopy': LineageSForMultiCopy.join(','),
                    'objectIdForPaste': objectIdForPaste,
                    'lineageForPaste': lineageForPaste,
                    'arrayOfNamesForCopy': arrayOfNamesForCopy.join('|')
                });
                PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/UserWorkSpace/pastefile", postData,
                 function (result) {
                     if (result.result == 1) {
                         IncCountAfterPaste(isFileCopy, lineageForPaste, objectIdForPaste, objectIdForCopy);
                         callEditableWorkSpaceJSON(objectIdForPaste, lineageForPaste);
                         PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                         PHARMAACE.FORECASTAPP.UTILITY.popalert("Copied successfully");
                         $("#example-select-all").prop("indeterminate", false);
                         $("#example-select-all").prop("checked", false);
                         enableDisableMultiOperTab();

                     }
                     else if (result.result == 2) {
                         PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                         PHARMAACE.FORECASTAPP.UTILITY.popalert("Some of file/folder are not available");

                     } else if (result.result == 0) {
                         PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                         PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to copy");
                     }
                 },
                function (result) {
                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Copying failed! " + result.responseText, '');
 
                });
       }
        
        function pastefile() {
           
            var objectIdForPaste = selectedFolderId;
            var lineageForPaste = selectedLineage;
            var postData = JSON.stringify({

                'objectIdForPaste': objectIdForPaste,
                'lineageForPaste': lineageForPaste,
                'arrayOfNamesForCopy': arrayOfNamesForCopy.join('|')
            });
            PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/UserWorkSpace/checkNameForPaste", postData,

            function (result) {
                if (result.result == 1) {
                    callPasteFile(objectIdForPaste, lineageForPaste, arrayOfNamesForCopy);
                }
                else {
                    bootbox.confirm({
                        size: 'small',
                        message: 'File(s)/folder(s) already exist.Are you sure you want to copy with another name',
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
                                callPasteFile(objectIdForPaste, lineageForPaste, arrayOfNamesForCopy);
                            }
                            else {
                                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                            }
                        }
                    });
                }
            },
        function (result) {

        });

        }

        function callPasteFolder(objectIdForPaste, lineageForPaste,sequence,arrayOfNamesForCopy)
        {

            var postData = JSON.stringify({
                'objectIdsForCopy': objectIdsForMultiCopy.join('|'),
                'lineagesForCopy': LineageSForMultiCopy.join(','),
                'objectIdForPaste': objectIdForPaste,
                'lineageForPaste': lineageForPaste,
                'arrayOfNamesForCopy': arrayOfNamesForCopy.join('|')
            });
            PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/UserWorkSpace/pasteFolder", postData,
             function (result) {
                 if (result.result == 1) {
                     IncCountAfterPaste(isFileCopy, lineageForPaste, objectIdForPaste, objectIdForCopy);
                     callLeftPaneFolderViewWithIndexForCreatedFolder(objectIdForPaste, lineageForPaste, sequence);
                     callEditableWorkSpaceJSON(objectIdForPaste, lineageForPaste);
                     PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                     PHARMAACE.FORECASTAPP.UTILITY.popalert("Copied successfully");
                     $("#example-select-all").prop("indeterminate", false);
                     $("#example-select-all").prop("checked", false);
                     enableDisableMultiOperTab();

                 }
                 else if (result.result == 2) {
                     PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                     PHARMAACE.FORECASTAPP.UTILITY.popalert("Some of file(s)/folder(s) are not available");
                 } else if (result.result == 0) {
                     PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                     PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to copy");
                 }
             },
            function (result) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Copying failed! " + result.responseText, '');
                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');

            });
        }
        function pasteFolder() {
            var objectIdForPaste = selectedFolderId;
            var lineageForPaste = selectedLineage;
            var sequence = document.getElementById(objectIdForPaste).getAttribute("sequence");

            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are copying...", 'editableWorkSpace', '15', '');
            var postData = JSON.stringify({

                'objectIdForPaste': objectIdForPaste,
                'lineageForPaste': lineageForPaste,
                'arrayOfNamesForCopy': arrayOfNamesForCopy.join('|')
            });
            PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/UserWorkSpace/checkNameForPaste", postData,
         function (result) {
             if (result.result == 1) {
                 callPasteFolder(objectIdForPaste, lineageForPaste, sequence, arrayOfNamesForCopy);
             }
             else {
                 PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                 bootbox.confirm({
                     size: 'small',
                     message: 'File(s)/folder(s) already exist.Are you sure you want to copy with another name',
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
                             callPasteFolder(objectIdForPaste, lineageForPaste, sequence, arrayOfNamesForCopy);
                         }
                         else {
                             PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                         }
                     }
                 });
             }
         },
        function (result) {
            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Copying failed! " + result.responseText, '');
        });
        }

        function callLeftPaneFolderViewWithIndexForCreatedFolder(objectId, lineage, parentIndex) {
            var SpanId = "Span" + objectId;
            var isProject = true;

            document.getElementById(SpanId).style.visibility = "hidden";
            if (lineage == "0") {
                isProject = true;
            }

            else {
                isProject = false;
            }
           
            var fisrSpanId = "SpanFirst" + objectId;
            var spanEl = document.getElementById(SpanId);
            var SpanFirst = document.getElementById(fisrSpanId);
            var selectedLi = document.getElementById(objectId);
            sequenceSet = $(selectedLi).attr('sequence');
            var SpanClassName = spanEl.className;

            if (SpanClassName == "fa fa-chevron-up") {
                var x;
                var li = document.getElementById(objectId);
                var ul = li.getElementsByTagName(
                    "ul")
                for (i = 0; i < ul.length; i++) {
                    x = ul[i];
                  
                    x.parentNode.removeChild(x)
                }
                spanEl.className = "fa fa-chevron-down";
                SpanFirst.className = "glyphicon glyphicon glyphicon-folder-close";
            }

            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/UserWorkSpace/LeftPaneFolderViewWithIndex", {
                ObjectId: objectId, lineage: lineage, parentIndex: sequenceSet, 'isProject': isProject
            },
                       function (result) {
                           if (result) {
                               if (result.includes("li"))
                               {
                                   document.getElementById(SpanId).style.visibility = "visible";
                               }
                               $("#" + objectId).append(result);
                           }
                           else
                           {

                           }
                          


                       },
                       function (result) {
                       });

                spanEl.className = "fa fa-chevron-up";
                SpanFirst.className = "glyphicon glyphicon glyphicon-folder-open";
            }
        $(function () {
            itemsDisabled["pasteRightPane"] = true;

            $.contextMenu({

                selector: '.context-menu-empty',
                build: function ($trigger, e) {
                    if (selectedFolderId == "" || selectedFolderId == undefined) {
                        return false;
                    }
                    else {


                        var selectedLiObjectId = [];
                    
                        $('#tree2').find('li.selected').each(function () {

                            selectedLiObjectId.push($(this)[0].getAttribute('id'));

                        });
                        selectedFolderId = selectedLiObjectId[selectedLiObjectId.length - 1];
                        var ListItem = document.getElementById(selectedFolderId);
                        var permission =$(ListItem).attr('permission');
                        var lineageString = $(ListItem).attr('lineageString');
                        selectedLineage = $(ListItem).attr('lineageString');
                        lineageForSpan = $(ListItem).attr('lineageString');

                        if (permission == "ContetFileShare")
                        {
                            return false;
                        }
                        if (lineageString == "0") {

                            if (isFileCopy == true) {
                                var menuItems = {
                                    "newRightPane": { name: "Create Folder", icon: "fa-folder-o" }
                                }
                            }
                            else if (isFileCopy == false) {
                                var menuItems = {
                                    "newRightPane": { name: "Create Folder", icon: "fa-folder-o" },
                                    "pasteRightPane": {
                                        name: "Paste", icon: "fa-clipboard", disabled:
                                  function (key, opt) {
                                      return !!itemsDisabled[key];
                                  }
                                    }
                                }
                            }
                           
                        }

                        else {
                            var menuItems = {
                                "newRightPane": { name: "Create Folder", icon: "fa-folder-o" },
                                "uploadfileRightPane": { name: "Upload File", icon: "fa-upload" },
                                "pasteRightPane": {
                                    name: "Paste", icon: "fa-clipboard", disabled:
                              function (key, opt) {
                                  return !!itemsDisabled[key];
                              }
                                }

                            }
                        }

                    }


                    return {
                        callback: function (key, options) {
                            var ParentId;
                            if (selectedFolderId == "" || selectedFolderId == undefined) {
                                return false;
                            }
                            else {
                                if (key == "newRightPane") {
                                    $('#btnmodl').click();

                                }
                                if (key == "uploadfileRightPane") {
                                    $('#btnupload').click();
                                }
                                if (key == "pasteRightPane") {
                                    if (isFileCopy == true) {
                                        pastefile();
                                    }
                                    else {
                                       
                                        pasteFolder();
                                    }
                                }
                            }
                        },
                        items: menuItems
                    };
                }
            });
        });


        $(function () {

            var tableid = $('#drop table').attr('id');

            itemsDisabled["uploadfileli"] = true;
            itemsDisabled["newli"] = true;
            itemsDisabled["pasteli"] = true;

            $.contextMenu({

                selector: '#tree2 li[class*=applycontextmenu]',
                build: function ($trigger, e) {

                    var permission = $trigger.attr('permission');
                    var lineageString = $trigger.attr('lineageString');
                    var isDefaultFolder = "False";
                    var DefaultFolder = $trigger.attr('IsDefaultFolder');

                    if (typeof DefaultFolder !== typeof undefined && DefaultFolder !== false) {
                        isDefaultFolder = DefaultFolder;
                    }

                    if (lineageString == "0") {

                        if (permission == "FullControl" && isFileCopy == true) {
                            var menuItems = {
                                "newli": { name: "Create Folder", icon: "fa-folder-o" },
                                "shareli": { name: "Permission", icon: "fa-share-square-o" },
                                "deleteli": { name: "Delete", icon: "fa-trash-o" }
                            }
                        }
                        else if (permission == "FullControl" && isFileCopy == false) {
                            var menuItems = {
                                "newli": { name: "Create Folder", icon: "fa-folder-o" },
                                "shareli": { name: "Permission", icon: "fa-share-square-o" },
                                "pasteli": {
                                    name: "Paste", icon: "fa-clipboard", disabled:
                                    function (key, opt) {
                                        return !!itemsDisabled[key];
                                    }

                                },
                                "deleteli": { name: "Delete", icon: "fa-trash-o" }

                            }
                        }
                        else if (permission == "Moderator" && isFileCopy == true) {
                            var menuItems = {
                                "newli": { name: "Create Folder", icon: "fa-folder-o" },

                                "shareli": { name: "Permission", icon: "fa-share-square-o" }

                            }
                        }
                        else if (permission == "Moderator" && isFileCopy == false) {
                            var menuItems = {
                                "newli": { name: "Create Folder", icon: "fa-folder-o" },
                                "shareli": { name: "Permission", icon: "fa-share-square-o" },
                                "pasteli": {
                                    name: "Paste", icon: "fa-clipboard", disabled:
                               function (key, opt) {
                                   return !!itemsDisabled[key];
                               }
                                }
                            }
                        }

                        else if (permission == "NoAccess") {
                            menuItems = {

                            }
                        }
                    }

                    else { //if clicked on subfolders
                        if (permission == "FullControl") {

                            if (isDefaultFolder == "True") {
                                menuItems = {
                                    "newli": { name: "Create Folder", icon: "fa-folder-o" },
                                    "uploadfileli": { name: "Upload File", icon: "fa-upload" },
                                    "shareli": { name: "Permission", icon: "fa-share-square-o" },
                                    "copyli": { name: "Copy", icon: "fa-files-o" },
                                    "pasteli": {
                                        name: "Paste", icon: "fa-clipboard", disabled:
                                        function (key, opt) {
                                            return !!itemsDisabled[key];
                                        }
                                    },
                                }
                            }

                            if (isDefaultFolder == "False") {
                                menuItems = {
                                    "newli": { name: "Create Folder", icon: "fa-folder-o" },
                                    "uploadfileli": { name: "Upload File", icon: "fa-upload" },
                                    "shareli": { name: "Permission", icon: "fa-share-square-o" },
                                    "copyli": { name: "Copy", icon: "fa-files-o" },
                                    "pasteli": {
                                        name: "Paste", icon: "fa-clipboard", disabled:
                                        function (key, opt) {
                                            return !!itemsDisabled[key];
                                        }

                                    },
                                    "renameli": { name: "Rename", icon: "fa-pencil-square-o" },
                                    "deleteli": { name: "Delete", icon: "fa-trash-o" }
                                }
                            }
                        }

                        else if (permission == "Moderator") {
                            if (isDefaultFolder == "True") {
                                var menuItems = {
                                    "newli": { name: "Create Folder", icon: "fa-folder-o" },
                                    "uploadfileli": { name: "Upload File", icon: "fa-upload" },
                                    "shareli": { name: "Permission", icon: "fa-share-square-o" },
                                    "copyli": { name: "Copy", icon: "fa-files-o" },
                                    "pasteli": {
                                        name: "Paste", icon: "fa-clipboard", disabled:
                                        function (key, opt) {
                                            return !!itemsDisabled[key];
                                        }

                                    },
                                }
                            }


                            if (isDefaultFolder == "False") {

                                var menuItems = {
                                    "newli": { name: "Create Folder", icon: "fa-folder-o" },
                                    "uploadfileli": { name: "Upload File", icon: "fa-upload" },
                                    "shareli": { name: "Permission", icon: "fa-share-square-o" },
                                    "copyli": { name: "Copy", icon: "fa-files-o" },
                                    "pasteli": {
                                        name: "Paste", icon: "fa-clipboard", disabled:
                                        function (key, opt) {
                                            return !!itemsDisabled[key];
                                        }

                                    },
                                    "renameli": { name: "Rename", icon: "fa-pencil-square-o" },
                                }
                            }
                        }


                        else if (permission == "NoAccess") {
                            menuItems = {

                            }
                        }

                    }

                    return {
                        callback: function (key, options) {

                            var x, ParentId;

                            var ListItem = $("li[class*='context-menu-active']");
                            var pid = $(ListItem).attr('id');
                            var permission = $(ListItem).attr('permission');
                            selectedFolderIdForReporting = pid;
                            var li = document.getElementById(pid);
                            var Name = li.getElementsByTagName("a");
                            var PrevName = Name[0].innerHTML;


                            selectedLineage = $(ListItem).attr('lineageString');
                            lineageForSpan = $(ListItem).attr('lineageString');

                            var selectedLineageForDelete = selectedLineage;
                            selectedFolderId = pid;


                            if (typeof pid != 'undefined') {
                                document.getElementById("txtParent").value = pid;
                            }

                            if (typeof selectedFolderIdForReporting != 'undefined') {
                                document.getElementById("txtParentRename").value = selectedFolderIdForReporting;
                            }

                            if (typeof ParentId != 'undefined') {
                                document.getElementById("txtParent").value = ParentId;
                            }

                            if (x == "File") {
                                alert("The directry or file can not be created under file");
                            }
                            else {

                                if (key == "shareli") {
                                    PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait", 'editableWorkSpace', '15', '');

                                    typeOfObjectShare = "Folder";
                                    ObjectIdForShare = pid;
                                    var lineageForsharePopup = selectedLineage;
                                    var folderForShare = PrevName.substr(PrevName.indexOf(' ') + 1);
                                    PHARMAACE.FORECASTAPP.SHARE.autocompleteForUsers();
                                    PHARMAACE.FORECASTAPP.SHARE.loadUsers();
                                    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/ProjCreators", {
                                        objectId: ObjectIdForShare, lineageForsharePopUp: lineageForsharePopup,

                                    },
                          function (result) {
                              if (result.success) {
                                  PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                  removeBDLDealChampOwner(result.value);


                              }
                              else {
                                  PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching project creators failed " + result.errors.join(), '');
                              }

                          },
                          function (result) {
                              PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                              PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching project creators failed " + result.responseText, '');
                          });
                                    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/FecthAlreadyShared", { ObjectId: ObjectIdForShare, lineageForAlreadyShare: selectedLineage },
                                        function (result) {
                                            if (result.success) {
                                                if (result.userForShare.length == 0) {
                                                    $("#btnShowShare").click();
                                                    populateSharePopup(folderForShare, lineageForsharePopup);
                                                    $('#prdverid tr').remove();

                                                }
                                                else if (result.userForShare.length > 0) {

                                                    $("#btnShowShare").click();
                                                    populateSharePopupWithFetchedData(result.userForShare, folderForShare, lineageForsharePopup);

                                                }
                                            }

                                            else
                                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                                        },
                    function (result) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                    });

                                }

                                if (key == "newli") {
                                    $('#btnmodl').click();

                                    var s = document.getElementById('txtFolderName').value
                                }
                                if (key == "uploadfileli") {

                                    $('#btnupload').click();
                                }
                                if (key == "renameli") {


                                    selectedTypeForRename = "Folder";

                                    var encodedStr = PrevName.substr(PrevName.indexOf(' ') + 1);

                                    var parser = new DOMParser;
                                    var dom = parser.parseFromString(
                                        '<!doctype html><body>' + encodedStr,
                                        'text/html');
                                    document.getElementById('txtFolderNameRename').placeholder = dom.body.textContent;

                                    $('#btnrename').click();
                                    document.getElementById('renameModalLabel').innerHTML = "Rename Folder";
                                }

                                if (key == "deleteli") {
                                    var isProceedDelete = "";
                                    var delmsg = "";
                                    var selectedLiForDelete = document.getElementById(pid);
                                    var aForDelete = selectedLiForDelete.getElementsByTagName('a');
                                    var tempFolderName = aForDelete[0].innerHTML;
                                    var folderNameForDelete = tempFolderName.substr(tempFolderName.indexOf(' ') + 1);
                                    if (selectedLineageForDelete == "0") {
                                        delmsg = "project";

                                    }
                                    else {
                                        delmsg = "folder";
                                    }
                                    bootbox.confirm({
                                        size: 'small',
                                        message: 'Are you sure you want to delete' + ' ' + delmsg + '(s) ?',
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

                                                objectIdForDelete = pid;
                                                var objectIdstringForDelete = objectIdForDelete.toString();
                                                lineageForDelete = selectedLineageForDelete;



                                                PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait while we are deleting folder ...", 'editableWorkSpace', '15', '');
                                                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/UserWorkSpace/delete", {
                                                    'objectIdstringForDelete': objectIdstringForDelete,
                                                    'lineageStringForDelete': lineageForDelete
                                                },
                                            function (result) {
                                                if (result.result == 2) {
                                                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("The " + delmsg + "(s) are deleted successfully.");
                                                    callEditableWorkSpaceJSON(selectedFolderId, selectedLineage);
                                                    if (lineageForDelete != 0) {
                                                        var arrForParentLineage = lineageForDelete.split('|');
                                                        var parentObjectId = arrForParentLineage[arrForParentLineage.length - 1];

                                                        var parentLineage = document.getElementById(parentObjectId).getAttribute("lineagestring");
                                                        var parentSequence = document.getElementById(parentObjectId).getAttribute("sequence");


                                                        callLeftPaneFolderViewWithIndexForCreatedFolder(parentObjectId, parentLineage, parentSequence);
                                                    }

                                                    else {
                                                        PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/userworkspace/leftpanefolderroot", {},
                                                                                     function (result) {
                                                                                         if (result) {
                                                                                             $('#tree2').html(result);
                                                                                         }
                                                                                         else {

                                                                                         }



                                                                                     },
                                                                                     function (result) {
                                                                                     });
                                                    }

                                                }
                                                else if (result.result == 1) {
                                                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Folder(s) already deleted");
                                                }
                                                else {
                                                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to delete " + delmsg + "(s).");

                                                }
                                            },
                                            function (result) {
                                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                                            });
                                            }

                                        }
                                    });

                                    objectIdForDelete = "";
                                    lineageForDelete = "";
                                }


                                if (key == "copyli") {
                                    objectIdsForMultiCopy = [];
                                    LineageSForMultiCopy = [];
                                    arrayOfNamesForCopy = [];

                                    objectIdForCopy = pid;
                                    lineageForCopy = selectedLineage;
                                    objectIdsForMultiCopy.push(objectIdForCopy);
                                    LineageSForMultiCopy.push(lineageForCopy);
                                    var folderNameForCopy = PrevName.substr(PrevName.indexOf(' ') + 1);
                                    var encodedStr = folderNameForCopy;

                                    var parser = new DOMParser;
                                    var dom = parser.parseFromString(
                                        '<!doctype html><body>' + encodedStr,
                                        'text/html');
                                    folderNameForCopy = dom.body.textContent;
                                    arrayOfNamesForCopy.push(folderNameForCopy);


                                    isFileCopy = false;
                                    itemsDisabled["pasteli"] = false;
                                    itemsDisabled["pasteRightPane"] = false;

                                }

                                if (key == "pasteli") {
                                    if (isFileCopy == true) {
                                        pastefile();
                                    }
                                    else {
                                        pasteFolder();

                                    }
                                }

                            }
                        },
                        items: menuItems
                    };
                }
            });
        });


        $.fn.extend({
            treed: function (o) {

                var openedClass = 'glyphicon-minus-sign';
                var closedClass = 'glyphicon-plus-sign';

                if (typeof o != 'undefined') {
                    if (typeof o.openedClass != 'undefined') {
                        openedClass = o.openedClass;
                    }
                    if (typeof o.closedClass != 'undefined') {
                        closedClass = o.closedClass;
                    }
                };

                //initialize each of the top levels
                var tree = $(this);
                tree.addClass("tree");
                tree.find('li').has("ul").each(function () {
                    var branch = $(this); //li with children ul
                    branch.prepend("<i class='indicator glyphicon " + closedClass + "'></i>");
                    branch.addClass('branch');
                    branch.on('click', function (e) {
                        if (this == e.target) {
                            var icon = $(this).children('i:first');
                            icon.toggleClass(openedClass + " " + closedClass);
                            $(this).children().children().toggle();
                        }
                    })
                    branch.children().children().toggle();
                });
                //fire event from the dynamically added icon
                tree.find('.branch .indicator').each(function () {
                    $(this).on('click', function () {
                        $(this).closest('li').click();
                    });
                });
                //fire event to open branch if the li contains an anchor instead of text
                tree.find('.branch>a').each(function () {
                    $(this).on('click', function (e) {
                        $(this).closest('li').click();
                        e.preventDefault();
                    });
                });
                //fire event to open branch if the li contains a button instead of text
                tree.find('.branch>button').each(function () {
                    $(this).on('click', function (e) {
                        $(this).closest('li').click();
                        e.preventDefault();
                    });
                });
            }
        });
        function convertToWholeNo(dealValue) {
            return (dealValue*1000000);
        }
        function convertToMillion(dealValue)
        {
            return (dealValue / 1000000);
        }

//*****************************************************UserWorkspaceIndex.aspx*************************************************************************