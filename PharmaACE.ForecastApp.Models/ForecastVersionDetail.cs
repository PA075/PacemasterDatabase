using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastVersionDetail
    {
        public ForecastVersionDetail()
        {
            Scenarios = new List<ForecastScenario>();
            ForecastProducts = new List<ForecastProduct>();
        }

        public string Name { get; set; }
        public string Version { get; set; }
        public ForecastPeriod Period { get; set; }
        //public ForecastCategory Category { get; set; }
        public string DataAvailableFrom { get; set; }
        public string DataAvailableTill { get; set; }
        public int ForecastYearTill { get; set; }
        //public ForecastDataType DataType { get; set; }
        public int HistoricalTimeStep { get; set; }
        public int TotalTimeStep { get; set; }

        public List<ForecastScenario> Scenarios { get; set; }
        public List<ForecastProduct> ForecastProducts { get; set; }
    }

    public class GenericForecastVersionDetail : ForecastVersionDetail
    {
        public ForecastCategory Category { get; set; }
        public ForecastDataType DataType { get; set; }
    }

    public class BDLForecastVersionDetail : ForecastVersionDetail
    {
        public BDLForecastVersionDetail()
        {
            Countrys = new List<string>();
            Indications = new List<string>();
        }

        public List<string> Countrys { get; set; }
        public ShareCalculationType ShareCalc { get; set; }
        public List<string> Indications { get; set; }
    }
}