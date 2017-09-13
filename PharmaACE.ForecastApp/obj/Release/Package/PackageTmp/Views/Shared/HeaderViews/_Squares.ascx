<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%--<div class="social" id="social-moz">   --%>    <div class="social">                   
     <ul class="social-share" >
                            <li id="liImages" class="pull-right dropdown">
                                <a href="#" aria-expanded="false" title="Home" data-original-title="Home" data-toggle="dropdown" class="dropdown-toggle"><i class="glyphicon glyphicon-th gi-2x"></i></a>
                                <ul class="dropdown-menu  fade bottom in" id="appul">
                                    <div class="arrow gpDiv5"></div>
                                    <div class="row appbar gpDiv7">
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Forecast Platform</div>
                                                 <%if (Session["user"] != null)
                                                   {if ((Boolean)(Session["ForecastPlatform"]) == true) {
                                                %>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("Index", "Forecast")%>" target="_blank">
                                                        <img title="Forecast Platform" alt="Forecast Platform" src="../../../Content/img/forecast_menu.png">
                                                    </a>
                                                </div>
                                                 <% }
                                               else
                                                 {
                                                     %>
                                                   <div class="panel-body opac">
                                                    <a href="<%=Url.Action("Index", "Forecast")%>" target="_blank" onclick="return false;">
                                                        <img title="Forecast Platform" alt="Forecast Platform" src="../../../Content/img/forecast_menu.png">
                                                    </a>
                                                </div>                                             
                                                     <%
                                                 }
                                            }
                                            else
                                            {%> 
                                            <div class="panel-body opac">
                                            <a href="<%=Url.Action("Index", "Forecast")%>" target="_blank" onclick="return false;">
                                                <img title="Forecast Platform" alt="Forecast Platform" src="../../../Content/img/forecast_menu.png">
                                            </a>
                                        </div>      
                                          <%} %>                                         
                                         </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Knowledge Base</div>
                                                 <%if (Session["user"] != null)
                                                   {if ((Boolean)(Session["KnowledgeManagement"]) == true) {
                                                %>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("Index","KM")%>" target="_blank">
                                                        <img title="Knowledge Base" alt="Knowledge Management" src="../../Content/img/knowledge.png">
                                                    </a>
                                                </div>
                                                 <% }
                                               else
                                                 {
                                                     %>
                                                    <div class="panel-body opac">
                                                    <a href="<%=Url.Action("Index","KM")%>" target="_blank" onclick="return false;">
                                                        <img title="Knowledge Base" alt="Knowledge Management" src="../../Content/img/knowledge.png">
                                                    </a>
                                                </div>
                                                 <%
                                                 }
                                            }
                                            else
                                            {%> 
                                                 <div class="panel-body opac">
                                                    <a href="<%=Url.Action("Index","KM")%>" target="_blank" onclick="return false;">
                                                        <img title="Knowledge Base" alt="Knowledge Management" src="../../Content/img/knowledge.png">
                                                    </a>
                                                </div>

                                                  <%} %>     

                                            </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Business Intelligence</div>
                                                 <%if (Session["user"] != null)
                                                   {if ((Boolean)(Session["BusinessIntelligence"]) == true) {
                                                %>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("Index", "Reporting")%>" target="_blank" >
                                                        <img title="Business Intelligence" alt="Business Intelligence" src="../../Content/img/business.png">
                                                    </a>
                                                </div>
                                                 <% }
                                               else
                                                 {
                                                     %>
                                                     <div class="panel-body opac">
                                                    <a href="<%=Url.Action("Index", "Reporting")%>" target="_blank" onclick="return false;" >
                                                        <img title="Business Intelligence" alt="Business Intelligence" src="../../Content/img/business.png">
                                                    </a>
                                                </div>
                                                 <%
                                                 }
                                            }
                                            else
                                            {%> 
                                                    <div class="panel-body opac">
                                                    <a href="<%=Url.Action("Index", "Reporting")%>" target="_blank" onclick="return false;" >
                                                        <img title="Business Intelligence" alt="Business Intelligence" src="../../Content/img/business.png">
                                                    </a>
                                                </div>
                                                 <%} %>  
                                            </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Utilities</div>
                                                 <%if (Session["user"] != null)
                                                   {if ((Boolean)(Session["Utilities"]) == true) {
                                                %>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("Utilities", "Forecast" )%>" target="_blank">
                                                        <img title="Utilities" alt="Utilities" src="../../Content/img/lsettings.jpg">
                                                    </a>
                                                </div>
                                                 <% }
                                               else
                                                 {
                                                     %>
                                                      <div class="panel-body opac">
                                                    <a href="<%=Url.Action("Utilities", "Forecast" )%>" target="_blank" onclick="return false;">
                                                        <img title="Utilities" alt="Utilities" src="../../Content/img/lsettings.jpg">
                                                    </a>
                                                </div>
                                                <%
                                                 }
                                            }
                                            else
                                            {%> 
                                                 <div class="panel-body opac">
                                                    <a href="<%=Url.Action("Utilities", "Forecast" )%>" target="_blank" onclick="return false;">
                                                        <img title="Utilities" alt="Utilities" src="../../Content/img/lsettings.jpg">
                                                    </a>
                                                </div>
                                                  <%} %>  
                                            </div>
                                        </div>
                                    </div>
                                    <div class="divider"></div>
                                    <div  class="row appbar gpDiv8" >
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Market Monitor</div>
                                                 <%if (Session["user"] != null)
                                                   {if ((Boolean)(Session["CustomFeed"]) == true) {
                                                %>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("Index", "LiveFeed")%>" target="_blank">
                                                        <img title="Market Monitor" alt="Market Monitor" src="../../Content/img/20-rss-64.png">
                                                    </a>
                                                </div>
                                                <% }
                                               else
                                                 {
                                                     %>
                                                   <div class="panel-body opac">
                                                    <a href="<%=Url.Action("Index", "LiveFeed")%>" target="_blank" onclick="return false;">
                                                        <img title="Market Monitor" alt="Market Monitor" src="../../Content/img/20-rss-64.png">
                                                    </a>
                                                </div>
                                                <%
                                                 }
                                            }
                                            else
                                            {%> 
                                                   <div class="panel-body opac">
                                                    <a href="<%=Url.Action("Index", "LiveFeed")%>" target="_blank" onclick="return false;">
                                                        <img title="Market Monitor" alt="Market Monitor" src="../../Content/img/20-rss-64.png">
                                                    </a>
                                                </div>
                                                  <%} %>  


                                            </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Community of Practice</div>
                                                <%if (Session["user"] != null)
                                                   {if ((Boolean)(Session["CommunityOfPractice"]) == true) {
                                                %>
                                                <div class="panel-body">
                                                       <a href="<%=Url.Action("Index", "CommunityPractice" )%>" target="_blank">                                         
                                                    <img title="Community of Practice" alt="Community of Practice" src="../../Content/img/commun.png">
                                                   </a>
                                                </div>
                                                 <% }
                                               else
                                                 {
                                                     %>
                                                       <div class="panel-body opac">
                                                       <a href="<%=Url.Action("Index", "CommunityPractice" )%>" target="_blank" onclick="return false;">                                         
                                                    <img title="Community of Practice" alt="Community of Practice" src="../../Content/img/commun.png">
                                                   </a>
                                                </div>
                                                 <%
                                                 }
                                            }
                                            else
                                            {%> 
                                           <div class="panel-body opac">
                                                       <a href="<%=Url.Action("Index", "CommunityPractice" )%>" target="_blank" onclick="return false;">                                         
                                                    <img title="Community of Practice" alt="Community of Practice" src="../../Content/img/commun.png">
                                                   </a>
                                                </div>
                                                   <%} %>  


                                            </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading"> User Workspace</div>
                                                 <%if (Session["user"] != null)
                                                   {if ((Boolean)(Session["UserWorkspace"]) == true) {
                                                %>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("Index", "UserWorkSpace" )%>" target="_blank"><img title="User Workspace" alt="User Workspace" src="../../Content/img/business-64.png"></a>
                                                </div>
                                                 <% }
                                               else
                                                 {
                                                     %>
                                                <div class="panel-body opac">
                                                    <a href="<%=Url.Action("Index", "UserWorkSpace" )%>" target="_blank" onclick="return false;"><img title="User Workspace" alt="User Workspace" src="../../Content/img/business-64.png"></a>
                                                </div>
                                                <%
                                                 }
                                            }
                                            else
                                            {%> 
                                             <div class="panel-body opac">
                                                    <a href="<%=Url.Action("Index", "UserWorkSpace" )%>" target="_blank" onclick="return false;"><img title="User Workspace" alt="User Workspace" src="../../Content/img/business-64.png"></a>
                                                </div>
                                                   <%} %>  

                                            </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Help Desk</div>
                                                 <%if (Session["user"] != null)
                                                   {if ((Boolean)(Session["HelpDesk"]) == true) {
                                                %>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("HelpDesk", "Home" )%>" target="_blank">
                                                        <img title="Help Desk" alt="Help Desk" src="../../Content/img/call.png">
                                                    </a>
                                                </div>
                                                <% }
                                               else
                                                 {
                                                     %>
                                                   <div class="panel-body opac">
                                                    <a href="<%=Url.Action("HelpDesk", "Home" )%>" target="_blank" onclick="return false;">
                                                        <img title="Help Desk" alt="Help Desk" src="../../Content/img/call.png">
                                                    </a>
                                                </div>
                                                 <%
                                                 }
                                            }
                                            else
                                            {%> 
                                                    <div class="panel-body opac">
                                                    <a href="<%=Url.Action("HelpDesk", "Home" )%>" target="_blank" onclick="return false;">
                                                        <img title="Help Desk" alt="Help Desk" src="../../Content/img/call.png">
                                                    </a>
                                                </div>
                                                 <%} %>  
                                            </div>
                                        </div>
                                    </div>
                                </ul>
                            </li>
                        </ul>
                    </div>
         
