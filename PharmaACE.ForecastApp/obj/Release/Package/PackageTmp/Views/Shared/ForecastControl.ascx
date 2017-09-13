<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<PharmaACE.ForecastApp.Models.ForecastEntity>" %>
<div class="tab-content">
    <div class="tab-pane fade active in" id="dropdown1">
        <div id="versionmsg" style="display: none;">
            <div>
                <h2 class="inherit-fc vcoment blink" style="font-size: 18px; margin: 0px; padding: 0px; margin-bottom: 6px; text-align: center; color: #999999 ;display:none;"> version</h2>
                <p style="display:none;" class="tollp">Comments are not availiable.</p>
            </div>
        </div>
        <div id="eDraw" class="eDraw">
            <object classid="clsid:367AD645-0381-4750-9B15-741067C2A118" id="OA1" codebase="https://forecastecosystem.azurewebsites.net/redist/x86/edexcel.cab#version=8,0,0,651" style="position: absolute; z-index: 2; ">
                <param name="Toolbars" value="-1">
                <param name="LicenseName" value="Halseeon6800972102">
                <param name="LicenseCode" value="EDE8-555D-1202-ABF3">
                <param name="BorderColor" value="15647136">
                <param name="BorderStyle" value="2">
                <param name="wmode" value="opaque">
            </object>
        </div>
    </div>
</div>


<div id="creatNewForecast" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" >×</button>
                <h4 class="modal-title">Create New Forecast</h4>
            </div>
            
                <form role="form" id="generic_forecast_creator">
                    <div class="modal-body">
              

                        <div id="wizard" class="form_wizard wizard_horizontal">
                    <ul class="wizard_steps">
                      <li>
                        <a href="#step-1">
                          <span class="step_no">1</span>
                          <span class="step_descr">
                                            Step 1<br />
                                            <small>Projects</small>
                                        </span>
                        </a>
                      </li>
                      <li>
                        <a href="#step-2">
                          <span class="step_no">2</span>
                          <span class="step_descr">
                                            Step 2<br />
                                            <small>Scenario</small>
                                        </span>
                        </a>
                      </li>
                      <li>
                        <a href="#step-3">
                          <span class="step_no">3</span>
                          <span class="step_descr">
                                            Step 3<br />
                                            <small>Products</small>
                                        </span>
                        </a>
                      </li>
                     <%-- <li>
                        <a href="#step-4">
                          <span class="step_no">4</span>
                          <span class="step_descr">
                                            Step 4<br />
                                            <small>SKU</small>
                                        </span>
                        </a>
                      </li>--%>
                    </ul>
                    <div id="step-1">
                      <form class="form-horizontal">

                        

                          <div class="form-group">
                                <div class=""><label class="control-label col-md-12 col-sm-12 col-xs-12 no-padding-left">Project Name</label> </div>                     
                                
                                    <div class="col-md-12 col-sm-12 col-xs-12 no-padding-left">
                                        <div class="col-md-6 col-sm-6  no-padding-left">
                                       
                                          <input type="text" id="idProject" required="required" class="form-control col-md-7 col-xs-12">

                                        </div>
                                       
                                    
                                </div>
                            </div>
                       
                      
                        <div class="form-group">                                                                                          
                            <div class="col-md-12 col-sm-12 col-xs-12 no-padding-left">
                                <div class="col-md-4 col-sm-4 col-xs-4 no-padding-left">
                                <label class="control-label col-md-12 col-sm-12 col-xs-12 no-padding-left">Forecast Frequency</label>
                                <div class="col-md-12 col-sm-12 col-xs-12 no-padding-left">
                                    <div id="frequency" class="btn-group" data-toggle="buttons">
                                        <label class="btn btn-default" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                        <input type="radio" name="frequency" value="1"> &nbsp; Monthly &nbsp;
                                        </label>
                                        <label class="btn btn-primary active" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                        <input type="radio" name="frequency" value="2" checked=""> Yearly
                                        </label>
                                    </div>
                                </div>                                  
                                </div>
                                <div class="col-md-4 col-sm-4 col-xs-4 ">                                       
                                    <label class="control-label col-md-12 col-sm-12 col-xs-12 no-padding-left">Category</label>
                                    <div class="col-md-12 col-sm-12 col-xs-12 no-padding-left">
                                    <div id="category" class="btn-group" data-toggle="buttons">
                                        <label class="btn btn-default" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                        <input type="radio" name="category" value="0"> &nbsp; BD&L &nbsp;
                                        </label>
                                        <label class="btn btn-primary active" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                        <input type="radio" name="category" value="1" checked=""> Internal
                                        </label>
                                    </div>
                                </div>                                       
                                </div>
                                <div class="col-md-4 col-sm-4 col-xs-4">                                       
                                        <label class="control-label col-md-12 col-sm-12 col-xs-12 no-padding-left">Data Type</label>
                                     <div class="col-md-12 col-sm-12 col-xs-12 no-padding-left">
                                   <div id="data-type" class="btn-group" data-toggle="buttons">
                              <label class="btn btn-default" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                <input type="radio" name="data-type" value="1"> &nbsp; TRx &nbsp;
                              </label>
                              <label class="btn btn-primary active" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                <input type="radio" name="data-type" value="0" checked=""> Units
                              </label>
                            </div>
                                </div>                                           
                                </div>
                            </div>                               
                           </div>





                          <div class="form-group">
                             <div class=""><label class="control-label col-md-6 col-sm-6 col-xs-6 no-padding-left">Data Availiable From</label> </div>   
                              <div class=""><label class="control-label col-md-6 col-sm-6 col-xs-6 no-padding-left">Data Availiable To</label> </div>                                 
                            
                                   <div class="col-md-12 col-sm-12 col-xs-6 no-padding-left">
                                      <div class="col-md-6 col-sm-6 col-xs-6 no-padding-left">
                                        
                                                <div><input id="datetimepicker1" type="text"></div>
                                             
                                               <%--<div class='input-group date' id='datetimepicker1'>
                                                    <input class="form-control" id="historical_start_date"   type="datetime"  title="Data available from should not be blank" required/>
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>--%>
                                      
                                      </div>
                                       <div class="col-md-6 col-sm-6 col-xs-6 no-padding-left">
                                                <div><input id="datetimepicker" type="text"></div>
                                            
                                           <%--<div class='input-group date' id='datetimepicker'>
                                                <input class="form-control" id="historical_end_date"   type="datetime"  title="Data available to should not be blank" required/>
                                                  <span class="input-group-addon">
                                                     <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                          </div>--%>
                                        </div>
                                    </div>
                            </div>
                   
                           <div class="form-group">
                                <div class=""><label class="control-label col-md-12 col-sm-12 col-xs-12 no-padding-left">Forecast End Year</label> </div>                     
                                
                                    <div class="col-md-12 col-sm-12 col-xs-12 no-padding-left">
                                        <div class="col-md-6 col-sm-6 col-xs-6 no-padding-left"> 
                                                <div><input id="datetimepicker3" type="text"></div>
                                                <%--<div class='input-group date' id='datetimepicker3'>
                                                <input class="form-control" id="forecast_end_year"   type="datetime"  title="Subscription Start Date should not be blank" required/>
                                                  <span class="input-group-addon">
                                                     <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                          </div>--%>
                                        </div>
                                </div>
                            </div>
                      </form>

                    </div>
                    <div id="step-2">
                        <form class="form-horizontal">
                        <div class="form-group">
                            <div class=""><label class="control-label col-md-12 col-sm-12 col-xs-12 no-padding-left">No. of Scenarios</label> </div>                                                    
                                <div class="col-md-12 col-sm-12 col-xs-12 no-padding-left">
                                    <div class="col-md-6 col-sm-6 col-xs-6 no-padding-left">                                  
                                        <select class="form-control search-filter select-dropdown selectBox " id="search-filter-dropdown" >
                                            <option  value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3" selected="selected">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                        </select>
                                    </div>                                   
                            </div>
                        </div>

                        <div class="form-group">
                            <div class=""><label class="control-label col-md-12 col-sm-12 col-xs-12 no-padding-left">Scenarios</label> </div>                                                    
                                <div class="col-md-12 col-sm-12 col-xs-12 no-padding-left">
                                    <div class="col-md-6 col-sm-6 col-xs-6 no-padding-left">                                  
                                        <label class="btn btn-default active" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default" data-toggle="button">
                                        1. Low 
                                        </label>
                                        <label class="btn btn-default" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default" data-toggle="button">
                                         2. Base
                                        </label>
                                        <label class="btn btn-default" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default" data-toggle="button">
                                         3. High
                                        </label>
                                    </div>                                   
                            </div>
                        </div>
                        <div class="form-group">
                        <div class=""><label class="control-label col-md-12 col-sm-12 col-xs-12 no-padding-left">Scenario 4</label> </div>                                                    
                            <div class="col-md-12 col-sm-12 col-xs-12 no-padding-left">
                                <div class="col-md-6 col-sm-6 col-xs-6 no-padding-left">                                       
                                   <input type="text" id="scenario4" required="required" class="form-control col-md-7 col-xs-12">
                                </div>                                    
                        </div>
                        </div>
                        <div class="form-group" id="addscenario5">
                            <div class=""><label class="control-label col-md-12 col-sm-12 col-xs-12 no-padding-left">Scenario 5</label> </div>                                                     
                                <div class="col-md-12 col-sm-12 col-xs-12 no-padding-left">
                                    <div class="col-md-6 col-sm-6 col-xs-6 no-padding-left">                                      
                                          <input type="text" id="scenario5" required="required" class="form-control col-md-7 col-xs-12">
                                    </div>                                    
                                </div>
                            </div>
                             <div class="form-group" id="addscenario6"></div>
                          </form> 
                        <a id="add_scenario" class="pull-left" href="#">
                                    <%--img src="../../Content/img/round_plus.png" alt="Add Scenario" title="Add Scenario"  />--%>
                                        <i class="fa fa-plus-circle gi-3x" aria-hidden="true"></i>
                        </a>
                        </div>
                    <div id="step-3">
                        <form class="form-horizontal">
                       <table class="table table-bordered table-hover" id="tab_product" style="width:100%; ">
				            <thead>
					            <tr >
						            <th class="text-center">
							            #
						            </th>
						            <th class="text-center">
							            Products
						            </th>
						            <th class="text-center">
                                        Brand
							            
						            </th>
						            <th class="text-center">
							            Product Type
                                        <div class="table  table-hover" style="margin-bottom:0px; font-weight:normal;padding-left:0px; padding-right:13px;">
                                            <div class="radchek" style="border-right:1px solid #ddd;">Inline</div><div class="radchek">&nbsp;&nbsp;&nbsp;Pipeline</div>
                                        </div>
						            </th>
                                    <th class="text-center" style="width:12%;">
                                        Forecast at SKU level
							            
						            </th>
                                    <th class="text-center">
							            Projection
                                        <div class="table  table-hover" style="margin-bottom:0px;font-weight:normal;padding-left:0px; padding-right:13px;">
                                            <div class="radchek" style="border-right:1px solid #ddd;">Markets</div><div class="radchek">&nbsp;&nbsp;&nbsp;Compititors</div>
                                        </div>
						            </th>
                                    <th>No. of Compititors</th>
                                    <th>SKU</th>
                                    <th></th>
					            </tr>
				            </thead>
				            <tbody>
					            <tr id='addproduct0'>
						            <td>
						            1
						            </td>
						            <td>
						            <input type="text" name='products0'  placeholder='Products' class="form-control"/>
						            </td>
						            <td>
						            <div class="checkbox">
                                     
                                        <input type="checkbox" class="flat" name="brand">
                                      
                                    </div>
						            </td>
						            <td>
                                        
                                        <div class="table  table-hover" style="margin-bottom:0px;">
                                            <div class="radchek"><input type="radio" class="flat" name="prodInPipeline0" id="prodInline0" value="Inline"  required /></div>
                                            <div class="radchek"><input type="radio" class="flat" name="prodInPipeline0" id="prodPipeline0" value="Pipeline" /></div>
                                        </div>
                                  
						            </td>
                                    <td>
						            <div class="checkbox">
                                     
                                        <input type="checkbox" class="flat" name="skuLevel0">
                                      
                                    </div>
						            </td>
                                    <td>
                                        
                                        <div class="table  table-hover" style="margin-bottom:0px;">
                                            <div class="radchek"><input type="radio" class="flat" name="proj_mar_comp0" id="projection_market0" value="market"   /></div>
                                            <div class="radchek"><input type="radio" class="flat" name="proj_mar_comp0" id="projection_compititors0" value="competitors" /></div>
                                        </div>
                                  
						            </td>
                                    <td>
                                        <select class="selectpicker form-control search-filter select-dropdown selectBox " id="no-of-compititors0" >
                                            <option selected="selected" value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                        </select>
                                    </td>
                                    <td> 
                                        <div class="tooltiproshan" style="text-align: center;">
                                            <a class="inherit-colour">
                                                <div class="sleeve">
                                                        <i class='fa fa-plus'></i>&nbsp;SKU                                                
                                                        <p  id="tollp" class="tollp">
                                                            <input name ='sku0' rel='skus' id='txtallwords0' class='form-control' type='text' value=''  >
                                                        </p>
                                                   
                                                </div>
                                            </a>
                                        </div>

                                    </td>
                                    <td><a class="btn" href="#" onclick="delCurrentRow('addproduct0')" style='color:red'><i class="fa fa-times"></i> </a></td>
					            </tr>
                                <tr id='addproduct1'></tr>
				            </tbody>
			            </table>
                        <a id="add_product" class="pull-left" href="#">
                           <i class="fa fa-plus-circle gi-3x" aria-hidden="true"></i> <%--<img src="../../Content/img/round_plus.png" alt="Add Product" title="Add Product"  />--%></a><%--<a id='delete_product' class="pull-right btn btn-default">Delete Last Product</a>--%>
                        </form>                                                 
                    </div>
                  </div>
                    </div>
                </form>
        </div>
    </div>
    <div id="cloneid" style="display:none;"></div>
</div>



<div id="ProjectParameterModal" class="modal" tabindex="-1">
    <div class="modal-dialog" style="width:300px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="setDefaultValue();" >×</button>
                <h4 class="modal-title" style="font-size:16px;">Project Parameters</h4>
            </div>            
            <div class="modal-body">
                <form role="form">
                    <% if (String.Compare(Model.ModelLocation, "Generics") == 0)
                        { %>
                                    <div class="input-group" style="margin-bottom: 0px; ">
                                        <div class="Hlink" id="divProduct">
                                            <label for="message-text" class="prtcls">Product:</label>
                                            <select id="selectProduct" class="divForecast form-control simport" onchange="onProductUpdate();" style="width: 239px;">
                                                <option value="" selected>Product</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="input-group" style="top: 8px;">
                                        <div class="Hlink" id="divSKU">
                                            <label for="message-text" class="prtcls">SKU:</label>
                                            <select id="selectSKU" class="divVersion form-control simport" onchange="onSKUUpdate();" style="width: 239px;">
                                                <option value="" selected>Sku</option>
                                            </select>
                                        </div>
                                    </div>
                    <% }
    else if (String.Compare(Model.ModelLocation, "BDL") == 0)
    { %>
                    <div class="input-group" style="margin-bottom: 0px; ">
                                        <div class="Hlink" id="divCountry">
                                            <label for="message-text" class="prtcls">Country:</label>
                                            <select id="selectCountry" class="divForecast form-control simport" onchange="onCountryUpdate();" style="width: 239px;">
                                                <option value="" selected>Country</option>
                                            </select>
                                        </div>
                                    </div>

                    <% } %>
                   <% else if (String.Compare(Model.ModelLocation, "Acthar") == 0)
                    { %>


                    <div class="input-group" style="margin-bottom: 0px; ">
                                        <div class="Hlink" id="divIndication">
                                            <label for="message-text" class="prtcls">Indication:</label>
                                            <select id="selectIndication" class="divForecast form-control simport" style="width: 239px;">
                                                <option value="" selected>Indication</option>
                                            </select>
                                        </div>
                                    </div>


                     <% } %>

                     <% if (String.Compare(Model.ModelLocation, "Generics") == 0 || (String.Compare(Model.ModelLocation, "BDL") == 0))
                        { %>
                                    <div class="input-group" style="margin-bottom:0px; top:16px;">
                                        <div class="Hlink" id="divScenario">
                                            <label for="message-text" class="prtcls">Scenario:</label>
                                            <select id="selectScenario" class="divVersion form-control simport" onchange="onScenarioUpdate();" style="width: 239px;">
                                                <option value="" selected>Scenario</option>
                                            </select>
                                        </div>
                                    </div>
                    <% } %>
                </form>
            </div>
            <div class="modal-footer" style="margin-top:15px;">
                <button type="button" class="btn btn-default" id="cancelBtnProjPmtr" data-dismiss="modal" onclick="setDefaultValue();">Cancel</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="projectOk();">OK</button>    
            </div>
        </div>
    </div>
</div>
<div id="saveModal" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" >×</button>
                <h4 class="modal-title">Save Forecast</h4>
            </div>
            <div class="modal-body">
                <form role="form">
                    <div class="form-group">
                        <label for="message-text" class="control-label">Save As:</label>
                            <input type="text" id="saveasdesc" data-toggle="tooltip" title="" placeholder=""  /><br /><br />
                        <input type="radio" class="flat" name="version" value="Default"  id="rbDefaultVersion" />Use Major Version<br />
                        <input type="radio" class="flat" name="version" value="Custom" checked="checked" id="rbCustonVersion" />Use Minor Version<br /><br/>
                        <label for="message-text" class="control-label">Description:</label>
                        <input type="text" class="form-control" id="vDesc" data-toggle="tooltip" title="" />
                       
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveExcel();">Save</button>
                <button id="saveofflinebutton" type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveOfflineByUser();">Save Offline</button>
            </div>
        </div>
    </div>
</div>
 <div  id="loading-indicatorForEdraw" style="text-align: center; top:40%; left:54%; position:absolute;">
                <div style="width:100%"><img src="../../Content/img/ajax-loader.gif" /></div>
                <div id="init_label" style="width:100%">Please wait. Installing components.</div>
  </div>

<div id="OfflineTemplateModal" class="modal" tabindex="-1">
   <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" >×</button>
                <h4 class="modal-title">Upload Template</h4>
            </div>
            <div class="modal-body">
                <form role="form">
                    <div class="row">
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-xs-8 browseclass">
                            <input id="Template_local_path" type="text" class=" " placeholder="" data-toggle="tooltip" title="" readonly>
                        </div>
                        <div class="col-xs-4">
                            <span class="btn btn-default btn-file" style="padding:9px;">Browse File
                                <input id="TemplateUpload" type="file" class="file_writeforTemplate" multiple  accept=".tif,.tiff,.gif,.jpg,.jpeg,.png,.doc,.docx,.pdf,.xls,.xlsb,.xlsm, .xlsx, .csv, .txt, .rtf, .html, .zip, .jpeg, .png,.ppt,.pptx,.bmp,.rar,.htm" />
                            </span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="UploadTemplate" onclick="ClosePopup();">OK</button>
            </div>
        </div>
    </div>
</div>


<div id="attachmentsModal1" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" >×</button>
                <h4 class="modal-title">Upload Files</h4>
            </div>
            <div class="modal-body">
                <form role="form">
                     <div class="col-xs-4">
                            <span class="btn btn-default btn-file" style="padding:9px;">Browse File
                                <%--<input id="file_attachmentSync" type="file" class="file_writeSync" multiple accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>--%>
                                <input id="file_attachmentSync" type="file" class="file_writeSync" multiple accept=".tif,.tiff,.gif,.jpg,.jpeg,.png,.doc,.docx,.pdf,.xls,.xlsb,.xlsm, .xlsx, .csv, .txt, .rtf,.zip, .jpeg, .png,.ppt,.pptx,.bmp,.rar"/>
                            </span>

                        </div>
                    <div class="row">
                   <div class="modal-body">
                    <div class="form-group">
                        <div class="clsPeople" id="">
                            <table id="sync_users_table" data-toggle="table" data-click-to-select="true" class="table table-striped">
                                <thead>
                                    <tr>
                                        <th data-field="state"></th>
                                        <th data-field="name">Select Version</th>
                                        <th data-field="stargazers_count">Files Uploaded</th>

                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>

                        </div>
                    </div>
                 </div>
                       <%-- <div class="col-xs-8 browseclass" id="syncdivid">
                            <input id="attachments_local_pathSync" type="text" class=" " placeholder="" data-toggle="tooltip" title="" readonly>
                        </div>--%>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <span id="lblError1" style="color: red; float: left"></span>
               <%-- <div>
                <label style="float:left;"> Check Across Products:</label>
                <input type="checkbox" class="" id="checkacrossproducts" style="float:left;margin-left:10px;margin-top:3px;"/>
                    </div> --%>
                <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="btnsync" onclick="ClosePopup();">OK</button>
            </div>
        </div>
    </div>
</div>
<div id="imsModal" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" >×</button>
                <h4 class="modal-title">Import Ims Data</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="col-sm-4 col-md-4 col-lg-4 control-label" for="textinput">Project Name</label>
                    <div class="col-sm-8 col-md-8 col-lg-8">
                      <input type="text" placeholder="" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 col-md-4 col-lg-4 control-label" for="textinput">Select Molecules</label>
                    <div class="col-sm-8 col-md-8 col-lg-8">
                      <select id="ims_molecule" class="form-control" multiple="multiple">
                                <option value="cheese">Option 1</option>
                                <option value="tomatoes">Option 2</option>
                                <option value="mozarella">Option 3</option>
                                <option value="mushrooms">Option 4</option>
                                <option value="pepperoni">Option 4</option>
                                <option value="onions">Option 5</option>
                            </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 col-md-4 col-lg-4 control-label" for="textinput">Select Products</label>
                    <div class="col-sm-8 col-md-8 col-lg-8">
                      <select id="ims_product" class="form-control" multiple="multiple">
                                <option value="cheese">Option 1</option>
                                <option value="tomatoes">Option 2</option>
                                <option value="mozarella">Option 3</option>
                                <option value="mushrooms">Option 4</option>
                                <option value="pepperoni">Option 4</option>
                                <option value="onions">Option 5</option>
                            </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 col-md-4 col-lg-4 control-label" for="textinput">Select Sku</label>
                    <div class="col-sm-8 col-md-8 col-lg-8">
                      <select id="ims_sku" class="form-control" multiple="multiple">
                                <option value="cheese">Option 1</option>
                                <option value="tomatoes">Option 2</option>
                                <option value="mozarella">Option 3</option>
                                <option value="mushrooms">Option 4</option>
                                <option value="pepperoni">Option 4</option>
                                <option value="onions">Option 5</option>
                            </select>
                    </div>
                </div>
               <%-- <div role="form">
                    <form class="row">
                        <div class="col-xs-12">
                            
                    <div class="form-group">
                        <label for="message-text" class="control-label">Project Name</label>
                            <input type="text" class="txtVersionName" id="imsPtojectNmae" />
                            <div><select id="import_ims_data" class="form-control" multiple="multiple">
                                <option value="cheese">Option 1</option>
                                <option value="tomatoes">Option 2</option>
                                <option value="mozarella">Option 3</option>
                                <option value="mushrooms">Option 4</option>
                                <option value="pepperoni">Option 4</option>
                                <option value="onions">Option 5</option>
                            </select></div>
                                </div>
                        
                        
                    </div>
                    <br />
                    
                </form>
                    </div>--%>
            </div>
            <div class="modal-footer">
                <span id="lblError2" style="color: red; float: left"></span>
                <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                <button type="button" class="btn btn-primary"  id="" onclick=" ">OK</button>
            </div>
        </div>
    </div>
</div>
<div id="attachmentsModal" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" >×</button>
                <h4 class="modal-title">Select Attachments</h4>
            </div>
            <div class="modal-body">
                <form role="form">
                    <div class="row">
                        <div class="col-xs-12">
                            <select id="attachment_sections" class="form-control" multiple="multiple">
                            </select>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-xs-8 browseclass">
                            <input id="attachments_local_path" type="text" class=" " style="width:128%" placeholder="" data-toggle="tooltip" title="" readonly>
                        </div>
                        <div class="col-xs-4">
                            <span class="btn btn-default btn-file" style="padding:9px;margin-left:42%">Browse
                                <input id="file_attachment" type="file" class="file_write" multiple accept=".tif,.tiff,.gif,.jpg,.jpeg,.png,.doc,.docx,.pdf,.xls,.xlsb,.xlsm, .xlsx, .csv, .txt, .rtf, .html, .zip, .jpeg, .png,.ppt,.pptx,.bmp,.rar,.htm" />
                            </span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <span id="lblError" style="color: red; float: left"></span>
                <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
<%--                <button type="button" class="btn btn-primary" data-dismiss="modal" id="btnUpload" onclick=" updateAttachmentIcons();ClosePopup();">OK</button>--%>
                       <button type="button" class="btn btn-primary" id="btnUpload" onclick=" updateAttachmentIconsWithValidation();">OK</button>

                     </div>
        </div>
    </div>
</div>
<%--<div style="display:none;"><script src="../../Scripts/lib/jquery/jquery-ui.js"></script></div>--%>
<div id="ShareResult"></div>

<div id="copyModal" class="modal" tabindex="-1">
    <div class="modal-dialog" style="width:700px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Copy Forecast</h4>
            </div>
                <form role="form">
                    <div class="modal-body">
                    <div class="form-group">
                        <div class="clsPeople" id="idPeopleNamecopy">
                            <table id="copied_users_table" data-toggle="table" data-click-to-select="true" class="table table-striped">
                                <thead>
                                    <tr id="forecast_cpy">
                                        <th data-field="state" >ForecastName:</th>
                                        <th id="ProjNameid" style = "font-weight:normal;"></th>
                                         <th data-field="state" >CopiedToName:</th>
                                         <th style=""><input type="text" id="copiedtoname" data-toggle="tooltip" style = "font-weight:normal;"/></th>
                                    </tr>
                                    <tr>
                                         <th data-field="name">Versions</th>
                                         <th data-field="Viewonly" style="padding-left:0px;">Check_Version</th>
                                       <%-- <th data-field="Share_All">EnableMinorVersion</th>--%>
                                        <th data-field="Share_All">Versions_Selected</th>
                                        <th>Check_All:</th>
                                        <td style=""><input data-index="1" class="" id="checkallversion" name="btSelectItem" type="checkbox"></td>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                 </div>
                </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                <button id="copydoc" type="button" class="btn btn-primary" data-dismiss="modal" onclick="CopyForecast();">Copy</button>
            </div>
        </div>
    </div>
</div>



<div id="chartModal" class="modal"tabindex="-1">
     <% if (String.Compare(Model.ModelLocation, "Generics") == 0)
                        { %>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClosePopup();">×</button>
                <h4 class="modal-title">Select Charts</h4>
            </div>
                <form role="form">
                    <div class="modal-body">
                    <div class="">
                         <div class=" has-feedback" >
                            <label for="message-text" class="control-label ">Product:</label>
                            <select id="chart_product" class="form-control col-xs-5 " onchange="onProductUpdateForChart();">
                                <option>Not Selected</option>
                            </select>
                        </div>
                        <div class=" has-feedback" style="margin-bottom:15px;">
                            <label for="message-text" class="control-label ">SKU:</label>
                            <select id="chart_sku" class="form-control col-xs-5 ">
                                <option>Not Selected</option>
                            </select>
                        </div>
                        <div class=" has-feedback" >
                            <label for="message-text" class="control-label ">Chart Type:</label>
                            <select id="chart_type" class="form-control col-xs-5">                                
                                <option>Volume</option>
                                <option>Gross Revenue</option>
                                <option>Net Revenue</option>
                                <option>Price</option>
                            </select>
                        </div>
                    </div>
                    <br />
 </div>
                </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateChartSku();ClosePopup();">OK</button>
            </div>
        </div>
    </div>
     <% }
    else if (String.Compare(Model.ModelLocation, "BDL") == 0)
    { %>
                         { %>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClosePopup();">×</button>
                <h4 class="modal-title">Select Charts</h4>
            </div>
                <form role="form">
                    <div class="modal-body">
                    <div class="">
                         <div class=" has-feedback" >
                            <label for="message-text" class="control-label ">Country:</label>
                            <select id="chart_country" class="form-control col-xs-5 ">
                                <option>Not Selected</option>
                            </select>
                        </div>
                        <div class=" has-feedback" style="margin-bottom:15px;">
                            <label for="message-text" class="control-label ">Product:</label>
                            <select id="chart_productbdl" class="form-control col-xs-5 ">
                                <option>Not Selected</option>
                            </select>
                        </div>
                        <div class=" has-feedback" >
                            <label for="message-text" class="control-label ">Parameter:</label>
                            <select id="chart_parameter" class="form-control col-xs-5">                                
                                <option>Patients</option>    
                                <option>Units</option>
                                <option>Gross Revenue</option>
                                <option>Net Revenue</option>
                                <%--<option>Price</option>--%>
                            </select>
                        </div>
                    </div>
                    <br />
 </div>
                </form>
            <div class="modal-footer">
                <label id="waitMessageId" style="text-align:left">Please wait we are processing..</label>&nbsp;&nbsp;&nbsp;&nbsp
                <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
<%--                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateChartBdl(); ClosePopup();">OK</button>--%>
                                <button type="button" class="btn btn-primary" onclick="updateChartBdl(); ">OK</button>
             </div>
        </div>
    </div>
   <% } %>
</div>
<div id="openModal" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClosePopup();">×</button>
                <h4 class="modal-title">Create Consolidator Version</h4>
            </div>
            <div class="modal-body">
                <form role="form">
                    <div class="divClsSelectList" id="divIdSelectList">
                        <label class="ddlblcls" id="ddlblid">Select Consolidator Product List Type</label>
                        <select onchange="getConsolidatorForm(this);" id="ddSelectProductType">
                            <option value="select">--Select--</option>
                            <option value="AllProduct">Consider Latest Version of All Products </option>
                            <option value="SelectedProduct">Consider Latest Version of Selected Products </option>
                            <option value="MySelection">Customize My Selection </option>
                        </select>
                    </div>
                    <div class="divSelectionCls" id="divSelectionId">
                    </div>
                    <br />
                    <br />
                    <div class="divSubmissionCls" id="divSubmissionId">
                        <div>
                            <label class="lblVersionNamecls" id="lblVersionNameId">Version Name</label>
                            <input type="text" class="txtVersionName" id="txtIdVersionName" />
                        </div>
                        <br />
                        <div>
                            <label class="lblVersionDescriptioncls" id="lblVersionDescriptionId">Version Description</label>
                            <textarea rows="3" cols="30" id="txtIdVersionDescription"></textarea>
                        </div>
                        <br />
                        <div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <input type="button" id="btnCreate" style="display: inline-block;" data-dismiss="modal" value="Create" onclick="ClosePopup(); setTimeout(function () { createConsolidator(); }, 1000);" />
                <input type="button" id="btnCreateAndView" style="display: inline-block;" data-dismiss="modal" value="Create And View" onclick="ClosePopup(); setTimeout(function () { viewConsolidator(); }, 1000);" />
            </div>
        </div>
    </div>
</div>

<script language="javascript" for="OA1" event="NotifyCtrlReady">
<!--
    OA1_NotifyCtrlReady();
    //-->
</script>
<script language="javascript" for="OA1" event="IESecurityReminder">
    OA1_IESecurityReminder();
</script>

<%--<script src="../../Scripts/lib/jquery/icheck.min.js"></script>--%>
<%--<script src="../../Scripts/lib/jquery/jquery-ui.js"></script>--%>
