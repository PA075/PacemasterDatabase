using EntityFramework.Extensions;
using PharmaACE.ForecastApp.EntityProvider.pacemaster;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using PAM = PharmaACE.ForecastApp.Models;

namespace PharmaACE.ForecastApp.Business
{
    //git testing
    public class CommunityManager
    {
        private IUnitOfWork uow;
        public CommunityManager(IUnitOfWork uow)
        {
            this.uow = uow;
        }

        //public List<PAM.ForumQuestion> GetQuestionsList(int questionCount)
        //{
        //    List<PharmaACE.ForecastApp.Models.ForumQuestion> questions = new List<PharmaACE.ForecastApp.Models.ForumQuestion>();

        //    using (var context = new MasterModel(GenUtil.MasterModelConnectionString))
        //    {
        //        try
        //        {
        //            var forumQuestionsQueryable = context.ForumQuestion
        //                .Select(fq => new PAM.ForumQuestion
        //                {
        //                    AnswerCount = fq.ForumAnswer.Count,
        //                    PostDate = fq.PostDate,
        //                    QuestionCategory = fq.Category,
        //                    QuestionId = fq.Id,
        //                    QuestionTitle = fq.Title,
        //                    UserId = fq.UserId ?? 0 //assume userId as 0 for default notifications/or if the user id is unresolved
        //                })
        //                //.OrderBy(fq => fq.PostDate)
        //                .OrderByDescending(fq => fq.PostDate)
        //                .AsQueryable();

        //            if (questionCount > 0)
        //                forumQuestionsQueryable = forumQuestionsQueryable.Take(questionCount);

        //            questions = forumQuestionsQueryable.ToList();
        //        }

        //        catch (Exception ex)
        //        {

        //        }

        //    }

        //    return questions;
        //}

  



        public List<PAM.ForumQuestion> GetQuestionsList(int questionCount)
        {
            List<PharmaACE.ForecastApp.Models.ForumQuestion> questions = new List<PharmaACE.ForecastApp.Models.ForumQuestion>();
            List<PharmaACE.ForecastApp.Models.ForumQuestion> listOfquestions = new List<PharmaACE.ForecastApp.Models.ForumQuestion>();
            
                try
                {
                    var forumQuestionsQueryable = uow.MasterContext.ForumQuestion
                        .Select(fq => new PAM.ForumQuestion
                        {
                            AnswerCount = fq.ForumAnswer.Count,
                            PostDate = fq.PostDate,
                            QuestionCategory = fq.Category,
                            QuestionId = fq.Id,
                            QuestionTitle = fq.Title,
                            UserId = fq.UserId ?? 0 //assume userId as 0 for default notifications/or if the user id is unresolved
                        })

                        .OrderByDescending(fq => fq.PostDate)
                        .AsQueryable();

                    questions = forumQuestionsQueryable.ToList();
                    var answerDetailQueryable = uow.MasterContext.ForumAnswer
                                       .Select(fa => new PAM.ForumAnswer
                                       {
                                           AnswerText = fa.Answer,
                                           PostDate = fa.PostDate,
                                           QuestionId = fa.QuestionId
                                       }).OrderByDescending(fa => fa.PostDate)
                                       .ToList();
                    
                    var diffAnswerids = new HashSet<int>(answerDetailQueryable.OrderByDescending(fa => fa.PostDate).Distinct().Select(fa => fa.QuestionId));
                    var questionWithAnsList = new List<PAM.ForumQuestion>();
                    foreach (var item in diffAnswerids)
                    {
                        var answeredTime = answerDetailQueryable.Where(x => x.QuestionId == item).OrderByDescending(q=>q.PostDate).Select(q => q.PostDate).FirstOrDefault();
                        foreach (var item2 in questions)
                        {
                            if (item == item2.QuestionId)
                            {

                                item2.LatestTime = answeredTime;
                                questionWithAnsList.Add(item2);
                            }
                        }
                    }

                    var questionWithotAnsList = questions.Where(q => !(diffAnswerids.Contains(q.QuestionId)))
                        .Select(fq => new PAM.ForumQuestion
                        {
                            AnswerCount = fq.AnswerCount,
                            LatestTime = fq.PostDate,
                            PostDate = fq.PostDate,
                            QuestionCategory = fq.QuestionCategory,
                            QuestionId = fq.QuestionId,
                            QuestionTitle = fq.QuestionTitle,
                            UserId = fq.UserId //assume userId as 0 for default notifications/or if the user id is unresolved
                        }).OrderByDescending(fq => fq.LatestTime).Distinct();

                    listOfquestions.AddRange(questionWithAnsList.OrderByDescending(q => q.LatestTime).Distinct());
                    listOfquestions.AddRange(questionWithotAnsList);
                }
                catch (Exception ex)
                {

                }

            return listOfquestions.OrderByDescending(q => q.LatestTime).ToList();
            //return listOfquestions;
        }




        public PAM.ForumQuestionDetails GetQuestionDetails(int questionId)
        {
            String connectionString = GenUtil.MasterModelConnectionString;
            PAM.ForumQuestionDetails forumQuestionDetails = new PAM.ForumQuestionDetails();
            
                try
                {
                    var questionDetailQueryable = uow.MasterContext.ForumQuestion
                        .Where(fq => fq.Id == questionId)
                        .Select(fq => new
                        {
                            QuestionId = fq.Id,
                            QuestionTitle = fq.Title,
                            QuestionCategory = fq.Category,
                            QuestionText = fq.Question,
                            PostDate = fq.PostDate,
                            Attachments = fq.ForumAttachment.Where(a => a.QuestionId == questionId && a.AnswerId == null).Select(a => new { AttachmentName = a.Name, AttachmentPath = a.AttachmentPath }),
                            Answers = fq.ForumAnswer
                                        .Select(fa => new
                                        {
                                            AnswerId = fa.Id,
                                            AnswerText = fa.Answer,
                                            PostDate = fa.PostDate,
                                            Attachments = fa.ForumAttachment.Select(a => new { AttachmentName = a.Name, AttachmentPath = a.AttachmentPath })
                                        })
                        });

                    var questionDetails = questionDetailQueryable.SingleOrDefault();

                    if (questionDetails != null)
                    {
                        forumQuestionDetails = new PAM.ForumQuestionDetails
                        {
                            forumQuestion = new PAM.ForumQuestion
                            {
                                QuestionId = questionDetails.QuestionId,
                                QuestionTitle = questionDetails.QuestionTitle,
                                QuestionCategory = questionDetails.QuestionCategory,
                                QuestionText = questionDetails.QuestionText,
                                PostDate = questionDetails.PostDate,
                                Attachments = questionDetails.Attachments
                                                .Select(a => new PAM.Attachment
                                                {
                                                    AttachmentName = a.AttachmentName,
                                                    AttachmentPath = a.AttachmentPath
                                                })
                                                .ToList()
                            },

                            forumAnswers = questionDetails.Answers.Select(qda => new PAM.ForumAnswer
                            {
                                AnswerId = qda.AnswerId,
                                AnswerText = HttpUtility.HtmlDecode(qda.AnswerText),
                                PostDate = qda.PostDate,
                                Attachments = qda.Attachments.Select(a => new PAM.Attachment
                                {
                                    AttachmentName = a.AttachmentName,
                                    AttachmentPath = a.AttachmentPath
                                })
                                .ToList()
                            }).OrderByDescending(fa=>fa.PostDate)
                            .ToList()

                        };
                    }

                }
                catch (Exception ex)
                {

                }

            return forumQuestionDetails;
        }


        //public PAM.ForumQuestionDetails GetQuestionDetails(int questionId)
        //{
        //    String connectionString = GenUtil.MasterModelConnectionString;
        //    PAM.ForumQuestionDetails forumQuestionDetails = new PAM.ForumQuestionDetails();
        //    using (var context = new MasterModel(connectionString))
        //    {
        //        try
        //        {
        //            var questionDetailQueryable = context.ForumQuestion
        //                .Where(fq => fq.Id == questionId)
        //                .Select(fq => new
        //                {
        //                    QuestionId = fq.Id,
        //                    QuestionTitle = fq.Title,
        //                    QuestionCategory = fq.Category,
        //                    QuestionText = fq.Question,
        //                    PostDate = fq.PostDate,
        //                    Attachments = fq.ForumAttachment.Where(a => a.ForumQuestion.Title == fq.Title && a.AnswerId == null).Select(a => new { AttachmentName = a.Name, AttachmentPath = a.AttachmentPath }),
        //                    Answers = fq.ForumAnswer
        //                                .Select(fa => new
        //                                {
        //                                    AnswerId = fa.Id,
        //                                    AnswerText = fa.Answer,
        //                                    PostDate = fa.PostDate,
        //                                    Attachments = fa.ForumAttachment.Select(a => new { AttachmentName = a.Name, AttachmentPath = a.AttachmentPath })
        //                                })
        //                });

        //            //var questionDetails = questionDetailQueryable.SingleOrDefault();
        //            var questionDetails = questionDetailQueryable.ToList();
        //            forumQuestionDetails = new PAM.ForumQuestionDetails();
        //            if (questionDetails != null && questionDetails.Count > 0)
        //            {
        //                foreach (var item in questionDetails)
        //                {
        //                    var forumQuestion = new PAM.ForumQuestion
        //                    {
        //                        QuestionId = item.QuestionId,
        //                        QuestionTitle = item.QuestionTitle,
        //                        QuestionCategory = item.QuestionCategory,
        //                        QuestionText = item.QuestionText,
        //                        PostDate = item.PostDate,
        //                        Attachments = item.Attachments
        //                                         .Select(a => new PAM.Attachment
        //                                         {
        //                                             AttachmentName = a.AttachmentName,
        //                                             AttachmentPath = a.AttachmentPath
        //                                         })
        //                                         .ToList()
        //                    };

        //                   var forumAnswers = item.Answers.Select(qda => new PAM.ForumAnswer
        //                    {
        //                        AnswerId = qda.AnswerId,
        //                        AnswerText = HttpUtility.HtmlDecode(qda.AnswerText),
        //                        PostDate = qda.PostDate,
        //                        Attachments = qda.Attachments.Select(a => new PAM.Attachment
        //                        {
        //                            AttachmentName = a.AttachmentName,
        //                            AttachmentPath = a.AttachmentPath
        //                        })
        //                        .ToList()
        //                    })
        //                    .ToList();
        //                    forumQuestionDetails.forumQuestion = forumQuestion;
        //                    forumQuestionDetails.forumAnswers = forumAnswers;
        //                }

        //            }

        //        }

        //        catch (Exception ex)
        //        {

        //        }

        //    }
        //    return forumQuestionDetails;
        //}

        public List<PAM.ForumQuestion> GetQuestionsListByCategory(byte category)
        {
            List<PharmaACE.ForecastApp.Models.ForumQuestion> categoryQuestions = new List<PAM.ForumQuestion>();
            
                try
                {
                    categoryQuestions = uow.MasterContext.ForumQuestion
                        .Where(fq => fq.Category == category)
                        .Select(fq => new PAM.ForumQuestion
                        {
                            QuestionId = fq.Id,
                            UserId = fq.UserId ?? 0, //assume userId as 0 for default notifications/or if the user id is unresolved
                            QuestionTitle = fq.Title,
                            QuestionCategory = category,
                            PostDate = fq.PostDate,
                            AnswerCount = fq.ForumAnswer.Count
                        }).OrderByDescending(fq => fq.PostDate)
                        .ToList();
                }

                catch (Exception ex)
                {

                }

            
            return categoryQuestions;
        }

        public List<PAM.ForumQuestion> SearchQuestionsByKeyWord(string keyWord)
        {
            List<PAM.ForumQuestion> questions = new List<PAM.ForumQuestion>();
            
                try
                {
                    questions = uow.MasterContext.ForumQuestion
                        .Where(fq => fq.Title.Contains(keyWord) || fq.Question.Contains(keyWord))
                        .Select(fq => new PAM.ForumQuestion
                        {
                            QuestionId = fq.Id,
                            UserId = fq.UserId ?? 0, //assume userId as 0 for default notifications/or if the user id is unresolved
                            QuestionTitle = fq.Title,
                            QuestionCategory = fq.Category,
                            PostDate = fq.PostDate
                        }).OrderByDescending(fq => fq.PostDate)
                        .ToList();
                }

                catch (Exception ex)
                {

                }

                return questions;
            

        }

        public int AddForumQuestion(int userId, PAM.ForumQuestion forumQuestion, HttpPostedFileBase file)
        {
            string msg = string.Empty;
            int returnValue = 0;
           // PAM.BlobUploadResult blobUploadResult = null;s
            string attachmentUrl = string.Empty;
            string attachmentName = string.Empty;
            string attachmentstreamId = string.Empty;

            try
            {

                if(file != null)
                {
                    StorageTypeFactory factory = new ConcreteStorageFactory();
                    StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                    string key = forumQuestion.QuestionTitle;
                    attachmentstreamId  = storagefactory.Upload(uow, key, file, PAM.StorageContext.Forum);
                    attachmentName = Path.GetFileName(file.FileName);
                }
                returnValue = AddQuestion(userId, forumQuestion.QuestionTitle, forumQuestion.QuestionCategory, forumQuestion.QuestionText, attachmentstreamId, attachmentName);
                msg = "Success";
                returnValue = 1;
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                returnValue = 0;
            }
            return returnValue;

        }

        private int AddQuestion(int userId, string title, int category, string questiontext, string attachmentstreamId, string attachmentName)
        {
            int result = 0;
            
                try
                {
                    var existingQ = uow.MasterContext.ForumQuestion.Where(fqe => fqe.Title == title && fqe.UserId == userId)
                                    .Select(fqe => fqe.Id)
                                    .FirstOrDefault();
                    if (existingQ == 0)
                    {
                        ForumQuestion fq = new ForumQuestion
                        {
                            Category = (Byte)category,
                            UserId = userId,
                            Title = title,
                            Question = questiontext,
                            // PostDate = DateTime.Now,
                            PostDate = DateTime.UtcNow,
                            ForumAttachment = new List<ForumAttachment>()
                        };
                        if (!String.IsNullOrEmpty(attachmentstreamId))
                        {
                            var attachmentUrlArray = attachmentstreamId;
                            var attachmentNameArray = attachmentName;

                            ForumAttachment fa = new ForumAttachment();
                            fa.Name = attachmentNameArray;
                            fa.AttachmentPath = attachmentUrlArray;
                            fq.ForumAttachment.Add(fa);

                        }
                    uow.MasterContext.ForumQuestion.Add(fq);
                    }
                    else
                    {
                        var attachmentUrlArray = attachmentstreamId;
                        var attachmentNameArray = attachmentName;
                        ForumAttachment fa = new ForumAttachment();
                        fa.Name = attachmentNameArray;
                        fa.AttachmentPath = attachmentUrlArray;
                        fa.QuestionId = existingQ;
                        fa.AnswerId = null;
                    uow.MasterContext.ForumAttachment.Add(fa);
                    }

                uow.MasterContext.SaveChanges();
                }
                catch (Exception ex)
                {

                }
            
            return result;
        }

        public int AddForumAnswer(int UserId, int QuestionId, PAM.ForumAnswer forumAnswer,HttpFileCollectionBase Files)
        {
            string msg = string.Empty;
            int returnValue = 0;
           // PAM.BlobUploadResult blobUploadResult = null;
            string AttachmentUrl = string.Empty;
            string AttachmentName = string.Empty;
            string attachmentstreamId = string.Empty;

            try
            {              
                returnValue = AddAnswer(UserId, QuestionId, forumAnswer.AnswerText,Files);
                msg = "Success";
                returnValue = 1;
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                returnValue = 0;
            }

            return returnValue;
        }

        private int AddAnswer(int userId, int questionId, string answertext,HttpFileCollectionBase Files)
        {
            int result = 0;
           
                try
                {
                    var answererQueryable = uow.MasterContext.UserMaster
                        .Where(um => um.Id == userId)
                        .Select(um => um.FirstName + " " + um.LastName)
                        .Future();

                    var questionerQueryable = uow.MasterContext.ForumQuestion
                        .Where(fq => fq.Id == questionId)
                        .Select(fq => new { UserId = fq.UserId })
                        .Future();

                    var userName = answererQueryable.First();
                    var questioner = questionerQueryable.First();
                    
                    ForumAnswer fa = new ForumAnswer
                    {
                        Answer = answertext,
                        QuestionId = questionId,
                        UserId = userId,
                        //PostDate = DateTime.Now 
                        PostDate = DateTime.UtcNow
                    };
                    if (Files.Count > 0)
                    {
                        fa.ForumAttachment = new List<ForumAttachment>();
                        for (int i = 0; i < Files.Count; i++)
                        {
                            HttpPostedFileBase file = null;
                            file = Files[i];
                            string AttachmentUrl = string.Empty;
                            string AttachmentName = string.Empty;
                            string attachmentstreamId = string.Empty;
                            StorageTypeFactory factory = new ConcreteStorageFactory();
                            StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                            string key = answertext;
                            attachmentstreamId = storagefactory.Upload(uow, key, file, PAM.StorageContext.Forum);
                            AttachmentName = Path.GetFileName(file.FileName);

                            if (!String.IsNullOrEmpty(AttachmentName))
                            {
                                    fa.ForumAttachment.Add(new ForumAttachment
                                    {
                                        Name = AttachmentName,
                                        AttachmentPath = attachmentstreamId,
                                        QuestionId = questionId
                                    });
                               
                            }
                        }
                    }
                uow.MasterContext.ForumAnswer.Add(fa);
                    var notificationid = uow.MasterContext.ForumAnswer.Where(fas => fas.QuestionId == questionId && fas.ForumQuestion.UserId != userId)
                            .Select(fas => fas.Id).ToList();
                    if (notificationid.Count >= 1)
                    {
                    uow.MasterContext.UserNotifications.Add(new UserNotifications
                        {
                            // CreatedDate = DateTime.Now,
                            CreatedDate = DateTime.UtcNow,
                            Descriptions = String.Format("{0} has answered your question", userName),
                            UserId = questioner.UserId ?? 0, //assume userId as 0 for default notifications/or if the user id is unresolved
                            UserKey = Guid.NewGuid().ToString()
                        });
                    }


                uow.MasterContext.SaveChanges();
                }
                catch (Exception ex)
                {

                }
            
            return result;
        }

        public int RemoveForumQuestion(int userId, int questionId)
        {
            string msg = string.Empty;
            int returnValue = 0;
            
                try
                {
                    //use cascade delete instead?
                    var forumQuestion = uow.MasterContext.ForumQuestion
                        .FirstOrDefault(fq => fq.Id == questionId && fq.UserId == userId);
                    foreach (var attachment in forumQuestion.ForumAttachment)
                    {
                        forumQuestion.ForumAttachment.Remove(attachment);
                    }
                    foreach (var answer in forumQuestion.ForumAnswer)
                    {
                        forumQuestion.ForumAnswer.Remove(answer);
                    }
                uow.MasterContext.ForumQuestion.Remove(forumQuestion);


                    msg = "Success";
                }

                catch (Exception ex)
                {
                    msg = ex.Message;
                }
            
            return returnValue;
        }


    }
}