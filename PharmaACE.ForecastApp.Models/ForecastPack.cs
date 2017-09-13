using System;
using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastPack
    {
        public string Name { get; set; }
        public int Order { get; set; }
    }

    public class PackComparer : IEqualityComparer<ForecastPack>
    {
        public bool Equals(ForecastPack x, ForecastPack y)
        {
            return String.Compare(x.Name, y.Name) == 0;
        }

        public int GetHashCode(ForecastPack obj)
        {
            return obj.Name.GetHashCode();
        }
    }
}