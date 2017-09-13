using PharmaACE.ForecastApp.Business;
using PAM = PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Configuration;

namespace PharmaACE.ForecastApp.Controllers
{
    public class CommunityPracticeController : BaseController
    {
        public ActionResult Index()
        {
            logger.Info("Inside CommunityPractice/Index");
            if ((Session != null && (!string.IsNullOrEmpty(Session["User"] as string)) && (Session["AccessTypeCP"].SafeToNum() != 0)))
            {
                return View();
            }
            else
            {
                 logger.Info("Invalid session");
                return RedirectToAction("Index", "Home");
            }
        }
        public ActionResult LatestQuestions(int questionCount)
        {
            logger.Info("Inside CommunityPractice/LatestQuestions");
            try
            {
                if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                PAM.CommunityPractice communityPractice = new PAM.CommunityPractice();
                communityPractice.questionList = new CommunityManager(UnitOfWork).GetQuestionsList(questionCount);
                if (communityPractice != null && communityPractice.questionList.Count() >= 1)
                    return View(communityPractice);
                else
                    //  return View("NoResultFound");
                    return View(communityPractice);
            }
            else
            {
                logger.Info("Invalid session");
                return RedirectToAction("Index", "Home");
            }
            }
            catch (Exception ex)
            {
                logger.Error("Exception at CommunityPractice/LatestQuestions: {0} \r\n {1}", ex.Message, ex.StackTrace);  
                return RedirectToAction("Error", "Error");
            }
        }
        public ActionResult QuestionsListByCategory(Byte CategoryId)
        {
            logger.Info("Inside CommunityPractice/QuestionsListByCategory");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                IEnumerable<PAM.ForumQuestion> QuestionList = new List<PAM.ForumQuestion>();
                PAM.CommunityPractice communityPractice = new PAM.CommunityPractice();
                communityPractice.questionList = new CommunityManager(UnitOfWork).GetQuestionsListByCategory(CategoryId);
                if (communityPractice != null && communityPractice.questionList.Count() >= 1)
                    return View("LatestQuestions", communityPractice);
                else
                    //return View("NoResultFound");
                    return View("LatestQuestions", communityPractice);
            }
            else
                {
                    logger.Info("Invalid session");
                    return RedirectToAction("Index", "Home");
                }
            }
            catch (Exception ex)
            {

                logger.Error("Exception at CommunityPractice/QuestionsListByCategory: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }
        public ActionResult AskQuestion()
        {
            try
            {
                logger.Info("Inside CommunityPractice/AskQuestion");
                if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
                {
                    PAM.CommunityPractice communityPractice = new PAM.CommunityPractice();
                    return View(communityPractice);
                }
                else
                {

                    logger.Info("Invalid session");
                    return RedirectToAction("Index", "Home");
                }
            }
            catch (Exception e)
            {
                logger.Info(e.Message);
                return RedirectToAction("Error", "Error");

                // throw;
            } 
           
        }
        [HttpPost]
        public int AddQuestion(string questionTitle, int questionCategoryCode)
        {
            logger.Info("Inside CommunityPractice/AddQuestion");
            string msg = string.Empty;
            int returnValue = 0;
            bool isValidExt = false;
            string extension = string.Empty;
            bool isValidStream = false;
            try
            {
                PAM.ForumQuestion forumQuestion = new PAM.ForumQuestion();
                forumQuestion.QuestionTitle = questionTitle;
                forumQuestion.QuestionCategory = questionCategoryCode;
                forumQuestion.QuestionText = Request["questionText"];
                HttpPostedFileBase file = null;
                // if (Request.Files != null && Request.Files.Count > 0)
                if (Request.Files != null)
                {
                    for (int i = 0; i < Request.Files.Count; i++)
                    {
                        file = Request.Files[i];
                        isValidExt = GenUtil.fileFilterExtensions(file);
                        extension = Path.GetExtension(file.FileName);
                        int index = file.FileName.LastIndexOf('.');
                        string fileExtension = file.FileName.Substring(index + 1);

                        int uploadTypeID = Convert.ToInt32(ConfigurationManager.AppSettings["uploadfiletype"].ToString());
                        if (isValidExt)
                        {
                            if (uploadTypeID == 0)
                            {
                                isValidStream = true;
                                msg = "";
                            }
                            else if (uploadTypeID == 1)
                            {
                                isValidStream = true;//GenUtil.getActualTypeOfFile(file, extension);
                                if (isValidStream == false)
                                {
                                    returnValue = 2;
                                    msg = "This is not " + fileExtension + "extension!";
                                    break;
                                }
                            }
                        }

                        if (isValidExt == false)
                        {
                            returnValue = 2;
                            msg = "One of selected file has invalid extension!";
                            break;
                        }

                    }
                }
                
                if (isValidExt == true && isValidStream == true)
                {
                    if (Request.Files != null && Request.Files.Count > 0)
                    {
                        for (int i = 0; i < Request.Files.Count; i++)
                        {
                            file = Request.Files[i];
                            returnValue = new CommunityManager(UnitOfWork).AddForumQuestion(Session["UserId"].SafeToNum(), forumQuestion, file);
                        }
                    }
                }
                else
                {
                    if (Request["questionText"]!="")
                    {
                        returnValue = new CommunityManager(UnitOfWork).AddForumQuestion(Session["UserId"].SafeToNum(), forumQuestion, file);
                    }
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at CommunityPractice/AddQuestion: {0} \r\n {1}", ex.Message, ex.StackTrace);
                returnValue = 0;
            }
            return returnValue;
        }
        public ActionResult ViewAnswer(int id)
        {
            logger.Info("Inside CommunityPractice/ViewAnswer");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                PAM.ForumQuestionDetails forumQuestionDetails = new PAM.ForumQuestionDetails();
                forumQuestionDetails = new CommunityManager(UnitOfWork).GetQuestionDetails(id);
                return PartialView(forumQuestionDetails);
            }
            else
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                logger.Error("Exception at CommunityPractice/LatestQuestions: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }
        [HttpPost]
        public int AddAnswer(int QuestionId)
        {
            logger.Info("Inside CommunityPractice/AddAnswer");
            string msg = string.Empty;
            int returnValue = 0;
            bool isValidExt = false;
            string extension = string.Empty;
            bool isValidStream = false;
            try
            {
                PAM.ForumAnswer forumanswer = new PAM.ForumAnswer();
                //if (Request["AnswerText"] == "" || Request.Files.Count<=0)
                if (Request["AnswerText"] == "")
                {
                    logger.Error("Exception at CommunityPractice/AddAnswer: {0} \r\n {1}", "AnswerText or attachment is not available","");
                    returnValue = 0;
                    return returnValue;
                }
                forumanswer.AnswerText = Request["AnswerText"];
                HttpPostedFileBase file = null;
                //if (Request.Files != null && Request.Files.Count > 0)
                if (Request.Files != null)
                {
                    for (int i = 0; i < Request.Files.Count; i++)
                    {
                        file = Request.Files[i];
                        isValidExt = GenUtil.fileFilterExtensions(file);
                        extension = Path.GetExtension(file.FileName);
                        int index = file.FileName.LastIndexOf('.');
                        string fileExtension = file.FileName.Substring(index + 1);

                        int uploadTypeID = Convert.ToInt32(ConfigurationManager.AppSettings["uploadfiletype"].ToString());
                        if (isValidExt)
                        {
                            if (uploadTypeID == 0)
                            {
                                isValidStream = true;
                                msg = "";
                            }
                            else if (uploadTypeID == 1)
                            {
                                isValidStream = true;//GenUtil.getActualTypeOfFile(file, extension);
                                if (isValidStream == false)
                                {
                                    returnValue = 2;
                                    msg = "This is not " + fileExtension + "extension!";
                                    break;
                                }
                            }
                        }

                        if (isValidExt == false)
                        {
                            returnValue = 2;
                            msg = "One of selected file has invalid extension!";
                            break;
                        }

                    }

                }
                if (isValidExt == true && isValidStream == true)
                {
                    if (Request.Files != null && Request.Files.Count > 0)
                    {
                            returnValue = new CommunityManager(UnitOfWork).AddForumAnswer(Session["UserId"].SafeToNum(), QuestionId, forumanswer, Request.Files);
                       
                    }

                }
                else
                {
                    if (Request["AnswerText"] != "")
                    {
                        returnValue = new CommunityManager(UnitOfWork).AddForumAnswer(Session["UserId"].SafeToNum(), QuestionId, forumanswer, Request.Files);
                    }
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at CommunityPractice/AddAnswer: {0} \r\n {1}", ex.Message, ex.StackTrace);
                returnValue = 0;
            }
            return returnValue;
        }
        public ActionResult SearchQuestions(string KeyWord)
        {
            logger.Info("Inside CommunityPractice/SearchQuestions");
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                IEnumerable<PAM.ForumQuestion> QuestionList = new List<PAM.ForumQuestion>();                
                QuestionList = new CommunityManager(UnitOfWork).SearchQuestionsByKeyWord(KeyWord);
                PAM.CommunityPractice communityPractice = new PAM.CommunityPractice();
                communityPractice.questionList = QuestionList;
                if (communityPractice != null && communityPractice.questionList.Count() >= 1)
                    return View("LatestQuestions", communityPractice);
                else
                    return View("NoResultFound");
            }
            else
                return RedirectToAction("Index", "Home");

            }
            catch (Exception ex)
            {
                logger.Error("Exception at CommunityPractice/LatestQuestions: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }
        public int RemoveForumQuestion(int userId, int questionId)
        {
            logger.Info("Inside CommunityPractice/RemoveForumQuestion");
            string msg = string.Empty;
            int returnValue = 0;
            try
            {
                returnValue = new CommunityManager(UnitOfWork).RemoveForumQuestion(userId, questionId);
                if (returnValue == 0)
                {
                    logger.Info("Successfully Remove Forum Question");
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at CommunityPractice/RemoveForumQuestion: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            return returnValue;
        }

        public ActionResult DownloadFile(string attstreamId, string attName)
        {
            logger.Info("Inside CommunityPractice/DownloadFile");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                string fileName = string.Empty;
                fileName = attName;
                byte[] byteArr = null;
                string msg = string.Empty;
                StorageTypeFactory factory = new ConcreteStorageFactory();
                string key = attstreamId + "|" + "";
                StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                try
                {
                    byteArr = storagefactory.Download(UnitOfWork, key, PAM.StorageContext.Forum);
                    if (byteArr != null)
                    {
                        logger.Info("got byte array for Download file");
                    }
                    else
                        logger.Info("not get byte array for Download file");
                }
                catch (Exception ex)
                {
                    msg = ex.Message;
                }
                if (byteArr != null && String.IsNullOrEmpty(msg))
                    return File(byteArr, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
                return null;
            }
            else
                return RedirectToAction("Index", "Home");

        }
    }
}
