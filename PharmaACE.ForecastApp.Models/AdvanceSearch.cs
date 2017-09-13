using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class AdvanceSearch
    {
        public string SelFileTypeList { get; set; }
        public string ContentKeyWord { get; set; }
        public string ListLineage { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string ListSelUserIds { get; set; }
        public bool IsFullTextSearch { get; set; }
        public int SelectedOpt { get; set;}
        public int isAllUser { get; set; }
    }
}
