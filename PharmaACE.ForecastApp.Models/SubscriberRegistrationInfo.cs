using System;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class SubscriberRegistrationInfo
    {
        [Display(Name = "Subscriber Id")]
        public int Id
        { get; set; }


        [Display(Name = "Subscriber Name")]
        public string SubscriberName
        { get; set; }

        [Display(Name = "Is Active")]
        public bool IsActive
        { get; set; }

        [Display(Name = "Subscription Start Date")]
        public DateTime SubscriptionStartDate
        { get; set; }

        [Display(Name = "Subscription End Date")]
        public DateTime SubscriptionEndDate
        { get; set; }

        [Display(Name = "Max User Number")]
        public int MaxUserNumber
        { get; set; }

        [Display(Name = "Database Name")]
        public string DatabaseName
        { get; set; }

        [Display(Name = "Db Server")]
        public string DbServer
        { get; set; }

        [Display(Name = "Db User")]
        public string DbUser
        { get; set; }

        [Display(Name = "Db Password")]
        public string DbPassword
        { get; set; }

        [Display(Name = "SP Account")]
        public string SPAccount
        { get; set; }

        [Display(Name = "SP Password")]
        public string SPPassword
        { get; set; }

        [Display(Name = "Archive")]
        public string Archive
        { get; set; }

        [Display(Name = "Feed Keyword")]
        public string FeedKeyword
        { get; set; }

        [Display(Name = "Admin Id")]
        public string AdminId { get; set; }
    }
}