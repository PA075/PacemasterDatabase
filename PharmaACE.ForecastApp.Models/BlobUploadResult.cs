using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class BlobUploadResult
    {
        [Display(Name = "Message")]
        public string Message { get; set; }

        [Display(Name = "BlobUrl")]
        public string BlobUrl { get; set; }
    }
}
