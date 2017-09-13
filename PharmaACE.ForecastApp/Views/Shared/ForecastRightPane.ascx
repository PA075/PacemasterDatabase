<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<PharmaACE.ForecastApp.Models.ForecastAuxiliary>" %>
 <div class="taskPane rightSidePane" id="divNotes2">
                    <div id="wrapper1" class="">
                        <div id="sidebar-wrapper1" class="affix-top">
                            <div id="product_news" class="">
                                <script type="text/javascript">
                                    PHARMAACE.FORECASTAPP.NEWSFEED.generateFeed({ keywords: ['<%=Session["FeedKeyword"] %>'], title: "Product Feed" });
                                </script>
                            </div>
                            <div id="custom_news" class="" style="position: relative;">
                                <script type="text/javascript">
                                    var link = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl(null);
                                    var count = 0;
                                    <% if (Model.NewsDetails != null)
                                    {
                                        if (Model.NewsDetails.NewsFeedLink != null && Model.NewsDetails.NewsFeedLink != "")
                                    {%>
                                    link = "<%=Model.NewsDetails.NewsFeedLink.Replace("\"", "\\\"")%>";
                                    <%}%>
                                        count = "<%=Model.NewsDetails.FeedCount%>";
                                    <%}%>
                                    
                                    if (!count || isNaN(count) || count < 1) {
                                        count = PHARMAACE.FORECASTAPP.CONSTANTS.DEFAULT_FEED_COUNT;
                                    }
                                    PHARMAACE.FORECASTAPP.NEWSFEED.generateFeed({ url: decodeURI(link), feedCount: count, title: "Custom Feed" });
                                </script>
                            </div>
                        </div>
                    </div>
                    <div class="paneHeader">
                         <button onclick="toggleTaskPane();" title="Toggle Visualization Pane" class="toggleBtn">
                            <div class="expanderBtn">
                                <div class="btnIcon">
                                    <span class="fa fa-angle-right" style="font-size: 24px; padding: 0px;"></span>
                                </div>
                            </div>
                            <h2 class="verticalTitle verticalText"><span class="collapsedVisualsTitle largeFontSize">Product </span><span class="collapsedFiltersTitle largeFontSize">Feed</span></h2>
                        </button>
                   </div>  
                </div>
                <% if (Model.Assumptions != null && Model.Assumptions.Visible)
                    { %>
                                <div id="divNotes" class="visualizationPane rightSidePane">
                                    <div class="version_properties">
                                        <div class="tab-content" id="tab-scroller">
                                            <div class="headertitle">
                                                <div class="feed_title"><a target="_blank" rel="nofollow" style="margin-bottom: 7px;">Assumptions</a>
                                                    <span class="expandSpan" onclick="toggleFullVisualisation();"><i class="fa fa-expand fa-3" aria-hidden="true" title="Maximize"></i></span></div>
                                            </div>
                                            <div class="botbar tab-pane fade active in" id="botbar" style="height: 579px; overflow-y: auto; overflow-x: hidden;">
                                                <section class="page1_header">
                                                    <div class="row">
                                                        <div id="set_assumptions" class="grid_4 col-md-12"></div>
                                                    </div>
                                                </section>
                                            </div>
                                            <div class="botbar2 tab-pane fade" id="botbar2" style="height: 579px; overflow-y: auto; overflow-x: hidden;">
                                                <section class="page1_header">
                                                    <div class="row">
                                                        <div id="get_assumptions" class="grid_4 col-md-12">
                                                        </div>
                                                    </div>
                                                </section>
                                            </div>
                                    </div>
                                     <div class="paneHeader">
                                        <button onclick="toggle();" class="toggleBtn">
                                            <div class="expanderBtn">
                                                <div class="btnIcon">
                                                    <span class="fa fa-angle-right" style="font-size: 24px; padding: 0px;"></span>
                                                </div>
                                            </div>
                                            <h2 class="verticalTitle verticalText"><span class="collapsedVisualsTitle largeFontSize">Assumption</span></h2>
                                        </button>
                                     </div>
                                </div>
                                     <input type="hidden" id="selectedassumption" value="0"/>
                                </div>
                <% } %>