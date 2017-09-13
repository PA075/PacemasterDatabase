using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class BDLForecastIO
    {
        public BDLForecastIO()
        {
            HistoricalData = new List<BDLTransaction>();
            ForecastData = new List<BDLTransaction>();
            EPIData = new List<EPIDataTransaction>();
            Events = new List<ForecastSegmentEvent>();
            Shares = new List<ForecastSegmentEvent>();
            AdvancedPricing = new List<ForecastSegmentPricing>();
            Sources = new List<ForecastSegmentSource>();
        }
        
        public List<BDLTransaction> HistoricalData { get; set; }
        public List<BDLTransaction> ForecastData { get; set; }
        public List<EPIDataTransaction> EPIData { get; set; }
        public List<ForecastSegmentEvent> Events { get; set; }
        public List<ForecastSegmentEvent> Shares { get; set; }
        public List<ForecastSegmentPricing> AdvancedPricing { get; set; }
        public List<ForecastSegmentSource> Sources { get; set; }
    }

    public class BDLForecastVersionInputOutput
    {
        public ForecastVersionDetail fv { get; set; }
        public BDLForecastIO fio { get; set; }
    }

}
