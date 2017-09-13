<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<style>
    .ui-tooltip-content{display:none;}
</style>
<div class="btn-group btn-group-sm" id="SearchABCD">
    <input type="button" class="btn btn-default" id="A" value="A" />
    <input type="button" class="btn btn-default" id="B" value="B" />
    <input type="button" class="btn btn-default" id="C" value="C" />
    <input type="button" class="btn btn-default" id="D" value="D" />
    <input type="button" class="btn btn-default" id="E" value="E" />
    <input type="button" class="btn btn-default" id="F" value="F" />
    <input type="button" class="btn btn-default" id="G" value="G" />
    <input type="button" class="btn btn-default" id="H" value="H" />
    <input type="button" class="btn btn-default" id="I" value="I" />
    <input type="button" class="btn btn-default" id="J" value="J" />
    <input type="button" class="btn btn-default" id="K" value="K" />
    <input type="button" class="btn btn-default" id="L" value="L" />
    <input type="button" class="btn btn-default" id="M" value="M" />
    <input type="button" class="btn btn-default" id="N" value="N" />
    <input type="button" class="btn btn-default" id="O" value="O" />
    <input type="button" class="btn btn-default" id="P" value="P" />
    <input type="button" class="btn btn-default" id="Q" value="Q" />
    <input type="button" class="btn btn-default" id="R" value="R" />
    <input type="button" class="btn btn-default" id="S" value="S" />
    <input type="button" class="btn btn-default" id="T" value="T" />
    <input type="button" class="btn btn-default" id="U" value="U" />
    <input type="button" class="btn btn-default" id="V" value="V" />
    <input type="button" class="btn btn-default" id="W" value="W" />
    <input type="button" class="btn btn-default" id="X" value="X" />
    <input type="button" class="btn btn-default" id="Y" value="Y" />
    <input type="button" class="btn btn-default" id="Z" value="Z" />
</div>
<div class="col-md-12 col-sm-12 col-xs-12" id="kmmainsearch">
    <div class="form-horizontal">
        <form class="navbar-form" role="search" id="searchbar" style="text-align: left;">
            <div class="input-group">
                <div id="search-box" class="col-md-8 col-sm-8 col-xs-12">
                    <div class="col-md-5 col-sm-5 col-xs-5">
                    <div class="ddl-select input-group-btn ">
                        <select class="selectpicker form-control search-filter select-dropdown selectBox kmBox2" id="search-filter-dropdown">
                            <option selected="selected" value="1">By Drug Name</option>
                                <option value="2">By Molecule</option>
                                <option value="3">Pharma Class</option>
                                <option value="4">By Indication</option>
                        </select>
                    </div>
                    </div>
                    <div class="col-md-6 col-sm-5 col-xs-6 ">
                        <div class="ui-widget">
                          
                    <input id="searchInput" style="width:100%;" type="text" class="form-control" placeholder="Enter here" aria-describedby="ddlsearch">
                    </div>
                    </div>
                    <div class="col-md-1 col-sm-1  col-xs-1 ">
                        <div class="input-group-btn">
                        <input id="btnSearch" class="btn btn-default" type="submit" value="" style="background-image: url('../../Content/img/search.jpg'); background-color: #e6e6e6; background-repeat: no-repeat; border-radius: 0px; box-shadow: inset 0px 1px 1px rgba(0,0,0,0.075); white-space: pre-wrap;" />
                        </div>
                    </div>
                </div>
                <div class="input-group-btn col-md-4 col-sm-4 col-xs-12" id="search-type">
                    <label class="checkbox-inline" style ="font-size:14px; margin-left :10px;">
                    <input type="checkbox" id="chkInline" value="Inline" checked="checked">Inline</label>
                    <label class="checkbox-inline" style ="font-size:14px;">
                    <input type="checkbox" id="chkPipeline" value="Pipeline" checked="checked">Pipeline</label>
                </div>
            </div>
        </form>
    </div>
</div>
 <%: Styles.Render( "~/Content/BootstrapselectCSS")  %>
  <%: Scripts.Render("~/Scripts/BootstrapselectScript") %>