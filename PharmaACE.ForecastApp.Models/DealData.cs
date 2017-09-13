using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
   public class DealData
    {     
        public int ID { get; set; }
        
        public string Name { get; set; }
      
        public int Owner { get; set; }

        public int DealChampion { get; set; }

        public int BDL_Lead { get; set; }

        public string StageName { get; set; }

        public int StageID { get; set; }

        public int ActivityID { get; set; }
        public string ActivityName { get; set; }

        public decimal Value { get; set; }

        public string Objective { get; set; } 
               
        public int ObjectID { get; set; }

        public int Priority { get; set; }

        public string BDLUserName { get; set; }
        public string DealChampUserName { get; set; }

        public int projectId { get; set; }
        public int ProjectType { get; set;}
        public int Currency { get; set; }

        public int OperationType { get; set; }
        public string ModifiedField { get; set; }
        // public  UWObject ObjectMaster { get; set; }

    }
}
