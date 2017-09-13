using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PharmaACE.ForecastApp.Models;
using PharmaACE.ForecastApp.Business;
using System.IO;

namespace PharmaACE.ForecastApp.Controllers
{
    public class AdminController : BaseController
    {
        //
        // GET: /Admin/

        public ActionResult Index()
        {
            logger.Info("Inside Admin/Index");
            if ((Session != null && (!string.IsNullOrEmpty(Session["User"] as string)) && (Session["RoleId"].SafeToNum() == 3) || (Session["RoleId"].SafeToNum() == 2)))
            {
                return View();
            }
            else
            {
                logger.Info("Invalid session");
                return RedirectToAction("Index", "Home");
            }
        }

        [HttpPost]
        public JsonResult SignUp(string firstName, string lastName, string email, int isadmin, int roleId, int SubscriberId, UserPermission permission, bool mailrequired, string tenantName)
        {
            logger.Info("Inside Admin/SignUp");
            int res = 4; //4 : Could not add user
            string msg = null;
            var model = new SignUp();
            model.FirstName = firstName;
            model.LastName = lastName;
            model.Email = email;
            model.SP_Email = "";
            model.SP_Password = "";
            model.IsActive = 1;
            model.RoleId = roleId;
            model.isadmin =isadmin;
            model.CompanyId = SubscriberId;
            logger.Info("SignUp for {0}", email);
            try
            {
                res = new UserManager(UnitOfWork).AddNewUser(model, permission, tenantName);
                if (res == 1)
                {
                    logger.Info("{0} added new user Successfully", email);
                }
                else
                    logger.Info("{0} add new user Fail", email);
                if (res == 1 && mailrequired)
                {
                    if (!new UserManager(UnitOfWork).SendMailForSignUpAdmin(email, model))
                    {
                        msg = "Mail not sent to " + email;
                        logger.Info(msg);
                    }
                    else
                    {
                        logger.Info("Successfully mail send to {0}", email);
                    }
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/SignUp: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }

            if (String.IsNullOrEmpty(msg))
            {
                return Json(new { success = true, result = res }, JsonRequestBehavior.AllowGet);
            }
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }


        [HttpGet]
        public JsonResult ShowUserInformation()
        {
            logger.Info("Inside Admin/ShowUserInformation");
            UserInfo userInfo = new UserInfo();
            string msg = null;
            try
            {
                if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
                {
                    string email = Session["User"].ToString();
                    var loginDate = Session["LoginDate"];
                    logger.Info("showing {0} information", email);
                    userInfo = new UserManager(UnitOfWork).GetUserInformationByEmail(email);
                    if (userInfo != null)
                    {
                        logger.Info("showing User information Successfully");
                    }
                    else
                    {
                        msg = "showing User information fail";
                        logger.Info(msg);
                    }
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/ShowUserInformation: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, userInfo = userInfo }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetUserInformationByUserId(int id)
        {
            logger.Info("Inside Admin/GetUserInformationByUserId");
            UserLoginDetails userDetails = new UserLoginDetails();
            string msg = null;
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                string email = Session["User"].ToString();
                userDetails = new UserManager(UnitOfWork).GetUserInformationByUserId(id);
                    if (userDetails!=null)
                    {
                        logger.Info("Got User Information By UserId successfully");

                    }
                    else
                    {
                        msg = "Getting User Information By UserId fail";
                        logger.Info(msg);
                    }
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/GetUserInformationByUserId: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
            {
                return Json(new { success = true, userInfo = userDetails }, JsonRequestBehavior.AllowGet);
            }
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }


        [HttpGet]
        public JsonResult UpdateUserProfile(string firstname, string lastname, string email)
        {
            logger.Info("Inside Admin/UpdateUserProfile");
            string msg = null;
            var model = new UpdateUserProfile();
            model.FirstName = firstname;
            model.LastName = lastname;
            //model.SubscriptionStartDate = subscriptionstartdate;
            //model.SubscriptionEndDate = subscriptionstartdate;
            model.Email = email;
            int outparam = 0;
            try
            {
                logger.Info("Updating {0} profile", email);
                outparam = new UserManager(UnitOfWork).UpdateUserProfile(firstname, lastname, email);
                if (outparam == 1)
                {
                    logger.Info("Update User profile successfully", email);
                }
                else
                {
                    msg = "Update user profile successfully";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/UpdateUserProfile: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
            {
               
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult UpdateUserProfileByUserId(int id, int status, int roleId, UserPermission permission)
        {
            logger.Info("Inside Admin/UpdateUserProfileByUserId");
            string msg = null;
            int outparam = 0;
            try
            {
            outparam = int.Parse(new UserManager(UnitOfWork).UpdateUserProfileByUserId(id, status, roleId, permission).ToString());
                if (outparam == 1)
                {
                    logger.Info("Updated user profile successfully");
                }else
                {
                    msg = "update user profile fail";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/UpdateUserProfileByUserId: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
            {
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult ManageUser()
        {
            logger.Info("Inside Admin/ManageUser");
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        public ActionResult UserList(List<int> SubscriberIds)
        {
            logger.Info("Inside Admin/UserList");
            string msg = String.Empty;
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                IEnumerable<UserInfo> UsersList = new List<UserInfo>();
                string email;
                email = Session["User"].ToString();
                UsersList = new UserManager(UnitOfWork).ViewUsersByCompanyId(SubscriberIds);
                return View(UsersList);
            }
            else
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/UserList: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }


        




        public ActionResult SubscriberList()
        {
            logger.Info("Inside Admin/SubscriberList");
            string msg = String.Empty;
            try
            {
            if (Session != null && (!string.IsNullOrEmpty(Session["user"] as string)))
            {
                IEnumerable<SubscriberRegistrationInfo> SubscribersList = new List<SubscriberRegistrationInfo>();
                SubscribersList = new UserManager(UnitOfWork).GetSubscriberDetailsList();
                return View(SubscribersList);
            }
            else
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/UserList: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }
        }

        [HttpGet]
        public JsonResult SubscriberListForSuperAdmin()
        {
            logger.Info("Inside Admin/SubscriberListForSuperAdmin");
            string msg = "";
            SubscriberListModel subscriberInfo = new SubscriberListModel();
            try
                {    
                    subscriberInfo = new UserManager(UnitOfWork).GetSubscriberList();
                if (subscriberInfo!=null)
                {
                    logger.Info("Getting Subscriber List For Super Admin Successfully");

                }else
                    logger.Info("Getting Subscriber List For Super Admin fail");

            }

            catch (Exception ex)
                {
                    msg = ex.Message;
                }
 
            if (String.IsNullOrEmpty(msg))
            {
                return Json(new { success = true, subscriberInfo = subscriberInfo }, JsonRequestBehavior.AllowGet);
            }
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }


        public ActionResult SignUpAdminUser()
        {
            logger.Info("Inside Admin/SignUpAdminUser");
            SubscriberListModel subscriberInfo = new SubscriberListModel();
            if ((Session != null && (!string.IsNullOrEmpty(Session["User"] as string)) && (Session["RoleId"].SafeToNum() == 3) || (Session["RoleId"].SafeToNum() == 2)))
            {
                subscriberInfo = new UserManager(UnitOfWork).GetSubscriberList();
                return View(subscriberInfo);
            }
            else
                return RedirectToAction("Index", "Home");
        }

        public ActionResult ViewUser()
        {
            logger.Info("Inside Admin/ViewUser");
            if ((Session != null && (!string.IsNullOrEmpty(Session["User"] as string)) && (Session["RoleId"].SafeToNum() == 3) || (Session["RoleId"].SafeToNum() == 2)))
            {
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public JsonResult DeleteUserById(int id)
        {
            logger.Info("Inside Admin/DeleteUserById");
            string msg = null;
            int outparam = 0;
            try
            {
                outparam = new UserManager(UnitOfWork).DeleteUserById(id);
                if (outparam==1)
                {
                    logger.Info("Successfully Delete User By Id={0}", id);
                }
                else
                {
                    msg = "fail to delete User";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/DeleteUserById: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }

            if (String.IsNullOrEmpty(msg))
            {
                return Json(new { success = true, outparam = outparam }, JsonRequestBehavior.AllowGet);
            }
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public JsonResult DeleteSubscriberByName(string subscriberName)
        {
            logger.Info("Inside Admin/DeleteSubscriberByName");
            string msg = null;
            int outparam = 0;
            try
            {
            outparam = new UserManager(UnitOfWork).DeleteSubscriberByName(subscriberName);
                if (outparam==1)
                {
                    logger.Info("Delete Subscriber By Name successfully");
                }
                else if (outparam==2)
                {
                    logger.Info("tenant does not exist");
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/DeleteSubscriberByName: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
            {
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult SubscriberRegistration()
        {
            logger.Info("Inside Admin/SubscriberRegistration");
            if ((Session != null && (!string.IsNullOrEmpty(Session["User"] as string)) && (Session["RoleId"].SafeToNum() == 3)))
            {
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }

        public ActionResult EditSubscriber(SubscriberRegistrationInfo subscriber)
        {
            logger.Info("Inside Admin/EditSubscriber");
            if ((Session != null && (!string.IsNullOrEmpty(Session["User"] as string)) && (Session["RoleId"].SafeToNum() == 3)))
            {
                return View(subscriber);
            }
            else
                return RedirectToAction("Index", "Home");

        }

        [HttpGet]
        public JsonResult UpdateSubscriberDetails(int subscriberId, bool isActive, DateTime subscriptionStartDate, DateTime subscriptionEndDate, int maxUserNumber,string dbServer, string dbUser, string dbPassword, string feedKeyword, string spPassword, string spAccount)
        {
            logger.Info("Inside Admin/UpdateSubscriberDetails");
            string msg = null;
            int outparam = 0;
            try
            {

            outparam = new UserManager(UnitOfWork).UpdateSubscriberDetails(subscriberId, isActive, subscriptionStartDate, subscriptionEndDate, maxUserNumber,dbServer, dbUser, dbPassword, feedKeyword,  spAccount, spPassword);
                if (outparam == 1)
                {
                    logger.Info("Successfully Updated Subscriber Details");
                }
                else
                {
                    msg = "fail to Updated Subscriber Details";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/UpdateSubscriberDetails: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
            {
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ViewSubscribers()
        {
            logger.Info("Inside Admin/ViewSubscribers");
            if ((Session != null && (!string.IsNullOrEmpty(Session["User"] as string)) && (Session["RoleId"].SafeToNum() == 3)))
            {
                return View();
            }
            else
                return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public JsonResult Subscriber(string subscriberName, bool isActive, DateTime subscriptionStartDate, DateTime subscriptionEndDate, int maxUserNumber, string dbServer, string dataBaseName, string dbUser, string dbPassword, string spAccount, string spPassword, string archive, string feedKeyword)
        {
            logger.Info("Inside Admin/Subscriber");
            string msg = null;
            var model = new SubscriberRegistrationInfo();
            model.SubscriberName = subscriberName;
            model.IsActive = isActive;
            model.SubscriptionStartDate = subscriptionStartDate;
            model.SubscriptionEndDate = subscriptionEndDate;
            model.MaxUserNumber = maxUserNumber;
            model.DatabaseName = dataBaseName;
            model.DbServer = dbServer;
            model.DbUser = dbUser;
            model.DbPassword = dbPassword;
            model.SPAccount = spAccount;
            model.SPPassword = spPassword;
            model.Archive = archive;
            model.FeedKeyword = feedKeyword;
            String message = string.Empty;
            try
            {
            SpComHelper.CreateDocumentLibrary(GenUtil.SPSiteUrl, model.SPAccount, model.SPPassword, "", true, model.Archive, null, out msg);
            msg = new UserManager(UnitOfWork).RegisterSubscriber(model);

            }
            catch (Exception ex)
            {
                message = ex.Message;
               logger.Error("Exception at Admin/Subscriber: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(message))
            {
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        private void CreateSubscriberDataBase(string DBServer, string DatabaseName, string DBUser, string DBPassword)
        {
            logger.Info("Inside Admin/CreateSubscriberDataBase");
            //TO DO: return the result to show messages
            int result = new UserManager(UnitOfWork).CreateSubscriberDataBase(DBServer,DatabaseName,DBUser,DBPassword);           
        }

        public ActionResult IndicationReference()
        {
            logger.Info("Inside Admin/IndicationReference");
            try
            {
                if ((Session != null && (!string.IsNullOrEmpty(Session["User"] as string)) && (Session["RoleId"].SafeToNum() == 3)))
                {
                    List<string> Indication = new List<string>();
                    Indication = new UserManager(UnitOfWork).GetAllIndicationName();
                    ViewBag.Indication = Indication;
                    List<SectionData> Section = new List<SectionData>();
                    Section = new UserManager(UnitOfWork).GetAllSectionName();
                    ViewBag.Sections = Section;
                    return PartialView();
                }
                else
                    return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                logger.Error("Exception at Admin/IndicationReference: {0} \r\n {1}", ex.Message, ex.StackTrace);
                return RedirectToAction("Error", "Error");
            }

        }

        public JsonResult SaveIndicationReference(string indicationName, int sectionId, string reference)
        {
            logger.Info("Inside Admin/SaveIndicationReference");
            string msg = String.Empty;
            int outparam = 0;
            try
            {
                if (indicationName.Trim() != "" && sectionId.SafeToNum() != 0 && reference.Trim() != "")
                {
                    outparam = new UserManager(UnitOfWork).SaveIndicationReference(indicationName, sectionId, reference);
                    if (outparam == 1)
                    {
                        logger.Info("Indication reference saved successfully");
                    }
                    else if (outparam == 2)
                    {
                        logger.Info("Indication name against section added successfully");
                    }
                    else
                    {
                        msg = "fail to save indication reference";
                        logger.Info(msg);
                    }
                }
                else
                {
                    outparam = 3;
                    msg = "Please enter all the field";
                    logger.Info(msg);
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/SaveIndicationReference: {0} \r\n {1}", ex.Message, ex.StackTrace);
            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, outparam = outparam }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, outparam = outparam, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult FetchIndicationReference(string indicationName, int sectionId)
        {
            logger.Info("Inside Admin/FetchIndicationReference");
            string msg = String.Empty;
            string outparam = string.Empty;
            try
            {
                outparam = new UserManager(UnitOfWork).FetchIndicationReference(indicationName, sectionId);
                if (String.IsNullOrEmpty(outparam))
                {
                    logger.Info("Reference is not present indication name and section id");
                }
                else
                {
                    logger.Info("Fetching indication reference successfully");
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                logger.Error("Exception at Admin/FetchIndicationReference: {0} \r\n {1}", ex.Message, ex.StackTrace);

            }
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true, outparam = outparam }, JsonRequestBehavior.AllowGet);
            else
                return Json(new { success = false, errors = new[] { msg } }, JsonRequestBehavior.AllowGet);

        }
    }
}
