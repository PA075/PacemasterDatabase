using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class MediaManagement
    {
        [Display(Name = "Id")]
        public string Id { get; set; }

        [Display(Name = "Indication")]
        public string Indication { get; set; }

        [Display(Name = "ImageBlobUrl")]
        public string ImageBlobUrl { get; set; }

        [Display(Name = "Vedio Url")]
        public string VedioUrl { get; set; }
    }
}
