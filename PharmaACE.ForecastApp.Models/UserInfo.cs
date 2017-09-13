using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class UserInfo
    {
        public int UserId
        { get; set; }

        [Display(Name = "First Name")]
        public string FirstName
        { get; set; }

        [Display(Name = "Last Name")]
        public string LastName
        { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd MM yyyy}")]
        public DateTime SubscriptionStartDate
        { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd MM yyyy}")]
        public DateTime SubscriptionEndDate
        { get; set; }

        [Display(Name = "Email")]
        public string Email
        { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd MM yyyy}")]
        public DateTime loginDate
        { get; set; }

        public int CompanyId
        { get; set; }

        public int LoginResult
        { get; set; }

        public int RoleId
        { get; set; }

        public Boolean IsAdmin
        { get; set; }

        public Boolean IsActive
        { get; set; }

        public string UserGroup
        { get; set; }

        public string Archive
        { get; set; }

        public string SubscriberName
        { get; set; }


        public string FeedKeyword
        { get; set; }
        //public string IsSuperAdmin
        //{ get; set; }

        //public string SPAccount
        //{ get; set; }

        //public string SPPassword
        //{ get; set; }

        public string RegulatoryFeedKeyword
        { get; set; }

        [Display(Name = "Subscriber")]
        public string CompanyName
        { get; set; }

        public int DeviceKeyStatus
        { get; set; }

        public string label { get; set; }

        public string value { get; set; }

        public string FullName { get; set; }
    }

    public class UserInfoComparer : IEqualityComparer<UserInfo>
    {
        public bool Equals(UserInfo x, UserInfo y)
        {
            return x.UserId == y.UserId;
        }

        public int GetHashCode(UserInfo obj)
        {
            return obj.UserId;
        }
    }

    public class UserPermission
    {
        public bool KnowledgeManagement { get; set; }
        public short AccessTypeKM { get; set; }
        public bool BusinessIntelligence { get; set; }
        public short AccessTypeBI { get; set; }
        public bool Utilities { get; set; }
        public short AccessTypeUT { get; set; }
        public bool CustomFeed { get; set; }
        public short AccessTypeCF { get; set; }
        public bool CommunityOfPractice { get; set; }
        public short AccessTypeCP { get; set; }
        public bool UserWorkspace { get; set; }
        public short AccessTypeUW { get; set; }
        public bool HelpDesk { get; set; }
        public short AccessTypeHD { get; set; }
        public bool ForecastPlatform { get; set; }
        public short AccessTypeFP { get; set; }
        public bool GenericTool { get; set; }
        public short AccessTypeGT { get; set; }
        public byte AccessTypeGTforproject { get; set; }
        public bool BDLTool { get; set; }
        public short AccessTypeBDL { get; set; }
        public byte AccessTypeBDLforproject { get; set; }
        public bool PatientFlow { get; set; }
        public short AccessTypePF { get; set; }
        public byte AccessTypePFforproject { get; set; }
    }

    public class UserLoginDetails
    {
        public UserInfo userInfo { get; set; }
        public UserPermission userPermission { get; set; }
        public LoginStatus Status { get; set; }
    }

    public class FlattenedUserInfo
    {
        public int Id
        { get; set; }
        
        public string FirstName
        { get; set; }

        public string LastName
        { get; set; }
        
        public string UserEmail
        { get; set; }
        
        public int CompanyId
        { get; set; }

        public int LoginResult
        { get; set; }

        public int KeyResult
        { get; set; }

        public int RoleId
        { get; set; }
        
        public string Archive
        { get; set; }

        public string SubscriberName
        { get; set; }
        
        public string FeedKeyword
        { get; set; }

        public bool KnowledgeManagement { get; set; }

        public short AccessTypeKM { get; set; }

        public bool BusinessIntelligence { get; set; }

        public short AccessTypeBI { get; set; }

        public bool Utilities { get; set; }

        public short AccessTypeUT { get; set; }

        public bool CustomFeed { get; set; }

        public short AccessTypeCF { get; set; }

        public bool CommunityOfPractice { get; set; }

        public short AccessTypeCP { get; set; }

        public bool UserWorkspace { get; set; }

        public short AccessTypeUW { get; set; }

        public bool HelpDesk { get; set; }

        public short AccessTypeHD { get; set; }

        public bool ForecastPlatform { get; set; }

        public short AccessTypeFP { get; set; }

        public bool GenericTool { get; set; }

        public short AccessTypeGT { get; set; }

        public bool BDLTool { get; set; }

        public short AccessTypeBDL { get; set; }

        public bool PatientFlow { get; set; }

        public short AccessTypePF { get; set; }

        public byte AccessTypeGTforproject { get; set; }

        public byte AccessTypeBDLforproject { get; set; }

        public byte AccessTypePFforproject { get; set; }
    }
}


