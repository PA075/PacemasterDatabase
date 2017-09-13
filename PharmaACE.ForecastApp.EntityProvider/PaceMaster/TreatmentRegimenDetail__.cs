namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Disease.TreatmentRegimenDetail")]
    public partial class TreatmentRegimenDetail
    {
        public int Id { get; set; }

        public string ClassSummary { get; set; }

        public int DiseaseIndicationDataId { get; set; }

        public int PharmaClassId { get; set; }

        public virtual PharmaClassMaster PharmaClassMaster { get; set; }
    }
}
