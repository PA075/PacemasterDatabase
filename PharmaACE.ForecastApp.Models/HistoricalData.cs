using System;
using System.Collections.Generic;
using System.Linq;

namespace PharmaACE.ForecastApp.Models
{
    public class HistoricalTransaction
    {
        public HistoricalTransaction()
        {
            Transactions = new List<CompetitorTransaction>();
        }

        public ForecastParameter Parameter { get; set; }
        public List<CompetitorTransaction> Transactions { get; set; }
    }

    public class PackTransaction
    {
        public PackTransaction()
        {
            Transactions = new List<CompetitorTransaction>();
        }

        public ForecastParameter Parameter { get; set; }
        public List<CompetitorTransaction> Transactions { get; set; }
    }

    public class CompetitorTransaction
    {
        public CompetitorTransaction()
        {
            DataStartFrom = -1;
            Transactions = new List<string>();
        }

        public string Competitor { get; set; }
        public int DataStartFrom { get; set; }
        public List<string> Transactions { get; set; }
    }

    public class ForecastTransaction
    {
        public ForecastTransaction()
        {
            DataStartFrom = -1;
            Transactions = new List<string>();
        }

        public ForecastParameter Parameter { get; set; }
        public int DataStartFrom { get; set; }
        public List<string> Transactions { get; set; }
    }
}