using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
namespace PharmaACE.ForecastApp.Models
{

    public class DiseaseListModel
    {
        public DiseaseListModel()
        {
           DiseaseList = new List<SelectListItem>();
        }

        [Display(Name = "Disease")]
        public List<SelectListItem> DiseaseList
        {
            get;
            set;
        }
    }
}