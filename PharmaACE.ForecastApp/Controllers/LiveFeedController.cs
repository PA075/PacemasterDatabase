using HtmlAgilityPack;
using PharmaACE.ForecastApp.Business;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Mvc;
namespace PharmaACE.ForecastApp.Controllers
{
    public class LiveFeedController : BaseController
    {
        //
        // GET: /LiveFeed/
        public ActionResult Index()
        {
            logger.Info("Inside LiveFeed/Index");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)) && (Session["AccessTypeCF"].SafeToNum() != 0))
            {
                NewsFeed newsFeed = new UserManager(UnitOfWork).GetNewsFeedParams(Session["UserId"].SafeToNum());
                if (newsFeed!=null)
                {
                    logger.Info("Got News feed successfully");
                }else
                    logger.Info("fetching News feed fail");
                return View(newsFeed);
            }
            else
            {
                logger.Error("Session is null");
                return RedirectToAction("Index", "Home");
            }
        }
        [HttpGet]
        public ActionResult GetFeedNews(string url)
        {
            logger.Info("Inside LiveFeed/GetFeedNews");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                url = "https://feed.mikle.com/widget/?rssmikle_url=" + HttpUtility.UrlEncode(url) + "&rssmikle_frame_width=auto&rssmikle_frame_height=555&frame_height_by_article=0&rssmikle_target=_blank&rssmikle_font=Arial%2C%20Helvetica%2C%20sans-serif&rssmikle_font_size=14&rssmikle_border=on&responsive=on&rssmikle_css_url=http%3A%2F%2Flocalhost%3A64184%2FContent%2FCSS%2FNewsFeed.css&text_align=left&text_align2=left&corner=off&scrollbar=on&autoscroll=on_mc&scrolldirection=up&scrollstep=6&mcspeed=120&sort=New&rssmikle_title=on&rssmikle_title_sentence=Keywords%3A%20Design%20Your%20Customised%20Feed%20Using%20News%20Settings!&rssmikle_title_bgcolor=%23B0AEAE&rssmikle_title_color=%23FFFFFF&rssmikle_item_bgcolor=%23BFBDBD&rssmikle_item_title_length=70&rssmikle_item_title_color=%23FFFFFF&rssmikle_item_border_bottom=on&rssmikle_item_description=on&item_link=on&rssmikle_item_description_length=370&rssmikle_item_description_color=%23FFFFFF&rssmikle_item_date=gl1&rssmikle_timezone=Etc%2FGMT&datetime_format=%25b%20%25e%2C%20%25Y%20%25l%3A%25M%20%25p&item_description_style=text%2Btn&item_thumbnail=full&item_thumbnail_selection=auto&rssmikle_item_podcast=off&"; //"&rssmikle_frame_width=auto&rssmikle_frame_height=500&frame_height_by_article=0&rssmikle_target=_blank&rssmikle_font=Arial%2C%20Helvetica%2C%20sans-serif&rssmikle_font_size=14&rssmikle_border=on&responsive=on&rssmikle_css_url=http%3A%2F%2Flocalhost%3A64184%2FContent%2FCSS%2FNewsFeedStatic.css&text_align=left&text_align2=left&corner=off&scrollbar=on&autoscroll=off_mc&scrolldirection=up&scrollstep=3&mcspeed=80&sort=New&rssmikle_title=on&rssmikle_title_sentence=Keywords%3A%20t&rssmikle_title_bgcolor=%23B0AEAE&rssmikle_title_color=%23FFFFFF&rssmikle_item_bgcolor=%23BFBDBD&rssmikle_item_title_length=100&rssmikle_item_title_color=%23FFFFFF&rssmikle_item_border_bottom=on&rssmikle_item_description=on&item_link=on&rssmikle_item_description_length=370&rssmikle_item_description_color=%23FFFFFF&rssmikle_item_date=gl1&rssmikle_timezone=Etc%2FGMT&datetime_format=%25b%20%25e%2C%20%25Y%20%25l%3A%25M%20%25p&item_description_style=text+tn&item_thumbnail=full&item_thumbnail_selection=auto&article_num=20&rssmikle_item_podcast=off";
                ViewBag.Mydata = GetFeed(url);
                if (ViewBag.Mydata != null)
                {
                    logger.Info("Got News feed successfully");
                }
                else
                    logger.Info("fetching News feed fail");
                return View();
            }
            else
            {
                logger.Error("Session is null");
                return RedirectToAction("Index", "Home");
            }
        }
        [HttpGet]
        public ActionResult GetFeedNewsStatic(string url, int divOrder, int item,string fdaKeyword)
        {
            logger.Info("Inside LiveFeed/GetFeedNewsStatic");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                List<string> FdaKeywordsList = new List<string>();
                //fdaKeyword = "DAIICHI SANKYO";
                if(divOrder == 0) //Home
                {
                    logger.Info("Home divOrder:{0}", divOrder);
                    if (item == 0) //Top Stories
                    {
                        url = String.Format("https://feed.mikle.com/widget/?rssmikle_url={0}&rssmikle_frame_width=auto&rssmikle_frame_height=555&frame_height_by_article=0&rssmikle_target=_blank&rssmikle_font=Arial%2C%20Helvetica%2C%20sans-serif&rssmikle_font_size=14&rssmikle_border=on&responsive=on&rssmikle_css_url=http%3A%2F%2Flocalhost%3A64184%2FContent%2FCSS%2FNewsFeedStatic.css&text_align=left&text_align2=left&corner=off&scrollbar=on&autoscroll=off_mc&scrolldirection=up&scrollstep=6&mcspeed=120&sort=New&rssmikle_title=on&rssmikle_title_sentence=&rssmikle_title_bgcolor=%23B0AEAE&rssmikle_title_color=%230000FF&rssmikle_item_bgcolor=%23BFBDBD&rssmikle_item_title_length=70&rssmikle_item_title_color=%23FFFFFF&rssmikle_item_border_bottom=on&rssmikle_item_description=on&item_link=on&rssmikle_item_description_length=800&rssmikle_item_description_color=%23FFFFFF&rssmikle_item_date=gl1&rssmikle_timezone=Etc%2FGMT&datetime_format=%25b%20%25e%2C%20%25Y%20%25l%3A%25M%20%25p&article_num=50&item_description_style=text%2Btn&item_thumbnail=full&item_thumbnail_selection=auto&rssmikle_item_podcast=off&", HttpUtility.UrlEncode(url));
                        ViewBag.Mydata = GetTopRatedFeeds(url, divOrder, null, "Top Stories"); //GetFeed(url);
                        if (ViewBag.Mydata!=null)
                        {
                            logger.Info("Got top stories successfully");
                        }
                        else
                            logger.Info("Getting top stories fail");
                    }
                    if(item == 1) //Latest Stories
                    {
                        url = String.Format("https://feed.mikle.com/widget/?rssmikle_url={0}&rssmikle_frame_width=auto&rssmikle_frame_height=555&frame_height_by_article=0&rssmikle_target=_blank&rssmikle_font=Arial%2C%20Helvetica%2C%20sans-serif&rssmikle_font_size=14&rssmikle_border=on&responsive=on&rssmikle_css_url=http%3A%2F%2Flocalhost%3A64184%2FContent%2FCSS%2FNewsFeedStatic.css&text_align=left&text_align2=left&corner=off&scrollbar=on&autoscroll=off_mc&scrolldirection=up&scrollstep=6&mcspeed=120&sort=New&rssmikle_title=on&rssmikle_title_sentence=&rssmikle_title_bgcolor=%23B0AEAE&rssmikle_title_color=%230000FF&rssmikle_item_bgcolor=%23BFBDBD&rssmikle_item_title_length=70&rssmikle_item_title_color=%23FFFFFF&rssmikle_item_border_bottom=on&rssmikle_item_description=on&item_link=on&rssmikle_item_description_length=800&rssmikle_item_description_color=%23FFFFFF&rssmikle_item_date=gl1&rssmikle_timezone=Etc%2FGMT&datetime_format=%25b%20%25e%2C%20%25Y%20%25l%3A%25M%20%25p&article_num=50&item_description_style=text%2Btn&item_thumbnail=full&item_thumbnail_selection=auto&rssmikle_item_podcast=off&", HttpUtility.UrlEncode(url));
                        ViewBag.Mydata = GetLatestFeedNewsStatic(url);
                        if (ViewBag.Mydata != null)
                        {
                            logger.Info("Got Latest Stories successfully");
                        }
                        else
                            logger.Info("Getting Latest Stories fail");
                    }
                }

                if (divOrder == 1) //Generic
                {
                    logger.Info("Generic divOrder:{0}", divOrder);
                    if (item == 0) //Top Stories
                    {
                        //FdaKeywordsList = GetListOfProductAndCompany();
                        url = String.Format("https://feed.mikle.com/widget/?rssmikle_url={0}&rssmikle_frame_width=auto&rssmikle_frame_height=555&frame_height_by_article=0&rssmikle_target=_blank&rssmikle_font=Arial%2C%20Helvetica%2C%20sans-serif&rssmikle_font_size=14&rssmikle_border=on&responsive=on&rssmikle_css_url=http%3A%2F%2Flocalhost%3A64184%2FContent%2FCSS%2FNewsFeedStatic.css&text_align=left&text_align2=left&corner=off&scrollbar=on&autoscroll=off_mc&scrolldirection=up&scrollstep=6&mcspeed=120&sort=New&rssmikle_title=on&rssmikle_title_sentence=&rssmikle_title_bgcolor=%23B0AEAE&rssmikle_title_color=%230000FF&rssmikle_item_bgcolor=%23BFBDBD&rssmikle_item_title_length=70&rssmikle_item_title_color=%23FFFFFF&rssmikle_item_border_bottom=on&rssmikle_item_description=on&item_link=on&rssmikle_item_description_length=800&rssmikle_item_description_color=%23FFFFFF&rssmikle_item_date=gl1&rssmikle_timezone=Etc%2FGMT&datetime_format=%25b%20%25e%2C%20%25Y%20%25l%3A%25M%20%25p&article_num=50&item_description_style=text%2Btn&item_thumbnail=full&item_thumbnail_selection=auto&rssmikle_item_podcast=off&", HttpUtility.UrlEncode(url));
                        ViewBag.Mydata = GetTopRatedFeeds(url, divOrder, null, "Top Stories"); //GetFeed(url);
                        if (ViewBag.Mydata != null)
                        {
                            logger.Info("Got Top Stories successfully");
                        }
                        else
                            logger.Info("Getting Top Stories fail");
                    }
                    if (item == 1) //Latest Stories
                    {
                        url = String.Format("https://feed.mikle.com/widget/?rssmikle_url={0}&rssmikle_frame_width=auto&rssmikle_frame_height=555&frame_height_by_article=0&rssmikle_target=_blank&rssmikle_font=Arial%2C%20Helvetica%2C%20sans-serif&rssmikle_font_size=14&rssmikle_border=on&responsive=on&rssmikle_css_url=http%3A%2F%2Flocalhost%3A64184%2FContent%2FCSS%2FNewsFeedStatic.css&text_align=left&text_align2=left&corner=off&scrollbar=on&autoscroll=off_mc&scrolldirection=up&scrollstep=6&mcspeed=120&sort=New&rssmikle_title=on&rssmikle_title_sentence=&rssmikle_title_bgcolor=%23B0AEAE&rssmikle_title_color=%230000FF&rssmikle_item_bgcolor=%23BFBDBD&rssmikle_item_title_length=70&rssmikle_item_title_color=%23FFFFFF&rssmikle_item_border_bottom=on&rssmikle_item_description=on&item_link=on&rssmikle_item_description_length=800&rssmikle_item_description_color=%23FFFFFF&rssmikle_item_date=gl1&rssmikle_timezone=Etc%2FGMT&datetime_format=%25b%20%25e%2C%20%25Y%20%25l%3A%25M%20%25p&article_num=50&item_description_style=text%2Btn&item_thumbnail=full&item_thumbnail_selection=auto&rssmikle_item_podcast=off&", HttpUtility.UrlEncode(url));
                        ViewBag.Mydata = GetLatestFeedNewsStatic(url);
                        if (ViewBag.Mydata != null)
                        {
                            logger.Info("Got Latest Stories successfully");
                        }
                        else
                            logger.Info("Getting Latest Stories fail");
                    }
                    if (item == 2) //Product
                    {
                        url = String.Format("https://feed.mikle.com/widget/?rssmikle_url={0}&rssmikle_frame_width=auto&rssmikle_frame_height=555&frame_height_by_article=0&rssmikle_target=_blank&rssmikle_font=Arial%2C%20Helvetica%2C%20sans-serif&rssmikle_font_size=14&rssmikle_border=on&responsive=on&rssmikle_css_url=http%3A%2F%2Flocalhost%3A64184%2FContent%2FCSS%2FNewsFeedStatic.css&text_align=left&text_align2=left&corner=off&scrollbar=on&autoscroll=off_mc&scrolldirection=up&scrollstep=6&mcspeed=120&sort=New&rssmikle_title=on&rssmikle_title_sentence=&rssmikle_title_bgcolor=%23B0AEAE&rssmikle_title_color=%230000FF&rssmikle_item_bgcolor=%23BFBDBD&rssmikle_item_title_length=70&rssmikle_item_title_color=%23FFFFFF&rssmikle_item_border_bottom=on&rssmikle_item_description=on&item_link=on&rssmikle_item_description_length=800&rssmikle_item_description_color=%23FFFFFF&rssmikle_item_date=gl1&rssmikle_timezone=Etc%2FGMT&datetime_format=%25b%20%25e%2C%20%25Y%20%25l%3A%25M%20%25p&article_num=50&item_description_style=text%2Btn&item_thumbnail=full&item_thumbnail_selection=auto&rssmikle_item_podcast=off&", HttpUtility.UrlEncode(url));
                        FdaKeywordsList.Add(fdaKeyword);
                        //FdaKeywordsList = GetListOfProductAndCompany();
                        ViewBag.Mydata = GetTopRatedFeedsForFdaList(url, divOrder, FdaKeywordsList);
                        //ViewBag.Mydata = GetLatestFeedNewsStatic(url);
                        if (ViewBag.Mydata != null)
                        {
                            logger.Info("Got Top rated feeds successfully for Product");
                        }
                        else
                            logger.Info("Getting Top rated feeds fail for product");
                    }
                    if (item == 3) //Company
                    {
                        url = String.Format("https://feed.mikle.com/widget/?rssmikle_url={0}&rssmikle_frame_width=auto&rssmikle_frame_height=555&frame_height_by_article=0&rssmikle_target=_blank&rssmikle_font=Arial%2C%20Helvetica%2C%20sans-serif&rssmikle_font_size=14&rssmikle_border=on&responsive=on&rssmikle_css_url=http%3A%2F%2Flocalhost%3A64184%2FContent%2FCSS%2FNewsFeedStatic.css&text_align=left&text_align2=left&corner=off&scrollbar=on&autoscroll=off_mc&scrolldirection=up&scrollstep=6&mcspeed=120&sort=New&rssmikle_title=on&rssmikle_title_sentence=&rssmikle_title_bgcolor=%23B0AEAE&rssmikle_title_color=%230000FF&rssmikle_item_bgcolor=%23BFBDBD&rssmikle_item_title_length=70&rssmikle_item_title_color=%23FFFFFF&rssmikle_item_border_bottom=on&rssmikle_item_description=on&item_link=on&rssmikle_item_description_length=800&rssmikle_item_description_color=%23FFFFFF&rssmikle_item_date=gl1&rssmikle_timezone=Etc%2FGMT&datetime_format=%25b%20%25e%2C%20%25Y%20%25l%3A%25M%20%25p&article_num=50&item_description_style=text%2Btn&item_thumbnail=full&item_thumbnail_selection=auto&rssmikle_item_podcast=off&", HttpUtility.UrlEncode(url));
                        FdaKeywordsList.Add(fdaKeyword);
                        ViewBag.Mydata = GetTopRatedFeedsForFdaList(url, divOrder, FdaKeywordsList);
                        if (ViewBag.Mydata != null)
                        {
                            logger.Info("Got Top rated feeds successfully for Company");
                        }
                        else
                            logger.Info("Getting Top rated feeds fail for Company");
                        //ViewBag.Mydata = GetLatestFeedNewsStatic(url);
                    }
                    if (item == 4) //Regulatory
                    {
                        url = String.Format("https://feed.mikle.com/widget/?rssmikle_url={0}&rssmikle_frame_width=auto&rssmikle_frame_height=555&frame_height_by_article=0&rssmikle_target=_blank&rssmikle_font=Arial%2C%20Helvetica%2C%20sans-serif&rssmikle_font_size=14&rssmikle_border=on&responsive=on&rssmikle_css_url=http%3A%2F%2Flocalhost%3A64184%2FContent%2FCSS%2FNewsFeedStatic.css&text_align=left&text_align2=left&corner=off&scrollbar=on&autoscroll=off_mc&scrolldirection=up&scrollstep=6&mcspeed=120&sort=New&rssmikle_title=on&rssmikle_title_sentence=&rssmikle_title_bgcolor=%23B0AEAE&rssmikle_title_color=%230000FF&rssmikle_item_bgcolor=%23BFBDBD&rssmikle_item_title_length=70&rssmikle_item_title_color=%23FFFFFF&rssmikle_item_border_bottom=on&rssmikle_item_description=on&item_link=on&rssmikle_item_description_length=800&rssmikle_item_description_color=%23FFFFFF&rssmikle_item_date=gl1&rssmikle_timezone=Etc%2FGMT&datetime_format=%25b%20%25e%2C%20%25Y%20%25l%3A%25M%20%25p&article_num=50&item_description_style=text%2Btn&item_thumbnail=full&item_thumbnail_selection=auto&rssmikle_item_podcast=off&", HttpUtility.UrlEncode(url));
                        //ViewBag.Mydata = GetLatestFeedNewsStatic(url);
                       // ViewBag.Mydata = GetTopRatedFeeds(url, divOrder, null);
                        ViewBag.Mydata = GetTopRatedFeedsForFdaList(url, divOrder, null, "Latest Stories");
                        if (ViewBag.Mydata != null)
                        {
                            logger.Info("Got Top rated feeds successfully for Regulatory");
                        }
                        else
                            logger.Info("Getting Top rated feeds fail for Regulatorys");
                    }
                }
                
                return View();
            }
            else
            {
                logger.Error("Session is null");
                return RedirectToAction("Index", "Home");
            }
        }

        [HttpPost]
        public JsonResult SetFeedRating(NewsFeedItem item)
        {
            logger.Info("Inside LiveFeed/SetFeedRating");
            int companyId = int.Parse(Session["CompanyId"].ToString());
            string msg = "";            
            try
            {
                if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
                {
                    new FeedManager(UnitOfWork).SetFeedData(item, Session["UserId"].SafeToNum(), companyId);
                }
                else
                    logger.Error("Session is null");
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at LiveFeed/SetFeedRating: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        private string GetLatestFeedNewsStatic(string url)
        {
            logger.Info("Inside LiveFeed/GetLatestFeedNewsStatic");
            return GetFeed(url);                
        }

        public List<string> GetListOfProductAndCompany()
        {
            logger.Info("Inside LiveFeed/GetListOfProductAndCompany");
            List<string> SearchList = new List<string>();
            SearchList.Add("Concerta");
            SearchList.Add("Invega Sustenna");
            SearchList.Add("Invega Trinza");
            SearchList.Add("Focalin XR");
            SearchList.Add("Adderal XR");
            SearchList.Add("Adderal IR");
            SearchList.Add("Xyrem");
            SearchList.Add("Oxycodone Solution");
            SearchList.Add("Oxycontin ER");
            SearchList.Add("Vyvanse");
            SearchList.Add("Truvada");
            SearchList.Add("Benzaclin");
            SearchList.Add("Lamictal XR");
            SearchList.Add("Mallinckrodt");
            SearchList.Add("Actavis");
            SearchList.Add("Osmotica");
            SearchList.Add("Endo");
            SearchList.Add("Par");
            SearchList.Add("Mylan");
            SearchList.Add("Kremers Urban");
            SearchList.Add("Teva");
            SearchList.Add("Sandoz");
            SearchList.Add("Janssen");
            //SearchList.Add("QUETIAPINE FUMARATE");
            //SearchList.Add("DAIICHI SANKYO");
            //SearchList.Add("MYLAN");
            
            return SearchList;
        }

        private string GetFeed(string urlAddress)
        {
            logger.Info("Inside LiveFeed/GetFeed");
            string data = null;
            try
            {
                HttpWebRequest request = (HttpWebRequest) WebRequest.Create(urlAddress);
                HttpWebResponse response = (HttpWebResponse) request.GetResponse();
                if (response.StatusCode == HttpStatusCode.OK)
                {
                    Stream receiveStream = response.GetResponseStream();
                    StreamReader readStream = null;
                    if (response.CharacterSet == null)
                        readStream = new StreamReader(receiveStream);
                    else
                        readStream = new StreamReader(receiveStream, Encoding.GetEncoding(response.CharacterSet));
                    data = readStream.ReadToEnd();
                    response.Close();
                    readStream.Close();

                }
            }
            catch (Exception ex)
            {
                logger.Error("Exception at LiveFeed/GetFeed: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }

            return data;
        }

        private string GetTopRatedFeedsForFdaList(string url, int divOrder, List<string> fdaKeywords, string caption = null)
        {
            logger.Info("Inside LiveFeed/GetTopRatedFeedsForFdaList");
            string result = String.Empty;
            int companyId = int.Parse(Session["CompanyId"].ToString());
            NewsFeedItems feedItems = new NewsFeedItems();
            HashSet<string> allRemovedNews = new HashSet<string>();
            List<FDAApprovalDetails> itemresult = new List<FDAApprovalDetails>();
            List<string> FdaListOfUrl = new List<string>();
            string feed = String.Empty;
            var result2 = new JsonResult();
            string msg = "";
            try
            {
                if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
                {
                    //var str = GetFeed(url);            
                    HtmlWeb web = new HtmlWeb();
                    HtmlDocument doc = web.Load(url);
                    doc.OptionOutputOriginalCase = true;
                    
                    doc.OptionFixNestedTags = true;
                    if (doc.ParseErrors != null && doc.ParseErrors.Count() > 0)
                    {
                        // Handle any parse errors as required
                    }
                    else
                    {
                        if (doc.DocumentNode != null)
                        {
                            UpdateCaption(doc, caption);
                            HtmlNode node = doc.DocumentNode.SelectSingleNode("//div[@id='container']//div[2]");
                            if (node != null)
                            {
                                if (fdaKeywords != null)
                                {
                                if (divOrder == 1)
                                {   
                                    FdaListOfUrl = GenerateFeedUrllist(fdaKeywords);
                                    if (FdaListOfUrl.Count > 0)
                                    {
                                        for (int j = 0; j < FdaListOfUrl.Count; j++)
                                        {

                                            //feed += FdaListOfUrl[j];
                                            node.FirstChild.InnerHtml += FdaListOfUrl[j];
                                        }
                                    }
                                }
                                    result = doc.DocumentNode.OuterHtml;
                                }
                                else
                                {
                                    // ----------------------------compare first with removed news------------------------//
                                    
                                    List<string> uniqueLinks = new List<string>();
                                    allRemovedNews = new FeedManager(UnitOfWork).getRemovedLinkFromFilteredNewsTable();   
                                    //HtmlNodeCollection node1 = doc.DocumentNode.SelectNodes("//div[@class='feed_item_link']//a/@href");
                                    //HtmlNode node1 = doc.DocumentNode.SelectSingleNode("//div[@id='content']");
                                    var node1 = doc.DocumentNode.SelectNodes("//div[@class='feed_item']");
                                    result = doc.DocumentNode.OuterHtml;
                                    for (int i = 0; i < node1.Count; i++)
                                    {
                                        var divToRemove = node1[i];
                                        string linkTitle = divToRemove.ChildNodes[7].ChildNodes[0].Attributes[0].Value;
                                        if (allRemovedNews.Contains(linkTitle))
                                        {
                                            result = result.Replace(divToRemove.OuterHtml, String.Empty);
                                        }                                        
                                    }    
                                   
                                   }
                               
                            }
                        }
                    }

                    //result = doc.DocumentNode.OuterHtml;
                   
                }
                else
                    logger.Info("session is null");

            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at LiveFeed/GetTopRatedFeedsForFdaList: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }

            return result;
        }

        private void UpdateCaption(HtmlDocument doc, string caption)
        {
            logger.Info("Inside LiveFeed/UpdateCaption");
            var captionNode = doc.DocumentNode.SelectSingleNode("//div[@id='container']//div[1]");
            if (captionNode != null)
            {
                var captionLinks = captionNode.Descendants("a").ToList();
                if (captionLinks != null)
                {
                    var newNodeStr = String.Format("<a target='_blank' rel='nofollow' style='font-size: 18px; cursor: default;'>{0}</a>", caption);
                    var newNode = HtmlNode.CreateNode(newNodeStr);
                    captionLinks[0].ParentNode.ReplaceChild(newNode, captionLinks[0]);
                    logger.Info("Update Caption successful");
                }
            }
        }

        [HttpGet]
        public JsonResult removeNewsFromList(string link,string item)
        {
            logger.Info("Inside LiveFeed/removeNewsFromList");
            string msg = String.Empty;
            bool result = false;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            result = new FeedManager(UnitOfWork).removeNewsFromList(link, item);
            if (result)
            {
                logger.Info("remove News From List is successful");
                return Json(new { success = true, removed = result }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                logger.Info("remove News From List is fail");
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }

        }

        public JsonResult GetNewsFeedWithComment(string link)
        {
            logger.Info("Inside LiveFeed/GetNewsFeedWithComment");
            string msg = String.Empty;
            int tenantId = int.Parse(Session["CompanyId"].ToString());
            string feedCount = string.Empty;
            NewsFeedItems feedItems = new NewsFeedItems();
            try
            {
                feedItems = new FeedManager(UnitOfWork).GetFeedDataWithComment(tenantId, link);
                if (feedItems != null && feedItems.Items != null && feedItems.Items.Count > 0)
                {
                    feedCount += "<div id='cmtsclbar'>";
                    for (int i = 0; i < feedItems.Items.Count; i++)
                    {

                        var item = feedItems.Items[i];
                        string timestamp = item.TimeStamp;
                        string comment = item.Comment;
                        double rating = item.Rating;
                        string firstName = item.FirstName;
                        string lastName = item.LastName;
                        feedCount += "<p class='commentbubble flname' style='font-weight:bold;text-transform:capitalize;' >" + firstName + " "+ lastName +": "+"</p>";
                        if (comment != "")
                        {
                            feedCount += "<p class='commentbubble'>" + comment + "</p>";
                        }

                        feedCount += "<p class='commentbubble'>" + timestamp + "</p>";
                        feedCount += getRatingHtmlForComment(i, rating);
          
                        if(i == 1)
                        {
                            feedCount += "<input type='hidden' id='idforscroller'/>";
                        }
                    }
                    feedCount += "</div>";
                }
                else
                {
                    throw new Exception("comments are not present");
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at LiveFeed/GetNewsFeedWithComment: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
            {
                logger.Info("successfully Get News Feed With Comment");
                return Json(new { success = true, feedCount = feedCount }, JsonRequestBehavior.AllowGet);
            }
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            
        }

        private string GetTopRatedFeeds(string url, int divOrder, List<string> fdaKeywords, string caption = null)
        {
            //GetUrl(3);
            logger.Info("Inside LiveFeed/GetTopRatedFeeds");
            List<int>  userIds;
            string result = String.Empty;
            int companyId = int.Parse(Session["CompanyId"].ToString());
            NewsFeedItems feedItems = new NewsFeedItems();
            List<FDAApprovalDetails> itemresult = new List<FDAApprovalDetails>();
            List<string> outputValue = new List<string>();
            string feed = String.Empty;
            //List<string> SearchString = new List<string>();
            //SearchString.Add("QUETIAPINE FUMARATE");
            //SearchString.Add("DAIICHI SANKYO");
            var result2 = new JsonResult();
            string msg = "";
            try
            {
                if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
                {
                    //var str = GetFeed(url);            
                    HtmlWeb web = new HtmlWeb();
                    HtmlDocument doc = web.Load(url);
                    doc.OptionFixNestedTags = true;
                    if (doc.ParseErrors != null && doc.ParseErrors.Count() > 0)
                    {
                        // Handle any parse errors as required
                    }
                    else
                    {
                        if (doc.DocumentNode != null)
                        {
                            UpdateCaption(doc, caption);
                            HtmlNode node = doc.DocumentNode.SelectSingleNode("//div[@id='container']//div[2]");
                            if (node != null)
                            {
                                feedItems = new FeedManager(UnitOfWork).GetFeedData(companyId, divOrder);
                                string isAllowed = "true";
                                if (feedItems != null && feedItems.Items != null && feedItems.Items.Count > 0)
                                {
                                    if (feedItems.Items.Count <= GenUtil.DEFAULT_FEED_COUNT)
                                    {
                                    for (int i = 0; i < feedItems.Items.Count; i++)
                                    {
                                       
                                            var item = feedItems.Items[i];
                                            /////////////////////////////////////////////////////////////////////////
                                            userIds = new FeedManager(UnitOfWork).CommentedUserIds(item.Link,companyId);

                                            for (int j = 0; j < userIds.Count; j++)
                                            {
                                                if (int.Parse(Session["UserId"].ToString()) == userIds[j])
                                                {
                                                    isAllowed = "false";
                                                     break;
                                                }
                                                else
                                                {
                                                    isAllowed = "true";
                                                }

                                            }
                                            ///////////////////////////////////////////////////////////////


                                            string link = item.Link;
                                            string title = item.Title;
                                            string desc = item.Description;
                                            string timestamp = item.TimeStamp;
                                            string thumbnail = item.Thumbnail;
                                            double rating = item.Rating;
                                            string source = item.Source;

                                            var thumbnailDesc = String.Empty;
                                            if (!String.IsNullOrEmpty(item.Thumbnail))
                                            {
                                                thumbnailDesc += "<div class=\"feed_item_thumbnail imgLiquid_bgSize imgLiquid_ready\"";
                                                thumbnailDesc += String.Format("style=\"background - image: url(&quot;//t3.gstatic.com/images?q=tbn:{0}&quot;); background-size: contain; background-position: center center; background-repeat: no-repeat;\">", thumbnail);
                                                thumbnailDesc += String.Format("<a href=\"{0}\" target=\"_blank\" rel=\"nofollow\" style=\"display: block; width: 100%; height: 100%;\"><img src=\"//t3.gstatic.com/images?q=tbn:{1}\" style=\"display: none;\"></a></div>", HttpUtility.HtmlEncode(link), thumbnail);
                                            }
                                            string descWithThumb = thumbnailDesc + desc;
                                            //feed += "hie this is top feed";
                                            feed += "\n\n\n  <div class=\"feed_item\">\n    ";
                                            feed += "<div class=\"feed_item_title\">";
                                            feed += String.Format("<a toAllowComment= " + isAllowed + " href=\"{0}\"  target=\"_blank\" rel=\"nofollow\">{3}</a></div><div style=\"position: absolute; top: 0px; right: 10px; color:#444;\"><a href=\"#\" onclick=\"removeonclick(event, this);\" id=\"removeClic\"><i class=\"fa fa-times newsRemove \" aria-hidden=\"true\" style=\"color:#c00; float:left; margin-top:3px;font-size:1.4em; opacity:0.76;\" id=\"closebtn1\"  data-toggle=\"tooltip\" data-placement=\"left\" title=\"Remove this feed : will be filtered out now onwards\"></i></a></div>\n          <div class=\"feed_item_description\">\n            {1}&nbsp;...    </div>\n        <div class=\"feed_item_date\">{2}</div>\n        ", link, descWithThumb, timestamp, title.Length >= 70 ? title.Substring(0, 70) : title);
                                           feed += String.Format("<div class=\"feed_item_link\"><a href = \"{0}\" target=\"_blank\" rel=\"nofollow\">{1}</a></div>", HttpUtility.HtmlEncode(link), source);
                                            feed += getRatingHtml(i, rating);
                                            feed += "</div> ";
                                        
                                        node.InnerHtml = feed;
                                    }
                                    }
                                    else
                                    {
                                        for (int i = 0; i < GenUtil.DEFAULT_FEED_COUNT; i++)
                                        {

                                            var item = feedItems.Items[i];
                                            userIds = new FeedManager(UnitOfWork).CommentedUserIds(item.Link, companyId);

                                            for (int j = 0; j < userIds.Count; j++)
                                            {
                                                if (int.Parse(Session["UserId"].ToString()) == userIds[j])
                                                {
                                                    isAllowed = "false";
                                                    break;
                                                }
                                                else
                                                {
                                                    isAllowed = "true";
                                                }

                                            }
                                            string link = item.Link;
                                            string title = item.Title;
                                            string desc = item.Description;
                                            string timestamp = item.TimeStamp;
                                            string thumbnail = item.Thumbnail;
                                            double rating = item.Rating;
                                            string source = item.Source;

                                            var thumbnailDesc = String.Empty;
                                            if (!String.IsNullOrEmpty(item.Thumbnail))
                                            {
                                                thumbnailDesc += "<div class=\"feed_item_thumbnail imgLiquid_bgSize imgLiquid_ready\"";
                                                thumbnailDesc += String.Format("style=\"background - image: url(&quot;//t3.gstatic.com/images?q=tbn:{0}&quot;); background-size: contain; background-position: center center; background-repeat: no-repeat;\">", thumbnail);
                                                thumbnailDesc += String.Format("<a href=\"{0}\" target=\"_blank\" rel=\"nofollow\" style=\"display: block; width: 100%; height: 100%;\"><img src=\"//t3.gstatic.com/images?q=tbn:{1}\" style=\"display: none;\"></a></div>", HttpUtility.HtmlEncode(link), thumbnail);
                                            }
                                            string descWithThumb = thumbnailDesc + desc;
                                            //feed += "hie this is top feed";
                                            feed += "\n\n\n  <div class=\"feed_item\">\n    ";
                                            feed += "<div class=\"feed_item_title\">";
                                            feed += String.Format("<a toAllowComment= " + isAllowed + " href=\"{0}\"  target=\"_blank\" rel=\"nofollow\">{3}</a></div><div style=\"position: absolute; top: 0px; right: 10px; color:#444;\"><a href=\"#\" onclick=\"removeonclick(event, this);\" id=\"removeClic\"><i class=\"fa fa-times newsRemove \" aria-hidden=\"true\" style=\"color:#c00; float:left; margin-top:3px;font-size:1.4em; opacity:0.76;\" id=\"closebtn1\"  data-toggle=\"tooltip\" data-placement=\"left\" title=\"Remove this feed : will be filtered out now onwards\"></i></a></div>\n          <div class=\"feed_item_description\">\n            {1}&nbsp;...    </div>\n        <div class=\"feed_item_date\">{2}</div>\n        ", link, descWithThumb, timestamp, title.Length >= 70 ? title.Substring(0, 70) : title);
                                            feed += String.Format("<div class=\"feed_item_link\"><a href = \"{0}\" target=\"_blank\" rel=\"nofollow\">{1}</a></div>", HttpUtility.HtmlEncode(link), source);
                                            feed += getRatingHtml(i, rating);
                                            feed += "</div> ";

                                            node.InnerHtml = feed;
                                        }

                                    }
                                    
                                }
                            }
                        }
                    }

                    result = doc.DocumentNode.OuterHtml;
                    

                }
                else
                    logger.Info("session is null");
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at LiveFeed/GetTopRatedFeeds: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }

            return result;
        }

        private string getRatingHtml(int feedItemIndex, double rating)
        {
            logger.Info("Inside LiveFeed/getRatingHtml");
            var ratingHtml = "<div class=\"cont\">";
            ratingHtml += "<div class=\"stars\">";
            ratingHtml += "<form action=\"\"  for="+'"'+feedItemIndex+'"'+">";
            for (int i = 5; i >= 1; i--)
            {
                string checkedStar = String.Empty;
                if (i == rating)
                    checkedStar = "checked=\"true\"";
                ratingHtml += String.Format("<input class=\"star star-{1}\" id=\"star-{1}-2-{0}\" type=\"radio\" name=\"star\" {2} onchange=\"ratingstar1(this.id)\"/  onclick=\"ratingstar(this.id)\"/>", feedItemIndex, i, checkedStar);
                ratingHtml += String.Format("<label class=\"star star-{1}\" for=\"star-{1}-2-{0}\"></label>", feedItemIndex, i);
                //ratingHtml += String.Format("<input class=\"star star-4\" id=\"star-4-2-{0}\" type=\"radio\" name=\"star\" onchange=\"onRating(this, {0})\"/>", feedItemIndex);
                //ratingHtml += String.Format("<label class=\"star star-4\" for=\"star-4-2-{0}\"></label>", feedItemIndex);
                //ratingHtml += String.Format("<input class=\"star star-3\" id=\"star-3-2-{0}\" type=\"radio\" name=\"star\" onchange=\"onRating(this, {0})\"/>", feedItemIndex);
                //ratingHtml += String.Format("<label class=\"star star-3\" for=\"star-3-2-{0}\"></label>", feedItemIndex);
                //ratingHtml += String.Format("<input class=\"star star-2\" id=\"star-2-2-{0}\" type=\"radio\" name=\"star\" onchange=\"onRating(this, {0})\"/>", feedItemIndex);
                //ratingHtml += String.Format("<label class=\"star star-2\" for=\"star-2-2-{0}\"></label>", feedItemIndex);
                //ratingHtml += String.Format("<input class=\"star star-1\" id=\"star-1-2-{0}\" type=\"radio\" name=\"star\" onchange=\"onRating(this, {0})\"/>", feedItemIndex);
                //ratingHtml += String.Format("<label class=\"star star-1\" for=\"star-1-2-{0}\"></label>", feedItemIndex);
                 ratingHtml += "<input type=\'hidden\' id='ratinghidden' name='thing' value=''>";
            }
            // ratingHtml += "</form></div><div id='commentdivid'><i  rel='tooltip' forid=\'comment\' data='hello' class='fa fa-commenting commentbar' style='' ></i> <div class='spinner'><div class='bounce1'></div><div class='bounce2'></div><div class='bounce3'></div></div></div></div>";
            // ratingHtml += "</form></div><div id='commentdivid'><i  rel='tooltip' forid=\'comment\' data='hello' class='fa fa-commenting commentbar' style='' ></i> </div></div>";
            ratingHtml += "</form></div><div id='commentdivid'><i  rel='tooltip' forid=\'comment\' data='hello' class='fa fa-commenting commentbar' style='' ></i></div></div>";
            return ratingHtml;
            
        }

        private string getRatingHtmlForComment(int feedItemIndex, double rating)
        {
            logger.Info("Inside LiveFeed/getRatingHtmlForComment");
            var ratingHtml = "<div class=\"cont commentbubbleclass\" id=\"\">";
            ratingHtml += "<div class=\"stars\">";
            ratingHtml += "<form action=\"\">";
            for (int i = 5; i >= 1; i--)
            {
                string checkedStar = String.Empty;
                if (i == rating)
                    checkedStar = "checked=\"true\"";
                ratingHtml += String.Format("<input class=\"star star-{1}\" id=\"star-{1}-2-{0}\" type=\"radio\" name=\"star\" {2} onchange=\"onRating(this, {0})\"/>", feedItemIndex, i, checkedStar);
                ratingHtml += String.Format("<label class=\"star star-{1}\" for=\"star-{1}-2-{0}\"></label>", feedItemIndex, i);
                //ratingHtml += String.Format("<input class=\"star star-4\" id=\"star-4-2-{0}\" type=\"radio\" name=\"star\" onchange=\"onRating(this, {0})\"/>", feedItemIndex);
                //ratingHtml += String.Format("<label class=\"star star-4\" for=\"star-4-2-{0}\"></label>", feedItemIndex);
                //ratingHtml += String.Format("<input class=\"star star-3\" id=\"star-3-2-{0}\" type=\"radio\" name=\"star\" onchange=\"onRating(this, {0})\"/>", feedItemIndex);
                //ratingHtml += String.Format("<label class=\"star star-3\" for=\"star-3-2-{0}\"></label>", feedItemIndex);
                //ratingHtml += String.Format("<input class=\"star star-2\" id=\"star-2-2-{0}\" type=\"radio\" name=\"star\" onchange=\"onRating(this, {0})\"/>", feedItemIndex);
                //ratingHtml += String.Format("<label class=\"star star-2\" for=\"star-2-2-{0}\"></label>", feedItemIndex);
                //ratingHtml += String.Format("<input class=\"star star-1\" id=\"star-1-2-{0}\" type=\"radio\" name=\"star\" onchange=\"onRating(this, {0})\"/>", feedItemIndex);
                //ratingHtml += String.Format("<label class=\"star star-1\" for=\"star-1-2-{0}\"></label>", feedItemIndex);
            }
            ratingHtml += "</form></div></div>";

            return ratingHtml;
        }

        [HttpGet]
        public JsonResult SaveNewsFeedLink(string newsLink, int count)
        {
            logger.Info("Inside LiveFeed/SaveNewsFeedLink");
            int CompanyId = int.Parse(Session["CompanyId"].ToString());

            string msg = "";
            try
            {
            if (Session["User"] == null)
            {
                msg = "Authentication failed!";
                logger.Info(msg);
            }
            else
            {
                bool result = new UserManager(UnitOfWork).SaveNewsFeedLink(Session["User"].ToString(), newsLink, count);
                if (!result)
                {
                    msg = "Failed ....Try Again. ";
                    logger.Info(msg);
                }
                else
                    logger.Info("Save News Feed Link successful");
            }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at LiveFeed/SaveNewsFeedLink: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetDivisionDetails(int subscriberId)
        {
            logger.Info("Inside LiveFeed/GetDivisionDetails");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
                {
                    List<Division> DivisionList = new List<Division>();
                    DivisionList = new UserManager(UnitOfWork).GetDivisionDetailsBySubscriberId(subscriberId);
                    return View(DivisionList);
                }
                else
                {
                    logger.Info("Invalid session");
                    return RedirectToAction("Index", "Home");
                }
            }
            catch (Exception ex)
            {
                logger.Error("Exception at LiveFeed/GetDivisionDetails: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }
        
        public List<string> GenerateFeedUrllist(List<string> lstSearchText)
        {
            logger.Info("Inside LiveFeed/GenerateFeedUrllist");
            List<FDAApprovalDetails> FdaapprovalDetailsList = new List<FDAApprovalDetails>();
             List<FDAApprovalDetails> itemresult = new List<FDAApprovalDetails>();
            //List<string> lstSearchText = new List<string>();
            // lstSearchText = GetListOfProductAndCompany();
             List<string> UrlList = new List<string>();
             UrlList = GetUrl(6);
             var url = "";
             HtmlWeb website = new HtmlWeb();
             Dictionary<string, FDAApprovalDetails> distinctFDAApprovalSet = new Dictionary<string, FDAApprovalDetails>();
             HashSet<string> searchTextSet = new HashSet<string>();
             string[] stringSeparators = new string[] { "\r\n" };
             string DrugNameAndApplicationno;
             string[] DrugName;
             //string feed = String.Empty;
             List<string> feedDetailsList = new List<string>();
            try
            {
            for(int K = 0; K < UrlList.Count ; K++ )
            {
                url = UrlList[K];
                FdaapprovalDetailsList.Clear();
                itemresult.Clear();
                //var uri = new Uri(url);
                NameValueCollection postData = new NameValueCollection(1);
                //month = Request.QueryString["reportSelectMonth"];
                //year = Request.QueryString["reportSelectYear"];
                postData.Add("rptname", "1");
                var parameters = HttpUtility.ParseQueryString(url);
                string ReportMonth = parameters["reportSelectMonth"];
                string ReportYear = parameters["reportSelectYear"];
                //postData.Add(HttpUtility.ParseQueryString(url));
                postData.Add("reportSelectMonth", ReportMonth);
                postData.Add("reportSelectYear", ReportYear);
                var rootDocument = SubmitFormValues(website, postData, url);
                foreach (var item in lstSearchText)
                {
                    if (!searchTextSet.Contains(item))
                        searchTextSet.Add(item.ToLower());
                }
                var cols = rootDocument.DocumentNode.SelectNodes("//table[@id='example']//tr//td");

                for (int i = 0; i < cols.Count; i = i + 7)
                {
                    if (cols.Count > 1)
                    {
                        FDAApprovalDetails fdaapprovalDetails = new FDAApprovalDetails();
                        DrugNameAndApplicationno = cols[i + 1].InnerText;
                        DrugNameAndApplicationno = DrugNameAndApplicationno.Replace(@"\r\n", " ");
                        DrugNameAndApplicationno = DrugNameAndApplicationno.Trim();
                        DrugName = DrugNameAndApplicationno.Split(stringSeparators, StringSplitOptions.None);
                        fdaapprovalDetails.DrugName = DrugName[0];
                        fdaapprovalDetails.ActiveIngredients = cols[i + 3].InnerText;
                        fdaapprovalDetails.Company = cols[i + 4].InnerText;
                        if (!searchTextSet.Contains(fdaapprovalDetails.DrugName.ToLower()) && !searchTextSet.Contains(fdaapprovalDetails.ActiveIngredients.ToLower()) && !searchTextSet.Contains(fdaapprovalDetails.Company.ToLower()))
                        {
                            continue;
                        }
                        fdaapprovalDetails.Submission = cols[i + 2].InnerText;
                        fdaapprovalDetails.RowIndex = (i / 7) + 1;
                        DateTime datetimeval = Convert.ToDateTime(cols[i].InnerText);
                        //fdaapprovalDetails.ApprovalDate = datetimeval.ToString("MMM d , yyyy h:mm tt");
                        fdaapprovalDetails.ApprovalDate = datetimeval.ToString("MMM dd, yyyy h:mm tt");
                        fdaapprovalDetails.SubmissionClassification = cols[i + 5].InnerText;
                        fdaapprovalDetails.SubmissionStatus = cols[i + 6].InnerText;
                        fdaapprovalDetails.ApplicationNo = DrugName[1].Trim();
                        if (!distinctFDAApprovalSet.ContainsKey(fdaapprovalDetails.ApplicationNo))
                        {
                            distinctFDAApprovalSet.Add(fdaapprovalDetails.ApplicationNo, fdaapprovalDetails);

                        }
                        else
                        {
                            var fdaDetailsItem = distinctFDAApprovalSet[fdaapprovalDetails.ApplicationNo];
                            if (String.Compare(fdaDetailsItem.SubmissionStatus, fdaapprovalDetails.SubmissionStatus) != 0)
                                fdaDetailsItem.SubmissionStatus += "/" + fdaapprovalDetails.SubmissionStatus;

                        }
                        FdaapprovalDetailsList.Add(fdaapprovalDetails);

                    }

                    itemresult.AddRange(FdaapprovalDetailsList);
                    string feed = String.Empty;
                    if (itemresult != null && itemresult.Count > 0)
                    {
                        if (itemresult.Count <= GenUtil.DEFAULT_FEED_COUNT)
                        {
                            for (int j = 0; j < itemresult.Count; j++)
                            {
                                //var link = "http://www.accessdata.fda.gov/scripts/cder/daf/index.cfm?event=reportsSearch.process&rptname=1&reportSelectMonth=11&reportSelectYear=2016";
                                //var rating = 5.0;
                                var source = "http://www.fda.gov/";
                                var link = url + "&RowIndex=" + itemresult[j].RowIndex;
                                // Guid guid = Guid.NewGuid();
                                string descWithThumb = String.Format(" New Product approved for " + itemresult[j].ActiveIngredients + " " + itemresult[j].Company + " received " + itemresult[j].SubmissionStatus + " on " + itemresult[j].ApprovalDate + " for its " + itemresult[j].DrugName + ", " + " application number " + itemresult[j].ApplicationNo);
                                string title = descWithThumb;
                                feed += "\n\n\n  <div class=\"feed_item\">\n    ";
                                feed += "<div class=\"feed_item_title\">";
                                feed += String.Format("<a href=\"{0}\" target=\"_blank\" rel=\"nofollow\">{3}</a></div>\n          <div class=\"feed_item_description\">\n            {1}&nbsp;...    </div>\n        <div class=\"feed_item_date\">{2}</div>\n        ", link, descWithThumb, itemresult[j].ApprovalDate, title.Length >= 70 ? title.Substring(0, 70) : title);
                                feed += String.Format("<div class=\"feed_item_link\"><a href = \"{0}\" target=\"_blank\" rel=\"nofollow\">{1}</a></div>", HttpUtility.HtmlEncode(link), link);
                                //feed += getRatingHtml(j, rating);
                                feed += "</div> ";

                            }

                            feedDetailsList.Add(feed);
                        }
                        else
                        {
                            for (int j = 0; j < GenUtil.DEFAULT_FEED_COUNT; j++)
                            {
                                //var link = "http://www.accessdata.fda.gov/scripts/cder/daf/index.cfm?event=reportsSearch.process&rptname=1&reportSelectMonth=11&reportSelectYear=2016";
                                //var rating = 5.0;
                                var source = "http://www.fda.gov/";
                                var link = url + "&RowIndex=" + itemresult[j].RowIndex;
                                // Guid guid = Guid.NewGuid();
                                string descWithThumb = String.Format(" New Product approved for " + itemresult[j].ActiveIngredients + " " + itemresult[j].Company + " received " + itemresult[j].SubmissionStatus + " on " + itemresult[j].ApprovalDate + " for its " + itemresult[j].DrugName + ", " + " application number " + itemresult[j].ApplicationNo);
                                string title = descWithThumb;
                                feed += "\n\n\n  <div class=\"feed_item\">\n    ";
                                feed += "<div class=\"feed_item_title\">";
                                feed += String.Format("<a href=\"{0}\" target=\"_blank\" rel=\"nofollow\">{3}</a></div>\n          <div class=\"feed_item_description\">\n            {1}&nbsp;...    </div>\n        <div class=\"feed_item_date\">{2}</div>\n        ", link, descWithThumb, itemresult[j].ApprovalDate, title.Length >= 70 ? title.Substring(0, 70) : title);
                                feed += String.Format("<div class=\"feed_item_link\"><a href = \"{0}\" target=\"_blank\" rel=\"nofollow\">{1}</a></div>", HttpUtility.HtmlEncode(link), link);
                                //feed += getRatingHtml(j, rating);
                                feed += "</div> ";

                            }

                            feedDetailsList.Add(feed);

                        }
                    }
                }
            }
            }
            catch (Exception ex)
            {
                logger.Error("Exception at LiveFeed/GenerateFeedUrllist: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }

            return feedDetailsList;
        }

        public HtmlDocument SubmitFormValues(HtmlWeb htmlWeb, NameValueCollection fv, string url)
        {
            logger.Info("Inside LiveFeed/SubmitFormValues");
            // Attach a temporary delegate to handle attaching
            // the post back data
            HtmlAgilityPack.HtmlWeb.PreRequestHandler handler = delegate(HttpWebRequest request)
            {
                string payload = this.AssemblePostPayload(fv);
                byte[] buff = Encoding.ASCII.GetBytes(payload.ToCharArray());
                request.ContentLength = buff.Length;
                request.ContentType = "application/x-www-form-urlencoded";
                System.IO.Stream reqStream = request.GetRequestStream();
                reqStream.Write(buff, 0, buff.Length);
                return true;
            };
            htmlWeb.PreRequest += handler;
            HtmlDocument doc = htmlWeb.Load(url, "POST");
            htmlWeb.PreRequest -= handler;
            return doc;
        }

        private string AssemblePostPayload(NameValueCollection fv)
        {
            logger.Info("Inside LiveFeed/AssemblePostPayload");
            StringBuilder sb = new StringBuilder();
            foreach (String key in fv.AllKeys)
            {
                sb.Append("&" + key + "=" + fv.Get(key));
            }
            return sb.ToString().Substring(1);
        }

        public List<string> GetUrl(int NoOfMonths)
        {
            logger.Info("Inside LiveFeed/GetUrl");
            string Url = string.Empty;
            //NoOfMonths = 13;
            List<string> UrlList = new List<string>();
            var Months = Enumerable.Range(0, NoOfMonths).Select(i => DateTime.Now.AddMonths(-i).ToString("MM/yyyy"));
            DateTime dt = DateTime.Now;

            foreach (var item in Months)
            {
                string[] dateWithMonAndYear = item.Split('/');
                int year, month;
                int.TryParse(dateWithMonAndYear[1], out year);
                int.TryParse(dateWithMonAndYear[0], out month);
                Url = String.Format("http://www.accessdata.fda.gov/scripts/cder/daf/index.cfm?event=reportsSearch.process&rptname=1&reportSelectMonth={0}&reportSelectYear={1}", month, year);
                UrlList.Add(Url);
            } 
            return UrlList;
        }

        [HttpGet]
        public JsonResult SaveRegulatoryKeywordsForLink(List<string> AllWords, int DivOrder)
        {
            logger.Info("Inside LiveFeed/SaveRegulatoryKeywordsForLink");
            int SubscriberId = int.Parse(Session["CompanyId"].ToString());
            int UserId = int.Parse(Session["UserId"].ToString());
            int result;
            string msg = "";
            try
            {
            if (Session["User"] == null)
            {
                   msg = "Authentication failed!";
                logger.Info(msg);
            }

            else
            {
                result = new FeedManager(UnitOfWork).SaveRegulatoryKeywordsForLink(UserId, SubscriberId, AllWords, DivOrder);
                if (result == 1)
                {
                    logger.Info("successfully Save Regulatory Keywords For Link");
                }
                else
                {  
                    msg = "fail to Save Regulatory Keywords For Link";
                    logger.Info(msg);
                }
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at LiveFeed/SaveRegulatoryKeywordsForLink: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }


        [HttpGet]
        public JsonResult RemoveRegulatoryKeywords(string removeText)
        {
            logger.Info("Inside LiveFeed/RemoveRegulatoryKeywords");
            int SubscriberId = int.Parse(Session["CompanyId"].ToString());
            int isRemove = 1;
            int result;
            string msg = "";
            try
            {
            if (Session["User"] == null)
            {
                msg = "Authentication failed!";
                logger.Info(msg);
            }
            else
            {
                result = new FeedManager(UnitOfWork).RemoveRegulatoryKeywords(removeText, isRemove, SubscriberId);
                if (result == 1)
                {
                    logger.Info("successfully Remove Regulatory Keywords For Link");
                }
                else
                {
                    msg = "fail to Remove Regulatory Keywords For Link";
                    logger.Info(msg);
                }

            }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at LiveFeed/RemoveRegulatoryKeywords: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }



        public JsonResult GetRegulatoryKeywordsForLink()
        {
            logger.Info("Inside LiveFeed/GetRegulatoryKeywordsForLink");

            int UserId = int.Parse(Session["UserId"].ToString());
            string msg = "";
            //string abc = "";
            string[] s = new string[100];

            List<string> result = new List<string>();
            try
            {
            if (Session["User"] == null)
            {
                msg = "Authentication failed!";
                logger.Info(msg);
            }
            else
            {
                result = new FeedManager(UnitOfWork).GetRegulatoryKeywordsForLink(UserId);
                if (result!=null)
                {
                    logger.Info("successfully get Regulatory Keywords For Link");
                }
                else
                {
                    msg= "fail to get Regulatory Keywords For Link";
                    logger.Info(msg);
                }
                    //s = result.ToArray();
                    //abc= result.ToString();

                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at LiveFeed/GetRegulatoryKeywordsForLink: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            string[] regarray = result.ToArray();
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, regarray = regarray }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }
    }
}
