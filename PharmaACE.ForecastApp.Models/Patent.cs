using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class Patent
    {
      public List<BrandInfo> brandList { get; set; }


    }

    public class BrandInfo
    {
        public int InlineTransId { get; set; }
        public string BrandName { get; set; }

    }
}
