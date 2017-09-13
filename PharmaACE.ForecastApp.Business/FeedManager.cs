using EntityFramework.Extensions;
using PharmaACE.ForecastApp.EntityProvider.pacemaster;
using PharmaACE.ForecastApp.EntityProvider.TenantModel;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Business
{
    public class FeedManager
    {
        private IUnitOfWork uow;
        public FeedManager(IUnitOfWork uow)
        {
            this.uow = uow;
        }

        public NewsFeedItems GetFeedData(int tenantId, int divOrder)
        {
            List<NewsFeedItem> orderedFeedList = new List<NewsFeedItem>();
            try
            {
                    orderedFeedList = uow.TenantContext.FeedUserMaster
                        .Where(fum => fum.DivOrder == divOrder)
                        .Select(fum => new
                        {
                            UserId = fum.UserID,
                            Comment = fum.Comment,
                            VisitCount = fum.VisitCount,
                            Rating = fum.Rating,
                            TransDate = fum.TransDateTime,
                            Link = fum.FeedItemMaster.Link,
                            Thumbnail = fum.FeedItemMaster.Thumbnail,
                            Title = fum.FeedItemMaster.Title,
                            Description = fum.FeedItemMaster.Description,
                            Source = fum.FeedItemMaster.FeedSourceMaster.Source,
                            Setting = fum.FeedItemMaster.FeedItemMapping.Select(fim => fim.FeedSettingMaster.FeedSetting).ToList()
                        })
                        .ToList()
                        .GroupBy(a => a.Link)
                        .Select(g => new NewsFeedItem
                        {
                            Link = g.FirstOrDefault().Link,
                            Comment = g.FirstOrDefault().Comment,
                            Description = g.FirstOrDefault().Description,
                            DivOrder = divOrder,
                            Thumbnail = g.FirstOrDefault().Thumbnail,
                            NoOfViews = g.FirstOrDefault().VisitCount == null ? 0 : g.FirstOrDefault().VisitCount.Value,
                            Rating = Math.Ceiling(g.Average(v => v.Rating)),
                            Setting = g.FirstOrDefault().Setting == null || g.FirstOrDefault().Setting.Count == 0 ? null : g.FirstOrDefault().Setting[0],
                            Source = g.FirstOrDefault().Source,
                            TimeStamp = g.FirstOrDefault().TransDate.ToString("MM/dd/yyyy"),
                            Title = g.FirstOrDefault().Title
                        })                    
                        .OrderByDescending(fi => fi.Rating)
                        .ThenByDescending(fi => fi.TimeStamp.SafeToDateTime())
                        .ToList();
            }
            catch(Exception ex)
            {

            }
            return new NewsFeedItems { Items = orderedFeedList };
        }

        public NewsFeedItems GetFeedDataWithComment(int tenantId, string link)
        {
            NewsFeedItems feedItems = new NewsFeedItems();
            try
            {                
                        var feedListQueryable = uow.TenantContext.FeedItemMaster
                            .Where(fim => String.Compare(fim.Link, link, true) == 0)
                            .SelectMany(fim => fim.FeedUserMaster
                                              .Select(fum => new
                                              {
                                                  Comment = fum.Comment,
                                                  Rating = fum.Rating,
                                                  TimeStamp = fum.TransDateTime,
                                                  //User = context.UserMaster
                                                  //              .Where(um => um.Id == fum.UserID)
                                                  //              .Select(um => new
                                                  //              {
                                                  //                  FirstName = um.FirstName,
                                                  //                  LastName = um.LastName
                                                  //              })
                                                  //              .FirstOrDefault()
                                                  UserID = fum.UserID
                                              }))
                           .OrderByDescending(a => a.Rating)
                           .ThenByDescending(a => a.TimeStamp)
                           .Future();

                        var tenantUsersQueryable = uow.MasterContext.UserMaster
                            .Where(um => um.SubscriberMaster.SubscriberId == tenantId)
                            .Select(um => new
                            {
                                UserId = um.Id,
                                FirstName = um.FirstName,
                                LastName = um.LastName
                            })
                            .Future();

                        var tenantUsers = tenantUsersQueryable.ToList();
                        feedItems.Items = feedListQueryable.ToList()
                            .Select(a => new NewsFeedItem
                            {
                                Comment = a.Comment,
                                Rating = a.Rating,
                                TimeStamp = a.TimeStamp.ToString(),
                                FirstName = tenantUsers.Where(tu => tu.UserId == a.UserID).Select(tu => tu.FirstName).FirstOrDefault(),
                                LastName = tenantUsers.Where(tu => tu.UserId == a.UserID).Select(tu => tu.LastName).FirstOrDefault()
                            })
                            .ToList();
            }
            catch (Exception ex)
            {

            }

            return feedItems;
        }
        public List<int> CommentedUserIds(string link, int tenantId)
        {
            List<int> userIds = new List<int>();
            try
            {
                    var feedListQueryable = uow.TenantContext.FeedItemMaster
                         .Where(fim => String.Compare(fim.Link, link, true) == 0)
                         .SelectMany(fim => fim.FeedUserMaster
                                           .Select(fum => new
                                           {

                                               UserID = fum.UserID
                                           }))
                        .Future();
                    userIds = feedListQueryable.Select(u => u.UserID).ToList();

                
            }
            catch (Exception ex)
            {

                throw ex;
            }

            return userIds;



        }
        public int SaveRegulatoryKeywordsForLink(int userId, int subscriberId, List<string> regulatoryKeywords, int divOrder, bool isDefaultRegulatory = false)
        {
            int retVal = 0;
            string regValues = string.Join(",", regulatoryKeywords.ToArray());
            string[] newArr = regValues.Split(',');


            try
            {
                    int divId = uow.MasterContext.DivisionMaster
                        .Where(dm => dm.SubscriberID == subscriberId && dm.DivisionOrder == divOrder)
                        .Select(dm => dm.ID)
                        .FirstOrDefault();

                    var RegulatoryFromDb = uow.MasterContext.DivisionRegulatoryMaster
                       .Select(DR => DR.RegulatoryName)
                       .ToList();

                    //List<string> uniqueItems = newArr
                    //.Distinct()
                    //.Where(x => RegulatoryFromDb.Contains(x))
                    //.ToList();


                    List<string> newList = (newArr.Except(RegulatoryFromDb).ToList());

                    if (newList.Count >= 1)
                    {
                        var divisionUserMappings = newList.Select(kw => new DivisionUserMapping
                        {
                            UserId = userId,
                            DivisionRegulatoryMaster = new DivisionRegulatoryMaster
                            {
                                RegulatoryName = kw,
                                IsDefaultRegulatory = isDefaultRegulatory,
                                DivisionID = divId
                            }
                        }).Distinct();

                    uow.MasterContext.DivisionUserMapping.AddRange(divisionUserMappings);


                    uow.MasterContext.SaveChanges();
                        retVal = 1;
                    }
            }
            catch (Exception ex)
            {
                retVal = 0;
            }

            return retVal;
        }
        public List<string> GetRegulatoryKeywordsForLink(int userId)
        {
            List<string> keywords = new List<string>();
            try
            {
                    //keywords = context.DivisionUserMapping
                    //    .Where(dum => dum.Id == userId)
                    //    .Select(dum => dum.DivisionRegulatoryMaster.RegulatoryName)
                    //    .Union(context.DivisionRegulatoryMaster
                    //                  .Where(drm => drm.IsDefaultRegulatory)
                    //                  .Select(drm => drm.RegulatoryName))
                    //    .ToList();

                    keywords = uow.MasterContext.DivisionRegulatoryMaster
                                      .Where(drm => drm.IsDefaultRegulatory || drm.DivisionUserMapping.Any(dum => dum.UserId == userId))
                                      .Select(drm => drm.RegulatoryName)
                                      .Distinct()
                                      .ToList();
                
            }
            catch(Exception ex)
            {

            }                    
            return keywords;
        }

        public int RemoveRegulatoryKeywords(string regulatoryKeyword, int isRemove, int SubscriberId)
        {
            int result = 0;
            try
            {
                    if (regulatoryKeyword != null)
                    {
                        var divisionUserMasterAndMappings = uow.MasterContext.DivisionUserMapping
                            .Where(dum => String.Compare(dum.DivisionRegulatoryMaster.RegulatoryName, regulatoryKeyword) == 0)
                            .Select(dum => new { DUM = dum, DRM = dum.DivisionRegulatoryMaster })
                            .ToList();
                        if (divisionUserMasterAndMappings != null && divisionUserMasterAndMappings.Count > 0)
                        {
                            var divisionUserMappings = divisionUserMasterAndMappings.Select(dumm => dumm.DUM);
                            var divisionUserMasters = divisionUserMasterAndMappings.Select(dumm => dumm.DRM);
                        uow.MasterContext.DivisionUserMapping.RemoveRange(divisionUserMappings);
                        uow.MasterContext.DivisionRegulatoryMaster.RemoveRange(divisionUserMasters);
                        uow.MasterContext.SaveChanges();
                            result = 1;
                        }
                    }
                
            }
            catch(Exception ex)
            {
                result = 0;
            }
            return result;
        }

        public void SetFeedData(NewsFeedItem item, int userId, int tenantId)
        {
            //string format = "MM/dd/yyyy";
            //DateTime dateTime;
            //if (DateTime.TryParseExact(item.TimeStamp, format, CultureInfo.InvariantCulture,
            //    DateTimeStyles.None, out dateTime))
            DateTime dt;
            try { 
            bool valid = DateTime.TryParseExact(item.TimeStamp, "MM/dd/yyyy", null, DateTimeStyles.None, out dt);

            if (!valid)
            {
                char date1stDigit = 'd';
                char hour1stDigit = 'h';
                var timeStampChars = item.TimeStamp.ToCharArray();
                if (Char.IsWhiteSpace(timeStampChars[4]))
                    date1stDigit = ' ';
                if (Char.IsWhiteSpace(timeStampChars[13]))
                    hour1stDigit = ' ';
                string format = String.Format("MMM {0}d, yyyy {1}h:mm tt", date1stDigit, hour1stDigit);

                dt = DateTime.ParseExact(item.TimeStamp, format, CultureInfo.InvariantCulture);
            }
            
                    var feedQueryable = uow.TenantContext.FeedItemMaster
                        .Where(fim => String.Compare(fim.Link, item.Link, true) == 0)
                        .Select(fim => new
                        {
                            Source = fim.FeedSourceMaster,
                            FeedItem = fim,
                            FeedItemMapping = fim.FeedItemMapping.Where(map => String.Compare(map.FeedSettingMaster.FeedSetting, item.Setting, true) == 0).FirstOrDefault(),
                            FeedUserMaster = fim.FeedUserMaster.Where(fum => fum.UserID == userId).FirstOrDefault()
                        })
                        .FirstOrDefault();

                    FeedSourceMaster source = feedQueryable != null ? feedQueryable.Source : null;
                    if (source == null && !String.IsNullOrEmpty(item.Source))
                    {
                        source = new FeedSourceMaster
                        {
                            Source = item.Source,
                            FeedItemMaster = new List<FeedItemMaster>()
                        };
                    uow.TenantContext.FeedSourceMaster.Add(source);
                    }
                    FeedItemMaster feedItem = feedQueryable != null ? feedQueryable.FeedItem : null;
                    if (feedItem == null)
                    {
                        feedItem = new FeedItemMaster
                        {
                            Description = item.Description,
                            DateTime = dt,
                            Link = item.Link,
                            Thumbnail = item.Thumbnail,
                            Title = item.Title,
                            FeedUserMaster = new List<FeedUserMaster>()
                        };
                        source.FeedItemMaster.Add(feedItem);
                    }

                    int feedSettingId = 0;
                    FeedSettingMaster feedSetting = null;
                    if (feedQueryable != null && feedQueryable.FeedItemMapping != null)
                    {
                        feedSettingId = feedQueryable.FeedItemMapping.FeedSettingId;
                    }
                    else if (!String.IsNullOrEmpty(item.Setting))
                    {
                        feedSetting = new FeedSettingMaster
                        {
                            FeedSetting = item.Setting
                        };
                    uow.TenantContext.FeedSettingMaster.Add(feedSetting);
                    }

                    //context.SaveChanges();

                    FeedUserMaster feedUser = null;
                    if (feedQueryable != null && feedQueryable.FeedUserMaster != null)
                    {
                        if (String.Compare(feedQueryable.FeedUserMaster.Comment, item.Comment, true) != 0)
                            feedQueryable.FeedUserMaster.Comment = item.Comment;
                        if (feedQueryable.FeedUserMaster.DivOrder != item.DivOrder)
                            feedQueryable.FeedUserMaster.DivOrder = item.DivOrder;
                        if (feedQueryable.FeedUserMaster.Rating != (int)item.Rating)
                            feedQueryable.FeedUserMaster.Rating = (int)item.Rating;
                        if (feedQueryable.FeedUserMaster.UserID != userId)
                            feedQueryable.FeedUserMaster.UserID = userId;                            
                        feedUser = feedQueryable.FeedUserMaster;
                    }
                    else
                    {
                        feedUser = new FeedUserMaster
                        {
                            Comment = item.Comment,
                            DivOrder = item.DivOrder,
                            FeedItemID = feedItem.ID,
                            Rating = (int)item.Rating,
                            UserID = userId,
                            VisitCount = item.NoOfViews
                        };
                    uow.TenantContext.FeedUserMaster.Add(feedUser);
                    }

                    feedUser.VisitCount = item.NoOfViews;
                    feedUser.TransDateTime = DateTime.Now;
                    feedSettingId = feedSetting != null ? feedSetting.id : feedSettingId;

                    if (feedSettingId > 0)
                    {
                        FeedItemMapping feedItemMapping = feedQueryable.FeedItemMapping;
                        if (feedItemMapping == null)
                        {
                            feedItemMapping = new FeedItemMapping
                            {
                                FeedItemId = feedItem.ID,
                                FeedSettingId = feedSettingId
                            };

                        uow.TenantContext.FeedItemMapping.Add(feedItemMapping);
                        }
                    }

                uow.TenantContext.SaveChanges();
                
            }
            catch(Exception ex)
            {

            }

            //DH.SetFeedData(userId, companyId, item.DivOrder, item.Setting, item.Source, item.Link, item.Title, item.Description, item.Thumbnail, dt, (short)item.Rating, item.Comment);       
        }

        public bool removeNewsFromList(string link, string item)
        {
            bool result = false;
            try
            {
                FilteredNews news = new FilteredNews();         //Poko class object
                
                    if (item == "TopStories")
                    {
                        var existingNewsInDb = uow.TenantContext.FeedUserMaster
                                .Where(fum => String.Compare(fum.FeedItemMaster.Link, link) == 0
                                 ).ToList();

                        if (existingNewsInDb.Count >= 1) //Top Stories
                        {
                            news = new FilteredNews
                            {
                                RemovedLink = link
                            };

                        uow.TenantContext.FilteredNews.Add(news);

                            /*----------------Removing From Table------------------*/

                            var removeLinkFromtable = uow.TenantContext.FeedUserMaster
                               .Where(fum => String.Compare(fum.FeedItemMaster.Link, link) == 0)
                               .Select(fum => new { FUM = fum, FIM = fum.FeedItemMaster })
                               .ToList();
                            if (removeLinkFromtable != null && removeLinkFromtable.Count > 0)
                            {
                                var FeedUserMasters = removeLinkFromtable.Select(rlft => rlft.FUM);
                                var FeedItemMasters = removeLinkFromtable.Select(rlft => rlft.FIM);
                            uow.TenantContext.FeedUserMaster.RemoveRange(FeedUserMasters);
                            uow.TenantContext.FeedItemMaster.RemoveRange(FeedItemMasters);
                            uow.TenantContext.SaveChanges();
                                result = true;
                            }
                        }
                    }
                    else if(item== "LatestStories")
                    {
                        news = new FilteredNews
                        {
                            RemovedLink = link
                        };

                    uow.TenantContext.FilteredNews.Add(news);
                    uow.TenantContext.SaveChanges();
                        result = true;
                    }
                
            }
            catch (Exception ex)
            {
                result = false;
            }
            return result;
        }
        public HashSet<string> getRemovedLinkFromFilteredNewsTable()
        {
            HashSet<string> deletedNews = new HashSet<string>();
            
                deletedNews = new HashSet<string>(uow.TenantContext.FilteredNews
                              .Select(fn => fn.RemovedLink)
                              .Distinct().AsEnumerable());
                              
            

                return deletedNews;
        }
    }
}
