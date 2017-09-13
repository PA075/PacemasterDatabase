using System.ComponentModel;

namespace PharmaACE.ForecastApp.Models
{
    public class TopHeader
    {
        public string LogoImagePath { get; set; }

        //[DefaultValue("http://www.pacehomepage.com/")]
        public string LogoImageHref { get; set; }

        public string PageHeader { get; set; }

        [DefaultValue(null)]
        public string PageMenu { get; set; }

        [DefaultValue(false)]
        public bool PopalertDisplay { get; set; }

        [DefaultValue(false)]
        public bool BreadcrumbDisplay { get; set; }
        
    }
}
