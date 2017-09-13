<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<div class="social " style="margin-top: 0px; position:absolute; left:0px; margin-top:0px; width:29px;">
                        <ul class="social-share">
                            <li id="liImages" class="pull-left dropdown">
                                <a href="#" aria-expanded="false" title="Home" data-original-title="Home" data-toggle="dropdown" class="dropdown-toggle"><i class="glyphicon glyphicon-th gi-2x"></i></a>
                                <ul class="dropdown-menu  fade bottom in gpDiv6">
                                    <div  class="arrow gpDiv5"></div>
                                    <div style="" class="row appbar">
                                        <div class="col-md-3 col-xs-6 col-sm-4 ">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Forecast Platform</div>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("Index", "Forecast")%>" target="_blank">
                                                        <img title="Forecast Platform" alt="Forecast Platform" src="../../Content/img/forecast.png">
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Knowledge Management</div>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("Index","KM")%>" target="_blank">
                                                        <img title="Knowledge Management" alt="Knowledge Management" src="../../Content/img/knowledge.png">
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Business Intelligence</div>
                                                <div class="panel-body">
                                                   <%-- <a href="<%=Url.Action("BI", "Reporting")%>" target="_blank">--%>
                                                        <img title="Business Intelligence" alt="Business Intelligence" src="../../Content/img/business.png">
                                                    <%--</a>--%>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Utilities</div>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("Utilities", "Forecast" )%>" target="_blank">
                                                        <img title="Utilities" alt="Utilities" src="../../Content/img/lsettings.jpg">
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="divider"></div>
                                    <div style="" class="row appbar">
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Market Monitor</div>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("Index", "LiveFeed")%>" target="_blank">
                                                        <img title="Market Monitor" alt="Market Monitor" src="../../Content/img/20-rss-64.png">
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Community of Practice</div>
                                                <div class="panel-body">
                                                    <img title="Community of Practice" alt="Community of Practice" src="../../Content/img/commun.png">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">User Workspace</div>
                                               <div class="panel-body">
                                                    <a href="<%=Url.Action("Index", "UserWorkSpace" )%>" target="_blank">
                                                        <img title="User Workspace" alt="User Workspace" src="../../Content/img/business-64.png"></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3 col-xs-6 col-sm-4">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Help Desk</div>
                                                <div class="panel-body">
                                                    <a href="<%=Url.Action("HelpDesk", "Home" )%>" target="_blank">
                                                        <img title="Help Desk" alt="Help Desk" src="../../Content/img/call.png">
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ul>
                            </li>
                        </ul>
                    </div>
         
