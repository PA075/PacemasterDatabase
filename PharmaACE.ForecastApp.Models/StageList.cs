using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace PharmaACE.ForecastApp.Models
{
  public  class StageList
    {
        public int ID{ get; set; }
        public string Name{ get; set; }



        //public  StageList()
        //{
        //    Stage = new List<SelectListItem>();

        //}

        //public List<SelectListItem> Stage
        //{
        //    get;
        //    set;
        //}
    }
}
