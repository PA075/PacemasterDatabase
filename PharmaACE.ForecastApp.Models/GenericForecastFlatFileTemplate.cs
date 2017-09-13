using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class GenericForecastFlatFileTemplate
    {
        public string Path { get; set; }
        public int TemplateId { get; set; }
        public int MajorVersion { get; set; }
        public DateTime Datetime { get; set; }
    }
}
