using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class GenericForecastIO
    {
        public GenericForecastIO()
        {
            HistoricalData = new List<GenericHistoricalTransaction>();
            ForecastData = new List<GenericForecastTransaction>();
            EventSections = new List<ForecastEventSection>();
            PackData = new List<GenericPackTransaction>();
        }

        //public ForecastProduct Product { get; set; }
        //public ForecastSKU SKU { get; set; }
        //public ForecastScenario Scenario { get; set; }
        public List<ForecastCompetitor> Competitors { get; set; }
        public List<ForecastPack> Packs { get; set; }
        public List<GenericHistoricalTransaction> HistoricalData { get; set; }
        public List<GenericForecastTransaction> ForecastData { get; set; }
        public List<ForecastEventSection> EventSections { get; set; }
        public ProductPenetration Penetration { get; set; }
        public List<GenericPackTransaction> PackData { get; set; }
    }

    public class GenericForecastVersionInputOutput
    {
        public ForecastVersionDetail fv { get; set; }
        public GenericForecastIO fio { get; set; }
    }

}
