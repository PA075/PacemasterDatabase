using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class Assumption
    {
        public string Project { get; set; }
        public string Version { get; set; }
        public int Product { get; set; } //TO DO: change the name so that it reflects product OR country as applicable
        public int SKU { get; set; } //only meaningful for generics
        public int Scenario { get; set; }
        public int Section { get; set; }
        public string Description { get; set; }
        public int Indication { get; set; }
        public List<Attachment> Attachments { get; set; }
    }
}