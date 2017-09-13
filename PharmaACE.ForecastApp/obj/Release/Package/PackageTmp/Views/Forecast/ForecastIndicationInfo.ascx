<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<PharmaACE.ForecastApp.Models.ForecastReference>" %>

<body class="nav-md">

    <div id="page-content-wrapper" data-spy="scroll" data-target="#spy" class="page-content-wrapper-left imgclickenable horizontalItemsContainer">
        <div class="container-fluid">

            <div class="row">

                  <%if (Model.Epidemiology!=null && Model.Epidemiology!=string.Empty){ %>
                <legend id="epidemiology" class="indicationRef">Epidemiology</legend>
                <div class="display-field indicationRef" style="word-break:keep-all;">
                    <%: Html.Raw(Model.Epidemiology)  %>
                </div>
                <%} %>

                  <%if (Model.HistoricalData!=null && Model.HistoricalData!=string.Empty){ %>
                <legend id="historicaldata"  class="indicationRef">Historical Data</legend>
                <div class="display-field indicationRef" style="word-break:keep-all;">
                    <%: Html.Raw(Model.HistoricalData)  %>
                </div>
                <%} %>

                  <%if (Model.Compliance!=null && Model.Compliance!=string.Empty){ %>
                <legend id="conversionparameters"  class="indicationRef"></legend>
                <legend id="compliance"  class="indicationRef">Compliance</legend>
                <div class="display-field indicationRef" style="word-break:keep-all;">
                    <%: Html.Raw(Model.Compliance)  %>
                </div>
                <%} %>

                  <%if (Model.Dosing!=null && Model.Dosing!=string.Empty){ %>
                <legend id="dosing"  class="indicationRef">Dosing</legend>
                <div class="display-field indicationRef" style="word-break:keep-all;">
                    <%: Html.Raw(Model.Dosing)  %>
                </div>
                <%} %>

                  <%if (Model.DoT!=null && Model.DoT!=string.Empty){ %>
                <legend id="dot"  class="indicationRef">Dot</legend>
                <div class="display-field indicationRef" style="word-break:keep-all;">
                    <%: Html.Raw(Model.DoT)  %>
                </div>
                <%} %>

                  <%if (Model.MarketAccess!=null && Model.MarketAccess!=string.Empty){ %>
                <legend id="marketaccess"  class="indicationRef">Market Access</legend>
                <div class="display-field indicationRef" style="word-break:keep-all;">
                    <%: Html.Raw(Model.MarketAccess)  %>
                </div>
                <%} %>

                  <%if (Model.Pricing!=null && Model.Pricing!=string.Empty){ %>
                <legend id="pricing"  class="indicationRef">Pricing</legend>
                <div class="display-field indicationRef" style="word-break:keep-all;">
                    <%: Html.Raw(Model.Pricing)  %>
                </div>
                <%} %>

                  <%if (Model.TreatmentAlgorithm!=null && Model.TreatmentAlgorithm!=string.Empty){ %>
                <legend id="treatmentalgorithm"  class="indicationRef">Treatment Algorithm</legend>
                <div class="display-field indicationRef" style="word-break:keep-all;">
                    <%: Html.Raw(Model.TreatmentAlgorithm)  %>
                </div>
                <%} %>

                <%if (Model.Events!=null && Model.Events!=string.Empty){ %>
                <legend id="eventspipeline"  class="indicationRef">Events Pipeline</legend>
                <div class="display-field indicationRef" style="word-break:keep-all;">
                    <%: Html.Raw(Model.Events)  %>
                </div>
                <%} %>
            </div>

        </div>
    </div>



    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">--%>
</body>
