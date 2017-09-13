using System;

namespace PharmaACE.ForecastApp.Models
{
    public class SignUp
    {
        public string FirstName
        { get; set; }

        public string LastName
        { get; set; }

        public string Email
        { get; set; }

        public string Password
        { get; set; }

        public string SP_Email
        { get; set; }

        public string SP_Password
        { get; set; }

        public int IsActive
        { get; set; }

        public DateTime SubscriptionStartDate
        { get; set; }

        public DateTime SubscriptionEndDate
        { get; set; }

        public string Role
        { get; set; }

        public int RoleId
        { get; set; }

        public string Geography
        { get; set; }

        public int isadmin
        { get; set; }

        public int SubscriberId
        { get; set; }

        public int CompanyId //Remove it 
        { get; set; }
    }
}
