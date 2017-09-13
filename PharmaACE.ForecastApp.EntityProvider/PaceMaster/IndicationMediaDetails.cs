namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class IndicationMediaDetails
    {
        [Key]
        [Column(Order = 0)]
        public string DiseaseName { get; set; }

        [Key]
        [Column(Order = 1)]
        public string IndicationName { get; set; }

        public string ImageUrl { get; set; }

        public string VideoUrl { get; set; }
    }
}
