using System;
using System.Collections.Generic;
using System.Linq;

namespace PharmaACE.ForecastApp.Models
{
    /// <summary>
    /// Used both for Historical, Forecast(Output), ConversionData transactions
    /// </summary>
    public class BDLTransaction
    {
        public BDLTransaction()
        {
            SegmentTransactions = new List<SegmentTransaction>();
        }

        public ForecastParameter Parameter { get; set; }
        public List<SegmentTransaction> SegmentTransactions { get; set; }
    }

    public class EPIDataTransaction
    {
        public int DataStartFrom { get; set; }
        public List<string> Transactions { get; set; }
    }

    public class SegmentTransaction
    {
        public SegmentTransaction()
        {
            ProductTransactions = new List<ProductTransaction>();
        }

        public ForecastSegment Segment { get; set; }
        public List<ProductTransaction> ProductTransactions { get; set; }
    }
    
    public class ProductTransaction
    {
        public ProductTransaction()
        {
            DataStartFrom = -1;
            Transactions = new List<string>();
        }

        public string Product { get; set; }
        public int DataStartFrom { get; set; }
        public List<string> Transactions { get; set; }
    }

    public class ForecastSegmentEvent
    {
        public string Segment { get; set; }
        public List<ForecastSegmentProductEvent> SegmentEvents { get; set; }
    }

    public class ForecastSegmentProductEvent
    {
        public string Product { get; set; }
        public List<ForecastEvent> ProductEvents { get; set; }
    }

    public class ForecastSegmentPricing
    {
        public string Segment { get; set; }
        public List<ForecastSegmentProductPricing> SegmentPricing { get; set; }
    }

    public class ForecastSegmentProductPricing
    {
        public string Product { get; set; }
        public List<ForecastPricing> ProductPricing { get; set; }
    }

    public class ForecastPricing
    {
        public string StartDate { get; set; }
        public double StartPrice { get; set; }
        public int Month { get; set; }
        public double Change { get; set; }
    }

    public class ForecastSegmentSource
    {
        public string Segment { get; set; }
        public List<ForecastSource> SegmentSources { get; set; }
    }

    public class ForecastSource
    {
        public string Product { get; set; }
        /// <summary>
        /// the following list will contain (N-1) values; where N = # of products
        /// </summary>
        public List<double> ProductSources { get; set; }
    }
}