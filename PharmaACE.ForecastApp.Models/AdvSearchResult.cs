using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class AdvSearchResult
    {
        public int ObjectId { get; set; }
        public string Lineage { get; set; }
        public string Name { get; set; }
        public decimal Size { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime ModDate { get; set; }
        public string Desc { get; set; }
        public byte Permission { get; set;}
        public int ParentID { get; set; }
        public string path { get; set; }
        public int Extn { get; set;}
        public byte[] File_Stream { get; set; }


    }
}
