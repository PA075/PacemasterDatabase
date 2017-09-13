$(document).ready(function () {
    $('#nestable').nestable();
    //.on('change', updateOutput);
    $('.dd').nestable('collapseAll');//renuka
    $(".dd-nodrag").on("mousedown", function (event) { // mousedown prevent nestable click
        event.preventDefault();
        return false;
    });
    $(".dd-nodrag").on("click", function (event) { // click event
        event.preventDefault();
        return false;
    });

    getSectionPreference(forecast, version);

});

function getSectionPreference(forecast, version) {
    var sectionsByOrder;
    var modelType = type;
    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetSectionPreference", { Forecast: forecast, Version: version, type: modelType },
        function (result) {
            if (result.success) {
                //PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery.nestable.js", function () {
                    createLeftPanelOfSections(result.SectionsOrderByUserId);
                //});
            }
        },
        function (result) {

        });
}

function createLeftPanelOfSections(sectionsByOrder) {
    //var yoursystemday = new Date(new Date().getTime() - (120000 * 60 + new Date().getTimezoneOffset() * 60000));
    //var random = Math.round(Math.round(yoursystemday));
    if (!sectionsByOrder || sectionsByOrder.length == 0)
        return;
    $('.sidebar-nav-left>li.sectionslist').remove();
    $('#droppable>li.sectionslist').remove();

    var draggedFromHtml = '';
    var droppedToHtml = '';
    var draggedFrom = $('.sidebar-nav-left')[0];
    for (var i = 0; i < sectionsByOrder.length; i++) {
        draggedFromHtml += getHtmlForSection(sectionsByOrder[i]);
    }
    draggedFrom.innerHTML += draggedFromHtml;
}

function getHtmlForSection(section) {
    var hasSubsections = section.SubSections != null && section.SubSections.length > 0;
    var str = '';
    var collapsedClass = '';
    if (hasSubsections)
        //collapsedClass = 'dd-collapsed';
        collapsedClass = '';

    str += '<li class="dd-item sectionslist dd-collapsed" data-id=' + section.Id + '>';
    if (hasSubsections) {
        str += '<button style="display: none;" type="button" data-action="collapse">Collapse</button>';
        str += '<button style="display: block;" type="button" data-action="expand">Expand</button>';
    }
    str += '<div class="dd-handle dd-nodrag">';
    if (hasSubsections) {
        str += '<a href="' + "#" + section.Name.split(" ").join("").toLowerCase() + '" id ="' + "active-" + section.Name.split(" ").join("").toLowerCase() + '" >' + section.Name + '</a>';

    }
    else {
        str += '<a href="' + "#" + section.Name.split(" ").join("").toLowerCase() + '" id ="' + "active-" + section.Name.split(" ").join("").toLowerCase() + '" onmousedown="sidebarClick("' + "active-" + section.Name.split(" ").join("").toLowerCase() + '",this)"  >' + section.Name + '</a>';
    }
    str += '</div>';
    if (hasSubsections) {
        str += '<ol class="dd-list">';
        for (var j = 0; j < section.SubSections.length; j++) {
            str += '<li class="no-dd-item" data-id= ' + section.SubSections[j].Id + '>';
            str += '<div class="no-dd-handle dd-nodrag">';
            str += '<a href="' + "#" + section.SubSections[j].Name.split(" ").join("").toLowerCase() + '" id="' + "active-" + section.SubSections[j].Name.split(" ").join("").toLowerCase() + '" onmousedown="sidebarClick("' + "active-" + section.SubSections[j].Name.split(" ").join("").toLowerCase() + '",this)">' + section.SubSections[j].Name + '</a>';
            str += '</div></li>';
        }
        str += '</ol>';
    }
    // str += '<div style="position:absolute; right:10px; top:5px; cursor:pointer;"><a href="#" onclick="return inactiveFunction(event,this)"><i title="Click to remove" class="fa fa-chevron-down" aria-hidden="true"></i></a></div>';

    str += ' </li>';

    return str;
}

function sidebarClick(param, currentMenu) {
    var target = currentMenu;
    $('.sidebar-nav-left li,.sidebar-nav-left li a').removeClass('activatedAssum');
    $('#' + param).addClass('activatedAssum');
    //event.preventDefault();
    window.location = target.getAttribute('href');
    // return false;

}