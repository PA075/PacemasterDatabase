namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pipeline.PipelineSearchData")]
    public partial class PipelineSearchData
    {
        [StringLength(500)]
        public string ProductName { get; set; }

        [StringLength(500)]
        public string CompanyName { get; set; }

        public string MoleculeName { get; set; }

        public string ProductCategory { get; set; }

        public string PrimaryPharmaClass { get; set; }

        public string SecondaryPharmaClass { get; set; }

        public string TertiaryPharmaClass { get; set; }

        public string Indication { get; set; }

        [StringLength(100)]
        public string Phase { get; set; }

        public string ROA { get; set; }

        public string FormNames { get; set; }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Module { get; set; }
    }
}
