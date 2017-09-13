using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class SectionData
    {
        public int Id { get; set; }
        public string SectionName { get; set; }

        public int? Parent { get; set; }

        public bool? HasAssumptions { get; set; }
        
    }
}
