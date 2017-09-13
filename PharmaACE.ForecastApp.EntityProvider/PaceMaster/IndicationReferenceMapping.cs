namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{ 
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Disease.IndicationReferenceMapping")]
    public partial class IndicationReferenceMapping
    {
        public int Id { get; set; }

        public int DiseaseIndicationDataId { get; set; }

        public int ReferenceId { get; set; }

        public virtual DiseaseIndicationData DiseaseIndicationData { get; set; }

        public virtual ReferenceMaster ReferenceMaster { get; set; }
    }
}
