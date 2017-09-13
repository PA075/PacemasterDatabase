using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class SecondaryIndication
    {
        public string secondaryIndicationName { get; set; }
        public int secondaryIndicationId { get; set; }

        public string primaryIndicationName { get; set; }

        public int diseaseAreaId { get; set; }
    }

}
