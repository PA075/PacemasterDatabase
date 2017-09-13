using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastSegmentLevel
    {
        public string Name { get; set; }
        public int Order { get; set; }
        public List<ForecastSegment> Segments { get; set; }
    }

    public class ForecastSegment
    {
        public string Name { get; set; }
        public int Order { get; set; }
    }
}
