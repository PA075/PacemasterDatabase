(function(PHARMAACE) {
    (function(FORECASTAPP) {
        (function (NEWSFEED) {
            PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES = {
                FDA_MED: 0, FDA_UCM: 1, CT: 2, MALLINCKRODT: 3, ACTAVIS: 4, PAR: 5, ENDO: 6, MYLAN: 7,
                KREMERS_URBAN: 8, TEVA: 9, SANDOZ: 10, GOOGLE: 11
            };
            PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl = function (sources) {
                if (sources === undefined)
                    sources = Object.keys(PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES);
                if (sources === null || sources.length == 0)
                    return PHARMAACE.FORECASTAPP.CONSTANTS.DEFAULT_NEWS_URL[PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.GOOGLE];
                var mergedSourceUrl = "";
                for (var i = 0; i < sources.length; i++) {
                    var sourceEnumVal = "";
                    if (i > 0)
                        mergedSourceUrl += "|";
                    if (!isNaN(sources[i]))
                        sourceEnumVal = sources[i];
                    else
                        sourceEnumVal = PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES[sources[i]];

                    mergedSourceUrl += PHARMAACE.FORECASTAPP.CONSTANTS.DEFAULT_NEWS_URL[sourceEnumVal];
                }
                return mergedSourceUrl;
            }
            PHARMAACE.FORECASTAPP.NEWSFEED.generateFeed = function (feedParams) {
                var appliedParams = PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultParams();
                //feed count
                if (feedParams && !isNaN(feedParams.feedCount) && feedParams.feedCount > 0)
                    appliedParams.feedCount = feedParams.feedCount;
                //url
                if (feedParams && feedParams.url && feedParams.url.length > 0)
                    appliedParams.url = feedParams.url;
                //keywords
                else if (feedParams && feedParams.keywords && feedParams.keywords.length > 0) {
                    var queryKeyword = PHARMAACE.FORECASTAPP.NEWSFEED.getFlattenedKeywords(feedParams.keywords);
                    appliedParams.url = PHARMAACE.FORECASTAPP.NEWSFEED.setQueryKeyword(PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl([PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.GOOGLE, PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.CT]),
                        [{ source: PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.GOOGLE, queryKeyword: queryKeyword }, { source: PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.CT, queryKeyword: queryKeyword }], false);
                }
                //title
                if (feedParams && feedParams.title && feedParams.title.length > 0)
                    appliedParams.title = feedParams.title;
                feedwind_show_widget_iframe(PHARMAACE.FORECASTAPP.NEWSFEED.updateFeedParams(appliedParams));
            }
            PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultParams = function () {
                return {
                    url: PHARMAACE.FORECASTAPP.NEWSFEED.getDefaultNewsUrl(null),
                    keywords: "",
                    feedCount: PHARMAACE.FORECASTAPP.CONSTANTS.DEFAULT_FEED_COUNT,
                    title: "",
                    titleAlignment: 0,
                    titleLink: "",
                    titleBgColor: "#ffffff",
                    titleColor: "#428bca",
                    itemBgColor: "#fff",
                    itemColor: "#999999",
                    itemDescriptionOn: false,
                };
            }
            PHARMAACE.FORECASTAPP.NEWSFEED.getFlattenedKeywords = function (keywords) {
                var flattenedKeywords = "";
                if (keywords) {
                    flattenedKeywords = keywords[0];
                    if (keywords.length > 1) {
                        for (var i = 1; i < keywords.length; i++) {
                            flattenedKeywords += NEWS_OR + keywords[i];
                        }
                    }
                }
                return flattenedKeywords;
            }
            PHARMAACE.FORECASTAPP.NEWSFEED.updateFeedParams = function (feedParams) {
                var productFeedParams = {
                    rssmikle_url: feedParams.url,
                    rssmikle_frame_width: "350",
                    rssmikle_frame_height: "350",
                    frame_height_by_article: "0",
                    rssmikle_target: "_blank",
                    rssmikle_font: "Arial, Helvetica, sans-serif",
                    rssmikle_font_size: "11",
                    rssmikle_border: "off",
                    responsive: "on",
                    //rssmikle_css_url: "http://localhost:64184/Content/CSS/newsfeed.css",
                    rssmikle_css_url: window.location.protocol + "//" + window.location.host + "/Content/CSS/news.css",
                    text_align: "left",
                    text_align2: "left",
                    corner: "off",
                    scrollbar: "off",
                    autoscroll: "on_mc",
                    scrolldirection: "up",
                    scrollstep: "3",
                    mcspeed: "120",
                    sort: "New",
                    rssmikle_title: "on",
                    rssmikle_title_sentence: feedParams.title,
                    rssmikle_title_link: window.location.protocol + "//" + window.location.host + "/LiveFeed",
                    rssmikle_title_bgcolor: "#ffffff",
                    //"#828c95",
                    rssmikle_title_color: "#428bca",
                    rssmikle_title_bgimage: "",
                    rssmikle_item_bgcolor: "#fff",
                    //"#b5bdc8",
                    rssmikle_item_bgimage: "",
                    rssmikle_item_title_length: "100",
                    rssmikle_item_title_color: "#999999",
                    //"#0066FF",
                    rssmikle_item_border_bottom: "on",
                    //rssmikle_item_description: feedParams.itemDescriptionOn,
                    rssmikle_item_description: "off",
                    item_link: "off",
                    rssmikle_item_description_length: "150",
                    rssmikle_item_description_color: "#FFFFFF",
                    //"#666666",
                    rssmikle_item_date: "gl1",
                    rssmikle_timezone: "Etc/GMT",
                    datetime_format: "%b %e, %Y %l:%M %p",
                    item_description_style: "text+tn",
                    item_thumbnail: "full",
                    item_thumbnail_selection: "auto",
                    article_num: feedParams.count,
                    rssmikle_item_podcast: "off",
                    keyword_inc: "",
                    keyword_exc: ""
                };
                return productFeedParams;
            }
            PHARMAACE.FORECASTAPP.NEWSFEED.setCustomParams = function (feedParams) {
                var productFeedParams = {
                    rssmikle_url: feedParams.url,
                    rssmikle_frame_width: "auto",
                    rssmikle_frame_height: "500",
                    frame_height_by_article: "0",
                    rssmikle_target: "_blank",
                    rssmikle_font: "Arial, Helvetica, sans-serif",
                    rssmikle_font_size: "14",
                    rssmikle_border: "on",
                    responsive: "on",
                    rssmikle_css_url: window.location.protocol + "//" + window.location.host + "/" + "Content/CSS/news.css",
                    text_align: "left",
                    text_align2: "left",
                    corner: "off",
                    scrollbar: "on",
                    autoscroll: "on_mc",
                    scrolldirection: "up",
                    scrollstep: "3",
                    mcspeed: "80",
                    sort: "New",
                    rssmikle_title: "on",
                    rssmikle_title_sentence: feedParams.title,
                    rssmikle_title_link: "",
                    rssmikle_title_bgcolor: "#B0AEAE",
                    //"#0066FF",
                    rssmikle_title_color: "#FFFFFF",
                    rssmikle_title_bgimage: "",
                    rssmikle_item_bgcolor: "#BFBDBD",
                    //"#FFFFFF",
                    rssmikle_item_bgimage: "",
                    rssmikle_item_title_length: "100",
                    rssmikle_item_title_color: "#FFFFFF",
                    //"#0066FF",
                    rssmikle_item_border_bottom: "on",
                    rssmikle_item_description: "off",
                    item_link: "on",
                    rssmikle_item_description_length: "800",
                    rssmikle_item_description_color: "#FFFFFF",
                    //"#666666",
                    rssmikle_item_date: "gl1",
                    rssmikle_timezone: "Etc/GMT",
                    datetime_format: "%b %e, %Y %l:%M %p",
                    item_description_style: "text+tn",
                    item_thumbnail: "full",
                    item_thumbnail_selection: "auto",
                    article_num: feedParams.count,
                    rssmikle_item_podcast: "off",
                    keyword_inc: "",
                    keyword_exc: ""
                };
                return productFeedParams;
            }
            PHARMAACE.FORECASTAPP.NEWSFEED.setCustomParamsFeeds = function (feedParams) {
                var productFeedParams = {
                    rssmikle_url: feedParams.url,
                    rssmikle_frame_width: "auto",
                    rssmikle_frame_height: "497",
                    frame_height_by_article: "0",
                    rssmikle_target: "_blank",
                    rssmikle_font: "Arial, Helvetica, sans-serif",
                    rssmikle_font_size: "14",
                    rssmikle_border: "on",
                    responsive: "on",
                    rssmikle_css_url: window.location.protocol + "//" + window.location.host + "/" + "Content/CSS/NewsFeed.css",
                    text_align: "left",
                    text_align2: "left",
                    corner: "off",
                    scrollbar: "off",
                    autoscroll: "on_mc",
                    scrolldirection: "up",
                    scrollstep: "3",
                    mcspeed: "80",
                    sort: "New",
                    rssmikle_title: "on",
                    rssmikle_title_sentence: feedParams.title,
                    rssmikle_title_link: "",
                    rssmikle_title_bgcolor: "#B0AEAE",
                    //"#0066FF",
                    rssmikle_title_color: "#FFFFFF",
                    rssmikle_title_bgimage: "",
                    rssmikle_item_bgcolor: "#BFBDBD",
                    //"#FFFFFF",
                    rssmikle_item_bgimage: "",
                    rssmikle_item_title_length: "100",
                    rssmikle_item_title_color: "#FFFFFF",
                    //"#0066FF",
                    rssmikle_item_border_bottom: "on",
                    rssmikle_item_description: "on",
                    item_link: "on",
                    rssmikle_item_description_length: "120",
                    rssmikle_item_description_color: "#FFFFFF",
                    //"#666666",
                    rssmikle_item_date: "gl1",
                    rssmikle_timezone: "Etc/GMT",
                    datetime_format: "%b %e, %Y %l:%M %p",
                    item_description_style: "text+tn",
                    item_thumbnail: "full",
                    item_thumbnail_selection: "auto",
                    article_num: feedParams.feedCount,
                    rssmikle_item_podcast: "off",
                    keyword_inc: "",
                    keyword_exc: ""
                };
                return productFeedParams;
            }

            PHARMAACE.FORECASTAPP.NEWSFEED.setCustomParamsFeedsStatic = function (feedParams) {
                var productFeedParams = {
                    rssmikle_url: feedParams.url,
                    rssmikle_frame_width: "auto",
                    rssmikle_frame_height: "530",
                    frame_height_by_article: "0",
                    rssmikle_target: "_blank",
                    rssmikle_font: "Arial, Helvetica, sans-serif",
                    rssmikle_font_size: "14",
                    rssmikle_border: "on",
                    responsive: "on",
                    rssmikle_css_url: window.location.protocol + "//" + window.location.host + "/" + "Content/CSS/NewsFeedStatic.css",
                    text_align: "left",
                    text_align2: "left",
                    corner: "off",
                    scrollbar: "on",
                    autoscroll: "off_mc",
                    scrolldirection: "up",
                    scrollstep: "6",
                    mcspeed: "120",
                    sort: "New",
                    rssmikle_title: "on",
                    rssmikle_title_sentence: feedParams.title,
                    rssmikle_title_link: "",
                    rssmikle_title_bgcolor: "#B0AEAE",
                    //"#0066FF",
                    rssmikle_title_color: "#FFFFFF",
                    rssmikle_title_bgimage: "",
                    rssmikle_item_bgcolor: "#BFBDBD",
                    //"#FFFFFF",
                    rssmikle_item_bgimage: "",
                    rssmikle_item_title_length: "70",
                    rssmikle_item_title_color: "#FFFFFF",
                    //"#0066FF",
                    rssmikle_item_border_bottom: "on",
                    rssmikle_item_description: "on",
                    item_link: "on",
                    rssmikle_item_description_length: "370",
                    rssmikle_item_description_color: "#FFFFFF",
                    //"#666666",
                    rssmikle_item_date: "gl1",
                    rssmikle_timezone: "Etc/GMT",
                    datetime_format: "%b %e, %Y %l:%M %p",
                    item_description_style: "text+tn",
                    item_thumbnail: "full",
                    item_thumbnail_selection: "auto",
                    article_num: feedParams.count,
                    rssmikle_item_podcast: "off",
                    keyword_inc: "",
                    keyword_exc: ""
                };
                return productFeedParams;
            }

            PHARMAACE.FORECASTAPP.NEWSFEED.setQueryKeyword = function (url, sourceQueryKeywordPairs, encode) {
                var operatorQueryParam = encode ? "%26" : "&";
                var operatorEqual = encode ? "%3D" : "=";
                var operatorQueryIdentifier = encode ? "%3F" : "?";
                var sourceSeparator = encode ? "%7C" : "|";
                var arrSourceBasedSplit = url.split(sourceSeparator);
                for (var j = 0; j < sourceQueryKeywordPairs.length; j++) {
                    var pair = sourceQueryKeywordPairs[j];
                    var querySymbol = PHARMAACE.FORECASTAPP.NEWSFEED.getSourceBasedQuerySymbol(pair.source);
                    if (querySymbol) {
                        var srcComponents = arrSourceBasedSplit[j].split(operatorQueryParam);
                        var queryStart = srcComponents[0].split(operatorQueryIdentifier + querySymbol + operatorEqual);
                        queryStart[1] = pair.queryKeyword;
                        srcComponents[0] = queryStart.join(operatorQueryIdentifier + querySymbol + operatorEqual);
                        arrSourceBasedSplit[j] = srcComponents.join(operatorQueryParam);
                    }
                }
                return arrSourceBasedSplit.join(sourceSeparator);
            }

            PHARMAACE.FORECASTAPP.NEWSFEED.getSourceBasedQuerySymbol = function (source) {
                var symbol = "";
                switch (source) {
                    case PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.GOOGLE:
                        symbol = "q";
                        break;
                    case PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.CT:
                        symbol = "term";
                        break;
                    default:
                        symbol = "";
                        break;
                }

                return symbol;
            }
            
            PHARMAACE.FORECASTAPP.NEWSFEED.makeQueryKeyword = function (allPhrases, encode, atleastonePhrases, sources) {
                var sourceQueryKeywordPairs = [];
                for (var i = 0; i < sources.length; i++) {
                    sourceQueryKeywordPairs[i] = {};
                    sourceQueryKeywordPairs[i].source = sources[i];
                    if (sources[i] == PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.GOOGLE || sources[i] == PHARMAACE.FORECASTAPP.NEWSFEED.SOURCES.CT) {
                        sourceQueryKeywordPairs[i].queryKeyword = PHARMAACE.FORECASTAPP.NEWSFEED.makeQueryKeywordGoogle(allPhrases, encode, atleastonePhrases);
                    }
                    else {
                        sourceQueryKeywordPairs[i].queryKeyword = "";
                    }
                }

                return sourceQueryKeywordPairs;
            }

            PHARMAACE.FORECASTAPP.NEWSFEED.makeQueryKeywordGoogle = function (allPhrases, encode, atleastonePhrases) {
                var mustHaveAllOfThem = "";
                var mustHaveOneOfThem = "";
                var operatorPhrase = encode ? "%2B" : "+";
                var operatorAND = operatorPhrase + "AND" + operatorPhrase;
                var operatorOR = operatorPhrase + "OR" + operatorPhrase;
                if (allPhrases) {
                    for (var j = 0; j < allPhrases.length; j++) {
                        var queryKeyword = "";
                        var allwords = allPhrases[j];
                        var arrWords = allwords.split(' ');
                        for (var i = 0; i < arrWords.length; i++) {
                            if (arrWords[i]) {
                                if (queryKeyword)
                                    queryKeyword += operatorPhrase;
                                queryKeyword += arrWords[i];
                            }
                        }
                        if (queryKeyword) {
                            if (mustHaveAllOfThem)
                                mustHaveAllOfThem += operatorAND;
                            mustHaveAllOfThem += '"' + queryKeyword + '"';
                        }
                    }
                }
                if (atleastonePhrases) {
                    for (var j = 0; j < atleastonePhrases.length; j++) {
                        var queryKeyword = "";
                        var allwords = atleastonePhrases[j];
                        var arrWords = allwords.split(' ');
                        for (var i = 0; i < arrWords.length; i++) {
                            if (arrWords[i]) {
                                if (queryKeyword)
                                    queryKeyword += operatorPhrase;
                                queryKeyword += arrWords[i];
                            }
                        }
                        if (queryKeyword) {
                            if (mustHaveOneOfThem)
                                mustHaveOneOfThem += operatorOR;
                            mustHaveOneOfThem += '"' + queryKeyword + '"';
                        }
                    }
                }
                var final = mustHaveAllOfThem;
                if (final && mustHaveOneOfThem)
                    final += operatorAND;
                final += mustHaveOneOfThem;
                return final;
            }

            PHARMAACE.FORECASTAPP.NEWSFEED.getProductKeywords = function () {
                return ["Concerta", "Invega Sustena", "Invega Trinza", "Focalin XR", "Addreal XR", "Adderal IR", "Xyrem", "Oxycodone Solution", "Oxycontin ER",
                    "Vyvanse", "Truvada", "Benzaclin", "Lamictal"];
            }

            PHARMAACE.FORECASTAPP.NEWSFEED.getMoleculeKeywords = function () {
                return ["methylphenidate ER"];
            }

            PHARMAACE.FORECASTAPP.NEWSFEED.getRegulatoryKeywords = function () {
                return ["ADHD Therapy Area", "Attention Deficit Hyperactivity Disorder", "Abbreviated New Drug Application", "ANDA",
                "AB status", "BX Status", "Bioequivalence", "Approval", "FDA", "Food Drug and Administration"];
            }

        }(window.PHARMAACE.FORECASTAPP.NEWSFEED = window.PHARMAACE.FORECASTAPP.NEWSFEED || {}));
    }(window.PHARMAACE.FORECASTAPP = window.PHARMAACE.FORECASTAPP || {}));
}(window.PHARMAACE = window.PHARMAACE || {}));