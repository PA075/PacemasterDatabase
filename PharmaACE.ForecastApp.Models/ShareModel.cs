using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
   public  class ShareModel
    {
        public ShareType ShareType { get; set; }
        public int Permission { get; set; }
        public int ObjectId { get; set; }
        public string FullName {get;set;}
        public string EmailId { get; set; }
        public string UserEmail { get; set; }
        public List<UserInfo> UserInfo { get; set; }
        public string Name { get; set; }
        public int UserId { get; set; }

        public int BdlId { get; set; }
        public int DealChampId { get; set; }

        public int OwnerId { get; set; }

        public string PathString { get; set; }

    }

    //public class SharePermission
    //{
    //    public int Permission { get; set; }
    //}
      
}
