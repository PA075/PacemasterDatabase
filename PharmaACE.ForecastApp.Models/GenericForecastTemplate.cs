using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
   public class GenericForecastTemplate
    {
        public int id { get; set; }
        public string ProjectName { get; set; }
        public string TemplatePath { get; set; }
        public DateTime Datetime { get; set; }
    }
}
