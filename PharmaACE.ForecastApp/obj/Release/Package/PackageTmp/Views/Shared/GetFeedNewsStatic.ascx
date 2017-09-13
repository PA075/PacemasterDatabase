<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%--<link href="../../Content/CSS/NewsFeedStatic.css" rel="stylesheet" />--%>
<link href="../../Content/CSS/NewsFeedStatic.css" rel="stylesheet" />
<link href="../../Content/CSS/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="../../Scripts/lib/bootstrap/bootstrap.min.js"></script>
  <script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>


<%--<script src="../../Scripts/lib/jquery/jquery.min.js"></script>--%>
<style>
@import url(http://fonts.googleapis.com/css?family=Roboto:500,100,300,700,400);
#starModal .modal-dialog{z-index:9999;}
.feed_item_title a{cursor:pointer;}

* {
  margin: 0;
  padding: 0;
  font-family: roboto;
}

body { background: #000; }

.cont {
  width: 100%;
  position:absolute; bottom:0px; right:6px;
  
  text-align: center;
  margin: 1% auto;
  padding: 6px 0;
 /* background: #111;*/
  color: #EEE;
  border-radius: 5px;
  
  overflow: hidden;
  float:right;
}

hr {
  margin: 20px;
  border: none;
  border-bottom: thin solid rgba(255,255,255,.1);
}
.activeCommentsInput {
    border-top-left-radius: 1em;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
    border-top-right-radius: 1em;
    border-left: 1px solid #598CFB;
    border-right: 1px solid #598CFB;
    border-top: 1px solid #598CFB;
}
[contentEditable=true]:empty:not(:focus):before {
    content: attr(data-text);
    color: gray;
}
.form-control:focus {
    border-color: #66afe9;
    outline: 0;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075),0 0 8px rgba(102,175,233,0.6);
    box-shadow: inset 0 1px 1px rgba(0,0,0,0.075),0 0 8px rgba(102,175,233,0.6);
}

.form-control {
    display: block;
    width: 100%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.428571429;
    color: #555;
    vertical-align: middle;
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
    -webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}

div.title { font-size: 2em; }

h1 span {
  font-weight: 300;
  color: #Fd4;
}

div.stars {
  
  /*display: inline-block;*/
}

input.star { display: none; }

label.star {
   
  float: right;
  padding: 3px;
  font-size: 16px;
  color: #444;
  transition: all .2s;
}

input.star:checked ~ label.star:before {
  content: '\f005';
  color: #FD4;
  transition: all .25s;
}

input.star-5:checked ~ label.star:before {
  color: #FE7;
  text-shadow: 0 0 12px #952;
}

input.star-1:checked ~ label.star:before { color: #F62; }

label.star:hover { transform: rotate(-15deg) scale(1.3); }

label.star:before {
  content: '\f006';
  font-family: FontAwesome;
}

.commentWrapper .commentClass {
    position: relative;
    padding-left: 15px;
    padding-top:0px;
}
.commentClass:before {
    border-right-color: rgb(192, 192, 192);
    border-width: 16px;
    margin-top: -16px;
    right: 100%;
    top: 24px;
    border-color: rgba(194, 225, 245, 0);
    content: " ";  
    position: absolute;
    pointer-events: none;
}
.ratingClass{display:flex;}
#ratingId .cont{ bottom:16px; right:32px;}
 

        .tooltip
{
            min-width:216px;
font-family: Ubuntu, sans-serif;
font-size: 0.875em;
text-align: center;
text-shadow: 0 1px rgba( 0, 0, 0, .5 );
line-height: 1.5;
color: #fff;
background: #333;
background: -webkit-gradient( linear, left top, left bottom, from( rgba( 0, 0, 0, .6 ) ), to( rgba( 0, 0, 0, .8 ) ) );
background: -webkit-linear-gradient( top, rgba( 0, 0, 0, .6 ), rgba( 0, 0, 0, .8 ) );
background: -moz-linear-gradient( top, rgba( 0, 0, 0, .6 ), rgba( 0, 0, 0, .8 ) );
background: -ms-radial-gradient( top, rgba( 0, 0, 0, .6 ), rgba( 0, 0, 0, .8 ) );
background: -o-linear-gradient( top, rgba( 0, 0, 0, .6 ), rgba( 0, 0, 0, .8 ) );
background: linear-gradient( top, rgba( 0, 0, 0, .6 ), rgba( 0, 0, 0, .8 ) );
-webkit-border-radius: 5px;
-moz-border-radius: 5px;
border-radius: 5px;
border-top: 1px solid #fff;
-webkit-box-shadow: 0 3px 5px rgba( 0, 0, 0, .3 );
-moz-box-shadow: 0 3px 5px rgba( 0, 0, 0, .3 );
box-shadow: 0 3px 5px rgba( 0, 0, 0, .3 );
position: absolute;
z-index: 100;
padding-top: 5px;
    padding-bottom: 0px;
    padding-left: 10px;
    padding-right: 10px;}
        .flname{padding-top:6px;border-top:1px solid #fff;}
        .flname:first-child{ border-top:0px solid #fff;}
         
/*.tooltip:after
{
       width: 0;
       height: 0;
       border-left: 10px solid transparent;
       border-right: 10px solid transparent;
border-top: 10px solid #333;
       border-top-color: rgba( 0, 0, 0, .7 );
content: '';
position: absolute;
left: 50%;
bottom: -10px;
margin-left: -10px;
}*/
.tooltip:after
{
       width: 0;
       height: 0;
       border-left: 10px solid transparent;
       border-right: 10px solid #333;
border-bottom: 10px solid transparent;
       border-top-color: rgba( 0, 0, 0, .7 );
content: '';
position: absolute;
left: 0%;
bottom: 45%;
margin-left: -20px;
}
.tooltip.top:after
{
      /* border-top-color: transparent;
border-bottom: 10px solid #333;
       border-bottom-color: rgba( 0, 0, 0, .6 );*/
top: 40px;
bottom: auto;
}
.tooltip.left:after
{
left: 10px;
margin: 0;
}
.tooltip.right:after
{
right: 10px;
left: auto;
margin: 0;
}
 .commentbar{font-size: 2.5em; margin-left:163px;color: #444;margin-top: 5px; float:left; margin-right:10px;cursor: pointer;}
 .commentbubble{margin-bottom:1px; position:relative; clear:both; text-align:left;}
 .commentbubbleclass{ position:relative;  padding:0px; border-radius:0px;}
 .commentbubbleclass:last-child{border-bottom:0px solid #fff;}
 #cmtsclbar{max-height:200px; margin-bottom:10px;}
 .spinner {
  width: 24px;
  text-align: center;
   margin-left:165px;
  top:21px; position:absolute;
}

.spinner > div {
  width: 6px;
  height: 7px;
  background-color: #fc0303;

  border-radius: 100%;
  display: inline-block;
  -webkit-animation: sk-bouncedelay 1.4s infinite ease-in-out both;
  animation: sk-bouncedelay 1.4s infinite ease-in-out both;
 
}

.spinner .bounce1 {
  -webkit-animation-delay: -0.32s;
  animation-delay: -0.32s;
}

.spinner .bounce2 {
  -webkit-animation-delay: -0.16s;
  animation-delay: -0.16s;
}

@-webkit-keyframes sk-bouncedelay {
  0%, 80%, 100% { -webkit-transform: scale(0) }
  40% { -webkit-transform: scale(1.0) }
}

@keyframes sk-bouncedelay {
  0%, 80%, 100% { 
    -webkit-transform: scale(0);
    transform: scale(0);
  } 40% { 
    -webkit-transform: scale(1.0);
    transform: scale(1.0);
  }
}
   /*
    #hellobar {
 overflow: auto;
 height: 140px;
}
*/
 /*.scrollcomments{ max-height:170px; overflow-y:auto; }*/
</style>


<div>
    <div id="StarModal" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
<%--                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>--%>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <!--<form role="form-->
                    <div class="form-group">
                        <div class="ratingClass" id="ratingId">
                            <div class="col-xs-2 col-md-2 col-lg-2 col-sm-2"><img src="../../Content/img/blankUser.gif" /></div>
                            <div class="col-xs-10 col-md-10 col-lg-10 col-sm-10 commentWrapper">

                                <div class="commentClass">
                                    <div class="fitText commentText">
                                        <div class="form-control commentInput  activeCommentsInput" id="CommentInputId" contenteditable="true" data-text="Give your feedback" style="font-size: 16px; height: 128px;"></div>

                                    </div>

                                </div>
                            </div>

                        </div>
                   </div>
                <!-- </form>-->
            </div>
            <div class="modal-footer">
<%--                <button type="button" class="btn btn-default" data-dismiss="modal">Skip</button>--%>
                <button type="button" id="ratingButton" class="btn btn-primary" onclick="ratingSubmit()" >Done</button>
                <input type="hidden" value="" id="hiddenId" />
            </div>
        </div>
    </div>
</div> 
    <%: Html.Raw(ViewBag.Mydata) %> 
    
                                      
</div>
<script>
    

    $(document).ready(function () {        

        $(function () {
            var bid, loaderDiv;
            var targets = $('[rel=tooltip]'),
            target = false,
            tooltip = false,
            title = false;
             loaderDiv = "<div class='spinner'><div class='bounce1'></div><div class='bounce2'></div><div class='bounce3'></div></div>";

            targets.bind('mouseenter', function () {
               // alert($("#comment").length + $('.spinner').css('display'));
                if (($("#comment").length == 0) && ($(".spinner").length==0)) {
                    //alert('hello');
                    target = $(this);
                    var link = $(this).parent().parent().parent().find('.feed_item_link a').attr('href');
                    var feedData;
                    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/LiveFeed/GetNewsFeedWithComment", { link: link },
                          function (result) {
                              if (result.success) {
                                  var feedComment = result.feedCount;
                                 // if ($("#comment").length == 0) {
                                 // target.next().css('display', 'block');
                                  //target.next().addClass('spinnerblock');
                                  // }
                                  target.after(loaderDiv);
                                  //setTimeout(function () {
                                     // target.next().css('display', 'none');
                                      //alert("hi");
                                      $('.spinner').remove();
                                      NewsFeedComment(targets, target, tooltip, title, feedComment);
                                  //}, 3000);
                              }
                              else {
                                  PHARMAACE.FORECASTAPP.UTILITY.popalert("There are no comments", '');
                              }
                          },
                          function (status) {
                              PHARMAACE.FORECASTAPP.UTILITY.popalert(status, "NewsFeed Form");
                          });


                }
                });
           
        });


        function NewsFeedComment(targets, target, tooltip, title, feedComment)
        {
            // targets.bind('mouseenter', function () {
            // target = $(this);
            // tip = target.attr('data');
            tip = feedComment;
            divid = target.attr('forid');
            tooltip = $('<div class="tooltip" id=' + divid + '><div>');

            if (!tip || tip == '')
                return false;

            //target.removeAttr( 'title' );
            tooltip.css({ 'opacity': '0' })
              .html(tip)
              .appendTo('body');
            if ($("#idforscroller").length == 1) {
                $('#' + divid).addClass('scrollcomments');
                PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery.nicescroll.min.js", function () {
                    $('#cmtsclbar').niceScroll({
                        cursorfixedheight: 70
                    });
                });

            }

            var init_tooltip = function () {
                if ($(window).width() < tooltip.outerWidth() * 1.5)
                    tooltip.css('max-width', $(window).width() / 2);
                else
                    tooltip.css('max-width', 340);

                var pos_left = target.offset().left + (target.width()) + 6,
                pos_top = target.offset().top - tooltip.outerHeight() / 2 -1,
                pos_left1 = target.offset().left + (target.outerWidth() / 2) - (tooltip.outerWidth() / 2);

                if (pos_left1 < 0) {
                    pos_left = target.offset().left + target.outerWidth() / 2 - 20;
                    tooltip.addClass('left');
                }
                else
                    tooltip.removeClass('left');

                if (pos_left1 + tooltip.outerWidth() > $(window).width()) {
                    pos_left = target.offset().left - tooltip.outerWidth() + target.outerWidth() / 2 + 20;
                    tooltip.addClass('right');

                }
                else
                    tooltip.removeClass('right');

                if (pos_top < 0) {
                    var pos_top = target.outerHeight() / 2;
                    $('body').append('<style>.tooltip.top:after{top: ' + (target.offset().top - 20) + 'px;}</style>');
                    tooltip.addClass('top');

                }
                else
                    tooltip.removeClass('top');

                $('#' + divid).show();
                tooltip.css({ left: pos_left, top: pos_top })
                  .animate({ top: '+=10', opacity: 1 }, 50);
            };
            init_tooltip();
            $(window).resize(init_tooltip);
            var remove_tooltip = function () {
                tooltip.animate({ top: '-=10', opacity: 0 }, 50, function () {
                    $(this).remove();
                });
                target.attr('data', tip);
            };
            if ($("#comment").length == 1 ) {

            $('body').bind({
                container: 'body'
            }).click(function (evt) {
               // evt.preventDefault();
                //var id = $(this).attr('id');
                //alert($('.' + evt.target.className));
                pid = $('.' + evt.target.className).parent().attr('id');
                //alert(pid);
                if (pid != "cmtsclbar") {
                         
                    var activdivid = $(this).attr('forid');
                    tooltip.animate({ top: '-=10', opacity: 0 }, 50, function () {
                        target.attr('data', tip);
                        //alert(pid);
                        $('#comment').remove();
                       // target.next().css('display', 'none');
                    });
                }

            });
        }
                
        }






        addRatingElements();

       // if (parent.getItemOrder() != 0) {
            $('.feed_item_title a').attr('data-toggle', 'modal');
            $('.feed_item_title a').attr('data-target', '#StarModal');
            $('.feed_item_title a').attr('data-backdrop', 'static');
            $('.feed_item_title a').attr('data-keyboard', 'false');
            $('.feed_item_title a').click(function () {
              
                var attr = $(this).attr('toAllowComment');

                if (typeof attr !== typeof undefined && attr !== false) {

                    var isallow = $(this).attr('toAllowComment')
                    if (isallow == "false") {
                        $(this).removeAttr("data-toggle");
                        $(this).removeAttr("data-target");
                        $(this).removeAttr("data-backdrop");
                        $(this).removeAttr("data-keyboard");
                    }
                    else if (isallow == "true") {
                        $('.feed_item_title a').attr('data-target', '#StarModal');
                        $('.feed_item_title a').attr('data-toggle', 'modal');
                        $('.feed_item_title a').attr('data-target', '#StarModal');
                        $('.feed_item_title a').attr('data-backdrop', 'static');
                        $('.feed_item_title a').attr('data-keyboard', 'false');
                        var abc = $(this).parent().parent().find('form').attr('for');
                        window.open($(this).attr('href'), '_blank');
                        $('#StarModal .modal-title').text($(this).text());
                        addRatingElementsPopup(abc);
                    }
                }
                else {
                    var abc = $(this).parent().parent().find('form').attr('for');
                    window.open($(this).attr('href'), '_blank');
                    $('#StarModal .modal-title').text($(this).text());
                    addRatingElementsPopup(abc);
                }
              
               
               // alert(abc);
                //$("#StarModal").modal('show');
            });
        //}
    });
    var hideInProgress = false;
    var showModalId = '';
    function showModal(elementId) {
        if (hideInProgress) {
            showModalId = elementId;
        } else {
            $("#" + elementId).modal("show");
        }
    }
    function hideModal(elementId) {
        hideInProgress = true;
        $("#" + elementId).on('hidden.bs.modal', hideCompleted);
        $("#" + elementId).modal("hide");
    }
    function hideCompleted(elementId) {
        hideInProgress = false;
        if (showModalId) {
            showModal(showModalId);
        }
        showModalId = '';
        $(elementId).off('hidden.bs.modal');
    }
    function ratingSubmit() {
        var ratingValue = $('#ratinghidden').val();
        if (!ratingValue) {
           

           // $(this).removeAttr('data-dismiss');
            alert('Please give us a ranking.');
            return false;
            //$('#StarModal').modal('show');
            //showModal('StarModal');


        }
        else {
            
            var splitRating = ratingValue.split("-");
            var feedIndex = splitRating[splitRating.length - 1];
            onRating(ratingValue, feedIndex);
        }
        
        
        //star - 1 - 2 - 1
    }
    function addRatingElementsPopup(abc) {
        //alert(abc);
        //if ($('.feed_item div.cont').length == 0) {
       // alert('hello');
            var ratingHtml = '<div class="cont">';
            ratingHtml += '<div class="stars">';
            ratingHtml += '<form action="" >'
            ratingHtml += '<input class="star star-5" id="star-5-2-{0}" type="radio" name="star" onclick="ratingstar(this.id);"/>';
            ratingHtml += '<label class="star star-5" for="star-5-2-{0}"></label>';
            ratingHtml += '<input class="star star-4" id="star-4-2-{0}" type="radio" name="star" onclick="ratingstar(this.id);"/>';
            ratingHtml += '<label class="star star-4" for="star-4-2-{0}"></label>';
            ratingHtml += '<input class="star star-3" id="star-3-2-{0}" type="radio" name="star" onclick="ratingstar(this.id);"/>';
            ratingHtml += '<label class="star star-3" for="star-3-2-{0}"></label>';
            ratingHtml += '<input class="star star-2" id="star-2-2-{0}" type="radio" name="star" onclick="ratingstar(this.id);"/>';
            ratingHtml += '<label class="star star-2" for="star-2-2-{0}"></label>';
            ratingHtml += '<input class="star star-1" id="star-1-2-{0}" type="radio" name="star" onclick="ratingstar(this.id);"/>';
            ratingHtml += '<label class="star star-1" for="star-1-2-{0}"></label>';
            ratingHtml += '<input type="hidden" id="ratinghidden" name="thing" value="">';
            ratingHtml += '</form></div></div>';
            
           // alert('hello');
            $('#ratingId').append(ratingHtml.replaceAll('{0}', abc));
            $('#ratingButton').removeAttr('data-dismiss', 'modal');
            $('#ratingId input[type="radio"]').prop('checked', false);
            $('#hiddenId').val('');


            //apply unique ids
            //var feedItems = $('.feed_item');
            //for (var i = 0; i < feedItems.length; i++) {
               // $(feedItems[i]).append(ratingHtml.replaceAll('{0}', i));
            //}
        }
   // }
    
    function addRatingElements() {
        
        if ($('.feed_item div.cont').length == 0) {
            var ratingHtml = '<div style="position:absolute;top:0px; right:10px;color:#444;"><a href="#" onclick="latestStoriesClosebtn(event, this);" id="LSClose"><i class="fa fa-times newsRemove" aria-hidden="true" style="color:#c00; float:left; margin-top:3px;font-size:1.4em; opacity:0.76;" id="closebtn2" data-toggle="tooltip" data-placement="left" title="Remove this feed : will be filtered out now onwards"></i></a></div><div class="cont">';
            ratingHtml += '<div class="stars">';
            ratingHtml += '<form action="" for="{0}">'
            ratingHtml += '<input class="star star-5" id="star-5-2-{0}" type="radio" name="star" onchange="ratingstar1(this.id);"/>';
            ratingHtml += '<label class="star star-5" for="star-5-2-{0}"></label>';
            ratingHtml += '<input class="star star-4" id="star-4-2-{0}" type="radio" name="star" onchange="ratingstar1(this.id);" />';
            ratingHtml += '<label class="star star-4" for="star-4-2-{0}"></label>';
            ratingHtml += '<input class="star star-3" id="star-3-2-{0}" type="radio" name="star" onchange="ratingstar1(this.id);"/>';
            ratingHtml += '<label class="star star-3" for="star-3-2-{0}"></label>';
            ratingHtml += '<input class="star star-2" id="star-2-2-{0}" type="radio" name="star" onchange="ratingstar1(this.id);" />';
            ratingHtml += '<label class="star star-2" for="star-2-2-{0}"></label>';
            ratingHtml += '<input class="star star-1" id="star-1-2-{0}" type="radio" name="star" onchange="ratingstar1(this.id);"/>';
            ratingHtml += '<label class="star star-1" for="star-1-2-{0}"></label>';
            ratingHtml += '<input type="hidden" id="ratinghidden" name="thing" value="">';
            //ratingHtml += '<input type="hidden" id="ratinghidden" name="thing" value="">';
            ratingHtml += '</form></div></div>';

            //apply unique ids
            var feedItems = $('.feed_item');
            for (var i = 0; i < feedItems.length; i++) {
                $(feedItems[i]).append(ratingHtml.replaceAll('{0}', i));
            }
        }
    }
    function ratingstar(id)
    {
        //alert(id);
        $('#ratinghidden').val(id);
    }
    function ratingstar1(id) {
        //alert(id);
        $('#ratinghidden').val(id);
        ratingSubmit();
    }

   
    function onRating(starInput, feedIndex) {
        //alert(feedIndex);
        if ($('#StarModal').css("display") == "block") {
            //alert("under" + feedIndex);
            $('#ratingButton').attr('data-dismiss', 'modal');
            $('#hiddenId').val(feedIndex);

        }
        
        var commentText = $('#CommentInputId').text();
        
        var feedItem = {};
        feedItem.Link = $('.feed_item_link:eq(' + feedIndex + ')>a').attr('href');//$('.feed_item>div>a:eq(' + feedIndex + ')').attr('href');
        feedItem.Title = $('.feed_item_title:eq(' + feedIndex + ')>a').text();//$('.feed_item>div>a:eq(' + feedIndex + ')').text();
        feedItem.Description = $('.feed_item_description:eq(' + feedIndex + ')').text();//$('.feed_item:eq(' + feedIndex + ')>div:eq(1)').text(); //$('.feed_item>div:eq(1):eq(' + feedIndex + ')').text();
        var thumbnailAttribute = $('.feed_item_description:eq(' + feedIndex + ')>div').attr('style');//$('.feed_item:eq(' + feedIndex + ')>div:eq(1)>div').attr('style');
        if (thumbnailAttribute) //if there is thumbnail
            feedItem.Thumbnail = thumbnailAttribute.split('tbn:')[1].split('");')[0]; //$('.feed_item>div:eq(1)>div:eq(' + feedIndex + ')').attr('style').split('tbn:')[1].split('");')[0];
        feedItem.TimeStamp = $('.feed_item_date:eq(' + feedIndex + ')').text();//$('.feed_item:eq(' + feedIndex + ')>div:eq(2)').text(); //$('.feed_item>div:eq(2):eq(' + feedIndex + ')').text();
        feedItem.Source = $('.feed_item_link:eq(' + feedIndex + ')').text();//$('.feed_item:eq(' + feedIndex + ')>div:eq(3)>a').text();
        feedItem.Rating = starInput.split('-')[1];
        feedItem.DivOrder = parent.getDivOrder();
        feedItem.Comment = commentText;

        PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/LiveFeed/SetFeedRating", JSON.stringify(feedItem),
        function (result) {
            if (result.success) {
                //add one enty to notification- you have rated this news
            }
            else {
                //could not rate this news at this moment
            }
        },
            function (result) {
                //could not rate this news at this moment
            });
    };

    //Renuka : TopStories Close Button Task.
    function removeonclick(e, current) {            
        e.preventDefault();
        var linkhref = current.parentElement.nextElementSibling.nextElementSibling.nextElementSibling.firstElementChild.getAttribute('href');
        //var link = linkhref.nodeValue;
        var item = "TopStories";
        removeNewsFromList(linkhref, item);
        $(current.parentElement.parentElement).fadeOut( 1000, "linear", function () { 
                $(this).remove();
        });
    }
    
    function latestStoriesClosebtn(e, current) {
        e.preventDefault();
        var linkhref = current.parentElement.previousElementSibling.firstElementChild.attributes['href'];
        var link = linkhref.nodeValue;
        var item = "LatestStories";
        removeNewsFromList(link,item);
        $(current.parentElement.parentElement).fadeOut(1000, "linear", function () {
            $(this).remove();
        });
    }
    function removeNewsFromList(link,item) {
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/LiveFeed/removeNewsFromList", { link: link ,item: item},
                     function (result) {
                         if (result.success) {
                             //alert("In Success Block");
                             //PHARMAACE.FORECASTAPP.UTILITY.popalert("News Removed from List", '');
                         }
                         else {
                             alert("Not In Success Block");
                             PHARMAACE.FORECASTAPP.UTILITY.popalert("News not Removed from List", '');
                         }
                     },
                 function (status) {
                     PHARMAACE.FORECASTAPP.UTILITY.popalert(status, "NewsFeed Form");
                 });
    }
    

</script>

<script src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
<script src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
