<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/CFSite.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.CommunityPractice>" %>
<%@ Import Namespace="System.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   Community of Practice
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <%--    <%: Scripts.Render("~/Scripts/ForecastAppServiceScript")%>--%>
   <%-- <script src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
      <link href="../../Content/CSS/bootstrap-glyphicons.css" rel="stylesheet" />--%>
   <!-- <script src="../../Scripts/lib/jquery/jquery.min.js"></script>
      <script src="../../Scripts/lib/jquery/bootstrap.min.js"></script>
      <script src="../../Scripts/lib/jquery/jquery.dataTables.min.js"></script>
      <script src="../../Scripts/lib/bootstrap/dataTables.bootstrap.min.js"></script>
      <script src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
      <script  src="../../Scripts/custom/PharmaACE.ForecastApp.Constants.js"></script>
      <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.FeedEngine.js"></script>
      <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Constants.js"></script>
      <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.NewsFeed.js"></script> -->
   <%--<script src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>--%>
   <%--  <%: Scripts.Render ("~/Scripts/HelpDeskScript") %>--%>
   <%--<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.FeedEngine.js"></script>
   <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.NewsFeed.js"></script> --%>
   <%--<script src="../../Scripts/lib/jquery/jquery.dataTables.min.js"></script>--%>
  <%-- <link href="../../Content/CSS/dataTables.bootstrap.min.css" rel="stylesheet" />
   <link href="../../Content/CSS/bootstrap-select.min.css" rel="stylesheet" />--%>
       <%: Styles.Render( "~/Content/CommunityCSS")  %>


   <div id="customBox" class="community-practice">
      <div class="container">
         <div class="row gap-top">
            <div id="content-box2" class="col-md-9 col-sm-8 col-xs-12 cpDiv1">
               <div id="SearchResult"></div>
            </div>
            <div id="content-box" class="col-md-3 col-sm-12 col-xs-12">
               <div class="NewsFeedtd sideimagebox" data-spy="affix" data-offset-top="20">
                  <div id="feedContainer">
                     <script type="text/javascript">
                         $(document).ready(function(){
                        var feedParams = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultParams();
                        var FKeywords = 'pharmaceuticals,forecasting,U.S.';
                        var arrOfKeywords = FKeywords.split(',');
                        var link = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl(null);
                        var qparam = "";
                        if (FKeywords != "") {
                            var wordsJoinByOr = FKeywords;
                            //var wordstring = wordsJoinByOr.replace(/,/g, '+OR+');
                            var wordstring = wordsJoinByOr.replace(/,/g, '+');
                            qparam = qparam + wordstring;
                        }
                        var newSrc = "";
                        var chars = qparam.split(' ');
                        if (chars.length > 1) {
                            newSrc = encodeURI(qparam)
                        }
                        else {
                            newSrc = qparam;
                        }
                        link = link.replace(/(q=).*?(&)/, '$1' + newSrc + '$2');
                        // var link = PHARMAACE.FORECASTAPP.NEWSFEED.setQueryKeyword(PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl(null), arrOfKeywords, false);
                        feedParams.url = link;
                        feedParams.title = FKeywords;
                        feedParams.itemDescriptionOn = "off";
                        if (!feedParams.feedCount || isNaN(feedParams.feedCount) || feedParams.feedCount < 1) {
                            feedParams.count = PHARMAACE.FORECASTAPP.CONSTANTS.DEFAULT_FEED_COUNT;
                        }
                        //var productFeedParams = PHARMAACE.FORECASTAPP.NEWSFEED.setCustomParamsFeeds(feedParams);
                        var productFeedParams = PHARMAACE.FORECASTAPP.NEWSFEED.setCustomParams(feedParams);
                        feedwind_show_widget_iframe(productFeedParams, 'feedContainer');
                        });
                     </script>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
   <%: Styles.Render( "~/Content/qa-stylesCSS")  %>
    <%: Scripts.Render ("~/Scripts/COPIndexScript") %>
</asp:Content>