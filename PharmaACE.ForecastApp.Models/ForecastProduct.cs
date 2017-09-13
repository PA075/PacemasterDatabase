using System;
using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastProduct
    {
        public int UniqueId { get; set; }
        public string Name { get; set; }
        public int Order { get; set; }
        public ProductType Type { get; set; }        
    }

    public class GenericProduct : ForecastProduct
    {
        public GenericProduct()
        {
            SKUs = new List<ForecastSKU>();
        }

        public ForecastTrendingType TrendingType { get; set; }
        public ForecastProjectionType Projection { get; set; }
        public bool? IsSKULevel { get; set; }
        public ProductBrand Brand { get; set; }

        public List<ForecastSKU> SKUs { get; set; }
    }

    public class BDLProduct : ForecastProduct
    {
        public DateTime LaunchDate { get; set; }
        public DateTime LOEDate { get; set; }
        public bool IncludeInFinal { get; set; }
    }
}