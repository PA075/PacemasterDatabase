using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ProductPenetration
    {
        public ProductPenetration()
        {
            DataStartFrom = -1;
            Transactions = new List<string>();
        }

        public PenetrationType Type { get; set; }
        public int? LaunchPriceSelection { get; set; }
        public int? PriceBasedOn { get; set; }
        public int? StartMonth1 { get; set; }
        public int? StartMonth2 { get; set; }
        public int? TrendType { get; set; }
        public int DataStartFrom { get; set; }
        public List<string> Transactions { get; set; }
    }
}