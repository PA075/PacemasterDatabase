using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class UWActivityReporting
    {

       
        public int ObjectId { get; set; }

        public string Extn { get; set; }

        public string Name { get; set; }

        public string Lineage { get; set; }

        public decimal? Size { get; set; }

        public ObjectType Type { get; set; }

        public DateTime ActivityDate { get; set; }

        public int Activity { get; set; }
        public int UserId { get; set; }

       public string FullName { get; set; }

        public string MainFolderName { get; set; }

        public string ActivityName { get; set; }

        public string CustomMessage { get; set; }
    }
}
