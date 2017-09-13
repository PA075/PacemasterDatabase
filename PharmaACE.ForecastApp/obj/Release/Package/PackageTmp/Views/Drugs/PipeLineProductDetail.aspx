<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<PharmaACE.ForecastApp.Models.PipelineProductDetail>>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    PipeLine Product Detail
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%--<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
   <script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>--%>
    <div class="">
         <div class="container">
               <div class="kmBox5">
            <h2><span class="kmBox6"><%= ViewData["productName"] %> Details</span></h2>
        </div>
        <div class="row">
            <div class="col-sm-12">
        <%if (Model.Count() >= 1)
          { %>


        <%PharmaACE.ForecastApp.Models.PipelineProductDetail firstProduct = Model.ElementAt(0); %>
        <div class="table-responsive" id="SearchResult">
                 <table id="" class="table table-bordered table-striped box-shadow--6dp " role="grid" aria-describedby="example_info">
                <tbody>
                    <%var TestVar = false;  %>
                    
                    <%for (int i = 0; i < Model.Count(); i++)
                        {
                            if (Model.ElementAt(i).ProductType=="Monotherapy")
                            {
                                TestVar = true;
                                %>
                               
                                      <tr class="kmBox11">
                        <td class="kmBox15">
                            <strong><%: Html.DisplayNameFor(model => model.ElementAt (0).ProductName) %> :</strong>  <%: Html.DisplayFor(model => model.ElementAt (0).ProductName) %><br />
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).CompanyName) %>:</strong>  <%: Html.DisplayFor(model =>  model.ElementAt (0).CompanyName) %><br />
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (i).MoleculeName) %>:</strong>  <%: Html.DisplayFor(model =>  model.ElementAt (i).MoleculeName) %><br />
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (i).PHARMA_CLASSES ) %>:</strong> <%: Html.DisplayFor(model =>  model.ElementAt (i).PHARMA_CLASSES) %>
                        </td>
                        <td class="kmBox14">
                            <%if (Model.ElementAt(0).Dosage_Adult!=null)
                                {%>
                            <div>
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).Dosage_Adult) %></strong><br />
                               <%-- <% string Dosage_Adult = Model.ElementAt (0).Dosage_Adult.ToString().Replace("|^|", "<LI>").Replace("|", "UL"); %>--%>
                                  <% string Dosage_Adult = Model.ElementAt (0).Dosage_Adult.ToString(); %>
                                <%: Html.Raw(Dosage_Adult) %>
                                </div>
                            <%}%>
                            <div>
                                <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).MOA) %>:</strong><br/>
                                 <%: Html.Raw(Model.ElementAt (0).MOA) %>
                            </div>
                        </td>
                        <td class="kmBox15">
                            <strong>Latest Development Phase:</strong> <%: Html.DisplayFor(model =>  model.ElementAt (0).LatestDevelopmentStatus) %><br />
                             <%if (Model.ElementAt(0).LatestDevelopmentStatus.ToString() != "Inline")
                              { %>
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (i).EstimateLaunchDate) %> :</strong> 
                            <%} else{%> Launch Date
                            <%} %>
                            <%if (Model.ElementAt(i).EstimateLaunchDate.ToString() != "1/1/0001 12:00:00 AM")
                              { %>
                            <%: Html.DisplayFor(model =>  model.ElementAt (i).EstimateLaunchDate) %>
                            <%} else{%> Not Available
                            <%} %>
                            <br />
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).AnalystEstimate) %> :</strong> <%: Html.DisplayFor(model =>  model.ElementAt (0).AnalystEstimate ) %>
                            <br />
                        </td>
                    </tr>


                            <% break;
                                    }


                                } %>

                    <%
                        if (TestVar)
                        {%>
                            <tr>
                        <td colspan="3">
                             <table id="tblTrialdat" class="table table-bordered table-striped  no-hover" role="grid" >
                                <tr class="kmBox2">
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).Regimen) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).DiseaseArea) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).Indication) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).DetailedIndication) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).StudyTitle) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).DevelopmentPhase ) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).ExpectedCompletionDate) %></strong></td>
                                </tr>
                                     <% foreach (var item in Model)
                           { %>
                                  <tr style ="width :100%">
                                    <td><%: Html.DisplayFor(model => item.Regimen) %></td>
                                    <td><%: Html.DisplayFor(model => item.DiseaseArea) %></td>
                                    <td><%: Html.DisplayFor(model => item.Indication) %></td>
                                    <td><%: Html.DisplayFor(model => item.DetailedIndication) %></td>
                                    <%if (item.NCT != null && item.NCT != "")
                                         { %>
                                     <td><%: Html.ActionLink(item.StudyTitle, "NCTDetails", "ClinicalTrials", new { NCT = item.NCT }, null) %></td>
                                     <%}
                                     else
                                     { %>
                                     <td><%: Html.ActionLink(item.StudyTitle, "Index", "ClinicalTrials") %></td>
                                     <%} %>
                                    <td><%: Html.DisplayFor(model => item.DevelopmentPhase) %></td>
                                    <td><%: Html.DisplayFor(model => item.ExpectedCompletionDate ) %></td>
                                       </tr>
                                    <%} %>
                            </table>
                        </td>
                    </tr>
                        <%}

                         %>

                    <%else
                        {%>
                              
                         <tr style="width: auto;">
                        <td style="width: 25%;">
                            <strong><%: Html.DisplayNameFor(model => model.ElementAt (0).ProductName) %> :</strong>  <%: Html.DisplayFor(model => model.ElementAt (0).ProductName) %><br />
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).CompanyName) %>:</strong>  <%: Html.DisplayFor(model =>  model.ElementAt (0).CompanyName) %><br />
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).MoleculeName) %>:</strong>  <%: Html.DisplayFor(model =>  model.ElementAt (0).MoleculeName) %><br />
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).PHARMA_CLASSES ) %>:</strong> <%: Html.DisplayFor(model =>  model.ElementAt (0).PHARMA_CLASSES) %>
                        </td>
                        <td style="width: 50%;">
                            <%if (Model.ElementAt(0).Dosage_Adult!=null)
                                {%>
                            <div>
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).Dosage_Adult) %></strong><br />
                               <%-- <% string Dosage_Adult = Model.ElementAt (0).Dosage_Adult.ToString().Replace("|^|", "<LI>").Replace("|", "UL"); %>--%>

                                  <% string Dosage_Adult = Model.ElementAt (0).Dosage_Adult.ToString(); %>
                                <%: Html.Raw(Dosage_Adult) %>
                                </div>
                            <div>
                                 <%}%>
                                <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).MOA) %>:</strong><br/>
                                 <%: Html.Raw(Model.ElementAt (0).MOA) %>
                            </div>
                        </td>
                        <td style="width: 25%;">
                            <strong>Latest Development Phase:</strong> <%: Html.DisplayFor(model =>  model.ElementAt (0).LatestDevelopmentStatus) %><br />
                             <%if (Model.ElementAt(0).LatestDevelopmentStatus.ToString() != "Inline")
                              { %>
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).EstimateLaunchDate) %> :</strong> 
                            <%} else{%> Launch Date
                            <%} %>
                            <%if (Model.ElementAt(0).EstimateLaunchDate.ToString() != "1/1/0001 12:00:00 AM")
                              { %>
                            <%: Html.DisplayFor(model =>  model.ElementAt (0).EstimateLaunchDate) %>
                            <%} else{%> Not Available
                            <%} %>
                            <br />
                            <strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).AnalystEstimate) %> :</strong> <%: Html.DisplayFor(model =>  model.ElementAt (0).AnalystEstimate ) %>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                             <table id="tblTrialdat" class="table table-bordered table-striped  no-hover " role="grid" >
                                <tr style ="width :100%">
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).Regimen) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).DiseaseArea) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).Indication) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).DetailedIndication) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).StudyTitle) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).DevelopmentPhase ) %></strong></td>
                                    <td><strong><%: Html.DisplayNameFor(model =>  model.ElementAt (0).ExpectedCompletionDate) %></strong></td>
                                </tr>
                                     <% foreach (var item in Model)
                           { %>
                                  <tr style ="width :100%">
                                    <td><%: Html.DisplayFor(model => item.Regimen) %></td>
                                    <td><%: Html.DisplayFor(model => item.DiseaseArea) %></td>
                                    <td><%: Html.DisplayFor(model => item.Indication) %></td>
                                    <td><%: Html.DisplayFor(model => item.DetailedIndication) %></td>
                                    <%if (item.NCT != null && item.NCT != "")
                                         { %>
                                     <td><%: Html.ActionLink(item.StudyTitle, "NCTDetails", "ClinicalTrials", new { NCT = item.NCT }, null) %></td>
                                     <%}
                                     else
                                     { %>
                                     <td><%: Html.ActionLink(item.StudyTitle, "Index", "ClinicalTrials") %></td>
                                     <%} %>
                                    <td><%: Html.DisplayFor(model => item.DevelopmentPhase) %></td>
                                    <td><%: Html.DisplayFor(model => item.ExpectedCompletionDate ) %></td>
                                       </tr>
                                    <%} %>
                            </table>
                        </td>
                    </tr>

                        <%}

                       %>
                </tbody>
            </table>
        </div>
        <%} %>
                </div>
              <br />
                <div style="text-align:right">
                <% if (Session["searchPage"].ToString() == "DrugsIndex")
                        {%>
                    <a href="<%=Url.Action("Index", "Drugs", new { returnBack = true })%>">
                        <button type="button" class="btn btn-primary Pipelinebackbtncss btn-arrow-left">Back</button></a>
                    <%  }
                        else
                        { %>
                    <a href="<%=Url.Action("Index", "KM", new { returnBack = true,searchType=0 })%>">
                        <button type="button" class="btn btn-primary Pipelinebackbtncss btn-arrow-left">Back</button></a>

                    <%} %>
                    </div>
          
            </div>
    </div>
         </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
     <script type="text/javascript">
    </script>
</asp:Content>
