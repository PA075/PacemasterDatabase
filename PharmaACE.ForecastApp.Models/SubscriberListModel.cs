using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace PharmaACE.ForecastApp.Models
{
    public class SubscriberListModel
    {
        public SubscriberListModel()
        {
            SubscriberList = new List<SelectListItem>();
        }

        [Display(Name = "Subscriber")]
        public List<SelectListItem> SubscriberList
        {
            get;
            set;
        }

    }
}
