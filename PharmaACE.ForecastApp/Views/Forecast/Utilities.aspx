<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.TopRibbon>" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Utilities</title>
<%: Styles.Render("~/Content/glyphiconCSS", "~/Content/bootstrapCSS", "~/Content/fontawesomeCSS", "~/Content/homeIndexCSS") %>
<link href="../../Content/CSS/animate.css" rel="stylesheet" />
<%--<%: Scripts.Render("~/Scripts/jqueryLIB", "~/Scripts/bootstrapLIB") %>
<script type="text/javascript" src="../../Scripts/lib/bootstrap/bootbox.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
<script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>--%>
<%: Scripts.Render("~/Scripts/forecastUtilitiesScript") %>

 <%--<script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>--%>
<header id="header" style=" position:relative;  width:100%;">
     <%Html.RenderAction("RenderHeader", "Header", new { headerType = "Utilities" }); %>
</header>
<div id="page-content-wrapper">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <link href="../../Content/CSS/component.css" rel="stylesheet" />
                <script src="../../Scripts/lib/modernizr/modernizr.custom.js"></script>
                <div class="col-lg-12 app-bar">
                    <div class="row">
                        <ul id="og-grid" class="og-grid wow fadeInDown" data-wow-duration="600ms" data-wow-delay="100ms" style="animation-duration: 600ms; animation-delay: 100ms; animation-name: fadeInDown;">
                            <li class="utili" style="background-image:url('../../Content/img/utilities/epi.png');" title="Epicyclopedia">
                                <div class="rmore"><a target="_blank" href="<%=Url.Action("ForecastModel", "Forecast", new { type = 10 } )%>">&nbsp;</a></div>
                                <a  href="#" data-largesrc="../../Content/img/utilities/epi.png" data-title="Epicyclopedia" title="Epicyclopedia" data-description="This is the database for various epidemiologic parameters like Incidence, prevalence, diagnosed population for key indications across major disease areas like Autoimmune and Inflammation, Cardio-metabolic Disorders, Rare Disease and Genetic Disorders and STDs. This also includes details at segment/disease stage level and sources for all data-points">
                                    <img src="../../Content/img/utilities/epi-1.png" alt="Epicyclopedia" class="utimg">
                                     <%--<span class="utimg utititle" title="Epicyclopedia">Epicyclopedia</span>--%>
                                </a>
                            </li>
                            <li class="utili" style="background-image:url('../../Content/img/utilities/event.png');" title="Analog Analysis Event Impact">
                                <div class="rmore"><a target="_blank" href="<%=Url.Action("ForecastModel", "Forecast", new { type = 12 } )%>">&nbsp;</a></div>
                                <a  href="#" data-largesrc="../../Content/img/utilities/event.png" data-title="Analog Analysis Event Impact" title="Analog Analysis Event Impact" data-description="Calculate share trend for your product based on the analogues from your historical data and also calculate the incremental impact of events that could be applied to your forecast">
                                    <img  src="../../Content/img/utilities/analog-analysis.png" alt="Analog Analysis Event Impact" class="utimg">
                                    <%-- <span class="utimg utititle" title="Analog Analysis Event Impact" >Analog Analysis Event Impact</span>--%>
                                   
                                </a>
                            </li>
                            <li class="utili" style="background-image:url('../../Content/img/utilities/trending.png');" title="Trending Tool">
                                <div class="rmore"><a target="_blank" href="<%=Url.Action("ForecastModel", "Forecast", new { type = 13 } )%>">&nbsp;</a></div>
                                <a  href="#" data-largesrc="../../Content/img/utilities/trending.png" data-title="Trending Tool" title="Trending Tool" data-description="Create trends for inline products based on historical data. Variety of trends to choose from Linear, Logarithmic, Exponential, S-Shaped, Power, Growth, Inverse, Quadratic, 2nd Degree Log etc.">
                                    <img src="../../Content/img/utilities/treding-tool_.png" alt="Trending Tool" class="utimg">
                                     <%--<span class="utimg utititle" title="Trending Tool" >Trending Tool</span>--%>
                                </a>
                               
                            </li>
                            <li class="utili" style="background-image:url('../../Content/img/utilities/waterfall.png');" title="Waterfall Creator">
                                <div class="rmore"><a target="_blank" href="<%=Url.Action("ForecastModel", "Forecast", new { type = 17 } )%>">&nbsp;</a></div>
                                <a  href="#" data-largesrc="../../Content/img/utilities/waterfall.png" data-title="Waterfall Creator " title="Waterfall Creator" data-description="Create waterfall charts for depicting impact of various events on actual and projected data or between data two periods. Option to export to PPT">
                                    <img src="../../Content/img/utilities/water-fall.png" alt="Waterfall Creator " class="utimg">
                                    <%--<span class="utimg utititle" title="Waterfall Creator" >Waterfall Creator</span>--%>
                                </a>
                            </li>
                          
                        </ul>
                    </div>
                </div>
                <script src="../../Scripts/lib/modernizr/grid.js"></script>     
                     
            </div>
        </div>
    </div>
</div>
<footer class="midnight-blue" id="footer" style="float:left; width:100%; ">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                © 2016 <a title="PharmaAce" href="#" target="_blank">PharmaACE</a>. All Rights Reserved.
            </div>
        </div>
    </div>
</footer>
<%: Scripts.Render("~/Scripts/commonLIB") %>
<script>
    var name = '<%= Session["User"] %>';
</script>
