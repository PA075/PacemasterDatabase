using System;
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

    }

    public class UserPermission
    {
        public bool KnowledgeManagement { get; set; }
        public byte AccessTypeKM { get; set; }
        public bool BusinessIntelligence { get; set; }
        public byte AccessTypeBI { get; set; }
        public bool Utilities { get; set; }
        public byte AccessTypeUT { get; set; }
        public bool CustomFeed { get; set; }
        public byte AccessTypeCF { get; set; }
        public bool CommunityOfPractice { get; set; }
        public byte AccessTypeCP { get; set; }
        public bool UserWorkspace { get; set; }
        public byte AccessTypeUW { get; set; }
        public bool HelpDesk { get; set; }
        public byte AccessTypeHD { get; set; }
        public bool ForecastPlatform { get; set; }
        public byte AccessTypeFP { get; set; }
        public bool GenericTool { get; set; }
        public byte AccessTypeGT { get; set; }
        public byte AccessTypeGTforproject { get; set; }
        public bool BDLTool { get; set; }
        public byte AccessTypeBDL { get; set; }
        public byte AccessTypeBDLforproject { get; set; }
        public bool PatientFlow { get; set; }
        public byte AccessTypePF { get; set; }
        public byte AccessTypePFforproject { get; set; }
    }

    public class UserLoginDetails
    {
        public UserInfo userInfo { get; set; }
        public UserPermission userPermission { get; set; }

    }
}


