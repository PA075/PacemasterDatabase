<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.Patent>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   Patent
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .paginate_button.active a {
        padding: 4px 14px; top:-2px;
    }
    #tablist li:last-child{ border-bottom:1px solid #e6e6e6;}
    #tablist{border-right:0px; height:36px;}
    #tablist li a{font-weight:bold; padding:6px 14px; border-right:1px solid #ddd;}
    #tablist>li.active>a:after{display:none;}
    .tab-content>.tab-pane{display:block !important;}
    .scroll-area {
	height: 390px;
	position: relative;
	overflow: auto;
    overflow-x:hidden;
}
   
     .nav-tabs li{border-bottom:0px solid #e6e6e6 !important; margin-left:0px;}
     #tablist li:last-child a{border:0px;}
     #patentNav{padding:0px; background-color:#f5f5f5;}
     .dataTables_info{margin-top:0px !important;}
     .pagination{margin:2px 0px 0px !important;}
     hr{margin-top:10px; margin-bottom:15px;}
     #myNavbar{padding-top:0px;}
     .dataTables_wrapper .col-sm-2:first-child{padding-right:0px; width:132px;left:72%}
     .dataTables_wrapper .col-sm-3{padding-left:0px;left:72%; max-width:191px;}
     .dataTables_filter{float:left !important;}
     #drugsid table.dataTable.no-footer{border-bottom: 0px solid #111;}
     .scroll-area .section h2{top:-7px; position:absolute; font-size:18px; padding-left:10px;color:#f00;}
     .scroll-area .section{margin-top:40px;}
     .scroll-area .section:first-child{margin-top:0px;}
     .scroll-area .section .tab-pane{position:relative;}
     /*.scroll-area .section{position:relative;}*/
     #mainDiv{clear:both;border:1px solid #ddd;/*box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);*/}
#tablist li.active a{background-color:#000; color:#fff;}
#patentResult{position:absolute; right:0px;top:15px;}
#patentResult h5{float:left;}
.yearright{text-align:right;}
    .nummiddle {
        text-align:center;
    }
    .dataTables_wrapper{min-height:380px;}
    .dataTables_info{padding-left:10px;}
    .table td{vertical-align:middle !important;}
</style>
 <div id="popalert" class="modal" style="overflow: visible;" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body">
                    <p style="text-align: center"></p>
                </div>
            </div>
        </div>
    </div>
    <div class="container" id="contentbox">
         <div id="Search">
                     <div class="col-md-12 col-sm-12 col-xs-12" id="kmmainsearch" style="margin-top:-16px;">
    <div class="form-horizontal">
        <form class="navbar-form kmBox1" role="search" id="searchbar">
            <div class="input-group">
                <div id="search-box" class="col-md-8 col-sm-8 col-xs-12">
                    <div class="col-md-5 col-sm-5 col-xs-5">
                    <div class="ddl-select input-group-btn ">
                        <select class="selectpicker form-control search-filter select-dropdown selectBox kmBox2" id="search-filter-dropdown" onclick="abc();">
                            <option selected="selected" value="drug-name">By Drug Name</option>
                            <option value="DiseaArea">By Disease Area</option>
                            <option value="Molecule">By Molecule</option>
                            <option value="Molecule">By Indication</option>
                            <option value="Molecule">By Company</option>
                        </select>
                    </div>
                    </div>
                    <div class="col-md-6 col-sm-5 col-xs-6 ">
                    <input id="searchInput" type="text" class="form-control kmBox2" placeholder="Enter here" aria-describedby="ddlsearch">
                    </div>
                    <div class="col-md-1 col-sm-1  col-xs-1 ">
                        <div class="input-group-btn">
                        <input id="btnSearch" class="btn btn-default" type="submit" value=""  />
                        </div>
                    </div>
                </div>
                
            </div>
        </form>
        <div id="patentResult">
            <h5 class="kmBox27">Search Result for: <span class="rcount">li</span>&nbsp;&nbsp;&nbsp;&nbsp;</h5>
            <h5 class="kmBox30">Result found: <span id="total_count" class="rcount">
            2147</span></h5>
        </div>
    </div>
</div>     
          </div>
        <script>

            var PatentData = "";
            function getPatentData(currentBrandRow)
            {
                PatentData = "";
                var inlineTransId = $(currentBrandRow).parent().parent().attr('InlineId');

                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Patent/GetPatentInfo", { "inlineTransId": inlineTransId },
                         function (result) {
                             if (result.success) {
                                 PatentData = result.result;
                                 showGenericAvailabiltyData(PatentData.generic);
                                 showSalesInformation(PatentData.saleInfo);
                                 showExclusivityInformation(PatentData.exclusivity);
                                 showApiInfoData(PatentData.apiInfoList);

                             }
                             else
                                 PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                         },
                           function (result) {
                               PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                           });
 
               
              
            }

            function getFormattedDate(fdate) {
                var r = new Date(parseInt(fdate.substr(6)));
                var d = ("0" + r.getDate()).slice(-2);
                var m = ("0" + (r.getMonth() + 1)).slice(-2);
                var dt = r.getFullYear() + "-" + (m) + "-" + (d);
                return dt;


            }

            function showApiInfoData(apiInfoList) {

                if ($('#table-api-info').DataTable().row().count() == 0) {
                    for (var i = 0; i < apiInfoList.length; i++) {
                        var submissionDate = getFormattedDate(apiInfoList[i].SubmissionDate);
                        var dmfHolder = apiInfoList[i].DMFHolders;
                        var dmfStatus = "";
                        if (apiInfoList[i].DMFStatus == "1")
                        {
                            dmfStatus = "Active";
                        }
                        else
                        {
                            dmfStatus = "Inactive";
                        }
                        var andaHolder = "";
                        if (apiInfoList[i].ANDAHolder == true)
                        {
                            andaHolder = "Yes";
                        }
                        else
                        {
                            andaHolder = "No";
                        }
                        var organizationFinishedProducts = "";
                        if (apiInfoList[i].OrganizationFinishedProducts ==true)
                        {
                            organizationFinishedProducts = "Yes";
                        }
                        else
                        {
                            organizationFinishedProducts = "No";
                        }
                        var dtrow = $('#table-api-info').DataTable();
                        dtrow.row.add([
                        (i + 1),
                        "",
                        submissionDate,
                        dmfHolder,
                        dmfStatus,
                        andaHolder,
                        organizationFinishedProducts


                        ]).draw(false);

                    }



                }
            }


            function showExclusivityInformation(exclusivity)
            {
                if ($('#table-exclusivity-info').DataTable().row().count() == 0) {
                    for (var i = 0; i < exclusivity.length; i++) {
                        var dtrow = $('#table-exclusivity-info').DataTable();
                        dtrow.row.add([
                        (i + 1),
                        exclusivity[i].Exclusivity,
                         exclusivity[i].Description,
                        getFormattedDate(exclusivity[i].Expiry)

                        ]).draw(false);

                    }
                }

            }
            function showSalesInformation(saleInfo)
            {
               
                if ($('#table-sales-info').DataTable().row().count() == 0) {
                    var dt = $('#table-sales-info').DataTable();
                    dt.row.add([
                    (1),
                   saleInfo.CurrentYear,
                   saleInfo.PrevYear,
                   saleInfo.Change

                    ]).draw(false);
                }
            }

            function showGenericAvailabiltyData(generic)
            {
                if ($('#table-generic-availability').DataTable().row().count()<=0) {
                    var genericAvailability =generic.GenericAvailability;
                    var FTFFilingDate = getFormattedDate(generic.FTFfilingDate);
                    var FTFApprovalDate = getFormattedDate(generic.FTFApprovalDate);
                    var FTFLaunchDate = getFormattedDate(generic.FTFLaunchDate);
                    var FTFHolder = "";
                    for (var j = 0; j < generic.FTFHolders.length; j++) {
                        FTFHolder = FTFHolder + generic.FTFHolders[j] + ",";

                    }
                    var GenericPlayers = "";

                    for (var j = 0; j < generic.GenericPlayers.length; j++) {
                        GenericPlayers = GenericPlayers + generic.GenericPlayers[j] + ",";

                    }
                    var AuthorizedGeneric = "";

                    for (var j = 0; j < generic.AuthorisedGenerics.length; j++) {
                        AuthorizedGeneric = AuthorizedGeneric + generic.AuthorisedGenerics[j] + ",";

                    }

                    var dt = $('#table-generic-availability').DataTable();
                    dt.row.add([
                    (1),
                   genericAvailability,
                    FTFFilingDate,
                    FTFApprovalDate,
                    FTFLaunchDate,
                    FTFHolder,
                   GenericPlayers,
                   AuthorizedGeneric
                    ]).draw(false);

                }
              
             
            }

            $(window).bind("load", function () {
              
                $('#tablist li a').attr('onclick', 'return false');
                $('#forhiddarea').css('display', 'none');

                });
       
           
            $(document).ready(function () {
             
                $('.activateLink').click(function (e) {
                   
                    $('#tablist li a').removeAttr('onclick');
                    $('#forhiddarea').css('display', 'block');

                  
                });
              

                    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                        $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
                    });

                    $('#table-key-info').DataTable({
                        
                       
                    });

                    // Apply a search to the second table for the demo
                    // $('#myTable2').DataTable().search('New York').draw();
                    $('#table-product-info').DataTable();
                    $('#table-generic-availability').DataTable();
                    $('#table-api-info').DataTable();
                    $('#table-patent-info').DataTable();
                    $('#table-exclusivity-info').DataTable();
                    $('#table-regulatory-strategy').DataTable();
                    $('#table-sales-info').DataTable();
                    //$('#table-price').DataTable();
                   
                    removeSection = function (e) {
                        $(e).parents(".section").remove();
                        $('[data-spy="scroll"]').each(function () {
                            var $spy = $(this).scrollspy("refresh");
                        });
                    }
                    $(".scroll-area").scrollspy({ target: "#myNavbar" });
                    $("#myNavbar").on("activate.bs.scrollspy", function () {
                        var currentItem = $(".nav li.active > a").text();
                        $("#info").empty().html("Currently you are viewing - " + currentItem);
                    })

                });
           
        </script>
     <!-- Nav tabs -->
    <%--<ul class="nav nav-tabs" role="tablist" id="tablist">
        <li role="presentation" class="active"><a href="#key-info" aria-controls="example1-tab1" role="tab" data-toggle="tab">Key Information</a></li>
        <li role="presentation"><a href="#product-info" aria-controls="example1-tab2" role="tab" data-toggle="tab">Product Information</a></li>
        <li role="presentation"><a href="#generic-availability" aria-controls="example1-tab2" role="tab" data-toggle="tab">Generic Availability</a></li>
        <li role="presentation"><a href="#api-info" aria-controls="example1-tab2" role="tab" data-toggle="tab">API Information</a></li>
        <li role="presentation"><a href="#exclusivity-info" aria-controls="example1-tab2" role="tab" data-toggle="tab">Exclusivity Info.</a></li>
        <li role="presentation"><a href="#patent-info" aria-controls="example1-tab2" role="tab" data-toggle="tab">Patent Info.</a></li>
        <li role="presentation"><a href="#regulatory-strategy" aria-controls="example1-tab2" role="tab" data-toggle="tab">Regulatory Strategy</a></li>
        <li role="presentation"><a href="#sales-info" aria-controls="example1-tab2" role="tab" data-toggle="tab">Sales Information</a></li>
        <li role="presentation"><a href="#price" aria-controls="example1-tab2" role="tab" data-toggle="tab">Price</a></li>
    </ul>--%>
       
       <div id="mainDiv">
        <nav id="myNavbar" class="navbar navbar-default" role="navigation"> 
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#patentNav"> 
                <span class="sr-only">Toggle navigation</span> 
                <span class="icon-bar"></span> 
                <span class="icon-bar"></span> 
                <span class="icon-bar"></span> 
            </button>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse " id="patentNav">
        <ul class="nav navbar-nav nav-tabs" role="tablist" id="tablist">
        <li role="presentation" class="active"><a href="#key-info">Summary</a></li>
        <li role="presentation" class="deactivate"><a href="#product-info" onclick="return false;">Product Information</a></li>
        <li role="presentation" class="deactivate"><a href="#generic-availability"  onclick="return false;">Generic Availability</a></li>
        <li role="presentation" class="deactivate"><a href="#api-info" onclick="return false;">API Information</a></li>
        <li role="presentation" class="deactivate"><a href="#exclusivity-info" onclick="return false;">Exclusivity Info.</a></li>
        <li role="presentation" class="deactivate"><a href="#patent-info" onclick="return false;">Patent Info.</a></li>
        <li role="presentation" class="deactivate"><a href="#regulatory-strategy" onclick="return false;">Regulatory Strategy</a></li>
        <li role="presentation" class="deactivate"><a href="#sales-info" onclick="return false;">Sales Information</a></li>
<%--        <li role="presentation"><a href="#price" >Price</a></li>--%>
            </ul>
        </div>
    </nav>
            <div class="scroll-area" data-spy="scroll" data-offset="0" id="drugsid">
    	<div class="section">
            
            <div role="tabpanel" class="tab-pane  in active" id="key-info">
                <h2>Summary:</h2>

            <table id="table-key-info" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>S.No.</th>
                        <th>Brand</th>
                        <th>Generic Name</th>
                        <th>Company</th>
                        <th>NCE Exclusivity Expiry</th>
                        <th>Earliest Product(Compound) Patent Expiry</th>
                         <th>Count of Available Generics</th>
                         <th>No. of Orange Book listed Patents</th>
                        <th>Count of active USDMF Holders</th>
                    </tr>
                </thead>
                <tbody>
                     <%

    if (Model.brandList != null)

    {
        var cnt = 0;
        foreach (var item in Model.brandList)
        { %>
                        <tr id="'<%="patentrow" + cnt%>'" InlineId="<%=item.InlineTransId %>">
                        <td class="nummiddle"><%=cnt+1 %></td>
                        <td><a href="#" onclick="getPatentData(this);" class ="activateLink"><%=item.BrandName%></a></td>
                        <td>Aripiprazole</td>
                        <td>Otsuka</td>
                        <td>Expired</td>
                        <td>Expired</td>
                        <td>14</td>
                        <td>10</td>
                        <td>34</td>
                    </tr>

                    <%
                                cnt++;
                            }

                        } %>
                   
                </tbody>
            </table>
        </div>
        </div>
        <hr>
                <div id="forhiddarea">
        <div class="section">
            
            <div role="tabpanel" class="tab-pane " id="product-info">
                <h2>Product Info:</h2>
            <table id="table-product-info" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>S.No.</th>
                        <th>Indication</th>
                        <th>RoA</th>
                        <th>Dosage Form</th>
                        <th>Strength</th>
                        <th>Marketing Status</th>
                         <th>Latest Label Date</th>
                        <th>RLD</th>
                        <th>TE Code</th>
                       
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="nummiddle">1</td>
                        <td>Schizophrenia</td>
                        <td>Oral</td>
                        <td>Tablet</td>
                        <td>2mg/ 5mg/ 10mg/ 15mg/ 20mg/ 30mg</td>
                        <td>Prescription</td>
                        <td class="yearright">23-02-2017</td>
                        <td>Yes</td>
                        <td>AB</td>
                    </tr>
                  <tr>
                        <td class="nummiddle">2</td>
                        <td>Acute Treatment of Manic and Mixed episodes associated with Bipolar Disorder</td>
                        <td>Oral</td>
                        <td>Tablet</td>
                        <td>2mg/ 5mg/ 10mg/ 15mg/ 20mg/ 30mg</td>
                        <td>Prescription</td>
                        <td class="yearright">23-02-2017</td>
                        <td>Yes</td>
                        <td>AB</td>
                    </tr>
                     <tr>
                        <td class="nummiddle">3</td>
                        <td>Adjunctive Treatment of Major Depressive Disorder</td>
                        <td>Oral</td>
                        <td>Tablet</td>
                        <td>2mg/ 5mg/ 10mg/ 15mg/ 20mg/ 30mg</td>
                        <td>Prescription</td>
                        <td class="yearright">23-02-2017</td>
                        <td>Yes</td>
                        <td>AB</td>
                    </tr>
                      <tr>
                        <td class="nummiddle">4</td>
                        <td>Irritability associated with Autisitc Disorder</td>
                        <td>Oral</td>
                        <td>Tablet</td>
                        <td>2mg/ 5mg/ 10mg/ 15mg/ 20mg/ 30mg</td>
                        <td>Prescription</td>
                        <td class="yearright">23-02-2017</td>
                        <td>Yes</td>
                        <td>AB</td>
                    </tr>
                     <tr>
                        <td class="nummiddle">5</td>
                        <td>Treatment of Tourette's Disorder</td>
                        <td>Oral</td>
                        <td>Tablet</td>
                        <td>2mg/ 5mg/ 10mg/ 15mg/ 20mg/ 30mg</td>
                        <td>Prescription</td>
                        <td class="yearright">23-02-2017</td>
                        <td>Yes</td>
                        <td>AB</td>
                    </tr>
                  
                </tbody>
            </table>
        </div>

        </div>
        <hr>
        <div class="section">
            
           <div role="tabpanel" class="tab-pane " id="generic-availability">
               <h2>Generic Availability:</h2>
            <table id="table-generic-availability" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>S.No.</th>
                        <th>Generic Availability</th>
                        <th>FTF filing date</th>
                        <th>FTF Approval Date</th>
                        <th>FTF Launch Date</th>
                        <th>FTF Holder</th>
                        <th>Generic Players</th>
                        <th>Authorized Generic</th>
                        
                    </tr>
                </thead>
                <tbody>
                     
                </tbody>
            </table> 
        </div> 
    </div>
        <hr>
        <div class="section">
           
                    <div role="tabpanel" class="tab-pane" id="api-info">
                         <h2>API Info:</h2>
                        <table id="table-api-info" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>S.No.</th>
                                    <th>Molecule Name</th>
                                    <th>Submission Date</th>
                                    <th>DMF Holder Name</th>
                                    <th>DMF Status</th>
                                    <th>ANDA Holder against the filed DMF</th>
                                    <th>Organization commercializes finished products in US</th>

                                </tr>
                            </thead>
                            <tbody>
                               <%-- <tr>
                                    <td class="nummiddle">1</td>
                                    <td>Aripiprazole</td>
                                    <td class="yearright">12/30/2016</td>
                                    <td>MYLAN LABORATORIES LTD</td>
                                    <td>Active</td>
                                    <td>No</td>
                                    <td>Yes</td>
                                </tr>
                                 <tr>
                                    <td class="nummiddle">2</td>
                                    <td>Aripiprazole</td>
                                    <td class="yearright">9/28/2016</td>
                                    <td>HEC PHARM CO LTD</td>
                                    <td>Active</td>
                                    <td>No</td>
                                    <td>No</td>
                                </tr>
                                 <tr>
                                    <td class="nummiddle">3</td>
                                    <td>Aripiprazole</td>
                                    <td class="yearright">12/14/2015</td>
                                    <td>ZCL CHEMICALS LTD</td>
                                    <td>Active</td>
                                    <td>No</td>
                                    <td>No</td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
        <hr>
        <div class="section">
                    <div role="tabpanel" class="tab-pane " id="exclusivity-info">
                         <h2>Exclusivity Info:</h2>
                        <table id="table-exclusivity-info" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>S.No.</th>
                                    <th>Exclusivity</th>
                                    <th>Description</th>
                                    <th>Expiry</th>
                                
                                </tr>
                            </thead>
                            <tbody>
                                <%--<tr>
                                    <td class="nummiddle">1</td>
                                    <td>ODE</td>
                                    <td>Orphan Drug Exclusivity</td>
                                    <td class="yearright">12-12-2021</td>
                                </tr>
                                 <tr>
                                    <td class="nummiddle">2</td>
                                    <td>M-137 </td>
                                    <td>Labeling Revisions Resulting From A Maintenance Trial In Pediatric Patients With Irritability Associated With Autistic Disorder</td>
                                    <td class="yearright">09-06-2017</td>
                                </tr>
                                 <tr>
                                    <td class="nummiddle">3</td>
                                    <td>I-700</td>
                                    <td>Treatment Of Pediatric Patients With Tourette'S Disorder (6-18 Years)</td>
                                    <td class="yearright">12-12-2017</td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
        <hr>
        <div class="section">
          
                    <div role="tabpanel" class="tab-pane " id="patent-info">
                          <h2>Patent Info:</h2>
                        <table id="table-patent-info" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>S.No.</th>
                                    <th>Patent No.</th>
                                    <th>Type of Patent</th>
                                    <th>Patent Use Code</th>
                                    <th>Expiry</th>
                                  <th>PTE Granted</th>
                                    <th>Independent Claims</th>
                                    <th>Delist Requested</th>
                                    <th>Patent Licensing Info</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="nummiddle">1</td>
                                    <td>US7053092</td>
                                    <td>MOU</td>
                                    <td>Treatment of Major Depressive Disorder</td>
                                    <td class="yearright">28-01-2022</td>
                                    <td>No</td>
                                    <td>1. A method of treating a patient suffering from a disorder of the central nervous system associated with 5-HT.sub.1A receptor subtype wherein the disorder is depression selected from the group consisting of endogenous depression, major depression, melancholia and treatment resistant depression, which comprises administering to said patient a therapeutically effective amount of a carbostyril compound of formula (1), or a pharmaceutically acceptable salt or solvate thereof, wherein said patient is a mammal: ##STR00003## wherein the carbon-carbon bond between 3- and 4- positions in the carbostyril skeleton is a single or a double bond.</td>
                                    <td>No</td>
                                    <td>No information</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
        <hr>        
        <div class="section">
           
                    <div role="tabpanel" class="tab-pane " id="regulatory-strategy">
                         <h2>Regulatory Strategy:</h2>
                        <table id="table-regulatory-strategy" class="display"  cellspacing="0" width="100%">
                             <thead>
                                <tr>
                                     <th rowspan="2">S.No.</th>
                                    <th rowspan="2">Patent No.</th>
                                    <th rowspan="2">Type of Patent</th>
                                    <th rowspan="2">Expiry</th>
                                    <th colspan="3" style="text-align:left;"><div class="ddl-select input-group-btn ">
                        <select class="selectpicker form-control search-filter select-dropdown selectBox kmBox2" id="compare-filter-dropdown" >
                            <option selected="selected" value="drug-name">Aportex</option>
                            <option value="DiseaArea">Company 3</option>
                            <option value="Molecule">Company 4</option>
                            <option value="Molecule">Company 5</option>
                            <option value="Molecule">Company 6</option>
                        </select>
                    </div></th>
                                    <th colspan="3" style="text-align:left;">

                                        <div class="ddl-select input-group-btn ">
                        <select class="selectpicker form-control search-filter select-dropdown selectBox kmBox2" id="compare-filter-dropdown" >
                            <option selected="selected" value="drug-name">Company2</option>
                            <option value="DiseaArea">Company 6</option>
                            <option value="Molecule">Company 7</option>
                            <option value="Molecule">Company 8</option>
                            <option value="Molecule">Company 9</option>
                        </select>
                    </div>
                                    </th>
                                   
                                </tr>
                                 <tr>
                                    <th>505(j)/505(B2)</th>
                                    <th>P-IV/P-III</th>
                                    <th>P-IV Strategy</th>
                                    <th>505(j)/505(B2</th>
                                    <th>P-IV/P-III</th>
                                     <th>P-IV Strategy</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>US7053092</td>
                                    <td>MOU</td>
                                    <td class="yearright">28-01-2022</td>
                                    <td>505(j)</td>
                                    <td>P-IV</td>
                                    <td>Section viii</td>
                                    <td>NA</td>
                                    <td>NA</td>
                                    <td>NA</td>
                                   
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>US8017615</td>
                                    <td>Formulation</td>
                                    <td  class="yearright">16-06-2024</td>
                                    <td>505(j)</td>
                                    <td>P-IV</td>
                                    <td>Invalidity</td>
                                    <td>NA</td>
                                    <td>NA</td>
                                    <td>NA</td>
                                   
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>US8580796</td>
                                    <td>Polymorph</td>
                                    <td  class="yearright">25-09-2022</td>
                                    <td>505(j)</td>
                                    <td>P-IV</td>
                                    <td>Invalidity</td>
                                    <td>NA</td>
                                    <td>NA</td>
                                    <td>NA</td>
                                   
                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td>US8642600</td>
                                    <td>MOU</td>
                                    <td  class="yearright">28-01-2022</td>
                                    <td>505(j)</td>
                                    <td>P-IV</td>
                                    <td>Section viii</td>
                                    <td>NA</td>
                                    <td>NA</td>
                                    <td>NA</td>
                                   
                                </tr>
                                <tr>
                                    <td>5</td>
                                    <td>US8642760</td>
                                    <td>Polymorph</td>
                                    <td  class="yearright">25-09-2022</td>
                                    <td>505(j)</td>
                                    <td>P-IV</td>
                                    <td>Invalidity</td>
                                    <td>NA</td>
                                    <td>NA</td>
                                    <td>NA</td>
                                   
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
        <hr>        
        <div class="section">
            
                    <div role="tabpanel" class="tab-pane " id="sales-info">
                        <h2>Sales Info:</h2>
                        <table id="table-sales-info" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                     <th>S.No.</th>
                                    <th>Current Year($)</th>
                                    <th>Previous Year($)</th>
                                    <th>%Change</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%--<tr>
                                    <td class="nummiddle">1</td>
                                    <td class="nummiddle">90</td>
                                    <td class="nummiddle">80</td>
                                    <td class="nummiddle">15</td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
                    </div>
                
       <%-- <div class="section">
           
                    <div role="tabpanel" class="tab-pane " id="price">
                         <h2>Price</h2>
                        <table id="table-price" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                     <th>S.No.</th>
                                    <th>Dosage Form</th>
                                    <th>RoA</th>
                                    <th>Strength</th>
                                  <th>No. of Units</th>
                                    <th>Price (CVS Pharmacy)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Tablet</td>
                                    <td>Oral</td>
                                    <td>2mg</td>
                                    <td>30 Tabs</td>
                                    <td>$941.71</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Tablet</td>
                                    <td>Oral</td>
                                    <td>5mg</td>
                                    <td>30 Tabs</td>
                                    <td>$941.71</td>
                                </tr>
                                 <tr>
                                    <td>3</td>
                                    <td>Tablet</td>
                                    <td>Oral</td>
                                    <td>10mg</td>
                                    <td>30 Tabs</td>
                                    <td>$941.71</td>
                                </tr>
                                 <tr>
                                    <td>4</td>
                                    <td>Tablet</td>
                                    <td>Oral</td>
                                    <td>15mg</td>
                                    <td>30 Tabs</td>
                                    <td>$941.71</td>
                                </tr>
                                <tr>
                                    <td>5</td>
                                    <td>Tablet</td>
                                    <td>Oral</td>
                                    <td>20mg</td>
                                    <td>30 Tabs</td>
                                    <td>$1,327.35</td>
                                </tr>
                                 <tr>
                                    <td>5</td>
                                    <td>Tablet</td>
                                    <td>Oral</td>
                                    <td>30mg</td>
                                    <td>30 Tabs</td>
                                    <td>$1,327.35</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>--%>
        
<%--    <h4 id="info" class="text-info">Currently you are viewing - Section 1</h4>--%>
</div>
        </div>
    <!-- Tab panes -->
  <%--  <div class="tab-content">
        <div role="tabpanel" class="tab-pane  in active" id="key-info">
            <table id="table-key-info" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Position</th>
                        <th>Office</th>
                        <th>Age</th>
                        <th>Start date</th>
                        <th>Salary</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Tiger Nixon</td>
                        <td>System Architect</td>
                        <td>Edinburgh</td>
                        <td>61</td>
                        <td>2011/04/25</td>
                        <td>$320,800</td>
                    </tr>
                    <tr>
                        <td>Garrett Winters</td>
                        <td>Accountant</td>
                        <td>Tokyo</td>
                        <td>63</td>
                        <td>2011/07/25</td>
                        <td>$170,750</td>
                    </tr>
                    <tr>
                        <td>Ashton Cox</td>
                        <td>Junior Technical Author</td>
                        <td>San Francisco</td>
                        <td>66</td>
                        <td>2009/01/12</td>
                        <td>$86,000</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div role="tabpanel" class="tab-pane " id="product-info">
            <table id="table-product-info" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Position</th>
                        <th>Office</th>
                        <th>Age</th>
                        <th>Start date</th>
                        <th>Salary</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Bradley Greer</td>
                        <td>Software Engineer</td>
                        <td>London</td>
                        <td>41</td>
                        <td>2012/10/13</td>
                        <td>$132,000</td>
                    </tr>
                    <tr>
                        <td>Dai Rios</td>
                        <td>Personnel Lead</td>
                        <td>Edinburgh</td>
                        <td>35</td>
                        <td>2012/09/26</td>
                        <td>$217,500</td>
                    </tr>
                    <tr>
                        <td>Jenette Caldwell</td>
                        <td>Development Lead</td>
                        <td>New York</td>
                        <td>30</td>
                        <td>2012/09/26</td>
                        <td>$217,500</td>
                     </tr>
                    <tr>
                            <td>Jenette Caldwell</td>
                        <td>Development Lead</td>
                        <td>New York</td>
                        <td>30</td>
                        <td>2011/09/03</td>
                        <td>$345,000</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>--%>
         
    </div>
<script>
    $(window).bind("load", function() {
        // code here
    
       // alert('hello');

        $('#searchbar .selectBox').click(function () {
            //alert('hello');
            if ($('#searchbar .select-dropdown').hasClass('open')) {
                $('#mainDiv').css("z-index", "0");
                $('#drugsid').css("z-index", "0");
                $('#myNavbar').css("z-index", "0");
            }
            else {
                $('#mainDiv').css("z-index", "-1");
                $('#drugsid').css("z-index", "-1");
                $('#myNavbar').css("z-index", "-1");
            }
        });
        //This is for visible dtatable searchbox after dropdown select
        $(document).on('click', function (e) {
            if (!$('#searchbar div.select-dropdown').hasClass('open')) {
                $('#mainDiv').css("z-index", "0");
                $('#drugsid').css("z-index", "0");
                $('#myNavbar').css("z-index", "0");
            }
        });
    });
</script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
