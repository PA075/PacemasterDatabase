using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
  public  class FullTextSearch
    {
        public int[] objectIds { get; set; }
        public string[] SearchedText { get; set; }
        public int[] Extns { get; set; }
        public string Extn { get; set; }
        public string permString { get; set; }
        public int ObjectId { get; set; }
        public string Lineage { get; set; }
        public string Name { get; set; }
        public ObjectType Type { get; set; }
        public decimal Size { get; set; }
        public DateTime creationDate { get; set; }
        public DateTime Moddate { get; set; }
        public string Desc { get; set; }
        public ObjectPermission permission { get; set; }
        public int ParentId { get; set; }
        public string Path { get; set; }
        public int? FileCounts { get; set; }
        public string Index { get; set; }
        public string SharedWithUsers { get; set; }
        public string IndexPath { get; set; }

    }
}
