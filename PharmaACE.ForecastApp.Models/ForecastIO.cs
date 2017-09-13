using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastIO
    {
        public ForecastIO()
        {
            HistoricalData = new List<HistoricalTransaction>();
            ForecastData = new List<ForecastTransaction>();
            EventSections = new List<ForecastEventSection>();
            PackData = new List<PackTransaction>();
        }

        //public ForecastProduct Product { get; set; }
        //public ForecastSKU SKU { get; set; }
        //public ForecastScenario Scenario { get; set; }
        public List<ForecastCompetitor> Competitors { get; set; }
        public List<ForecastPack> Packs { get; set; }
        public List<HistoricalTransaction> HistoricalData { get; set; }
        public List<ForecastTransaction> ForecastData { get; set; }
        public List<ForecastEventSection> EventSections { get; set; }
        public ProductPenetration Penetration { get; set; }
        public List<PackTransaction> PackData { get; set; }
    }

    public class ForecastVersionInputOutput
    {
        public ForecastVersionDetail fv { get; set; }
        public ForecastIO fio { get; set; }
    }
}
