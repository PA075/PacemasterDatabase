<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Company Profile Overview
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">  
   <style>
       .thClass {vertical-align:middle !important;}

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
       <div class="row">
        <div class="col-xs-6 col-sm-3">
<%--          <p style="font-weight:bold;">Mallinckrodt</p>--%>
            <p style="margin:0px; padding:0px; text-align:center; vertical-align:middle;">
                <a href="#"><img src="../../Content/img/malinckrodt.png" alt="Mallinckrodt" title="Mallinckrodt" /></a></p>               
        </div>
        <div class="col-xs-6 col-sm-3">
            <div style="font-weight:bold;">Principal Executive Office</div>
            <div>Mallinckrodt plc 3 Lotus Park</div>
            <div>The Causeway Staines-Upon-Thames,</div> 
            <div>Surrey TW18 3AG </div>
            <div>United Kingdom</div>
        </div>

        <!-- Add the extra clearfix for only the required viewport -->
        <div class="clearfix visible-xs"></div>

        <div class="col-xs-6 col-sm-3"><div style="font-weight:bold;">Global External Manufacturing Operations</div>
            <div>College Business & Technology Park Cruiserath, Blanchardstown, </div><div>Dublin 15 Ireland</div>
</div>
        <div class="col-xs-6 col-sm-3">
            <div style="font-weight:bold;">U.S. Headquarters</div>
            <div>675 McDonnell Blvd.</div>
            <div> St. Louis,</div>
            <div> MO 63042 USA</div>
        </div>
      </div>

        <div class="row" >
        <div class="col-xs-12 col-sm-6 col-md-6" style="margin-top:15px;">
         
               <div class="row">
               
                <div class="col-xs-12 col-sm-6 col-md-6" style="padding-right:0px;">
                     <div class="form-inline" style="width:100%;">
                         <div class="form-group" style="width:100%;">
                            <label for="email">Employees:</label>
                            <input type="text" class="form-control"  value="Total - 5,700 |US - 4,400" style="display:inline-block; width:160px; padding:2px; margin-left:22px;">
                         </div>
                    </div> 
                    <div class="form-inline" style="margin-top:10px;">
                        <div class="form-group">
                            <label for="email">Market Capital:</label>
                            <input type="Text" class="form-control"  value="$7500 M" style="display:inline-block; padding:2px; width:160px;">
                        </div>
                       </div>   
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6" style="padding-left:0px;">
                    <div class="form-inline">
                        <div class="form-group">
                            <label for="email">Stock Price:</label>
                            <input type="Text" class="form-control"  value="150,422.00/1.79M" style="display:inline-block; padding:2px;width:141px;">
                        </div>
                       </div>
                     <div class="form-inline" style="margin-top:10px;">
                        <div class="form-group">
                            <label for="email">Vol/Avg:</label>
                            <input type="Text" class="form-control"  value="150,422.00/1.79M" style="display:inline-block; padding:2px; margin-left:26px; width:141px;">
                        </div>
                       </div>

                </div>




        </div>
            </div>      
        </div>
        <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12" style="text-align:center;">
            <img src="../../Content/img/Contactgraph.png" style="margin-bottom:15px; margin-top:15px;" />
        </div>
            </div>
        <table class="table  table-bordered table-condensed table-striped"> 
            <thead> 
               </thead> 
            <tbody> 
                 <tr> 
                    <th style="width:20%;" class="thClass">Revenues(million $)</th>
                    <th class="thClass">
                        <table class="table  table-striped " style="margin-bottom:0px;">
                            <tr>
                                <td>2016</td>
                                <td>2015</td>
                                <td>2014</td>
                                <td>2013</td>
                                <td>Growth</td>
                            </tr>
                            <tr>
                                <td>3,380.80</td>
                                <td>3,346.90</td>
                                <td>2,082</td>
                                <td>1,712.3</td>
                                <td>1.01%</td>
                            </tr>


                        </table>
                    </th> 

                </tr> 
                <tr> 
                    <th class="thClass">Company Overviews</th> 
                    <td>A global specialty biopharmaceutical and nuclear imaging business that develops, manufactures, markets and distributes specialty pharmaceutical and biopharmaceutical products and nuclear imaging agents.</td> 

                </tr> 
                <tr> <th class="thClass">Management Details</th> 
                    <td>|Mark Trudeau - President, CEO and Director |Matthew Harbaugh - Senior VP and CFO |Gary Phillips - Executive VP and Chief Strategy Officer</td> 

                </tr> 
                <tr> <th class="thClass">Therapeutic Area of Focus</th> 
                    <td>Therapeutic areas of focus include autoimmune and rare disease specialty areas (including neurology, rheumatology, nephrology, ophthalmology and pulmonology); immunotherapy and neonatal critical care respiratory therapies; analgesics and hemostasis products; and central nervous system drugs</td> 

                </tr>
                <tr> <th class="thClass">Business Segment</th> 
                    <td>Specialty Brand-produces and markets branded pharmaceutical products and therapies
Specialty Generics -produces and markets specialty generic pharmaceuticals and active pharmaceutical ingredients ("API") consisting of biologics, medicinal opioids, synthetic controlled substances, acetaminophen and other active ingredients.</td> 

                </tr>
                <tr> <th  class="thClass">Regional Segment</th> 
                    <td>US | EMEA | Others</td> 

                </tr>
                <tr> 
                    <th style="width:20%;" class="thClass">Key Marketed Products</th>
                    <td style="padding:0px;">
                        <table class="table  table-striped table-bordered table-condensed"  style="margin-bottom:0px; border-collapse:collapse;">
                            <tr>
                                <th></th>
                                <th>2016</th>
                                <th>2015</th>                              
                                <th>Growth</th>
                            </tr>
                            <tr>
                                <td>Acthar: It is an Injectable drug used for the treatment of proteinuria in nephrotic syndrome of the idiopathic type ("NS");acute exacerbations of multiple sclerosis ("MS") in adults;  infantile spasms ("IS") in infants and children under two years of age;  pulmonology indication of sarcoidosis; ophthalmic conditions related to severe acute and chronic allergic and inflammatory processes; and certain rheumatology-related conditions, including rare and closely related neuromuscular disorders, dermatomyositis and polymyositis</td>
                                <td>$1160.4</td>
                                <td>$.3</td>                              
                                <td>11.86</td>
                            </tr>
                            <tr>
                                <td>Offirmev: It is a proprietary intravenous formulation of acetaminophen indicated for the management of mild to moderate pain, the management of moderate to severe pain with adjunctive opioid analgesics and the reduction of fever.</td>
                                <td>$284.3</td>
                                <td>$.0</td>                              
                                <td>8.09</td>
                            </tr>
                            <tr>
                                <td>Inomax:is a vasodilator that, in conjunction with ventilatory support and other appropriate agents, is indicated to improve oxygenation and reduce the need for extracorporeal membrane oxygenation in term and near-term (>34 weeks) neonates with hypoxic respiratory failure ("HRF") associated with clinical or echocardiographic evidence of pulmonary hypertension.</td>
                                <td>$474.3</td>
                                <td>$185.2</td>                              
                                <td>156.1</td>
                            </tr>
                            <tr>
                                <td>Therakos:It is an immunotherapy Drug.</td>
                                <td>$207.6</td>
                                <td>NA</td>                              
                                <td>NA</td>
                            </tr>


                        </table>
                    </td> 

                </tr> 
                <tr> <th class="thClass">Product Exclusivity</th> 
                    <td>Exalgo - Exclusivity expired in May 2014
Acthar - currently approved indications of Acthar are not subject to patent or other exclusivity, with the exception of IS which was granted orphan drug status from the FDA upon its approval in October 2010 
Ofirmev  - Protected by two patents that expire in August 2017 and June 2021 and company has the potential to obtain an additional six months of exclusivity for each patent if the FDA grants pediatric exclusivity. Settlement agreements have been reached in association with certain challenges to these patents, which allow for generic competition to Ofirmev in December 2020, or earlier under certain circumstances
</td> 

                </tr> 
                <tr> <th class="thClass">Strategy</th> 
                    <td>Company's long-term strategy in Specialty Brands  is 
To increase patient access and appropriate utilization of their existing products,
Develop new and follow-on formulations for recently acquired products, 
Advance pipeline products and bring them to market and selectively acquire or license products that are strategically aligned with their product portfolio to expand the size and profitability of the segment
</td> 

                </tr> 
                <tr> <th class="thClass">Competition Details</th> 
                    <td>Specialty Brands - No Direct Competition | Specialty Generics - Allergan, Inc. (formerly Actavis, Inc.), Endo Health Solutions Inc., Johnson & Johnson (including its Noramco, Inc. subsidiary), Johnson Matthey plc, Mylan N.V., Pfizer Inc., Purdue Pharma L.P. and Teva Pharmaceutical Industries Ltd.
</td> 

                </tr> 
                <tr> <th class="thClass">Distribution Model</th> 
                    <td>Maintain distribution centers in 18 countries. In addition, in certain countries outside the U.S, utilize third-party distribution centers. Products generally are delivered to these distribution centers from company's manufacturing facilities and then subsequently delivered to the customer. In some instances, product, such as nuclear medicine, is delivered directly from manufacturing facility to the customer. Contract with a wide range of transport providers to deliver products by road, rail, sea and air
</td> 

                </tr> 
                <tr> <th class="thClass">Mergers and Acquisition</th> 
                    <td>In March 2014, the company acquired Cadence, a pharmaceutical company focused on commercializing products principally for use in the hospital setting for approximately $1.3 billion 
 In April 2015, the acquired Ikaria through the acquisition of all the outstanding common stock of Compound Holdings II, Inc.
In August 2014, they acquired Questcor, a pharmaceutical company, for total consideration of approximately $5.9.million
In September 2015, they acquired Therakos, through the acquisition of all the outstanding common stock of TGG Medical Solutions, Inc., the parent holding company of Therakos
In February 2016,  the company acquired three commercial stage topical hemostasis drugs from The Medicines Company ("the Hemostasis Acquisition") - RECOTHROM® Thrombin topical (Recombinant), PreveLeakTM Surgical Sealant, and RAPLIXATM (Fibrin Sealant
(Human)) - for upfront consideration of $173.5 million
</td> 

                </tr> 
                <tr> <th class="thClass">Agreements and Collaborations</th> 
                    <td> On August 24, 2016, the company announced that they had entered into a definitive agreement to sell their Nuclear Imaging business to IBA Molecular ("IBAM"), which is expected to be completed during the first half of calendar 2017.
</td> 

                </tr> 

            </tbody> </table>
    </div>
</asp:Content>

