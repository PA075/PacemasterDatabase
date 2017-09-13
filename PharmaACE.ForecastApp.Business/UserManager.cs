using Microsoft.Azure;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.StorageClient;
using PharmaACE.ForecastApp.EntityProvider.pacemaster;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using EntityFramework.Extensions;
using System.Data.Entity;
using System.Web.Mvc;
using PharmaACE.ForecastApp.EntityProvider.TenantModel;
using System.Text;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net.NetworkInformation;
using System.Web.Security;

namespace PharmaACE.ForecastApp.Business
{
    public class UserManager
    {
        private MasterModel masterContext;
        private TenantModel tenantContext;
        public UserManager(IUnitOfWork uow)
        {
            this.masterContext = uow.MasterContext;
            this.tenantContext = uow.TenantContext;
        }
        
        public int AddNewUser(SignUp model, UserPermission permission, string tenantName)
        {
            int result = 0;
            try
            {
                //generate an arbitrary passwrod for the new user
                model.Password = GenUtil.GeneratePassword(model.FirstName, model.LastName, tenantName);
                
                    SqlParameter firstName = new SqlParameter("@firstName", SqlDbType.NVarChar, 50);
                    firstName.Direction = ParameterDirection.Input;
                    firstName.Value = model.FirstName;

                    SqlParameter lastName = new SqlParameter("@lastName", SqlDbType.NVarChar, 50);
                    lastName.Direction = ParameterDirection.Input;
                    lastName.Value = model.LastName;

                    SqlParameter email = new SqlParameter("@email", SqlDbType.NVarChar, 100);
                    email.Direction = ParameterDirection.Input;
                    email.Value = model.Email;

                    SqlParameter password = new SqlParameter("@password", SqlDbType.NVarChar, 50);
                    password.Direction = ParameterDirection.Input;
                    password.Value = model.Password;

                    SqlParameter companyId = new SqlParameter("@CompanyId", SqlDbType.Int);
                    companyId.Direction = ParameterDirection.Input;
                    companyId.Value = model.CompanyId;

                    SqlParameter isActive= new SqlParameter("@IsActive", SqlDbType.Int);
                    isActive.Direction = ParameterDirection.Input;
                    isActive.Value = model.IsActive;

                    //SqlParameter isAdmin = cmd.Parameters.Add("@IsAdmin", SqlDbType.Int);
                    //isAdmin.Direction = ParameterDirection.Input;
                    //isAdmin.Value = model.isadmin;

                    SqlParameter roleId= new SqlParameter("@RoleId", SqlDbType.Int);
                    roleId.Direction = ParameterDirection.Input;
                    roleId.Value = model.RoleId;

                    SqlParameter knowledgeManagement = new SqlParameter("@KnowledgeManagement", SqlDbType.Bit);
                    knowledgeManagement.Direction = ParameterDirection.Input;
                    knowledgeManagement.Value = permission.KnowledgeManagement;

                    SqlParameter accessTypeKM = new SqlParameter("@AccessTypeKM",SqlDbType.TinyInt);
                    accessTypeKM.Direction = ParameterDirection.Input;
                    accessTypeKM.Value = permission.AccessTypeKM;

                    SqlParameter businessIntelligence = new SqlParameter("@BusinessIntelligence", SqlDbType.Bit);
                    businessIntelligence.Direction = ParameterDirection.Input;
                    businessIntelligence.Value = permission.BusinessIntelligence;

                    SqlParameter accessTypeBI = new SqlParameter("@AccessTypeBI",SqlDbType.TinyInt);
                    accessTypeBI.Direction = ParameterDirection.Input;
                    accessTypeBI.Value = permission.AccessTypeBI;

                    SqlParameter utilities = new SqlParameter("@Utilities",SqlDbType.Bit);
                    utilities.Direction = ParameterDirection.Input;
                    utilities.Value = permission.Utilities;

                    SqlParameter accessTypeUT = new SqlParameter("@AccessTypeUT", SqlDbType.TinyInt);
                    accessTypeUT.Direction = ParameterDirection.Input;
                    accessTypeUT.Value = permission.AccessTypeUT;

                    SqlParameter customFeed = new SqlParameter("@CustomFeed",SqlDbType.Bit);
                    customFeed.Direction = ParameterDirection.Input;
                    customFeed.Value = permission.CustomFeed;

                    SqlParameter accessTypeCF = new SqlParameter("@AccessTypeCF", SqlDbType.TinyInt);
                    accessTypeCF.Direction = ParameterDirection.Input;
                    accessTypeCF.Value = permission.AccessTypeCF;

                    SqlParameter communityOfPractice = new SqlParameter("@CommunityOfPractice",SqlDbType.Bit);
                    communityOfPractice.Direction = ParameterDirection.Input;
                    communityOfPractice.Value = permission.CommunityOfPractice;

                    SqlParameter accessTypeCP = new SqlParameter("@AccessTypeCP", SqlDbType.TinyInt);
                    accessTypeCP.Direction = ParameterDirection.Input;
                    accessTypeCP.Value = permission.AccessTypeCP;

                    SqlParameter userWorkspace = new SqlParameter("@UserWorkspace",SqlDbType.Bit);
                    userWorkspace.Direction = ParameterDirection.Input;
                    userWorkspace.Value = permission.UserWorkspace;

                    SqlParameter accessTypeUW = new SqlParameter("@AccessTypeUW", SqlDbType.TinyInt);
                    accessTypeUW.Direction = ParameterDirection.Input;
                    accessTypeUW.Value = permission.AccessTypeUW;

                    SqlParameter helpDesk = new SqlParameter("@HelpDesk",SqlDbType.Bit);
                    helpDesk.Direction = ParameterDirection.Input;
                    helpDesk.Value = permission.HelpDesk;

                    SqlParameter accessTypeHD = new SqlParameter("@AccessTypeHD", SqlDbType.TinyInt);
                    accessTypeHD.Direction = ParameterDirection.Input;
                    accessTypeHD.Value = permission.AccessTypeHD;

                    SqlParameter forecastPlatform = new SqlParameter("@ForecastPlatform",SqlDbType.Bit);
                    forecastPlatform.Direction = ParameterDirection.Input;
                    forecastPlatform.Value = permission.ForecastPlatform;

                    SqlParameter accessTypeFP = new SqlParameter("@AccessTypeFP", SqlDbType.TinyInt);
                    accessTypeFP.Direction = ParameterDirection.Input;
                    accessTypeFP.Value = permission.AccessTypeFP;

                    SqlParameter genericTool = new SqlParameter("@GenericTool",SqlDbType.Bit);
                    genericTool.Direction = ParameterDirection.Input;
                    genericTool.Value = permission.GenericTool;

                    SqlParameter accessTypeGT = new SqlParameter("@AccessTypeGT", SqlDbType.TinyInt);
                    accessTypeGT.Direction = ParameterDirection.Input;
                    accessTypeGT.Value = permission.AccessTypeGT;

                    SqlParameter accessTypeGTforproject = new SqlParameter("@AccessTypeGTforproject", SqlDbType.TinyInt);
                    accessTypeGTforproject.Direction = ParameterDirection.Input;
                    accessTypeGTforproject.Value = permission.AccessTypeGTforproject;

                    SqlParameter BDLTool = new SqlParameter("@BDLTool",SqlDbType.Bit);
                    BDLTool.Direction = ParameterDirection.Input;
                    BDLTool.Value = permission.BDLTool;

                    SqlParameter accessTypeBDL = new SqlParameter("@AccessTypeBDL",SqlDbType.TinyInt);
                    accessTypeBDL.Direction = ParameterDirection.Input;
                    accessTypeBDL.Value = permission.AccessTypeBDL;

                    SqlParameter accessTypeBDLforproject = new SqlParameter("@AccessTypeBDLforproject",SqlDbType.TinyInt);
                    accessTypeBDLforproject.Direction = ParameterDirection.Input;
                    accessTypeBDLforproject.Value = permission.AccessTypeBDLforproject;

                    SqlParameter patientFlow = new SqlParameter("@PatientFlow",SqlDbType.Bit);
                    patientFlow.Direction = ParameterDirection.Input;
                    patientFlow.Value = permission.PatientFlow;

                    SqlParameter accessTypePF = new SqlParameter("@AccessTypePF",SqlDbType.TinyInt);
                    accessTypePF.Direction = ParameterDirection.Input;
                    accessTypePF.Value = permission.AccessTypePF;

                    SqlParameter accessTypePFforproject = new SqlParameter("@AccessTypePFforproject", SqlDbType.TinyInt);
                    accessTypePFforproject.Direction = ParameterDirection.Input;
                    accessTypePFforproject.Value = permission.AccessTypePFforproject;


                string query = "exec dbo.uspAddNewUser @firstName, @lastName, @email, @password, @CompanyId, @IsActive, @RoleId, @KnowledgeManagement, @AccessTypeKM,"
                    + "@BusinessIntelligence, @AccessTypeBI, @Utilities, @AccessTypeUT, @CustomFeed, @AccessTypeCF, @CommunityOfPractice, @AccessTypeCP,"
                    + "@UserWorkspace, @AccessTypeUW, @HelpDesk, @AccessTypeHD, @ForecastPlatform, @AccessTypeFP, @GenericTool, @AccessTypeGT, @AccessTypeGTforproject,"
                    + "@BDLTool, @AccessTypeBDL, @AccessTypeBDLforproject, @PatientFlow, @AccessTypePF, @AccessTypePFforproject";
                result = masterContext.Database.SqlQuery<int>(query, firstName, lastName, email, password, companyId, isActive, roleId, 
                    knowledgeManagement, accessTypeKM, businessIntelligence, accessTypeBI, utilities, accessTypeUT, customFeed, accessTypeCF, communityOfPractice,
                    accessTypeCP, userWorkspace, accessTypeUW, helpDesk, accessTypeHD, forecastPlatform, accessTypeFP, genericTool, accessTypeGT,
                    accessTypeGTforproject, BDLTool, accessTypeBDL, accessTypeBDLforproject, patientFlow, accessTypePF, accessTypePFforproject).SingleOrDefault().SafeToNum();


            }
            catch (Exception ex)
            {
                result = 0;
            }

            return result;
        }

        public bool SendMailForSignUpAdmin(string toEmail, SignUp model)
        {
            var password = model.Password;
            // StringBuilder class is present in System.Text namespace
            StringBuilder sbEmailBody = new StringBuilder();
            sbEmailBody.Append("Welcome! <br/><br/>");
            sbEmailBody.Append("Thank you for becoming a registered member of: PACEHomepage.com.");
            sbEmailBody.Append("Please use following credentials for login.<br/>");
            sbEmailBody.Append(" Username: " + toEmail + " <br/> password:  " + password);
            sbEmailBody.Append("<br/><br/>");
            sbEmailBody.Append("<b>Regards,</b>");
            sbEmailBody.Append("<br/>");
            sbEmailBody.Append("<b>"+ GenUtil.GetClientNameForSendingMail()+"</b>");
            return GenUtil.SendEmail("Registration Successfull", sbEmailBody.ToString(), toEmail);
        }

        public UserLoginDetails CheckUsersCredentials(string email, string password)
        {
            UserInfo userInfo = new UserInfo();
            UserLoginDetails userLoginDetails = new UserLoginDetails();

            try
            {
                    SqlParameter emailParam = new SqlParameter("@email", SqlDbType.NVarChar, 100);
                    emailParam.Direction = ParameterDirection.Input;
                    emailParam.Value = email;

                    SqlParameter passwordParam = new SqlParameter("@password", SqlDbType.NVarChar, 50);
                    passwordParam.Direction = ParameterDirection.Input;
                    passwordParam.Value = password;

                    SqlParameter deviceKeyParam = new SqlParameter("@deviceKey", SqlDbType.NVarChar, 100);
                    deviceKeyParam.Direction = ParameterDirection.Input;
                    deviceKeyParam.Value = String.Empty;

                FlattenedUserInfo flattenedUserInfo = masterContext.Database.SqlQuery<FlattenedUserInfo>("dbo.uspCheckUsersCredentials @email, @password, @deviceKey", emailParam, passwordParam, deviceKeyParam).SingleOrDefault();

                if (flattenedUserInfo != null)
                {
                    UserPermission userPermission = new UserPermission();
                    userInfo.LoginResult = flattenedUserInfo.LoginResult;
                    userInfo.DeviceKeyStatus = flattenedUserInfo.KeyResult;
                    if (userInfo.DeviceKeyStatus == 3)
                    {
                        //SendNotificationEmail(email);
                    }

                    //userInfo.DeviceKeyStatus = cmd.Parameters["@DeviceKeyStatus"].Value.SafeToNum();
                    if (userInfo.LoginResult == 1)
                    {
                        userInfo.FirstName = flattenedUserInfo.FirstName;
                        userInfo.LastName = flattenedUserInfo.LastName;
                        userInfo.Email = flattenedUserInfo.UserEmail;
                        userInfo.CompanyId = flattenedUserInfo.CompanyId;
                        userInfo.RoleId = flattenedUserInfo.RoleId;
                        char[] delimiterChars = { ' ' };
                        string[] keywords = flattenedUserInfo.FeedKeyword.Split(delimiterChars);
                        // string[] regKeywords = row["RegulatoryName"].SafeTrim().Split(',');
                        string FeedKeyword = string.Empty;
                        //string RegulatoryfeedKeyword = string.Empty;
                        if (keywords.Length > 1)
                        {
                            for (int i = 0; i < keywords.Length; i++)
                            {
                                if (i != keywords.Length - 1)
                                    FeedKeyword += '\'' + keywords[i] + '\'' + '+';
                                else
                                    FeedKeyword += '\'' + keywords[i] + '\'';

                            }
                            FeedKeyword = FeedKeyword.Trim('\'');
                        }
                        else
                        {
                            FeedKeyword += keywords[0];
                        }
                        userInfo.FeedKeyword = FeedKeyword;
                        userInfo.Archive = flattenedUserInfo.Archive;
                        //userInfo.LoginResult = row["LoginResult"].SafeToNum();
                        userInfo.SubscriberName = flattenedUserInfo.SubscriberName;
                        userInfo.UserId = flattenedUserInfo.Id;

                        //UserPermission userPermission = new UserPermission();
                        userPermission.KnowledgeManagement = flattenedUserInfo.KnowledgeManagement;
                        userPermission.AccessTypeKM = flattenedUserInfo.AccessTypeKM;
                        userPermission.BusinessIntelligence = flattenedUserInfo.BusinessIntelligence;
                        userPermission.AccessTypeBI = flattenedUserInfo.AccessTypeBI;
                        userPermission.Utilities = flattenedUserInfo.Utilities;
                        userPermission.AccessTypeUT = flattenedUserInfo.AccessTypeUT;
                        userPermission.CustomFeed = flattenedUserInfo.CustomFeed;
                        userPermission.AccessTypeCF = flattenedUserInfo.AccessTypeCF;
                        userPermission.CommunityOfPractice = flattenedUserInfo.CommunityOfPractice;
                        userPermission.AccessTypeCP = flattenedUserInfo.AccessTypeCP;
                        userPermission.UserWorkspace = flattenedUserInfo.UserWorkspace;
                        userPermission.AccessTypeUW = flattenedUserInfo.AccessTypeUW;
                        userPermission.HelpDesk = flattenedUserInfo.HelpDesk;
                        userPermission.AccessTypeHD = flattenedUserInfo.AccessTypeHD;
                        userPermission.ForecastPlatform = flattenedUserInfo.ForecastPlatform;
                        userPermission.AccessTypeFP = flattenedUserInfo.AccessTypeFP;
                        userPermission.GenericTool = flattenedUserInfo.GenericTool;
                        userPermission.AccessTypeGT = flattenedUserInfo.AccessTypeGT;
                        userPermission.BDLTool = flattenedUserInfo.BDLTool;
                        userPermission.AccessTypeBDL = flattenedUserInfo.AccessTypeBDL;
                        userPermission.PatientFlow = flattenedUserInfo.PatientFlow;
                        userPermission.AccessTypePF = flattenedUserInfo.AccessTypePF;
                        userPermission.AccessTypeGTforproject = flattenedUserInfo.AccessTypeGTforproject;
                        userPermission.AccessTypeBDLforproject = flattenedUserInfo.AccessTypeBDLforproject;
                        userPermission.AccessTypePFforproject = flattenedUserInfo.AccessTypePFforproject;


                        //userLoginDetails.userInfo = userInfo;
                        //userLoginDetails.userPermission = userPermission;
                    }
                    userLoginDetails.userInfo = userInfo;
                    userLoginDetails.userPermission = userPermission;
                }
            }

            catch (Exception ex)
            {

            }
            return userLoginDetails;
        }
        public bool CheckValidEmailAndGuid(string email, Guid guid)
        {
            var res = false;
            try
            {
                    var existingQueryable = masterContext.ResetPasswordRequestDetails
                        .Where(rprd => String.Compare(rprd.UserEmail, email, true) == 0)
                        .Future();
                    var existing = existingQueryable.FirstOrDefault();
                    //if (existing != null && String.Compare(existing.GUID.ToString(), guid.ToString()) == 0)
                    //    res = true;
                    if (existing != null)
                        res = true;                
            }
            catch (Exception ex)
            {
                res = false;
            }

            return res;

        }

        public int SendPasswordResetEmail(string toEmail, string hostUrl)
        {
            int result = 0;
            // MailMessage class is present is System.Net.Mail namespace
            MailMessage mailMessage = new MailMessage("pharmatestuser@gmail.com", toEmail);
            // StringBuilder class is present in System.Text namespace
            StringBuilder sbEmailBody = new StringBuilder();
            sbEmailBody.Append("Dear " + toEmail + ",<br/><br/>");
            sbEmailBody.Append("Please click on the following link to reset your password.<br/> This link will get expired in 15 minutes.");
            Guid messageId = Guid.NewGuid();
            sbEmailBody.Append("<br/>");
            sbEmailBody.Append(String.Format("{0}/ResetPassword/Index?uid={1}&email={2}", hostUrl, messageId.ToString(), toEmail));
            sbEmailBody.Append("<br/><br/>");
            sbEmailBody.Append("<b>"+ GenUtil.GetClientNameForSendingMail()+"</b>");

            if (AddLinkDetails(toEmail, messageId) == 1)
            {
             bool status= GenUtil.SendEmail("Reset Password", sbEmailBody.ToString(), toEmail);
                if (status)
                    result = 1;
                else
                    result = 0;
                }
            else
            {
                result = 0;
            }
            return result;

        }

        public int UpdateSubscriberDetails(int subscriberId, bool isActive, DateTime subscriptionStartDate, DateTime subscriptionEndDate, int maxUserNumber,
             string dbServer, string dbUser, string dbPassword, string feedKeyword, string sPAccount, string spPassword)
        {
            int res = 0;
            try
            {
                    SqlParameter SubscriberId = new SqlParameter("@SubscriberId", SqlDbType.Int);
                    SubscriberId.Direction = ParameterDirection.Input;
                    SubscriberId.Value = subscriberId;

                    SqlParameter IsActive = new SqlParameter("@IsActive", SqlDbType.Bit);
                    IsActive.Direction = ParameterDirection.Input;
                    IsActive.Value = isActive;

                    SqlParameter SubscriptionStartDate = new SqlParameter("@SubscriptionStartDate", SqlDbType.DateTime);
                    SubscriptionStartDate.Direction = ParameterDirection.Input;
                    SubscriptionStartDate.Value = subscriptionStartDate;

                    SqlParameter SubscriptionEndDate = new SqlParameter("@SubscriptionEndDate", SqlDbType.DateTime);
                    SubscriptionEndDate.Direction = ParameterDirection.Input;
                    SubscriptionEndDate.Value = subscriptionEndDate;

                    SqlParameter MaxUserNo = new SqlParameter("@MaxUserNo", SqlDbType.Int);
                    MaxUserNo.Direction = ParameterDirection.Input;
                    MaxUserNo.Value = maxUserNumber;

                    SqlParameter DBServer = new SqlParameter("@DBServer", SqlDbType.NVarChar,200);
                    DBServer.Direction = ParameterDirection.Input;
                    DBServer.Value = dbServer;

                    SqlParameter DBUser = new SqlParameter("@DBUser", SqlDbType.NVarChar, 200);
                    DBUser.Direction = ParameterDirection.Input;
                    DBUser.Value = dbUser;

                    SqlParameter DBPassword = new SqlParameter("@DBPassword", SqlDbType.NVarChar, 200);
                    DBPassword.Direction = ParameterDirection.Input;
                    DBPassword.Value = dbPassword;

                    SqlParameter FeedKeyword = new SqlParameter("@FeedKeyword", SqlDbType.VarChar, 200);
                    FeedKeyword.Direction = ParameterDirection.Input;
                    FeedKeyword.Value = feedKeyword;

                    SqlParameter SPPassword = new SqlParameter("@SPPassword", SqlDbType.NVarChar, 200);
                    SPPassword.Direction = ParameterDirection.Input;
                    SPPassword.Value = spPassword;

                    SqlParameter SPAccount = new SqlParameter("@SPAccount", SqlDbType.VarChar, 200);
                    SPAccount.Direction = ParameterDirection.Input;
                    SPAccount.Value = sPAccount;

                    string query = "exec dbo.uspModifySubscriberDetails @SubscriberId, @IsActive, @SubscriptionStartDate, @SubscriptionEndDate, @MaxUserNo, @DBServer, @DBUser, @DBPassword, @FeedKeyword,"
                    + "@SPPassword, @SPAccount";
                    res = masterContext.Database.SqlQuery<int>(query, SubscriberId, IsActive, SubscriptionStartDate, SubscriptionEndDate, MaxUserNo, DBServer, DBUser,
                        DBPassword, FeedKeyword, SPPassword, SPAccount).SingleOrDefault().SafeToNum();
            }
            catch(Exception ex)
            {
                res = 0;
            }

            return res;
        }


        public SubscriberListModel GetSubscriberList()
        {
            SubscriberListModel SubscriberList = new SubscriberListModel();
            

                try
                {
                    //SelectListItem listItem = new SelectListItem();

                    List<SelectListItem> items = new List<SelectListItem>();
                    items.Add(new SelectListItem() { Text = "---------Select---------", Value = "0", Selected = false });

                    var result = masterContext.SubscriberMaster.Where(x => x.IsActive == true).Select(x => new SelectListItem { Text = x.SubscriberName, Value = x.SubscriberId.ToString() }).ToList();

                    foreach (var value in result)
                    {
                        SelectListItem listItem = new SelectListItem();
                        listItem.Text = value.Text;
                        listItem.Value = value.Value;
                        items.Add(listItem);

                    }

                    SubscriberList.SubscriberList = items;
                }

                catch (Exception ex)
                {

                }
                return SubscriberList;
            
        }

        
        public List<UserInfo> GetAllUsersByTenant(int tenantId, ForecastModelType type)
        {
            List<UserInfo> users = new List<UserInfo>();
            UsersList UserName = new UsersList();
            try
            {            
                    users = masterContext.UserMaster.Where(x => x.CompanyId == tenantId && x.Id != -1 && x.UserEmail != null && x.RoleId != 3
                    && ((type == ForecastModelType.Generic && x.UserAccessForecastPlatform.Any(uafp => uafp.AccessTypeGTforproject != 1))
                    || (type == ForecastModelType.BDL && x.UserAccessForecastPlatform.Any(uafp => uafp.AccessTypeBDLforproject != 1))
                    || (type == ForecastModelType.Acthar && x.UserAccessForecastPlatform.Any(uafp => uafp.AccessTypePFforproject != 1))))
                    .Select(x => new UserInfo
                    {
                        UserId = x.Id,
                        FirstName = x.FirstName,
                        LastName = x.LastName,
                        Email = x.UserEmail,
                        label = x.FirstName,
                        value = x.FirstName,
                        FullName = x.FirstName + " " + x.LastName
                    }).OrderBy(s => s.FirstName)
                        //.Distinct(new UserInfoComparer())
                    .ToList();

                
            }
            catch (Exception ex)
                {
                throw ex;
                }
           
            return users;
        }      

        public AutocompleteList GetAllUsersByTenantForShare(int tenantId, ForecastModelType type)
        {
           // List<UserInfo> users = new List<UserInfo>();
            AutocompleteList users = new AutocompleteList();
            try
            {
                    var usersQueryable = masterContext.UserMaster.Where(x => x.CompanyId == tenantId && x.Id != -1 && x.UserEmail != null && x.RoleId != 3
                   && ((type == ForecastModelType.Generic && x.UserAccessForecastPlatform.Any(uafp => uafp.AccessTypeGTforproject != 1))
                   || (type == ForecastModelType.BDL && x.UserAccessForecastPlatform.Any(uafp => uafp.AccessTypeBDLforproject != 1))
                   || (type == ForecastModelType.Acthar && x.UserAccessForecastPlatform.Any(uafp => uafp.AccessTypePFforproject != 1))))
                         .Select(p => new UsersList { label = p.UserEmail, value = p.UserEmail }).Distinct().Future();

                    users.UsersList = usersQueryable.ToList();
                
            }
            catch (Exception ex)
                {
                    throw ex;
                }
            
            return users;
        }        
        
        public int OnForgotPassword(string email, string newPassword)
        {
            int res = 0;
            try
            {
                    SqlParameter userEmail = new SqlParameter("@UserEmail", SqlDbType.VarChar, 320);
                    userEmail.Direction = ParameterDirection.Input;
                    userEmail.Value = email;

                    SqlParameter password = new SqlParameter("@User_NewPassword", SqlDbType.NVarChar, 50);
                    password.Direction = ParameterDirection.Input;
                    password.Value = newPassword;
                    
                    res = masterContext.Database.SqlQuery<int>("exec dbo.uspUpdatePassword @UserEmail, @User_NewPassword", userEmail, password).SingleOrDefault().SafeToNum();
            }
            catch (Exception ex)
            {
                res = 0;
            }

            return res;
        }

        int AddLinkDetails(string email, Guid guid)
        {
            var res = 0;
            try
            {
                    var existingQueryable = masterContext.ResetPasswordRequestDetails
                        .Where(rprd => String.Compare(rprd.UserEmail, email, true) == 0)
                        .Future();
                    var isActiveQueryable = masterContext.UserMaster
                        .Where(um => String.Compare(um.UserEmail, email) == 0)
                        .Select(um => new { SubscriptionEnd = um.SubscriberMaster.SubscriptionEndDate })
                        .Future();

                    var existing = existingQueryable.FirstOrDefault();
                    if (existing != null && String.Compare(existing.GUID.ToString(), guid.ToString()) == 0)
                        existing.GUID = guid;
                    else
                    {
                        var isActivate = isActiveQueryable.FirstOrDefault();
                        if (isActivate == null)
                            res = 2; //user does not exist
                        else
                        {
                            if (isActivate.SubscriptionEnd < DateTime.Now)
                                res = 3; //subscription expired
                            else
                            {
                            masterContext.ResetPasswordRequestDetails.Add(new ResetPasswordRequestDetails
                            {
                                UserEmail = email,
                                GUID = guid,
                                ExpiryDate = DateTime.Now + TimeSpan.FromMinutes(15),
                                IsActive = true
                                });
                            }
                        }
                    }

                    if (masterContext.SaveChanges() == 1) //1 row should get affected
                        res = 1;
            }
            catch(Exception ex)
            {
                res = 0;
            }

            return res;
        }

        public string RegisterSubscriber(SubscriberRegistrationInfo model)
        {
            string result = "false";
            
            try
            {
                    SqlParameter tenant = new SqlParameter("@tenant", SqlDbType.VarChar, 100);
                    tenant.Direction = ParameterDirection.Input;
                    tenant.Value = model.SubscriberName;

                    SqlParameter isActive = new SqlParameter("@IsActive", SqlDbType.Bit);
                    isActive.Direction = ParameterDirection.Input;
                    isActive.Value = model.IsActive;

                    SqlParameter subscriptionStartDate = new SqlParameter("@SubscriptionStartDate", SqlDbType.DateTime);
                    subscriptionStartDate.Direction = ParameterDirection.Input;
                    subscriptionStartDate.Value = model.SubscriptionStartDate;

                    SqlParameter subscriptionEndDate = new SqlParameter("@SubscriptionEndDate", SqlDbType.DateTime);
                    subscriptionEndDate.Direction = ParameterDirection.Input;
                    subscriptionEndDate.Value = model.SubscriptionEndDate;

                    SqlParameter maxUserNumber = new SqlParameter("@MaxUserNumber", SqlDbType.Int);
                    maxUserNumber.Direction = ParameterDirection.Input;
                    maxUserNumber.Value = model.MaxUserNumber;

                    SqlParameter dataBaseName = new SqlParameter("@DataBaseName", SqlDbType.VarChar, 100);
                    dataBaseName.Direction = ParameterDirection.Input;
                    dataBaseName.Value = model.DatabaseName;

                    SqlParameter dbServer = new SqlParameter("@dbServer", SqlDbType.VarChar, 100);
                    dbServer.Direction = ParameterDirection.Input;
                    dbServer.Value = model.DbServer;

                    SqlParameter dbUser = new SqlParameter("@DbUser", SqlDbType.VarChar, 100);
                    dbUser.Direction = ParameterDirection.Input;
                    dbUser.Value = model.DbUser;

                    SqlParameter dbPassword = new SqlParameter("@DbPassword", SqlDbType.VarChar, 100);
                    dbPassword.Direction = ParameterDirection.Input;
                    dbPassword.Value = model.DbPassword;

                    SqlParameter feedKeyword = new SqlParameter("@FeedKeyword", SqlDbType.VarChar, 500);
                    feedKeyword.Direction = ParameterDirection.Input;
                    feedKeyword.Value = model.FeedKeyword;

                    SqlParameter spAccount = new SqlParameter("@SPAccount", SqlDbType.VarChar, 100);
                    spAccount.Direction = ParameterDirection.Input;
                    spAccount.Value = model.SPAccount;

                    SqlParameter spPassword = new SqlParameter("@SPPassword", SqlDbType.NVarChar, 100);
                    spPassword.Direction = ParameterDirection.Input;
                    spPassword.Value = model.SPPassword;

                    SqlParameter archive = new SqlParameter("@Archive", SqlDbType.VarChar, 100);
                    archive.Direction = ParameterDirection.Input;
                    archive.Value = model.Archive;

                result = masterContext.Database.SqlQuery<string>("exec dbo.uspAddNewTenant @tenant, @IsActive, @SubscriptionStartDate, @SubscriptionEndDate, @MaxUserNumber, @DataBaseName, @dbServer, @DbUser, @DbPassword, @FeedKeyword, @SPAccount, @SPPassword, @Archive", 
                    tenant, isActive, subscriptionStartDate, subscriptionEndDate, maxUserNumber, dataBaseName, dbServer, dbUser, dbPassword, feedKeyword, spAccount, spPassword, archive).SingleOrDefault().SafeNoTrim();
            }
            catch (Exception ex)
            {
               
            }

            return result;
        }

        public int UpdateNotificationStatus(int userId, List<int> notificationIds,int tenantId)
        {
            int res = 0;
            try
            {
                    List<UserNotifications> existingNotifications = new List<UserNotifications>();
                    List<TenantUserNotifications> existingNotificationsoftenant = new List<TenantUserNotifications>();                    
                        for (int i = 0; i < notificationIds.Count(); i++)
                        {
                            var notificationId = notificationIds[i];

                            existingNotifications = masterContext.UserNotifications.Where(un => un.UserId == userId && un.Id == notificationId && un.IsRead == false).ToList();
                            if (existingNotifications != null && existingNotifications.Count > 0)
                            {
                                foreach (var notification in existingNotifications)
                                {
                                    notification.IsRead = true;
                                }

                                masterContext.SaveChanges();
                                res = 1;
                            }
                            else
                            {
                                existingNotificationsoftenant = tenantContext.UserNotifications.Where(un => un.UserId == userId && un.Id == notificationId && un.IsRead == false).ToList();
                                if (existingNotificationsoftenant != null && existingNotificationsoftenant.Count > 0)
                                {
                                    foreach (var notification in existingNotificationsoftenant)
                                    {
                                        notification.IsRead = true;
                                    }
                                    tenantContext.SaveChanges();
                                    res = 1;
                                }
                            }
                        }
                    
            }
            catch (Exception ex)
            {
                res = 0;
            }

            return res;
        }

        public int CreateSubscriberDataBase(string Server, string DatabaseName, string DBUser, string DBPassword)
        {
            int result = 0;                        
            try
            {
                    var tenant = new SqlParameter("@tenant", SqlDbType.VarChar, 100);
                tenant.Direction = ParameterDirection.Input;
                tenant.Value = DatabaseName;

                result = masterContext.Database.ExecuteSqlCommand("exec uspAddNewTenant @tenant", tenant);

                result = 1;
            }
            catch (System.Exception ex)
            {

            }
            
            return result;
        }

        public List<Division> GetDivisionDetailsBySubscriberId(int subscriberId)
        {
            List<Division> divisionList = new List<Division>();
            try
            {
                    divisionList = masterContext.SubscriberMaster
                        .Where(sm => sm.SubscriberId == subscriberId)
                        .SelectMany(sm => sm.DivisionMaster)
                        .Select(dm => new Division
                        {
                            DivisionName = dm.DivisionName,
                            DivisionOrder = dm.DivisionOrder
                        })
                        .ToList();
                
            }
            catch (Exception ex)
            {

            }
            return divisionList;
        }
        
        public Dictionary<int, UserInfo> GetUserInfoByUserId(List<int> userIDs)
        {
            Dictionary<int, UserInfo> userInfoMap = new Dictionary<int, UserInfo>();
            try
            {
                
                    var userList = masterContext.UserMaster
                        .Where(um => userIDs.Contains(um.Id))
                        .Select(um => new UserInfo
                        {
                            UserId = um.Id,
                            FirstName = um.FirstName,
                            LastName = um.LastName,
                            Email = um.UserEmail,
                            IsAdmin = um.RoleId == 2
                        })
                        .ToList()
                        .Distinct();
                    userInfoMap = userList.ToDictionary(u => u.UserId, u => u);
                
            }
            catch (Exception ex)
            {

            }
            return userInfoMap;
        }

        public UserLoginDetails GetUserInformationByUserId(int userId)
        {
            UserLoginDetails userLoginDetails = new UserLoginDetails();
            try
            {
                    userLoginDetails = masterContext.UserMaster
                        .Where(um => um.Id == userId)
                        .ToList()
                        .Select(um => new UserLoginDetails
                        {
                            userInfo = new UserInfo
                            {
                                UserId = userId,
                                FirstName = um.FirstName,
                                LastName = um.LastName,
                                Email = um.UserEmail,
                                IsAdmin = um.RoleId == 2,
                                RoleId=um.RoleId
                            },
                            userPermission = new UserPermission
                            {
                                KnowledgeManagement = um.UserAccess.Select(ua => ua.KnowledgeManagement).FirstOrDefault(),
                                AccessTypeBDL = (byte)um.UserAccessForecastPlatform.Select(uafp => uafp.AccessTypeBDL).FirstOrDefault(),
                                AccessTypeBDLforproject = um.UserAccessForecastPlatform.Select(uafp => uafp.AccessTypeBDLforproject).FirstOrDefault(),
                                AccessTypeBI = (byte)um.UserAccess.Select(ua => ua.AccessTypeBI).FirstOrDefault(),
                                AccessTypeCF = (byte)um.UserAccess.Select(ua => ua.AccessTypeCF).FirstOrDefault(),
                                AccessTypeCP = (byte)um.UserAccess.Select(ua => ua.AccessTypeCP).FirstOrDefault(),
                                AccessTypeFP = (byte)um.UserAccess.Select(ua => ua.AccessTypeFP).FirstOrDefault(),
                                AccessTypeGT = (byte)um.UserAccessForecastPlatform.Select(ua => ua.AccessTypeGT).FirstOrDefault(),
                                AccessTypeGTforproject = um.UserAccessForecastPlatform.Select(ua => ua.AccessTypeGTforproject).FirstOrDefault(),
                                AccessTypeHD = (byte)um.UserAccess.Select(ua => ua.AccessTypeHD).FirstOrDefault(),
                                AccessTypeKM = (byte)um.UserAccess.Select(ua => ua.AccessTypeKM).FirstOrDefault(),
                                AccessTypePF = (byte)um.UserAccessForecastPlatform.Select(ua => ua.AccessTypePF).FirstOrDefault(),
                                AccessTypePFforproject = um.UserAccessForecastPlatform.Select(ua => ua.AccessTypePFforproject).FirstOrDefault(),
                                AccessTypeUT = (byte)um.UserAccess.Select(ua => ua.AccessTypeUT).FirstOrDefault(),
                                AccessTypeUW = (byte)um.UserAccess.Select(ua => ua.AccessTypeUW).FirstOrDefault(),
                                BDLTool = um.UserAccessForecastPlatform.Select(ua => ua.BDLTool).FirstOrDefault(),
                                BusinessIntelligence = um.UserAccess.Select(ua => ua.BusinessIntelligence).FirstOrDefault(),
                                CommunityOfPractice = um.UserAccess.Select(ua => ua.CommunityOfPractice).FirstOrDefault(),
                                CustomFeed = um.UserAccess.Select(ua => ua.CustomFeed).FirstOrDefault(),
                                ForecastPlatform = um.UserAccess.Select(ua => ua.ForecastPlatform).FirstOrDefault(),
                                GenericTool = um.UserAccessForecastPlatform.Select(ua => ua.GenericTool).FirstOrDefault(),
                                HelpDesk = um.UserAccess.Select(ua => ua.HelpDesk).FirstOrDefault(),
                                PatientFlow = um.UserAccessForecastPlatform.Select(ua => ua.PatientFlow).FirstOrDefault(),
                                UserWorkspace = um.UserAccess.Select(ua => ua.UserWorkspace).FirstOrDefault(),
                                Utilities = um.UserAccess.Select(ua => ua.Utilities).FirstOrDefault()
                            }
                        })
                        .FirstOrDefault();
                
            }
            catch (Exception ex)
            {

            }

            return userLoginDetails;
        }

        public UserInfo GetUserInformationByEmail(string Email)
        {
            
            UserInfo userInfo = new UserInfo();
            
                try
                {
                    userInfo = masterContext.UserMaster.Where(x => x.UserEmail == Email).
                   Select(x => new UserInfo
                   {
                       FirstName = x.FirstName.SafeTrim(),
                       LastName = x.LastName.SafeTrim(),
                       Email = x.UserEmail.SafeTrim()
                   }).Distinct().SingleOrDefault();

                }

                catch (Exception ex)
                {

                }

            
            return userInfo;
        }

        public void PopulateUserInfoFromUserId(UserInfo user, Dictionary<int, UserInfo> accessors)
        {
            if (accessors.ContainsKey(user.UserId))
            {
                user.FirstName = accessors[user.UserId].FirstName;
                user.LastName = accessors[user.UserId].LastName;
                user.Email = accessors[user.UserId].Email;
            }
        }
                
        public List<UserInfo> ViewUsersByCompanyId(List<int> companyIds)
        {

            List<UserInfo> usersList = new List<UserInfo>();
            
                try
                {
                    usersList = masterContext.UserMaster.Where(x => companyIds.Contains(x.CompanyId) && x.RoleId != 3).
                        Select(x => new UserInfo
                        {
                            UserId = x.Id,
                            FirstName = x.FirstName,
                            LastName = x.LastName,
                            Email = x.UserEmail,
                            IsActive = x.IsActive,
                            CompanyName = x.SubscriberMaster.SubscriberName
                            //IsAdmin = x.IsAdmin.HasValue ? x.IsAdmin.Value : false
                        }).ToList();
                }

                catch (Exception ex)
                {

                }

            
            return usersList;

        }
        
        //Send Email Notification for New Sign-ins
        public int SendNotificationEmail(string toEmail)
        {
            int result = 0;
            // MailMessage class is present is System.Net.Mail namespace
            MailMessage mailMessage = new MailMessage("pharmatestuser@gmail.com", toEmail);
            // StringBuilder class is present in System.Text namespace
            StringBuilder sbEmailBody = new StringBuilder();
            sbEmailBody.Append("Dear " + toEmail + ",<br/><br/>");
            sbEmailBody.Append("Your account was just used to sign in from another device.");
            //Guid messageId = Guid.NewGuid();
            //sbEmailBody.Append("<br/>");
            //sbEmailBody.Append(String.Format("{0}ResetPassword/Index?uid={1}&email={2}", GenUtil.HostUrl, messageId.ToString(), toEmail));
            sbEmailBody.Append("<br/><br/>");
            sbEmailBody.Append("<b>"+ GenUtil.GetClientNameForSendingMail()+"</b>");

            //if (AddLinkDetails(toEmail, messageId) == 1)
            //{
            GenUtil.SendEmail("New sign-in notification", sbEmailBody.ToString(), toEmail);
            result = 1;
            //}
            ////else
            ////{
            ////    result = 0;
            ////}
            return result;

        }

        public int CheckValidUser(string email)
        {
            int result=0;
            int companyid = 0;
            DateTime expireddate;
            try
            {
                   companyid = masterContext.UserMaster.Where(x => x.UserEmail == email && x.IsActive==true).
                   Select(x => x.CompanyId)
                  .Distinct()
                  .SingleOrDefault();
                    if(companyid !=0 )
                    {
                        expireddate = masterContext.SubscriberMaster.Where(x => x.SubscriberId == companyid).
                      Select(x =>
                         x.SubscriptionEndDate).FirstOrDefault();
                        if (DateTime.Now < expireddate)
                            result = 2;
                        else
                            result = 3;
                    }
                    else
                    result = 1;
                    //return context.UserMaster.Any(um => String.Compare(um.UserEmail, email, true) == 0 && um.IsActive);
                    return result;
                
             
            }
            catch (Exception ex)
            {
                return result;
            }
        }

        public bool CheckLinkValid(string email, Guid GUID)
        {
            try
            {
                    return masterContext.ResetPasswordRequestDetails.Any(rprd => String.Compare(rprd.UserEmail, email) == 0 && rprd.ExpiryDate >= DateTime.Now && rprd.IsActive==true);
                
            }
            catch (Exception ex)
            {
                return false;
            }
        }
                
        public NotificationCount GetNotifications(int tenantId, int userId)
        {

            List<Notification> userNotificationLists = new List<Notification>();
            List<Notification> userNotifications = new List<Notification>();
            NotificationCount userNotificationsForCount = new NotificationCount();
            UserInfo userInfo = new UserInfo();
            try
            {
                        var notificationListQueryable = masterContext.UserNotifications
                            .Where(un => un.UserId == userId && un.Descriptions != "")
                            .Select(un => new
                            {
                                createdDate = un.CreatedDate,
                                description = un.Descriptions,
                                isRead = un.IsRead,
                                notificationId = un.Id,
                                userId = un.UserId
                            }).Future();

                        var notificationListFromTenantQueryable = tenantContext.UserNotifications
                            .Where(un => un.UserId == userId && un.Descriptions != "")
                            .Select(un => new
                            {
                                createdDate = un.CreatedDate,
                                description = un.Descriptions,
                                isRead = un.IsRead,
                                notificationId = un.Id,
                                userId = un.UserId                           
                            }).Future();

                        userNotificationLists = notificationListQueryable.ToList().Union(notificationListFromTenantQueryable.ToList())
                          .Select(unp => new Notification
                           {
                               CreatedDate = unp.createdDate,
                               Description = unp.description,
                               IsRead = unp.isRead,
                               NotificationId = unp.notificationId,
                               UserId = unp.userId
                           }).ToList();
                       
                        userNotifications = userNotificationLists.OrderByDescending(u => u.CreatedDate).ToList();
                        userNotificationsForCount.Notifications = userNotifications;
                        userNotificationsForCount.Notificationcount = userNotifications.Where(u => u.IsRead != true && u.UserId == userId).ToList().Count();
                
            }
            catch (Exception ex)
            {        
                throw;
            }

            return userNotificationsForCount;
        }
            

        public int DeleteUserById(int userId)
        {
            int result = 0;
            
                try
                {
                    var userMasterId = masterContext.UserMaster.Where(um => um.Id == userId).Select(um => new
                    {
                        UserId = um.Id,
                    }).SingleOrDefault();

                    if (userMasterId != null)
                    {
                        var divisionUserMappingQueryable = masterContext.DivisionUserMapping.Where(dum => dum.UserId == userId).Future();
                        var forumQuestionQueryable = masterContext.ForumQuestion.Where(fq => fq.UserId == userId).Future();
                        var forumAnswerQueryable = masterContext.ForumAnswer.Where(fa => fa.UserId == userId).Future();
                        var userAccessQueryable = masterContext.UserAccess.Where(ua => ua.UserID == userId).Future();
                        var userAccessForecastPlatformQueryable = masterContext.UserAccessForecastPlatform.Where(uafp => uafp.UserID == userId).Future();
                        var userMasterQueryable = masterContext.UserMaster.Where(um => um.Id == userId).Future();

                        var divisionUserMappings = divisionUserMappingQueryable.ToList();
                        if (divisionUserMappings != null && divisionUserMappings.Count > 0)
                        masterContext.DivisionUserMapping.RemoveRange(divisionUserMappings);

                        //Questions and Answers can stay even if their creators left!
                        var forumQuestionList = forumQuestionQueryable.ToList();
                        if (forumQuestionList != null && forumQuestionList.Count > 0)
                            forumQuestionList.ForEach(fq => fq.UserId = null);

                        var forumAnswerList = forumAnswerQueryable.ToList();
                        if (forumAnswerList != null && forumAnswerList.Count > 0)
                            forumAnswerList.ForEach(fa => fa.UserId = null);

                        var userAccessList = userAccessQueryable.ToList();
                        if (userAccessList != null && userAccessList.Count > 0)
                        masterContext.UserAccess.RemoveRange(userAccessList);

                        var userAccessForecastPlatformList = userAccessForecastPlatformQueryable.ToList();
                        if (userAccessForecastPlatformList != null && userAccessForecastPlatformList.Count > 0)
                        masterContext.UserAccessForecastPlatform.RemoveRange(userAccessForecastPlatformList);

                        var userMasterList = userMasterQueryable.ToList();
                        if (userMasterList != null && userMasterList.Count > 0)
                        masterContext.UserMaster.RemoveRange(userMasterList);

                    //TO DO: also remove/update tenant dependencies for the user

                    masterContext.SaveChanges();
                        result = 1;
                    }
                    else
                    {
                        result = 2;
                    }
                }

                catch (Exception ex)
                {
                    result = 0;
                }
            

            return result;
        }

        public List<SubscriberRegistrationInfo> GetSubscriberDetailsList()
        {
            
            List<SubscriberRegistrationInfo> subscribersList = new List<SubscriberRegistrationInfo>();
            
                try
                {
                    subscribersList = masterContext.SubscriberMaster.Select(value => new SubscriberRegistrationInfo
                    {
                        Id = value.SubscriberId,
                        SubscriberName = value.SubscriberName,
                        SubscriptionStartDate = value.SubscriptionStartDate,
                        SubscriptionEndDate = value.SubscriptionEndDate,
                        IsActive = value.IsActive,
                        MaxUserNumber = value.MaxUserNo,
                        DatabaseName = value.DataBaseName,
                        DbServer = value.DBServer,
                        DbUser = value.DBUser,
                        DbPassword = value.DBPassword,
                        FeedKeyword = value.FeedKeyword,
                        SPAccount = value.SPAccount,
                        SPPassword = value.SPPassword,
                        Archive = value.Archive
                    }).ToList();
                }

                catch (Exception ex)
                {

                }
            
            return subscribersList;
        }

        public bool SaveNewsFeedLink(string email, string newsLink, int count)
        {
            bool res = false;
            try
            {
                    var user = masterContext.UserMaster.Where(um => String.Compare(um.UserEmail, email, true) == 0).FirstOrDefault();
                    if (user != null)
                    {
                        if (String.Compare(user.NewsFeedLink, newsLink, true) != 0)
                            user.NewsFeedLink = newsLink;
                        if (user.NewsFeedCount != count)
                            user.NewsFeedCount = count;

                        if (masterContext.SaveChanges() == 1)
                            res = true;
                    }
                
            }
            catch (Exception ex)
            {
                res = false;
            }

            return res;
        }

        public NewsFeed GetNewsFeedParams(int userId)
        {
            try
            {
                var RegulatoryKeywords = masterContext.DivisionRegulatoryMaster
                                        .Where(drm => drm.IsDefaultRegulatory || drm.DivisionUserMapping.Any(dum => dum.UserId == userId))
                                        .Select(drm => drm.RegulatoryName)
                                       .ToList();
                string RegulatoryKeyword = string.Join(",", RegulatoryKeywords);
                return masterContext.UserMaster
                        .Where(um => um.Id == userId)
                        .Select(um => new NewsFeed
                        {
                            NewsFeedLink = um.NewsFeedLink,
                            RegulatoryKeyword = RegulatoryKeyword,
                            FeedCount = um.NewsFeedCount ?? 50
                        }) //replace 50 with const
                                .First();

            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public int UpdateUserProfileByUserId(int id, int status, int roleId, UserPermission permission)
        {

            int result = 0;
            try
            {
                    var userMaster = masterContext.UserMaster.Where(um => um.Id == id).SingleOrDefault();
                    if (userMaster != null)
                    {
                        userMaster.IsActive = status.SafeToBool();
                        userMaster.RoleId = roleId;
                    }

                    var userAccess = masterContext.UserAccess.Where(ua => ua.UserID == id).SingleOrDefault();
                    if (userAccess != null)
                    {
                        userAccess.KnowledgeManagement = permission.KnowledgeManagement;
                        userAccess.AccessTypeKM = permission.AccessTypeKM;
                        userAccess.BusinessIntelligence = permission.BusinessIntelligence;
                        userAccess.AccessTypeBI = permission.AccessTypeBI;
                        userAccess.Utilities = permission.Utilities;
                        userAccess.AccessTypeUT = permission.AccessTypeUT;
                        userAccess.CustomFeed = permission.CustomFeed;
                        userAccess.AccessTypeCF = permission.AccessTypeCF;
                        userAccess.CommunityOfPractice = permission.CommunityOfPractice;
                        userAccess.AccessTypeCP = permission.AccessTypeCP;
                        userAccess.UserWorkspace = permission.UserWorkspace;
                        userAccess.AccessTypeUW = permission.AccessTypeUW;
                        userAccess.HelpDesk = permission.HelpDesk;
                        userAccess.AccessTypeHD = permission.AccessTypeHD;
                        userAccess.ForecastPlatform = permission.ForecastPlatform;
                        userAccess.AccessTypeFP = permission.AccessTypeFP;

                    }


                    var userAccessForecastPlatform = masterContext.UserAccessForecastPlatform.Where(uafp => uafp.UserID == id).SingleOrDefault();
                    if (userAccessForecastPlatform != null)
                    {
                        userAccessForecastPlatform.GenericTool = permission.GenericTool;
                        userAccessForecastPlatform.AccessTypeGT = permission.AccessTypeGT;
                        userAccessForecastPlatform.BDLTool = permission.BDLTool;
                        userAccessForecastPlatform.AccessTypeBDL = permission.AccessTypeBDL;
                        userAccessForecastPlatform.PatientFlow = permission.PatientFlow;
                        userAccessForecastPlatform.AccessTypePF = permission.AccessTypePF;
                        userAccessForecastPlatform.AccessTypeGTforproject = permission.AccessTypeGTforproject;
                        userAccessForecastPlatform.AccessTypeBDLforproject = permission.AccessTypeBDLforproject;
                        userAccessForecastPlatform.AccessTypePFforproject = permission.AccessTypePFforproject;

                    }

                masterContext.SaveChanges();
                    result = 1;
                

            }

            catch (Exception ex)
            {
                result = 0;
            }

            return result;

        }


        public int DeleteSubscriberByName(string subscriberName)
        {
            var retval = 0;
            try
            {
                        var tenant = masterContext.SubscriberMaster
                            .Include(sm => sm.UserMaster)                            
                            .Include(sm => sm.UserMaster.SelectMany(um => um.UserAccess).SingleOrDefault())
                            .Include(sm => sm.UserMaster.SelectMany(um => um.UserAccessForecastPlatform).SingleOrDefault())
                            .Include(sm => sm.DivisionMaster)
                            .Include(sm => sm.UserMaster.SelectMany(um => um.DivisionUserMapping))
                            .Include(sm => sm.DivisionMaster.Select(dm => dm.DivisionRegulatoryMaster))
                            .Include(sm => sm.DivisionMaster.Select(dm => dm.DivisionCompanyMaster))
                            //let the tenant's community contributions exist even if the tenant itself is not there
                            //.Include(sm => sm.UserMaster.Select(um => um.ForumQuestion))
                            //.Include(sm => sm.UserMaster.Select(um => um.ForumAnswer))
                            //.Include(sm => sm.UserMaster.Select(um => um.ForumQuestion.Select(fq => fq.ForumAttachment)))
                            //.Include(sm => sm.UserMaster.Select(um => um.ForumAnswer.Select(fa => fa.ForumAttachment)))
                            .Where(sm => String.Compare(sm.SubscriberName, subscriberName) == 0)
                            .SingleOrDefault();
                        if (tenant != null)
                        {
                                    if (!tenantContext.Database.Delete())
                                        retval = 3; //could not drop tenant databse

                            masterContext.DivisionUserMapping.RemoveRange(tenant.UserMaster.SelectMany(um => um.DivisionUserMapping.ToList()));
                                    var userAccess = tenant.UserMaster.SelectMany(um => um.UserAccess).SingleOrDefault();
                                    if(userAccess != null)
                                masterContext.UserAccess.Remove(userAccess);
                                    var userAccessFP = tenant.UserMaster.SelectMany(um => um.UserAccessForecastPlatform).SingleOrDefault();
                                    if (userAccess != null)
                                masterContext.UserAccessForecastPlatform.Remove(userAccessFP);
                            masterContext.DivisionCompanyMaster.RemoveRange(tenant.DivisionMaster.SelectMany(dm => dm.DivisionCompanyMaster));
                            masterContext.DivisionRegulatoryMaster.RemoveRange(tenant.DivisionMaster.SelectMany(dm => dm.DivisionRegulatoryMaster));
                            masterContext.DivisionMaster.RemoveRange(tenant.DivisionMaster);
                            masterContext.UserMaster.RemoveRange(tenant.UserMaster);
                            masterContext.SubscriberMaster.Remove(tenant);

                            masterContext.SaveChanges();
                                    
                                    retval = 1;
                                
                        
                            
                        }
                        else
                            retval = 2; //tenant does not exist                    
                
            }
            catch (Exception ex)
            {
                retval = 0;
            }

            return retval;
        }

        public int UpdatePassword(string email, string password, string new_password)
        {
            int res = 0;
            try
            {
                using (var conn = new SqlConnection(GenUtil.MasterModelConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("[dbo].[uspResetPassword]", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter emailParam = cmd.Parameters.Add("@UserEmail", SqlDbType.NVarChar, 100);
                    emailParam.Direction = ParameterDirection.Input;
                    emailParam.Value = email;

                    SqlParameter oldPwdParam = cmd.Parameters.Add("@User_OldPassword", SqlDbType.NVarChar, 50);
                    oldPwdParam.Direction = ParameterDirection.Input;
                    oldPwdParam.Value = password;

                    SqlParameter newPwdParam = cmd.Parameters.Add("@User_NewPassword", SqlDbType.NVarChar, 50);
                    newPwdParam.Direction = ParameterDirection.Input;
                    newPwdParam.Value = new_password;

                    SqlDataAdapter adp = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    adp.Fill(ds);

                    if(ds.HasData())
                        res = ds.Tables[0].Rows[0][0].SafeToNum();                    
                }
            }
            catch (Exception ex)
            {
                res = 0;
            }

            return res;
        }

        public int UpdateUserProfile(string firstname, string lastname, string email)
        {
            try
            {
                    var user = masterContext.UserMaster.Where(um => String.Compare(um.UserEmail, email, true) == 0).SingleOrDefault();
                    if (user != null)
                    {
                        if ((String.Compare(user.FirstName, firstname, true) == 0) && (String.Compare(user.LastName, lastname, true) == 0))
                            return 0;
                        if (String.Compare(user.FirstName, firstname, true) != 0)
                            user.FirstName = firstname;
                        if (String.Compare(user.LastName, lastname, true) != 0)
                            user.LastName = lastname;
                    masterContext.SaveChanges();
                        return 1;
                    }
                    else
                        return 2; //user does not exist
                
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public void SaveNotificationKey(int userId, string msg, string messageId, int tenantId)
        {
            try
            {
                    TenantUserNotifications notification = new TenantUserNotifications
                    {
                        UserId = userId,
                        CreatedDate = DateTime.Now,
                        Descriptions = msg,
                        IsRead = false,
                        UserKey = messageId
                    };
                tenantContext.UserNotifications.Add(notification);
                tenantContext.SaveChanges();
                
            }
            catch (Exception ex)
            {

            }
        }
        public int SaveIndicationReference(string indicationName, int sectionId, string reference)
        {
            int result = 0;
            try
            {
                var Reference = tenantContext.BDLIndicationReference.Where(o => String.Compare(o.IndicationName, indicationName, true) == 0 && o.SectionId == sectionId).FirstOrDefault();
                if (Reference != null)
                {
                    Reference.Reference = reference;
                    tenantContext.SaveChanges();
                    result = 1;
                }
                else
                {
                    var IndicationReference = new BDLIndicationReference();
                    IndicationReference.IndicationName = indicationName;
                    IndicationReference.SectionId = sectionId;
                    IndicationReference.Reference = reference;
                    
                    tenantContext.BDLIndicationReference.Add(IndicationReference);
                    tenantContext.SaveChanges();
                    result = 2;
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return result;
        }
        public string  FetchIndicationReference(string indicationName, int sectionId)
        {
            string Refer = string.Empty;
            try
            {
           var Reference = tenantContext.BDLIndicationReference.Where(o => String.Compare(o.IndicationName, indicationName, true) == 0 && o.SectionId == sectionId).FirstOrDefault();
            Refer =Reference.Reference;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return Refer;
        }
        public List<string> GetAllIndicationName()
        {
            List<string> IndicationReference = new List<string>();
            try
            {
           IndicationReference = tenantContext.BDLIndicationReference.Select(o=>o.IndicationName).Distinct().ToList();
            
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return IndicationReference;
        }
        public List<SectionData> GetAllSectionName()
        {
            List<SectionData> SectionList = new List<SectionData>();
            try
            {
                var Sections = tenantContext.BDLSectionMaster.Where(sm => sm.Id != 3 && sm.Id != 10 && sm.Id != 12 && sm.Id != 17)
                                   .Select(bdl => new
                                   {
                                       SectionId = bdl.Id,
                                       SectionName = bdl.SectionName
                                   }).ToList();

                foreach (var item in Sections)
                {
                    SectionData sd = new SectionData()
                    {
                        SectionName = item.SectionName,
                        Id = item.SectionId
                    };
                    SectionList.Add(sd);
                }
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return SectionList;
        }
    }
}

class UserDetails
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string UserEmail { get; set; }
    public int CompanyId { get; set; }
    public int RoleId { get; set; }
    public int Id { get; set; }
    public string SubscriberName { get; set; }
    public string FeedKeyword { get; set; }
    public string Archive { get; set; }
    public string SPAccount { get; set; }
    public string SPPassword { get; set; }
    public int LoginResult { get; set; }
    public int KnowledgeManagement { get; set; }
    public int AccessTypeKM { get; set; }
    public int BusinessIntelligence { get; set; }
    public int AccessTypeBI { get; set; }
    public int Utilities { get; set; }
    public int AccessTypeUT { get; set; }
    public int CustomFeed { get; set; }
    public int AccessTypeCF { get; set; }
    public int CommunityOfPractice { get; set; }
    public int AccessTypeCP { get; set; }
    public int UserWorkspace { get; set; }
    public int AccessTypeUW { get; set; }
    public int HelpDesk { get; set; }
    public int AccessTypeHD { get; set; }
    public int ForecastPlatform { get; set; }
    public int AccessTypeFP { get; set; }
    public int GenericTool { get; set; }
    public int AccessTypeGT { get; set; }
    public int BDLTool { get; set; }
    public int AccessTypeBDL { get; set; }
    public int PatientFlow { get; set; }
    public int AccessTypePF { get; set; }
    public int AccessTypeGTforproject { get; set; }
    public int AccessTypeBDLforproject { get; set; }
    public int AccessTypePFforproject { get; set; }
}