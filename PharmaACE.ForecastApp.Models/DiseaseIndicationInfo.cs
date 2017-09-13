using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
  public class DiseaseIndicationInfo
    {
        public int Id { get; set; }

        public int PrimaryIndicationId { get; set; }

        public string DiseaseOverview { get; set; }

        public string DetailedIndication { get; set; }

        //public MediaDetail MediaDetails { get; set; }

        public List<References> ReferenceList  { get; set; }

        public List<MediaDetail> MediaDetails { get; set; }

    }
    public class MediaDetail
    {
        public bool isPathoImage { get; set; }
        [Display(Name = "ImageUrl")]
        public string ImageUrl { get; set; }

        [Display(Name = "ImageUrl")]
        public byte[] ImageByte { get; set; }

        [Display(Name = "VideoUrl")]
        public string VideoUrl { get; set; }
    }
    public class References
    {
        public int ReferenceId { get; set;}

        public string ReferenceLink { get; set; }
    
    }

    


}
