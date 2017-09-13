using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class DiseaseIndicationMapper
    {
        public int DiseaseAreaId { get; set; }
        public string DiseaseName { get; set; }
        public List<string> Indications { get; set; }
    }
}


     //public DiseaseIndicationCollection()
     //{
     //    Dictionary<string, string> DiseaseIndicationsCollection = new Dictionary<string, string>();
     //}
     //public string Disease {get; set;}
     //public string Indication {get; set;}