using System;
using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastCompetitor
    {
        public string Name { get; set; }
        public int Order { get; set; }
    }

    public class CompetitorComparer : IEqualityComparer<ForecastCompetitor>
    {
        public bool Equals(ForecastCompetitor x, ForecastCompetitor y)
        {
            return String.Compare(x.Name, y.Name) == 0;
        }

        public int GetHashCode(ForecastCompetitor obj)
        {
            return obj.Name.GetHashCode();
        }
    }
}