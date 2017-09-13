namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pipeline.PipelineProcessedData")]
    public partial class PipelineProcessedData
    {
        [StringLength(500)]
        public string ProductName { get; set; }

        [StringLength(500)]
        public string CompanyName { get; set; }

        [StringLength(4000)]
        public string MoleculeName { get; set; }

        [StringLength(50)]
        public string ProductCategory { get; set; }

        [StringLength(500)]
        public string PrimaryPharmaClass { get; set; }

        [StringLength(500)]
        public string SecondryPharmaClass { get; set; }

        [StringLength(500)]
        public string TertiaryPharmaClass { get; set; }

        [StringLength(500)]
        public string IndicationName { get; set; }

        [StringLength(100)]
        public string Phase { get; set; }

        [StringLength(1000)]
        public string ROA { get; set; }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Module { get; set; }
    }
}
