<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

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
<form class="navbar-form" role="search" id="searchbar">
    <div class="input-group" >
        <div class="ddl-select input-group-btn">
        <select class="selectpicker form-control search-filter select-dropdown selectBox kmBox18" id="search-filter-dropdown" >
            <option selected="selected" value="1">By Company Name</option>
        </select>
        </div>
        <input id="searchInput" class="form-control" placeholder="Search" name="q" type="text" >
        <div class="input-group-btn" style="vertical-align: top;">
            <input id="btnSearch" class="btn btn-default" type="submit" value="" style="background-image: url('../../Content/img/search.png'); background-color: #e6e6e6; background-repeat: no-repeat; border-radius: 0px; box-shadow: inset 0px 1px 1px rgba(0,0,0,0.075); white-space: pre-wrap;" />
        </div>
    </div>
     <%: Styles.Render( "~/Content/BootstrapselectCSS")  %>
  <%: Scripts.Render("~/Scripts/BootstrapselectScript") %>
</form>
