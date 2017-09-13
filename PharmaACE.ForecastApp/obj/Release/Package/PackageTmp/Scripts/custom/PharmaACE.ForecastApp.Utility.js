(function (PHARMAACE) {
    (function (FORECASTAPP) {
        (function (UTILITY) {
            PHARMAACE.FORECASTAPP.UTILITY.isIE = function () {
                var ua = window.navigator.userAgent;

                var msie = ua.indexOf('MSIE ');
                if (msie > 0) {
                    // IE 10 or older => return version number
                    return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
                }

                var trident = ua.indexOf('Trident/');
                if (trident > 0) {
                    // IE 11 => return version number
                    var rv = ua.indexOf('rv:');
                    return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
                }

                var edge = ua.indexOf('Edge/');
                if (edge > 0) {
                    // Edge (IE 12+) => return version number
                    return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
                }

                // other browser
                return false;
            }
            PHARMAACE.FORECASTAPP.UTILITY.parseJsonDate = function (jsonDate, pattern) {
                var offset = new Date().getTimezoneOffset() * 60000;
                var parts = /\/Date\((-?\d+)([+-]\d{2})?(\d{2})?.*/.exec(jsonDate);
                if (parts[2] == undefined) parts[2] = 0;
                if (parts[3] == undefined) parts[3] = 0;
                d = new Date(+parts[1] + offset + parts[2] * 3600000 + parts[3] * 60000);
                var date = d.getDate();
                date = date < 10 ? "0" + date : date;
                var mon = d.getMonth() + 1;
                mon = mon < 10 ? "0" + mon : mon;
                var year = d.getFullYear();
                var hour = d.getHours();
                var timeLabel = "AM";
                if(hour > 12)
                    timeLabel = "PM";
                var minute = d.getMinutes();
                if (pattern == "mmddyyyy")
                    return (mon + "/" + date + "/" + year + " " + hour + ":" + minute + " " + timeLabel);
                else
                    return (date + "." + mon + "." + year + " " + hour + ":" + minute + " " + timeLabel);
            }
            PHARMAACE.FORECASTAPP.UTILITY.getUrlVars = function (url) {
                var vars = [], hash;
                var hashes = url.slice(url.indexOf('?') + 1).split('&');
                for(var i = 0; i < hashes.length; i++)
                {
                    hash = hashes[i].split('=');
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                }
                return vars;
            }
            PHARMAACE.FORECASTAPP.UTILITY.updateQueryString = function (url, key, value) {
                if (!url) url = window.location.href;
                var re = new RegExp("([?&])" + key + "=.*?(&|#|$)(.*)", "gi"),
                    hash;
                if (re.test(url)) {
                    if (typeof value !== 'undefined' && value !== null)
                        return url.replace(re, '$1' + key + "=" + value + '$2$3');
                    else {
                        hash = url.split('#');
                        url = hash[0].replace(re, '$1$3').replace(/(&|\?)$/, '');
                        if (typeof hash[1] !== 'undefined' && hash[1] !== null)
                            url += '#' + hash[1];
                        return url;
                    }
                }
                else {
                    if (typeof value !== 'undefined' && value !== null) {
                        var separator = url.indexOf('?') !== -1 ? '&' : '?';
                        hash = url.split('#');
                        url = hash[0] + separator + key + '=' + value;
                        if (typeof hash[1] !== 'undefined' && hash[1] !== null)
                            url += '#' + hash[1];
                        return url;
                    }
                    else
                        return url;
                }
            }

            PHARMAACE.FORECASTAPP.UTILITY.getImageIconForFileType = function (fileType) {
                switch (fileType) {
                    case "txt":
                        return '<i class="fa fa-file-text img-thumbnail" title=' + fileType + ' aria-hidden="true"></i>';
                        break;
                    case "doc":
                    case "docx":
                    case "docm":
                    case "dotx":
                    case "dotm":
                    case "odt":
                    case "dot":
                    case "rtf":
                    case "xps":
                    case "docb":
                        return '<i class="fa fa-file-word-o img-thumbnail" title=' + fileType + ' aria-hidden="true"></i>';
                        break;
                    case "xlsx":
                    case "xls":
                    case "xlsm":
                    case "xlsb":
                    case "xml":
                    case "xla":
                    case "xlam":
                    case "xps":
                    case "xlt":
                    case "dif":
                    case "xltx":
                    case "xltm":
                    case "xlm":
                        return '<i class="fa fa-file-excel-o img-thumbnail" title=' + fileType + ' aria-hidden="true"></i>';
                        break;
                    case "pptx":
                    case "ppt":
                    case "pptm":
                    case "potx":
                    case "potm":
                    case "pot":
                    case "ppsx":
                    case "ppsm":
                    case "pps":
                        return '<i class="fa fa-file-powerpoint-o img-thumbnail" title=' + fileType + ' aria-hidden="true"></i>';
                        break;
                    case "pdf":
                        return '<i class="fa fa-file-pdf-o img-thumbnail" title=' + fileType + ' aria-hidden="true"></i>';
                        break;
                    case "jpg":
                    case "png":
                    case "bmp":
                    case "jpeg":
                    case "tif":
                    case "gif":
                        return '<i class="fa fa-file-image-o img-thumbnail" title=' + fileType + ' aria-hidden="true"></i>';
                        break;
                    case "zip":
                    case "zipx":
                        return '<i class="fa fa-file-archive-o img-thumbnail" title=' + fileType + ' aria-hidden="true"></i>';
                        break;
                    case "rar":
                    case "rev":
                    case "r00":
                    case "r01":
                        return '<i class="fa fa-file-archive-o img-thumbnail" title=' + fileType + ' aria-hidden="true"></i>';
                        break;
                    default:
                        return '<i class="fa fa-paperclip img-thumbnail" title=' + fileType + ' aria-hidden="true"></i>';
                }
            }

            PHARMAACE.FORECASTAPP.UTILITY.getImageForFileType = function (fileType) {
                switch (fileType) {
                    case "txt":
                        return "../../Content/img/txtk.png";
                        break;
                    case "doc":
                    case "docx":
                    case "docm":
                    case "dotx":
                    case "dotm":
                    case "odt":
                    case "dot":
                    case "rtf":
                    case "xps":
                    case "docb":
                        return "../../Content/img/word-iconu.png";
                        break;
                    case "xlsx":
                    case "xls":
                    case "xlsm":
                    case "xlsb":
                    case "xml":
                    case "xla":
                    case "xlam":
                    case "xps":
                    case "xlt":
                    case "dif":
                    case "xltx":
                    case "xltm":
                    case "xlm":
                        return "../../Content/img/excelu.png";
                        break;
                    case "pptx":
                    case "ppt":
                    case "pptm":
                    case "potx":
                    case "potm":
                    case "pot":
                    case "ppsx":
                    case "ppsm":
                    case "pps":
                        return "../../Content/img/pptu.png";
                        break;
                    case "pdf":
                        return "../../Content/img/adobu.png";
                        break;
                    case "jpg":
                    case "png":
                    case "bmp":
                    case "jpeg":
                    case "tif":
                    case "gif":
                        return "../../Content/img/imageu.png";
                        break;
                    case "zip":
                    case "zipx":
                        return "../../Content/img/winzipu.png";
                        break;
                    case "rar":
                    case "rev":
                    case "r00":
                    case "r01":
                        return "../../Content/img/WinRARu.png";
                        break;
                    default:
                        return "../../Content/img/attachment.png";
                }
            }
            PHARMAACE.FORECASTAPP.UTILITY.getFileNameWithoutExtension = function (name) {
                if (name) {
                    var arr = name.split('.');
                    if (arr.length > 0) {
                        arr.pop();
                        return arr.join('.');
                    }
                }
                return name;
            }
            PHARMAACE.FORECASTAPP.UTILITY.getFileExtension = function (name) {
                if (name) {
                    var arr = name.split('.');
                    if (arr.length > 0) {
                        return arr.pop();                        
                    }
                }
                return name;
            }
            PHARMAACE.FORECASTAPP.UTILITY.getCookie = function (name) {
                var value = "; " + document.cookie;
                var parts = value.split("; " + name + "=");
                if (parts.length == 2) return parts.pop().split(";").shift();
            }
            PHARMAACE.FORECASTAPP.UTILITY.loadScript = function (filename, callback) {
                var fileref = document.createElement('script');
                fileref.setAttribute("type", "text/javascript");
                fileref.onload = callback;
                fileref.setAttribute("id", "videojs");
                fileref.setAttribute("src", filename);
                if (typeof fileref != "undefined") {
                    document.getElementsByTagName("head")[0].appendChild(fileref)
                }
            }

            PHARMAACE.FORECASTAPP.UTILITY.removejscssfile = function (filename, filetype)
            {
                var targetelement=(filetype=="js")? "script" : (filetype=="css")? "link" : "none" //determine element type to create nodelist from
                var targetattr=(filetype=="js")? "src" : (filetype=="css")? "href" : "none" //determine corresponding attribute to test for
                var allsuspects=document.getElementsByTagName(targetelement)
                for (var i=allsuspects.length; i>=0; i--){ //search backwards within nodelist for matching elements to remove
                    if (allsuspects[i] && allsuspects[i].getAttribute(targetattr)!=null && allsuspects[i].getAttribute(targetattr).indexOf(filename)!=-1)
                        allsuspects[i].parentNode.removeChild(allsuspects[i]) //remove element by calling parentNode.removeChild()
                }
            }


                
            PHARMAACE.FORECASTAPP.UTILITY.stopPropagation = function (evt) {
                if (evt.stopPropagation !== undefined) {
                    evt.stopPropagation();
                } else {
                    evt.cancelBubble = true;
                }
            }

            PHARMAACE.FORECASTAPP.UTILITY.searchFromList = function (idForSearch, inputboxId) {
                // Declare variables
                var input, filter, ul, li, a, i;
                input = document.getElementById(idForSearch);
                $('li em').contents().unwrap();
                filter = input.value.toUpperCase();
                //$('#tree2 li').removeClass('parentSearch');
                ul = document.getElementById(inputboxId);
                li = ul.getElementsByTagName('li');
                for (i = 0; i < li.length; i++) {
                    a = li[i].getElementsByTagName("a")[0];
                    // a = li[i];
                    if (filter != '') {
                        if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {

                            li[i].style.display = "list-item";

                            var matchStart = a.text.toLowerCase().indexOf("" + filter.toLowerCase() + "");
                            var matchEnd = matchStart + filter.length - 1;
                            var beforeMatch = a.text.slice(0, matchStart);
                            var matchText = a.text.slice(matchStart, matchEnd + 1);
                            var afterMatch = a.text.slice(matchEnd + 1);
                            a.innerHTML = beforeMatch + "<em>" + matchText + "</em>" + afterMatch;

                            if (li[i].classList.contains('firstLi'))
                                li[i].classList.add("parentSearch");
                            else if (li[i].parentNode.parentNode.classList.contains('firstLi'))
                                li[i].parentNode.parentNode.classList.add("parentSearch");

                        } else {

                            if (li[i].parentNode.parentNode.classList.contains('parentSearch'))
                                li[i].parentNode.parentNode.style.display = "list-item";
                            else
                                li[i].style.display = "none";


                        }


                    }
                    else {
                        li[i].style.display = "list-item";
                    }
                }

            }
            PHARMAACE.FORECASTAPP.UTILITY.advsearch = function () {
                $('.headerText').toggleClass('shSearch');
               // $('#headerSelect').toggleClass('shSearch');
                if ($('#tblbody').hasClass("open")) {
                    //$('#tbltfoot').css("display", "none");
                    $('#advsearchrow').removeAttr('style');
                    $('#tblbody').css("margin-top", "0px");
                    $('#tblbody').removeClass("open");
                    $("#advimgsrc").attr("src", "../../Content/img/zoom-in.png");
                }
                else {
                    //$('#tbltfoot').css("display", "block");
                    $('#advsearchrow').css("display", "none");

                    $('#tblbody').css("margin-top", "84px");
                    $('#tblbody').addClass("open");
                    $("#advimgsrc").attr("src", "../../Content/img/zoom-out.png")
                }
            }
            PHARMAACE.FORECASTAPP.UTILITY.loadScriptsFromPartialView = function (source_dom) {
                var scriptElements = source_dom.getElementsByTagName('SCRIPT');
                for (i = 0; i < scriptElements.length; i++) {
                    if ($(document.head).find('script[id="{0}"]'.replace("{0}", scriptElements[i].id)).length == 0) {
                        var scriptElement = document.createElement('SCRIPT');
                        scriptElement.type = 'text/javascript';
                        if (!scriptElements[i].src) {
                            scriptElement.innerHTML = scriptElements[i].innerHTML;
                        } else {
                            scriptElement.src = scriptElements[i].src;
                        }
                        document.head.appendChild(scriptElement);
                    }
                }
            }
            PHARMAACE.FORECASTAPP.UTILITY.filteration = function (tableDrawCallback) {
                //gt means exclude column index
                $('#example thead th:gt(0)').each(function () {
                    var title = $(this).text();

                    //$(this).html('<input type="text" placeholder="Search ' + title + '" />');
                    // alert("rr" + trim(title) + "kk");
                    if (title != "SNo.")
                        $(this).html(title + "<br><div class='shSearch headerText' id=''>" + '<input type="text"  placeholder="Search" onclick="PHARMAACE.FORECASTAPP.UTILITY.stopPropagation(event);" onmousedown="PHARMAACE.FORECASTAPP.UTILITY.stopPropagation(event)" />');

                });
                var table = $('#example').DataTable({
                    dom: 'lBfrtip',
                    buttons: [
                        'copy', 'csv', 'excel', 'pdf', 'print'
                    ]
                });
                //$(".dataTables_length:contains('entries')");
                $('.dataTables_length:contains("entries")').each(function () {
                    $(this).html($(this).html().split("entries").join(""));
                });
                //$("#example_wrapper .row:first #example_filter").after("<div class='pull-left '><div class='' id='advSearch'><a  onclick='PHARMAACE.FORECASTAPP.UTILITY.advsearch();'><i class='fa fa-filter fa-3' aria-hidden='true'></i></div></div>");
                $("#example_wrapper #example_filter").after("<div class='pull-left '><div class='' id='advSearch'><a  onclick='PHARMAACE.FORECASTAPP.UTILITY.advsearch();'><i class='fa fa-filter fa-3' aria-hidden='true'></i></div></div>");

                table.columns(':gt(0)').every(function () {
                    var that = this;
                    var regval = '';
                    var textval = '';
                    var filtered = '';
                    var filteredand = '';
                    var filterand = '';
                    var filtered1 = '';
                    var filteredand1 = '';
                    var filterand1 = '';
                    var filter1 = '';

                    var select = $('<select class="selectpicker shSearch form-control search-filter select-dropdown selectBox headerText" id="" onclick="PHARMAACE.FORECASTAPP.UTILITY.stopPropagation(event);" onmousedown="PHARMAACE.FORECASTAPP.UTILITY.stopPropagation(event)" onclick="PHARMAACE.FORECASTAPP.UTILITY.stopPropagation(event);" onchange="PHARMAACE.FORECASTAPP.UTILITY.stopPropagation(event)" ><option value="-1">Nothing Selected</option>')
                               .appendTo($(that.header()))
                               .on('change', function () {
                                   var val = $.fn.dataTable.util.escapeRegex(
                                       $(this).val()
                                   );
                                   that
                                   if ((val == 7) || (val == -1)) {
                                       val = "";
                                   }
                                   regval = val;
                                   var keywords1 = textval.split('|'), filter1 = '';
                                   var keywordsand1 = textval.split('+'), filterand1 = '';
                                   for (var i = 0; i < keywords1.length; i++) {
                                       filter1 = filter1 + '|' + keywords1[i];
                                   }
                                   for (var i = 0; i < keywordsand1.length; i++) {
                                       filterand1 = filterand1 + '(?=.*' + keywordsand1[i] + ')';
                                   }
                                   filtered1 = filter1;
                                   filteredand1 = filterand1;
                                   if (regval) {
                                       if (regval == 4)
                                           that.search("^" + textval, true, false, true)
                                       else if (regval == 2)
                                           that.search("^\\s+$", true, false, true)
                                       else if (regval == 5)
                                           that.search(textval + "$", true, false, true)
                                       else if (regval == 9)
                                           table.column(that.index()).search(filteredand1, true, false)
                                       else
                                           that.search(textval, true, false, true)
                                   }
                                   else {
                                       that.search(textval, true, false);
                                   }
                                   that.draw();
                               });

                    //alert(title + "ff");
                    //if (that.title != "SNo.") {
                    //select.append('<option value="4">Starts With</option><option value="5">Ends With</option><option value="7" selected>Contains</option><option value="9" title="|(OR)&+(AND)">Logical</option>');                    // }
                    //  $('.shSerach select').append('<option value="4">Starts With</option><option value="5">Ends With</option><option value="7" selected>Contains</option><option value="9" title="|(OR)&+(AND)">Logical</option></select>');
                    select.append('<option value="4">Starts With</option><option value="5">Ends With</option><option value="7" selected>Contains</option><option value="9" title="|(OR)&+(AND)">Logical</option></select>');

                    $('input', this.header()).on('keyup change', function () {
                        textval = this.value
                        var keywords = textval.split('|'), filter = '';
                        var keywordsand = textval.split('+'), filterand = '';
                        for (var i = 0; i < keywords.length; i++) {
                            filter = filter + '|' + keywords[i];
                        }
                        for (var i = 0; i < keywordsand.length; i++) {
                            filterand = filterand + '(?=.*' + keywordsand[i] + ')';
                        }
                        filtered = filter;
                        filteredand = filterand;
                        if (that.search() !== this.value) {
                            if (regval)
                                if (regval == 4)
                                    table.column(that.index()).search("^" + this.value, true, false)
                                else if (regval == 5)
                                    table.column(that.index()).search(this.value + '$', true, false)
                                else if (regval == 9)
                                    table.column(that.index()).search(filteredand, true, false)
                                else
                                    table.column(that.index()).search(this.value, true, false)
                            else
                                table.column(that.index()).search(this.value, true, false)
                            that.draw();
                        }
                    });
                });
            }
            PHARMAACE.FORECASTAPP.UTILITY.popalert = function (popmessage, poptitle) {
			var yoursystemday = new Date(new Date().getTime() - (120000 * 60 + new Date().getTimezoneOffset() * 60000));
			//yoursystemday = new Date();
			var random = Math.round(Math.round(yoursystemday));
			
            var popSection='<div id="popalert'+random+'" class="alert-info popalert" style="margin-bottom:0px !important;padding-top:0px;"><span class="close" data-dismiss="alert">&times;</span><p style="text-align: center"></p></div>';
              $('#customCss').css('display', 'block');
                $('.modal-backdrop').css("display", "none");
                $('#headerbar').append(popSection);
			    $("#popalert"+random+" p").html(popmessage);
				 $("#popalert"+random).alert();
			   setTimeout(function () {
                    //$("#popalert"+random).fadeOut();
                     $("#popalert"+random).remove();
                }, 10000);
				$("#popalert"+random+" .close").click(function () {
                    $(this).parent().remove();
                });
			   var notificationstack = [];
                var storedAlerts = sessionStorage.getItem("notificationkey");
                if (storedAlerts)
                    notificationstack = JSON.parse(storedAlerts);
                if ($.inArray(popmessage, notificationstack) == -1) {
                    //if (notificationstack.length == 10)
                    //    notificationstack.shift();
                    notificationstack.push(popmessage + '|' + Date());
                    sessionStorage.setItem("notificationkey", JSON.stringify(notificationstack));
                }

                //var ulref = document.getElementById('flyerInnerbox');
                //if (notificationstack) {
                //    for (var i = notificationstack.length - 1; i >= 0 ; i--) {
                //        res = notificationstack[i].split('|');
                //        str += '<li ><a><span class="notification_item_title">' + res[0] + "</br><span class='notification_item_date'>" + res[1] + '</span></a></li>';
                //    }
                //}
                //ulref.prepend(str);
                PHARMAACE.FORECASTAPP.UTILITY.populateNotificationList(); 
            }
            PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue = function (key) {
                return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
            }
            PHARMAACE.FORECASTAPP.UTILITY.getUrlVars = function(url) {
                var vars = [], hash;
                var hashes = url.slice(url.indexOf('?') + 1).split('&');
                for (var i = 0; i < hashes.length; i++) {
                    hash = hashes[i].split('=');
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                }
                return vars;
            }

            PHARMAACE.FORECASTAPP.UTILITY.createSignInForm = function(formLable)
            {
                var el = document.getElementById("loginform");
                if (el)
                    return;

                var str = "";
                str += '<div id="loginform" class="modal" tabindex="-1">';
                str +=  '<div class="modal-dialog">';
                str += '<div class="modal-content">';
                //str +=  '<div class="modal-header">';
                str += '<button type="button" class="close" data-dismiss="modal" aria-hidden="true" >&times;</button>';
                //str += '</div>';
                str += '<div class="modal-body">';
                if (formLable)
                    str += '<p class="msglabel">' + formLable + '</p>';
               // str += '<button type="button" class="close" data-dismiss="modal" aria-hidden="true" >X</button>';
                str +=  '<ul class="nav nav-tabs">';
                str +=  '<li class="active"><a href="#signin" data-toggle="tab">Sign In</a></li>';
                str +=  '</ul>';
                str +=  '<div class="tab-content">';
                str +=  '<div id="signin" class="tab-pane fade in active">';
                str +=  '<form role="form" id="signinid" method="post">';
                str +=  '<div class="modal-body">';
                str +=  '<div class="form-group">';
                str +=  '<label for="recipient-name" class="control-label">Email:</label>';
                str +=  '<input type="email" class="form-control" id="recipient-name" title="Please enter a valid email address" pattern="(.+)@(.+)\.(.+)" required>';
                str +=  '</div>';
                str +=  '<div class="form-group">';
                str +=  '<label for="message-text" class="control-label">Password:</label>';
                str +=   '<input type="password" class="form-control" id="message-text" required />';
                str +=  '</div>';
                str +=  '</div>';
                str +=   '<div class="modal-footer">';
                str +=  '<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>';
                str +=   '<input type="submit" class="btn btn-primary" style="float: right;" value="Sign In" />';
                str +=  '</div>';
                str +=  '</form>';
                str +=   '</div>';
                str +=  '</div>';
                str +=  '</div>';
                str +=  '</div>';
                str +=  '</div>';
                str += '</div>';
                $("body").append(str);
            }
            //PHARMAACE.FORECASTAPP.UTILITY.populateNotificationList = function () {                
            //    var ulref = document.getElementById('flyerInnerbox');
            //    if (!ulref)
            //        return;
            //    var notificationvalues = JSON.parse(sessionStorage.getItem("notificationkey"));
            //        var str = '';
            //        var res = '';
            //        var notinum = document.getElementById('notification-num');
            //        if (notificationvalues) {
            //            for (var i = notificationvalues.length - 1; i >= 0 ; i--) {
            //            res=notificationvalues[i].split('|');
            //            str += '<li ><a><span class="notification_item_title">' + res[0] + "</br><span class='notification_item_date'>" + res[1] + '</span></a></li>';
            //            res = '';
            //        }
            //        notinum.textContent = notificationvalues.length;
            //        if (notificationvalues.length > 3) {
            //            PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery.nicescroll.min.js", function () {
            //                $("#flyerInnerbox").niceScroll();
            //            });
            //        }
            //    }
            //    if (str == '') {
            //        str = "<li ><a><span class='notification_item_title'>Welcome {0} {1}!".replace("{0}", $('#fnid').text()).replace("{1}", $('#lnid').text()) + "</a></li>";
            //        notinum.textContent = 1;
            //    }
            //    ulref.innerHTML = str;
            //}


            PHARMAACE.FORECASTAPP.UTILITY.populateNotificationList = function (NotificationArray) {
                var ulref = document.getElementById('flyerInnerbox');
                var tempNotifications = "";
                if (!ulref)
                    return;
                var previousNotifications = ulref.innerHTML;
                var str = '';
                var notinum = document.getElementById('notification-num');
                notinum.textContent = "";
                if (NotificationArray) {
                    if (NotificationArray.Notifications) {
                        if (NotificationArray.Notifications.length > 0) {
                            for (var i = 0; i <= NotificationArray.Notifications.length - 1 ; i++) {
                                if (NotificationArray.Notifications[i].Description != "") {
                                    var date1=PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(parseInt(NotificationArray.Notifications[i].CreatedDate.substr(6))));
                                    var formattedDate=PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(date1));
                                    //str += '<li ><span style=" font-weight: bold;"><a><span class="notification_item_title">' + NotificationArray.Notifications[i].Description + "</br><span class='notification_item_date'>" + PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(parseInt(NotificationArray.Notifications[i].CreatedDate.substr(6)))) + "</span></span></a><span><input type='hidden' notificationId=" + NotificationArray.Notifications[i].NotificationId + " isReadAttr = " + NotificationArray.Notifications[i].IsRead + " value=" + NotificationArray.Notifications[i].NotificationId + "></span></span></li>";
                                    str += '<li ><span style=" font-weight: bold;"><a><span class="notification_item_title">' + NotificationArray.Notifications[i].Description + "</br><span class='notification_item_date'>" + formattedDate + "</span></span></a><span><input type='hidden' notificationId=" + NotificationArray.Notifications[i].NotificationId + " isReadAttr = " + NotificationArray.Notifications[i].IsRead + " value=" + NotificationArray.Notifications[i].NotificationId + "></span></span></li>";
                                }
                            }
                            notinum.textContent = NotificationArray.Notificationcount;
                            if (NotificationArray.Notificationcount > 3) {
                                PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery.nicescroll.min.js", function () {
                                    $("#flyerInnerbox").niceScroll();
                                });
                            }
                        }
                    }
                }

                tempNotifications = PHARMAACE.FORECASTAPP.UTILITY.getTempNotifications();
                if (str == '' && tempNotifications == '') {
                    str = "<li ><a><span class='notification_item_title'>Welcome {0} {1}!".replace("{0}", $('#fnid').text()).replace("{1}", $('#lnid').text()) + "</a><span><input type='hidden' value='-1'></span></li>";
                    notinum.textContent = 1;
                }
                if (notinum.textContent == "") {
                    notinum.textContent = 0;
                }
                notinum.textContent = parseInt(notinum.textContent) + parseInt($(tempNotifications).length);
                if (notinum.textContent == 0)
                    notinum.textContent = "";

                if (str)
                    ulref.innerHTML = tempNotifications + str;
                else
                    // ulref.innerHTML = tempNotifications + ulref.innerHTML;
                    ulref.innerHTML = tempNotifications;

            }

            PHARMAACE.FORECASTAPP.UTILITY.getTempNotifications = function () {
                var notificationvalues = JSON.parse(sessionStorage.getItem("notificationkey"));
                        var str = '';
                        if (notificationvalues) {
                            for (var i = notificationvalues.length - 1; i >= 0 ; i--) {
                                res = notificationvalues[i].split('|');
                                str += '<li ><a><span class="notification_item_title">' + res[0] + "</br><span class='notification_item_date'>" + PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(res[1])) + '</span></a></li>';
                            }
                        }
                        return str;
            }


            PHARMAACE.FORECASTAPP.UTILITY.htmlEncode = function (value) {
                return $('<div/>').text(value).html().replace(/"/g, "'");
            }
            PHARMAACE.FORECASTAPP.UTILITY.htmlDecode = function (value) {
                return $('<div/>').html(value).text();
            }
            PHARMAACE.FORECASTAPP.UTILITY.dateDifference = function (date) {
                var returnValue = "";
                var date_now = new Date();
                var privious_date = new Date(date);
                seconds = Math.floor((date_now - privious_date) / 1000);
                minutes = Math.floor(seconds / 60);
                hours = Math.floor(minutes / 60);
                days = Math.floor(hours / 24);
                hours = hours - (days * 24);
                minutes = minutes - (days * 24 * 60) - (hours * 60);
                seconds = seconds - (days * 24 * 60 * 60) - (hours * 60 * 60) - (minutes * 60);
                if (days > 0)
                    returnValue += days + " days ";
                if (hours > 0)
                    returnValue += hours + " hours ";
                if (minutes >= 0)
                    returnValue += minutes + " minutes ";
                return returnValue;
            }
            PHARMAACE.FORECASTAPP.UTILITY.dayOfWeekAsString = function (dayIndex) {
                var days = ["Sun","Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
                return days[dayIndex];
            }
            PHARMAACE.FORECASTAPP.UTILITY.monthAsString = function (monthIndex) {
                var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                return months[monthIndex];
            }
            PHARMAACE.FORECASTAPP.UTILITY.formatDate = function (date1) {
                var hours = date1.getHours() == 0 ? "12" : date1.getHours() > 12 ? date1.getHours() - 12 : date1.getHours();
                var minutes = (date1.getMinutes() < 10 ? "0" : "") + date1.getMinutes();
                var ampm = date1.getHours() < 12 ? "AM" : "PM";
                var formattedTime =PHARMAACE.FORECASTAPP.UTILITY.monthAsString(date1.getMonth()) + " " + date1.getDate() + " " + date1.getFullYear() + " " + hours + ":" + minutes + " " + ampm;
                return formattedTime;
            }

            PHARMAACE.FORECASTAPP.UTILITY.formatDateForDataTable = function (date1) {            
                var mon = (date1.getMonth() + 1);
                var day = date1.getDate();
                var hours = date1.getHours();
                var min = date1.getMinutes();
                var formattedTime = (mon < 10 ? "0" + mon : mon) + "/" + (day < 10 ? "0" + day : day) + "/" + date1.getFullYear() + " " + (hours < 10 ? "0" + hours : hours) + ":" + (min < 10 ? "0" + min : min);
                return formattedTime;
            }
           /* PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate = function (date) {
                var newDate = new Date(date.getTime() + date.getTimezoneOffset() * 60 * 1000);

                var offset = date.getTimezoneOffset() / 60;
                var hours = date.getHours();

                newDate.setHours(hours - offset);

                return newDate;
            }*/
            PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate = function (UTCDateString) {
                var convertUTCTime = UTCDateString.toString();
                var date = convertUTCTime.replace("GMT+0530 (India Standard Time)", "UTC");
                var convertdLocalTime = new Date(date).toString();
                return convertdLocalTime;
              
            }
           
            //PHARMAACE.FORECASTAPP.UTILITY.showOverlay = function (jqueryElement, message) {
            //    if (jqueryElement.overlay)
            //        jqueryElement.overlay(message);
            //}

            PHARMAACE.FORECASTAPP.UTILITY.checkFileSize = function (files) {
                var totalFileSize = 0;
                var fileSizeNotAllowed = false;
                for (var i = 0; i < files.length; i++) {
                    totalFileSize += files[i].size;
                    if (totalFileSize > 104857600) //if exceeded above 100 mb=104857600bytes
                    {
                        fileSizeNotAllowed = true;
                        return fileSizeNotAllowed;
                    }
                }
                return fileSizeNotAllowed;
            }

            PHARMAACE.FORECASTAPP.UTILITY.showOverlay = function (loadmessage, divid, loaderSize, fromTop) {
                if ($("body").overlay) {
                    $('#bodyOverlay').css("display", "block");
                    $("body").overlay(loadmessage, divid, loaderSize, fromTop);
                }
            }
            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay = function (divid) {
                if ($("body").overlayout) {
                    $('#bodyOverlay').css("display", "none");
                    $("body").overlayout(divid);
                }
                //if ($.overlayout)
                //    $.overlayout(divid);
            }
            PHARMAACE.FORECASTAPP.UTILITY.getColumnLetterByIndex = function (sheet, columnIndex) {
                return sheet.Cells(1, columnIndex).Address.split('$')[1];
            }
            PHARMAACE.FORECASTAPP.UTILITY.getColumnIndexByLetter = function (sheet, columnLetter) {
                return sheet.Range(columnLetter + "1").Column;
            }
            PHARMAACE.FORECASTAPP.UTILITY.toJSArray = function (vbArray) {
                return new VBArray(vbArray).toArray();
            }
            PHARMAACE.FORECASTAPP.UTILITY.setRectangularRangeValue = function (app, sheet, leftTop, rightBottom, arr) {
                sheet.Range(leftTop + ":" + rightBottom).Value = objExcel.WorksheetFunction.Transpose(app.WorksheetFunction.Transpose(arr.toVBArray()));
            }
        }(window.PHARMAACE.FORECASTAPP.UTILITY = window.PHARMAACE.FORECASTAPP.UTILITY || {}));
    }(window.PHARMAACE.FORECASTAPP = window.PHARMAACE.FORECASTAPP || {}));
}(window.PHARMAACE = window.PHARMAACE || {}));
Array.prototype.inArray = function (props) {
    var retVal = -1;
    var self = this;
    var matched = false;
    for (var index = 0; index < self.length; index++) {
        var item = self[index];
        for (var pIndex = 0; pIndex < props.length; pIndex++) {
            if (!item.hasOwnProperty(props[pIndex].property))
                break;
        }
        if (pIndex == props.length) {
            for (var pIndex = 0; pIndex < props.length; pIndex++) {
                if (item[props[pIndex].property].toString().toLowerCase() === props[pIndex].searchFor.toString().toLowerCase())
                    matched = true;
                else
                    matched = false;
                if (!matched)
                    break;
            }
            if (matched) {
                retVal = index;
                break;
            }
        }
        else
            break; //if property is not there no point in going any farther
    };
    return retVal;
};
// js array to safearray
Array.prototype.toVBArray = function () {
    var dict = new ActiveXObject("Scripting.Dictionary");
    for (var i = 0, len = this.length; i < len; i++)
        dict.add(i, this[i]);
    return dict.Items();
};
Array.prototype.getUnique = function () {
    return [new Set([this])];
};
if (!String.prototype.startsWith) {
    String.prototype.startsWith = function (prefix) {
        if (this)
            return this.indexOf(prefix, 0) === 0;
        return this === prefix;
    }
};
String.prototype.endsWith = function (suffix) {
    if (this)
        return this.indexOf(suffix, this.length - suffix.length) !== -1;
    return this === suffix;
};
String.prototype.replaceLastOccurrence = function (pat, repWith) {
    if(this)
        return this.replace(new RegExp(pat + '$'), repWith);
    return this;
};
String.prototype.replaceAll = function (search, replacement) {
    var target = this;
    return target.split(search).join(replacement);
};