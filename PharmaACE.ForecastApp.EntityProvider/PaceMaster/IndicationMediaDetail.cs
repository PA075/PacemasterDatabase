namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("IndicationMediaDetail")]
    public partial class IndicationMediaDetail
    {
        public int Id { get; set; }

        public string ImageUrl { get; set; }

        public string VideoUrl { get; set; }

        public int DiseaseIndicationDataId { get; set; }

        public bool IsPathoImage { get; set; }


        public virtual DiseaseIndicationData DiseaseIndicationData { get; set; }
    }
}
