<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/CFSite.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.NewsFeed>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   Market Monitor
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
   <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Constants.js"></script>
   <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.FeedEngine.js"></script>
   <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
   <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.NewsFeed.js"></script>
   <script type="text/javascript" src="../../Scripts/custom/bootbox.js"></script>
   <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>   
   <script src="../../Scripts/lib/bootstrap/formValidation.min.js"></script>
   <script src="../../Scripts/lib/bootstrap/bootstrap-tagsinput.min.js"></script>
   <script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>
   <script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
    <%: Styles.Render(" ~/Content/LiveFeedCss")  %>
   <script type="text/javascript">
      $(document).ready(function () {
          $("#textareaid").niceScroll({
              cursorfixedheight: 70
          });
      });
   </script>

   <div id="RegulatoryTagModal" class="modal" tabindex="-1">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
               <h4 class="modal-title">Latest Stories</h4>
            </div>
            <div class="modal-body">
               <form role="form" method="post" id="RegulatoryTagformid">
                  <div class="modal-body">
                     User-Defined Tags:
                     <%--                <input type="text" class="form-control" id="tagInput" />--%>
                     <div id="regulatoryTextarea" class="lfDiv1">
                        <input id="regulatoryInput" class="form-control" type="text" rel="skus">
                     </div>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                     <%--<button type="button" class="btn btn-primary" id="regulatoryButton">Save</button>--%>
                     <input type="submit" class="btn btn-primary lfDiv2" value="Save" />
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
   <div id="popalert" class="modal" style="overflow: visible;" tabindex="-1">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClosePopup();">×</button>
               <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
               <p style="text-align: center"></p>
            </div>
         </div>
      </div>
   </div>
   <div class="container-fluid lfDiv3">
      <div class="c lfDiv4">
         <div class="">
            <div id="livefeedid" class="lfDiv5">
               <div class="col-md-2 lfDiv6">
                  <div id="leftmenu">
                     <nav class="sidebar">
                        <ul class="nav-left" id="CategoryList">
                           <li id="top-stories" class="item "><a href="#" class="active">Top Stories</a></li>
                           <li id="regulatory" class="item lfDiv7"><span class="lfDiv8"><a href="#">Latest Stories<span class="grey-arrow"></span></a></span>
                              <span id="regiconid" class="lfDiv9"><i class="fa fa-edit lfDiv10" ></i></span>
                           </li>
                        </ul>
                     </nav>
                  </div>
               </div>
               <div class="col-md-8" id="containerDetail">
                  <div id="feedContainerStatic" style="min-height:540px;">
                     <script type="text/javascript">
                        function displayFeedBox()
                        {
                            $('#newsfeedbox').toggleClass('feedvisible');
                        }
                        $('#regiconid').click(function (event) {
                            event.preventDefault();
                            event.stopPropagation();
                            $('#RegulatoryTagModal').modal('show');
                            if ($('.nav-left li.item a').hasClass('active'))
                            {
                                $('.nav-left li.item a').removeClass('active')
                                $('#regulatory').addClass("active");
                            }
                            GenerateHtmlForRegulatoryFeed();
                        });
                        function GenerateHtmlForRegulatoryFeed()
                        {
                            if ($("#regulatoryTextarea .bootstrap-tagsinput").children().length > 1)
                            {
                               $("#regulatoryTextarea .bootstrap-tagsinput .tag").remove();
                            }
                            var inputTagValue = '<input type="text" size="1" placeholder="" class="notclick lfDiv11">';
                            var getallRegulatoryKeywords;
                            var getallRegulatoryKeywordsArr = [];
                            var spanhtml = '';          
                            //getallRegulatoryKeywords = currentRegulatoryKeyword;
                            getallRegulatoryKeywordsArr = currentRegulatoryKeyword;
                            if (getallRegulatoryKeywordsArr) {
                                for (var i = 0; i < getallRegulatoryKeywordsArr.length ; i++) {
                                    spanhtml += "<span class='tag label label-info' id='taginput" + i + "'>" + getallRegulatoryKeywordsArr[i] + "<span data-role='remove'   onclick='removeSpan(" + '"' + "taginput" + i + '"' + ");'></span></span>"
                                     }
                                     $("#regulatoryTextarea .bootstrap-tagsinput").prepend(spanhtml);
                                 }
                                 $("#regulatoryTextarea .bootstrap-tagsinput").append(inputTagValue);
                            
                        }
                        function getItemOrder() {
                            var categoryItems = $("#CategoryList>li");
                            for (var i = 0; i < categoryItems.length; i++) {
                                if ($("#CategoryList>li:eq(" + i + ")>a").hasClass('active'))
                                    return i;
                            }
                        }
                        function getDivOrder() {
                            return 1;
                        }
                        function getLatestStoriesQueryKeywordPairs() {
                            var divOrder = getDivOrder();
                            var pairs;
                            if (divOrder == 0) {
                                var queryKeyword = "<%= Session["SubscriberName"] %>";
                                pairs = [{ source: PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.GOOGLE, queryKeyword: queryKeyword }];
                            }
                            else if (divOrder == 1) {
                                pairs = PHARMAACE.FORECASTAPP.NEWSFEED.makeQueryKeyword(null, true, PHARMAACE.FORECASTAPP.NEWSFEED.getProductKeywords(), [PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.GOOGLE]);
                            }
                            return pairs;
                        }
                        var currentRegulatoryKeyword = [];
                        var feedParams = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultParams();
                        var link = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl(null);
                        feedParams.url = PHARMAACE.FORECASTAPP.NEWSFEED.setQueryKeyword(link, getLatestStoriesQueryKeywordPairs(), false);
                        var productFeedParams = PHARMAACE.FORECASTAPP.NEWSFEED.setCustomParamsFeedsStatic(feedParams);
                        feedwind_show_widget(productFeedParams, 'feedContainerStatic', getDivOrder(), 0, "Top Stories");
                        $('#bodyOverlay').css("display", "block");
                        PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait..", 'feedContainerStatic', '15', '');
                     </script>
                  </div>
               </div>
               <div class="col-md-2 pull-right lfDiv12">
                  <div class="input-group-btn">
                     <div class="btn-group" role="group">
                        <div class="dropdown dropdown-lg lfDiv13" id="searchtool">
                           <button type="button" id="displayFeedBox" class="btn btn-default dropdown-toggle lfDiv14" data-toggle="dropdown" onclick="displayFeedBox();">Setting<span class="caret"></span></button>
                           <div class="dropdown-menu-right notclick" role="menu" id="newsfeedbox">
                              <form class="form-horizontal notclick" role="form" id="search-form-box">
                                 <h4>Find news stories that have</h4>
                                 <div class="form-group notclick">
                                    <label for="contain" class="lfDiv15">Include Keywords</label>
                                    <div id="textareaid" class="lfDiv16">
                                       <input id="txtallwords"  class="form-control notclick"  data-role="tagsinput" type="text"  >
                                    </div>
                                 </div>
                                 <div class="form-group notclick">
                                    <label for="contain">Match Phrase</label>
                                    <input id="txtexactword" class="form-control notclick" type="text">
                                 </div>
                                 <div class="form-group notclick">
                                    <label for="contain">Exclude Keywords</label>
                                    <input id="txtnoneword" class="form-control notclick" type="text">
                                 </div>
                                 <div class="row notclick">
                                    <div class="col-xs-6 col-md-4 notclick">
                                       <div class="form-group notclick">
                                          <label for="contain">Country</label>
                                          <select id="txtcountry" class="form-control notclick">
                                             <option value="0" class="notclick">--Select--</option>
                                             <option value="au" class="notclick">Australia</option>
                                             <option value="cn" class="notclick">China</option>
                                             <option value="fr" class="notclick">France</option>
                                             <option value="de" class="notclick">Germany</option>
                                             <option value="in" class="notclick">India</option>
                                             <option value="nz" class="notclick">New Zealand</option>
                                             <option value="us" class="notclick">U.S.</option>
                                             <option value="uk" class="notclick">U.K.</option>
                                          </select>
                                       </div>
                                    </div>
                                    <div class="col-xs-6 col-md-4 notclick">
                                       <div class="form-group notclick">
                                          <label for="contain">Number Of Feeds</label>
                                          <input type="number" id="txtnooffeeds" class="form-control notclick" placeholder="Number Of Feeds" name="quantity" min="0" max="1000">
                                       </div>
                                    </div>
                                 </div>
                                 <div class="row notclick">
                                    <div class="col-xs-12 col-md12 notclick">
                                       <input type="submit" class="btn btn-primary notclick lfDiv17" value="OK" />
                                       <button type="button" class="btn btn-default lfDiv18" data-dismiss="modal" onclick="displayFeedBox();" >Cancel</button>
                                    </div>
                                 </div>
                              </form>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div id="feedContainer" class="" style="">
                     <script type="text/javascript">                                
                        var feedParams = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultParams();
                        var link = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl(null);
                        <% if (Model.NewsFeedLink != null && Model.NewsFeedLink != "")
                           {%>
                        link = "<%=Model.NewsFeedLink.Replace("\"", "\\\"")%>";
                        <%}%>  
                        feedParams.feedCount = "<%=Model.FeedCount%>";
                        if (!feedParams.feedCount || isNaN(feedParams.feedCount) || feedParams.feedCount < 1) {
                            feedParams.feedCount = PHARMAACE.FORECASTAPP.CONSTANTS.DEFAULT_FEED_COUNT;
                        }
                        feedParams.url = decodeURI(link);
                        var params = PHARMAACE.FORECASTAPP.UTILITY.getUrlVars(feedParams.url);
                        if (params && params.length > 0) {
                            var qArray = "";
                            if (params['q'] && params['q'].length > 0) {
                                qArray = params['q'].split(encodeURIComponent(' "'));
                                qArray[0] = decodeURI(qArray[0]);
                                $('#txtallwords').val(decodeURIComponent(qArray[0] ? $.trim(qArray[0].split('+OR+').join(',')) : ""));
                                if (qArray.length > 1) {
                                    qArray.splice(0, 1);
                                    qArray = (encodeURIComponent(' "') + qArray.join(encodeURIComponent(' "'))).split(encodeURIComponent(' -'));
                                    $('#txtexactword').val(decodeURIComponent(qArray[0].replaceAll(encodeURIComponent(' "'), '').replaceAll(encodeURIComponent('"'), '')));
                                    if (qArray.length > 1) {
                                        qArray.splice(0, 1);
                                        $('#txtnoneword').val(decodeURIComponent(qArray.join(' ')));
                                    }
                                }
                            }
                            if (params['ned'] && params['ned'].length > 0)
                                $('#txtcountry  option[value="' + params['ned'] + '"]').attr('selected', 'selected');
                            if (params['qdr'] && params['qdr'].length > 0)
                                $('#opduration  option[value="' + params['qdr'] + '"]').attr('selected', 'selected');
                        }
                        if (feedParams.feedCount > 0)
                            $('#txtnooffeeds').val(feedParams.feedCount);
                        //
                        var caption = $('#txtallwords').val();
                        if(!caption || caption.length == 0)
                            caption = PHARMAACE.FORECASTAPP.CONSTANTS.DEFAULT_NEWS_TITLE;
                        feedParams.title = "Keywords: " + decodeURI(caption);
                        var productFeedParams = PHARMAACE.FORECASTAPP.NEWSFEED.setCustomParamsFeeds(feedParams);
                        feedwind_show_widget_iframe(productFeedParams, 'feedContainer', 0);
                     </script>
                  </div>
               </div>
            </div>
         </div>
         <br />
         <br />
      </div>
   </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
   <script type="text/javascript">
      var currentCaption = { caption: "" };
      $(".nav-left .dropdown-menu li").click(function () {
          if ($('.nav-left .dropdown-menu li').hasClass('active'));
          $('.nav-left .dropdown-menu li').removeClass('active');
          $(this).addClass('active');
          $(this).parent().parent().find('a').first().addClass('active');          
      });
      $(".nav-left li.item a").click(function () {      
          if ($('.nav-left li.item a').hasClass('active') || $('#regulatory').hasClass('active'))
              $('.nav-left li.item a').removeClass('active');
             $('#regulatory').removeClass('active');
             $(this).addClass('active');      
      });
      function removeSpan(removeKeyword)
      {      
          var removeText = $('span[id=' + removeKeyword + ']').text();
          PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/LiveFeed/RemoveRegulatoryKeywords", { removeText: removeText},
                     function (data) {
                         $('span[id=' + removeKeyword + ']').remove();
                     },
                     function (status) {
                         PHARMAACE.FORECASTAPP.UTILITY.popalert(status, "NewsFeed Form");
                     });      
          GenerateHtmlForRegulatoryFeed();      
      }
      $(document).ready(function () {         
          $('.notclick').on('keydown', function (e) {
              e.stopPropagation();
          });
          $('body').click(function (e) {              
              if ((!$(e.target).hasClass('notclick')) && (e.target.id != 'txtcountry') && (e.target.id != 'displayFeedBox') && (!$(e.target).hasClass('bootstrap-tagsinput') && ($(e.target).attr('data-role') != 'remove'))) {
                      $('#newsfeedbox').removeClass('feedvisible');                  
              }
          });      
          $('input[rel="skus"]').tagsinput();
          $('input[rel="txtallwords"]').tagsinput();      
          $("#options li").click(function () {
              var id = $(this).attr("id");
              $("#options li").removeClass("active");             
              $('#' + id).addClass("active");
              localStorage.setItem("selectedolditem", id);
          });
          var selectedolditem = localStorage.getItem('selectedolditem');      
          if (selectedolditem != null) {                                                 
              $('#' + selectedolditem).addClass("active");
          }
          var currentSelectedMenu = getDivOrder();
          if ($('#options li').first().not('.active') && currentSelectedMenu == 0) {
              $('#options li').first().addClass('active');      
          }
          if ($('#CategoryList li a').first().hasClass('active') && currentSelectedMenu == 0) {     
              $('#CategoryList a.dropdown-toggle, #regulatory a').addClass('inactiveMenu');
              $('.inactiveMenu').click(function () {
                  return false;
              });
          }
          else {
              $('#CategoryList a.dropdown-toggle, #regulatory').removeClass('inactiveMenu');
          }

          getRegulatoryKeywords();
      });

      function getRegulatoryKeywords()
      {
          PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/LiveFeed/GetRegulatoryKeywordsForLink", null,
                function (data) {
                    currentRegulatoryKeyword = data.regarray;
                },
                function (status) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert(status, "NewsFeed Form");
                });
      }

      $('#RegulatoryTagformid').submit(function () {
          var allWordsOfReg = $('#regulatoryInput').val();          
          var divOrder = getDivOrder();
          if (allWordsOfReg == '')
          {
              getRegulatoryKeywordsInSave(true);
          }
          else
          {
              PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/LiveFeed/SaveRegulatoryKeywordsForLink", { AllWords: allWordsOfReg, DivOrder: divOrder },
                      function (data) {
                          $('#regulatoryInput').val('');
                          getRegulatoryKeywordsInSave(false);
                          hideModal('RegulatoryTagModal');
                      },
                      function (status) {
                          PHARMAACE.FORECASTAPP.UTILITY.popalert(status, "NewsFeed Form");
                          hideModal('RegulatoryTagModal');
                      });            
          }       
          return false;                                     
      });     
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
      function getRegulatoryKeywordsInSave(keywordsFromModel)
      {
          var getallRegulatoryKeywords;
          var getallRegulatoryKeywordsArr = [];

          if (keywordsFromModel) {
              //getallRegulatoryKeywords = currentRegulatoryKeyword;
              getallRegulatoryKeywordsArr = currentRegulatoryKeyword;
              newsSettingForRegKeywords(getallRegulatoryKeywordsArr , true);
          }
             
          else {
              PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/LiveFeed/GetRegulatoryKeywordsForLink", null,
               function (data) {
                   currentRegulatoryKeyword = data.regarray;
                   getallRegulatoryKeywordsArr = data.regarray;
                   newsSettingForRegKeywords(getallRegulatoryKeywordsArr , true);
               },
               function (status) {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert(status, "NewsFeed Form");
                   hideModal('RegulatoryTagModal');
               });
          }
          
      }

       function newsSettingForRegKeywords(getallRegulatoryKeywordsArr , isHideModal)
       {
           if (getallRegulatoryKeywordsArr) {
               var queryKeyword = PHARMAACE.FORECASTAPP.NEWSFEED.makeQueryKeyword(null, true, getallRegulatoryKeywordsArr,
                   [PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.FDA_MED, PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.FDA_UCM, PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.CT, PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.GOOGLE]);
               SetRegulatoryNewsUrl(queryKeyword);
               if (isHideModal)
               hideModal('RegulatoryTagModal');
           }
       }


      $('#search-form-box').submit(function () {
          var allwords = $('#txtallwords').val();
          var excatword = $('#txtexactword').val();
          var noneword = $('#txtnoneword').val();
          var duration = $('#opduration').val();
          var location = $('#txtcountry').val();
          var source = $('#txtsource').val();
          var feedCount = $('#txtnooffeeds').val();
          var link = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl(null);     
          if (noneword) {
              noneword = $.trim(noneword);
              noneword = ' -' + noneword.replaceAll(' ', ' -');
          }     
          var qparam = "";
          if (allwords != "") {
              var wordsJoinByOr = allwords;
              var wordstring = wordsJoinByOr.replace(/,/g, '+OR+');
              qparam = qparam + wordstring;
          }
          if (excatword) {
              qparam += ' "' + $.trim(excatword) + '"';
          }
          if (noneword) {
              qparam += noneword;
          }
          var newSrc = "";
          var chars = qparam.split(' ');
          if (chars.length > 1)
          {
              newSrc = encodeURI(qparam);
          }
          else
          {
              newSrc  = qparam;
          }
          link = link.replace(/(q=).*?(&)/, '$1' + newSrc + '$2');
          if (duration) {
              if (link.indexOf("&qdr=") >= 0)
                  link = link.replace(/(qdr=).*?(&)/, '$1' + duration + '$2');
              else {
                  if (!link.endsWith('&'))
                      link += '&';
                  link = link + "qdr=" + duration;
              }
          }
          if (location) {
              if (link.indexOf("&ned=") >= 0)
                  link = link.replace(/(ned=).*?(&)/, '$1' + location + '$2');
              else {
                  if (!link.endsWith('&'))
                      link += '&';
                  link = link + "ned=" + location;
              }                
          }
          link = link.replace(/(num=).*?(&)/, '$1' + feedCount + '$2');
          PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/LiveFeed/SaveNewsFeedLink", { newsLink: encodeURI(link), count: feedCount },
            function (data) { 
            },
            function (status) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert(status, "NewsFeed Form");
            });
           feedParams.url = link;
           feedParams.title = "Keywords:" + allwords;
           feedParams.feedCount = feedCount;
          var newFeedParams = PHARMAACE.FORECASTAPP.NEWSFEED.setCustomParamsFeeds(feedParams);
          feedwind_show_widget_iframe(newFeedParams, 'feedContainer', 0);      
          $('#newsfeedbox').toggleClass('feedvisible');
          return false;
      });
      $('#productList>li').click(function () {            
          //trim, compact and encode the keyword
          var productName = $.trim($(this).text());
          var allwords = productName;
          var moleculeName = $(this).attr('molecule'); //need to be program driven later
          var queryKeyword = PHARMAACE.FORECASTAPP.NEWSFEED.makeQueryKeyword([allwords, moleculeName], true, null, [PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.GOOGLE]);
          var link = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl(["GOOGLE"]);
          setIFrameSrc(queryKeyword, getDivOrder(), 2,link, productName);
          currentCaption.caption = "Product/" + allwords;
      });      
      $('#companyList>li').click(function () {
          //trim, compact and encode the keyword
          var companyName = $.trim($(this).text());
          var allwords = companyName;
          var sourceKey = allwords.replace(/ /g, '_').toUpperCase();
          var moleculeName = "methylphenidate ER"; //need to be program driven later
          var arrSources = [PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.GOOGLE];
          var arrSourceUrlKeys = ["GOOGLE"];
          if (PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES[sourceKey]) {
              arrSources = [PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES[sourceKey], PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.GOOGLE];
              arrSourceUrlKeys = [sourceKey, "GOOGLE"];
          }
          var queryKeyword = PHARMAACE.FORECASTAPP.NEWSFEED.makeQueryKeyword([allwords, moleculeName], true, null, arrSources);
          var link = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl(arrSourceUrlKeys);
          setIFrameSrc(queryKeyword, getDivOrder(), 3,link, companyName);
          currentCaption.caption = "Company/" + allwords;
      });      
      $("#regulatory").click(function () {
          var getallregulatorykeywords;
          var getallRegulatoryKeywordsArr = [];
          PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/LiveFeed/GetRegulatoryKeywordsForLink", null,
             function (data) {
                 currentRegulatoryKeyword = data.regarray;
                 getallRegulatoryKeywordsArr = data.regarray;
                 newsSettingForRegKeywords(getallRegulatoryKeywordsArr, true);
             },
             function (status) {
                 PHARMAACE.FORECASTAPP.UTILITY.popalert(status, "NewsFeed Form");
                 hideModal('RegulatoryTagModal');
             });
                
      });
      function SetRegulatoryNewsUrl(queryKeyword)
      {
          var link = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl(["FDA_MED", "FDA_UCM", "CT", "GOOGLE"]);
          setIFrameSrc(queryKeyword, getDivOrder(), 4, link, "");
      }      
      $('#latest-stories').click(function () {
          PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait..", 'feedContainerStatic', '15', '');
          getLatestStories(1);
      });
      $('#regulatory').click(function () {
          PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait..", 'feedContainerStatic', '15', '');
          getLatestStories(1);
      });
     
      $('#top-stories').click(function () {
          PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Please wait..", 'feedContainerStatic', '15', '');
          getLatestStories(0);
      });
      function getLatestStories(itemOrder){
          setIFrameSrc(getLatestStoriesQueryKeywordPairs(), getDivOrder(), itemOrder, "");
      }
      function setIFrameSrc(sourceQueryKeywordPairs, divOrder, itemOrder, link, fdaKeyword) {
          var caption = "";
          var iframeSrc = document.getElementsByTagName('iframe')[0].src;
          iframeSrc = spliAndJoinByQueryParam(iframeSrc, divOrder, itemOrder, caption, encodeURIComponent(fdaKeyword))
          if (link) {
              iframeSrc = PHARMAACE.FORECASTAPP.UTILITY.updateQueryString(iframeSrc, 'url', encodeURIComponent(link), true);
          }
          document.getElementsByTagName('iframe')[0].src = PHARMAACE.FORECASTAPP.NEWSFEED.setQueryKeyword(iframeSrc, sourceQueryKeywordPairs, true);
      }
      function spliAndJoinByQueryParam(iframeSrc, divOrder, itemOrder, encodedCaption, encodedFDAKeyword) {
          var forDivOrder = iframeSrc.split("&divOrder=");
          var forItem = forDivOrder[1].split("&item=");
          var forCaption = forItem[1].split("&caption=");
          var forFDAKeyword = forCaption[forCaption.length - 1].split("&fdaKeyword=");
          forFDAKeyword[1] = encodedFDAKeyword;
          forFDAKeyword[0] = encodedCaption;          
          forCaption[1] = forFDAKeyword.join("&fdaKeyword=");
          forCaption[0] = itemOrder;
          forItem[1] = forCaption.join("&caption=");
          forItem[0] = divOrder;
          forDivOrder[1] = forItem.join("&item=");
          return forDivOrder.join("&divOrder=");
      }
      function stringtrim(str) {
          str = str.replace(/^\s+/, '');
          for (var i = str.length - 1; i >= 0; i--) {
              if (/\S/.test(str.charAt(i))) {
                  str = str.substring(0, i + 1);
                  break;
              }
          }
          return str;
      }
      function onNewsLoaded() {
          PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('feedContainerStatic');
      }
   </script>
</asp:Content>