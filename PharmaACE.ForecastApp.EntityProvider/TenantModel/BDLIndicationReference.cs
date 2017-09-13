namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.IndicationReference")]
    public partial class BDLIndicationReference
    {
        //[DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }

        [Required]
        public string IndicationName { get; set; }

        public int SectionId { get; set; }

        public string Reference { get; set; }

        public virtual BDLSectionMaster SectionMaster { get; set; }
    }
}
