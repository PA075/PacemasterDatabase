using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastEventSection
    {
        public ForecastEventSection()
        {
            Events = new List<ForecastEvent>();
        }

        //public ForecastSection Section { get; set; }
        public int Section { get; set; }
        public List<ForecastEvent> Events { get; set; }
    }
}