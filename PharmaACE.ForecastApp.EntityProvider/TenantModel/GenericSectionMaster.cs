namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.SectionMaster")]
    public partial class GenericSectionMaster
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }

        [StringLength(32)]
        public string SectionName { get; set; }

        public int? Parent { get; set; }

        public bool? HasAssumptions { get; set; }
    }
}
