using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class AdvSearch
    {       
            public List<int> RootFolderIds { get; set; }

            public List<int> Extns { get; set; }

            public DateTime StartDate { get; set; }

            public List<int> UserIds { get; set; }

            public string ContentKeywords { get; set; }


    }
}

