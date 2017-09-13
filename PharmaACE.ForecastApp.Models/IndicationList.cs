using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
namespace PharmaACE.ForecastApp.Models
{
    public class IndicationListModel
    {
        public IndicationListModel()
        {
            IndicationList = new List<SelectListItem>();
        }

        [Display(Name = "Indication")]
        public List<SelectListItem> IndicationList
        {
            get;
            set;
        }
    }
}
