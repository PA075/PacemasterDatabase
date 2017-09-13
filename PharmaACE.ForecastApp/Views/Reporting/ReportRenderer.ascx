<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<PharmaACE.ForecastApp.Models.DistinctReportSettings>" %>
<%@ Import Namespace="MvcReportViewer" %>
<%@ Import Namespace="PharmaACE.ForecastApp.Models" %>
<%@ Import Namespace="PharmaACE.ForecastApp.Business" %>
<div>
    <%: Html.Raw( Html.MvcReportViewer(
                                        String.Format("/{0}/{1}", Session["SubscriberName"], Model.ReportType == ReportModelType.Generic ? "GenericsReport" : "BDL_Report"),
                                        GenUtil.GetReportSettings(Model) ,
                                        //height defined in ssrs: 3.51042 in = 263px
                                        new { Height = "532px", Width = "100%", style = "border: none;" })) %>
                                        <%--new { Height = "532px", Width = "100%", style = "border: none;", onload = "onReportLoad(this);" })) %>--%>
                                        <%--new { Height = "532px", Width = "100%", style = "resize: both; overflow: auto;", onload = "onReportLoad();" })) %>--%>
</div>
