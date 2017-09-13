<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<div class="col-md-12 col-sm-12 col-xs-12" id="kmmainsearch">
    <div class="form-horizontal">
        <form class="navbar-form kmBox1" role="search" id="searchbar">
            <div class="input-group">
                <div id="search-box" class="col-md-8 col-sm-8 col-xs-12">
                    <div class="col-md-5 col-sm-5 col-xs-5">
                    <div class="ddl-select input-group-btn ">
                        <select class="selectpicker form-control search-filter select-dropdown selectBox kmBox2" id="search-filter-dropdown">
                            <option selected="selected" value="drug-name">By Drug Name</option>
                            <option value="DiseaArea">By Disease Area</option>
                            <option value="Molecule">By Molecule</option>
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
                <div class="input-group-btn col-md-4 col-sm-4 col-xs-12" id="search-type">
                    <label class="checkbox-inline kmBox3">
                    <input type="checkbox" id="chkInline" value="Inline" checked="checked">Inline</label>
                    <label class="checkbox-inline kmBox4" >
                    <input type="checkbox" id="chkPipeline" value="Pipeline" checked="checked">Pipeline</label>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
$(document).ready(function () {
          
          $("#flyerInnerbox").niceScroll({
              cursorfixedheight: 70
          });
      });
  </script>
   <style type="text/css">
/*
    #tab-scroller #botbar {
 overflow: auto;
 height: 280px;
}
*/
</style>
 <%--   <link href="../../Content/CSS/bootstrap-select.min.css" rel="stylesheet" />
<script src="../../Scripts/lib/bootstrap/bootstrap-select.min.js" defer></script>--%>
 <%: Styles.Render( "~/Content/BootstrapselectCSS")  %>
  <%: Scripts.Render("~/Scripts/BootstrapselectScript") %>
 