using System;
using System.Collections.Generic;
using System.Linq;

namespace PharmaACE.ForecastApp.Models
{
    public class GenericHistoricalTransaction
    {
        public GenericHistoricalTransaction()
        {
            Transactions = new List<CompetitorTransaction>();
        }

        public ForecastParameter Parameter { get; set; }
        public List<CompetitorTransaction> Transactions { get; set; }
    }

    public class GenericPackTransaction
    {
        public GenericPackTransaction()
        {
            Transactions = new List<CompetitorTransaction>();
        }

        public ForecastParameter Parameter { get; set; }
        public List<CompetitorTransaction> Transactions { get; set; }
    }

    //public class CompetitorTransaction
    //{
    //    public CompetitorTransaction()
    //    {
    //        //DataStartFrom = -1;
    //        //Transactions = new List<string>();
    //    }

    //    public string Competitor { get; set; }
    //    public int DataStartFrom { get; set; }
    //    public List<string> Transactions { get; set; }
    //}

    public class GenericForecastTransaction
    {
        public GenericForecastTransaction()
        {
            DataStartFrom = -1;
            Transactions = new List<string>();
        }

        public ForecastParameter Parameter { get; set; }
        public int DataStartFrom { get; set; }
        public List<string> Transactions { get; set; }
    }
}