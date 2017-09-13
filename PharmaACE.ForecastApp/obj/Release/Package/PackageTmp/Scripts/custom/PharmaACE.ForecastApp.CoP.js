//*******************************************************Index.aspx*****************************************************************

$(document).ready(function () {
    //Getting Latest Questions
    var searchResultElement = document.getElementById('SearchResult');
    if(searchResultElement){
        PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/CommunityPractice/LatestQuestions", { questionCount: -1 },
           function (data) {
               searchResultElement.innerHTML = data;
               var questions = $('.questionPostTimetxt');
               for (var i = 0; i < questions.length; i++) {
                   var pDate = questions[i].innerHTML;
                   var date1 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(pDate));
                   var formattedDate = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(date1));
                   questions[i].innerHTML = formattedDate;
               }
               $('#questionlistBox').DataTable({
                   "bDestroy": true,
                   "ordering": false
               });
               setInterval(function () {
                   $("#CategoryListParent ul.inner li").attr("onclick", "categoryFilter(this)");
               }, 2000);                
           },
           function (status) {
               PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
           });
    }

    localStorage.removeItem('selectedolditem');

          var $placeholder = $('.placeholder');
          $('#question-details').summernote({
              height: 100,
              codemirror: {
                  mode: 'text/html',
                  htmlMode: true,
                  lineNumbers: true,
                  theme: 'monokai'
              },
              callbacks: {
                  onInit: function () {
                      $placeholder.show();
                  },
                  onFocus: function () {
                      $placeholder.hide();
                  },
                  onBlur: function () {
                      var $self = $(this);
                      setTimeout(function () {
                          if ($self.summernote('isEmpty') && !$self.summernote('codeview.isActivated')) {
                              $placeholder.show();
                          }
                      }, 300);
                  }
              }
          });
      });
$("#CategoryList li").click(function () {
    var categoryId = this.id;
    if (categoryId != 0) {
        PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/CommunityPractice/QuestionsListByCategory", { CategoryId: categoryId },
          function (data) {
              document.getElementById('SearchResult').innerHTML = '';
              document.getElementById('SearchResult').innerHTML = data;
              var questions = $('.questionPostTimetxt');
              for (var i = 0; i < questions.length; i++) {
                  var pDate = questions[i].innerHTML;
                  var pDate1=PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(pDate));
                  questions[i].innerHTML = '';
                  questions[i].innerHTML = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(pDate1));
              }
          },
          function (status) {
              PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
          });
    }
});
function GetQuestionsListByCategory(CategoryId) {
    var categoryId = CategoryId;
    if (categoryId != 0) {
        PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/CommunityPractice/QuestionsListByCategory", { CategoryId: categoryId },
          function (data) {
              document.getElementById('SearchResult').innerHTML = '';
              document.getElementById('SearchResult').innerHTML = data;
              var questions = $('.questionPostTimetxt');
              for (var i = 0; i < questions.length; i++) {
                  var pDate = questions[i].innerHTML;
                  var pDate1 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(pDate));
                  questions[i].innerHTML = '';
                  questions[i].innerHTML = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(pDate1));
              }
          },
          function (status) {
              PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
          });
    }
}
$("#btnQuestionSearch").click(function () {
    var searchKeyWord = $("#txtSearch").val();
    if (searchKeyWord != "") {
        PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/CommunityPractice/SearchQuestions", { KeyWord: searchKeyWord },
         function (data) {
             document.getElementById('SearchResult').innerHTML = '';
             document.getElementById('SearchResult').innerHTML = data;
             var questions = $('.questionPostTimetxt');
             for (var i = 0; i < questions.length; i++) {
                 var pDate = questions[i].innerHTML;
                 var pDate1=PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(pDate));
                 questions[i].innerHTML = '';
                 questions[i].innerHTML = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(pDate1));
             }
         },
        function (status) {
            PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
        });
    }
});
$('#txtSearch').on('keypress', function (e) {
    if (e.which === 13) {
        var searchKeyWord = $("#txtSearch").val();
        if (searchKeyWord != "") {
            $("#btnQuestionSearch").click();
        }
    }
});
function deleteQuestion(userid, questionid) {
    PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/CommunityPractice/RemoveForumQuestion", { UserId: userid, QuestionId: questionid },
          function (data) {
              if (data == 1)
                  alert("Question Removed");
              window.location.href = "/CommunityPractice/Index";
          },
             function (status) {
                 alert(status);
             });
}
function categoryFilter(param) {
    //var categoryId = param.id;
    //var categoryId = param.selectedIndex;
    if (param.getAttribute('data-original-index') == null)
        var categoryId = param.selectedIndex
    else
        categoryId = param.getAttribute('data-original-index');
    if (categoryId != 0) {
        PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/CommunityPractice/QuestionsListByCategory", { CategoryId: categoryId },
          function (data) {
              document.getElementById('SearchResult').innerHTML = '';
              document.getElementById('SearchResult').innerHTML = data;
              var questions = $('.questionPostTimetxt');
              $('#questionlistBox').DataTable({
                  "ordering": false
              });
              $("#CategoryList").selectpicker();
              $('#CategoryListParent ul.inner li').removeClass('selected');
              $('[data-original-index="' + categoryId + '"]').addClass('selected');
              var texts = $('[data-original-index="' + categoryId + '"]').text();
              $('#CategoryListParent .filter-option').html(texts);
              $('#CategoryListParent button').attr('title', texts);
              for (var i = 0; i < questions.length; i++) {
                  var pDate = questions[i].innerHTML;
                  var pDate1 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(pDate));
                  questions[i].innerHTML = '';
                  questions[i].innerHTML = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(pDate1));
              }
          },
          function (status) {
              PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
          });
    }
    else
    {
        PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/CommunityPractice/LatestQuestions", { questionCount: -1 },
      function (data) {
          document.getElementById('SearchResult').innerHTML = data;
          var questions = $('.questionPostTimetxt');
          for (var i = 0; i < questions.length; i++) {
              var pDate = questions[i].innerHTML;
              var pDate1 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(pDate));
              questions[i].innerHTML = '';
              questions[i].innerHTML = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(pDate1));
          }
          $('#questionlistBox').DataTable({
              "bDestroy": true
          });
          $("#CategoryList").selectpicker();
          setInterval(function () {
              $("#CategoryListParent ul.inner li").attr("onclick", "categoryFilter(this)");
          }, 2000);
      },
      function (status) {
          PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
      });
        $('#CategoryListParent ul.inner li').removeClass('selected');
        $('[data-original-index="' + categoryId + '"]').addClass('selected');
        var texts = $('[data-original-index="' + categoryId + '"]').text();
        $('#CategoryListParent .filter-option').html(texts);
        $('#CategoryListParent button').attr('title', texts);
    }
}

function onNewsLoaded() {
}

//*******************************************************Index.aspx*****************************************************************

//******************************************************AskQuestion.aspx*************************************************************
        $(document).ready(function () {
            var $placeholder = $('.placeholder');
            $('#question-details').summernote({
                height: 130,
                codemirror: {
                    mode: 'text/html',
                    htmlMode: true,
                    lineNumbers: true,
                    theme: 'monokai'
                },
                callbacks: {
                    onInit: function () {
                        $placeholder.show();
                    },
                    onFocus: function () {
                        $placeholder.hide();
                    },
                    onBlur: function () {
                        var $self = $(this);
                        setTimeout(function () {
                            if ($self.summernote('isEmpty') && !$self.summernote('codeview.isActivated')) {
                                $placeholder.show();
                            }
                        }, 300);
                    }
                }
            });
        });

$("#file_attachment").change(function () {
    var val = $(this).val().toLowerCase();
    var ext = val.substr(val.lastIndexOf('.') + 1);
    if (PHARMAACE.FORECASTAPP.FILETYPE.indexOf(ext) == -1) {
        $(this).val('');
        PHARMAACE.FORECASTAPP.UTILITY.popalert("Sorry, this file type is not permitted for security reasons...", '');
        return;
    }
});

$('#addquestionid').submit(function () {
    var formdata = new FormData();
    var title = $('#question-title').val();
    var categoryCode = $("#questionCategory option:selected").val();
    var attachment = $('#file_attachment').val();
    var questionText = PHARMAACE.FORECASTAPP.UTILITY.htmlEncode($('.note-editable').html());
    var questionTextWithoutHtml = $('.note-editable').text();
    if (questionTextWithoutHtml != "")
    { 
        if ($('#file_attachment').length > 0) {
            var fileInput = $('#file_attachment')[0];
            if (fileInput.files != null && fileInput.files.length > 0) {
                var notValidFileSize = PHARMAACE.FORECASTAPP.UTILITY.checkFileSize(fileInput.files);
                if (notValidFileSize)
                {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to add question : file size exceeded.", '');
                    return false;
                }
                else {
                    for (var i = 0; i < fileInput.files.length; i++) {
                        var fileStream = fileInput.files[i];
                        formdata.append(fileInput.files[i].name, fileInput.files[i]);
                    }
                }                                   
            }
        }
        formdata.append('questionText', questionText);
        var controllerUrl = "/CommunityPractice/AddQuestion?questionTitle=" + title + "&questionCategoryCode=" + categoryCode;
        var xhr = new XMLHttpRequest();
        xhr.open('POST', controllerUrl);
        xhr.send(formdata);
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                if (xhr.responseText == 1) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Question added successfully.", '');
                }
                else if (xhr.responseText == 2)
                {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to add question : invalid file extension. ", '');
                }
                else
                {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to add Question. ", '');
                }
                window.location.href = "/CommunityPractice/Index";
                return false;
            }
        }
    }
    else
    {
        PHARMAACE.FORECASTAPP.UTILITY.popalert("Please add question details... ", '');
        return false;
    }
});

//******************************************************AskQuestion.aspx*************************************************************

//***************************************************************LatestQuestions.ascx***********************************************************

$(document).ready(function () {

    $("#CategoryList").change(function () {

        var sVal = $(this).val();
        var categoryId = this.selectedIndex;
        //var categoryId =this.selec;
        //alert(sId);
        if (categoryId != 0) {
            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/CommunityPractice/QuestionsListByCategory", { CategoryId: categoryId },
            function (data) {
                document.getElementById('SearchResult').innerHTML = '';
                document.getElementById('SearchResult').innerHTML = data;
                var questions = $('.questionPostTimetxt');
                for (var i = 0; i < questions.length; i++) {
                    var pDate = questions[i].innerHTML;
                    questions[i].innerHTML = '';
                    questions[i].innerHTML = PHARMAACE.FORECASTAPP.UTILITY.dateDifference(PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(pDate)), "mmddyyyy");
                }
            },
            function (status) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
            });
        }
    });
});
$(document).ready(function () {
    var $placeholder = $('.placeholder');
    $('#question-details').summernote({
        height: 100,
        codemirror: {
            mode: 'text/html',
            htmlMode: true,
            lineNumbers: true,
            theme: 'monokai'
        },
        callbacks: {
            onInit: function () {
                $placeholder.show();
            },
            onFocus: function () {
                $placeholder.hide();
            },
            onBlur: function () {
                var $self = $(this);
                setTimeout(function () {
                    if ($self.summernote('isEmpty') && !$self.summernote('codeview.isActivated')) {
                        $placeholder.show();
                    }
                }, 300);
            }
        }
    });

});

//***************************************************************LatestQuestions.ascx***********************************************************