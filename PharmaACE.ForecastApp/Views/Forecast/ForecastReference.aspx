<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<!-- css are here -->
<%: Styles.Render("~/Content/forecastReferenceCSS") %>
<%--<link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet" />--%>
<%: Scripts.Render("~/Scripts/forecastReferenceScript") %>
<%--<script src="../../Scripts/lib/jquery/jquery.nestable.js"></script>--%>


<style type="text/css">
.sidebar-nav-left li a{font-size:13px;}
.activatedAssum{}
    .dd-handle a, .no-dd-handle a {
        padding-left: 5px;
    }
    
.cf:after { visibility: hidden; display: block; font-size: 0; content: " "; clear: both; height: 0; }
* html .cf { zoom: 1; }
*:first-child+html .cf { zoom: 1; }



a:hover { text-decoration: none; }

.small { color: #666; font-size: 0.875em; }
.large { font-size: 1.25em; }

/**
 * Nestable
 */

.dd { position: relative; display: block; margin: 0; padding: 0; max-width: 600px; list-style: none; font-size: 13px; line-height: 20px; }

.dd-list { display: block; position: relative; margin: 0; padding: 0; list-style: none; }
.dd-list .dd-list { padding-left: 22px; }
.dd-collapsed .dd-list { display: none; }

.dd-item,.no-dd-item
.dd-empty,
.dd-placeholder { display: block; position: relative; margin: 0; padding: 0; min-height: 20px; font-size: 13px; line-height: 20px; }

.dd-handle, .no-dd-handle { display: block; height: 30px; margin: 5px 0;  color: #333; text-decoration: none; font-weight: bold; border: 1px solid #ccc;
    background: #fafafa;
    background: -webkit-linear-gradient(top, #fafafa 0%, #eee 100%);
    background:    -moz-linear-gradient(top, #fafafa 0%, #eee 100%);
    background:         linear-gradient(top, #fafafa 0%, #eee 100%);
    -webkit-border-radius: 3px;
            border-radius: 3px;
    box-sizing: border-box; -moz-box-sizing: border-box;
}
.dd-handle:hover, .no-dd-handle:hover { color: #2ea8e5; background: #fff; }

.dd-item > button, .no-dd-item > button { display: block; position: relative; cursor: pointer; float: left; width: 14px; height: 20px; margin: 5px 0; padding: 0; text-indent: 100%; white-space: nowrap; overflow: hidden; border: 0; background: transparent; font-size: 12px; line-height: 1; text-align: center; font-weight: bold; }
.dd-item > button:before, .no-dd-item > button:before { content: '+'; display: block; position: absolute; width: 100%; text-align: center; text-indent: 0; }
.dd-item > button[data-action="collapse"]:before, .no-dd-item > button[data-action="collapse"]:before { content: '-'; }

.dd-placeholder,
.dd-empty { margin: 5px 0; padding: 0; min-height: 30px; background: #f2fbff; border: 1px dashed #b6bcbf; box-sizing: border-box; -moz-box-sizing: border-box; }
.dd-empty { border: 1px dashed #bbb; min-height: 100px; background-color: #e5e5e5;
    background-image: -webkit-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff),
                      -webkit-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff);
    background-image:    -moz-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff),
                         -moz-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff);
    background-image:         linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff),
                              linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff);
    background-size: 60px 60px;
    background-position: 0 0, 30px 30px;
}

.dd-dragel { position: absolute; pointer-events: none; z-index: 9999; }
.dd-dragel > .dd-item .dd-handle, .dd-dragel > .dd-item .no-dd-handle { margin-top: 0; }
.dd-dragel .dd-handle, dd-dragel .no-dd-handle {
    -webkit-box-shadow: 2px 4px 6px 0 rgba(0,0,0,.1);
            box-shadow: 2px 4px 6px 0 rgba(0,0,0,.1);
}

/**
 * Nestable Extras
 */

.nestable-lists { display: block; clear: both;  width: 100%; border: 0;  }

#nestable-menu { padding: 0; margin: 20px 0; }

#nestable-output,
#nestable2-output { width: 100%; height: 7em; font-size: 0.75em; line-height: 1.333333em; font-family: Consolas, monospace; padding: 5px; box-sizing: border-box; -moz-box-sizing: border-box; }



@media only screen and (min-width: 700px) {

    .dd { float: left; width: 94%; margin:0% 3%; }
    .dd + .dd { margin-left: 2%; }

}

.dd-hover > .dd-handle, .dd-hover > .no-dd-handle { background: #2ea8e5 !important; }

/**
 * Nestable Draggable Handles
 */

.dd3-content { display: block; height: 30px; margin: 5px 0; padding: 5px 10px 5px 40px; color: #333; text-decoration: none; font-weight: bold; border: 1px solid #ccc;
    background: #fafafa;
    background: -webkit-linear-gradient(top, #fafafa 0%, #eee 100%);
    background:    -moz-linear-gradient(top, #fafafa 0%, #eee 100%);
    background:         linear-gradient(top, #fafafa 0%, #eee 100%);
    -webkit-border-radius: 3px;
            border-radius: 3px;
    box-sizing: border-box; -moz-box-sizing: border-box;
}
.dd3-content:hover { color: #2ea8e5; background: #fff; }

.dd-dragel > .dd3-item > .dd3-content { margin: 0; }

.dd3-item > button { margin-left: 30px; }

.dd3-handle { position: absolute; margin: 0; left: 0; top: 0; cursor: pointer; width: 30px; text-indent: 100%; white-space: nowrap; overflow: hidden;
    border: 1px solid #aaa;
    background: #ddd;
    background: -webkit-linear-gradient(top, #ddd 0%, #bbb 100%);
    background:    -moz-linear-gradient(top, #ddd 0%, #bbb 100%);
    background:         linear-gradient(top, #ddd 0%, #bbb 100%);
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
}
.dd3-handle:before { content: '≡'; display: block; position: absolute; left: 0; top: 3px; width: 100%; text-align: center; text-indent: 0; color: #fff; font-size: 20px; font-weight: normal; }
.dd3-handle:hover { background: #ddd; }


/*
    #tab-scroller #botbar {
 overflow: auto;
 height: 480px;
}
*/
.navigationPane
{display:block;}
.wrapper-left{padding-left:0px !important;}


.sidebar-wrapper-left li a:active,
.sidebar-wrapper-left a:focus {
  text-decoration: none;
   background: rgba(255,255,255,0.2);
}
p{font-size:14px;}
.page-content-wrapper-left{padding-right:15px; padding-top:0px;}
.plink{padding-top:0px;}

    </style>
 


 <script>
     var forecast='<%=ViewData["forecast"]%>';
     var version='<%=ViewData["version"]%>';
     var type=<%=ViewData["type"]%>;
</script>


<body class="nav-md">

     <%Html.RenderAction("RenderHeader", "Header", new { headerType =0 }); %>

<div id="overlay_container" class="story">
    <div class="wrapper-left explorationHost " id="wrapper">
        <div class="navigationPane unselectable">
                 <div class="innerLayout">      
                        <div class="scrollRegion scroll-view">
                             <div class="headertitle"><a href="#">Forecast Navigation</a></div>
                             <div class="sidebar-wrapper-left nav" id="spy">
                                <div id="raidul">
                                    <div class="cf nestable-lists">
                                        <div class="dd" id="nestable">
                                             <ol class="dd-list sidebar-nav-left" style=" height:564px;">     
                                            </ol> 
                                        </div>
                                        <div style="width: 210px; bottom: 0px; position: fixed;">
                                        <div class="referenceSlider" onclick="toggleSliderSidebar();"> </div>                                            
                                        </div>
                                    </div>                                    
                                </div>  
                            </div>
                      </div>
                  </div>
               </div>
     <div id="page-content-wrapper" data-spy="scroll" data-target="#spy" class="page-content-wrapper-left imgclickenable horizontalItemsContainer">
            <div class="container-fluid">
                <div class="row"> 
                   <%Html.RenderAction("ForecastIndicationInfo", "Forecast", new  { indication = ViewData["indicationValue"]  }); %>
                </div>
            </div>
        </div>
    </div>
</div>


<%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">--%>
   </body>
