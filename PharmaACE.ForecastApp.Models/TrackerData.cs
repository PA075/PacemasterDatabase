using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
   public class TrackerData
    {
        public int screenProfileCounts { get; set; }
       public int DilligenceCounts { get; set; }
        public int NegotiationCounts { get; set; }
        public int onHoldWithdrwalCounts { get; set; }

        public string screenProfileCounts_Price { get; set; }
        public string Dilligence_Price { get; set; }
        public string Negotiation_Price { get; set; }
        public string onHoldWithdrwal_Price { get; set; }
        public string Total_Price { get; set; }

        public List<ActivityListData> TrackerDataList { get; set; }
    }
}
