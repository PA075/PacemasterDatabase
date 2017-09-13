namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.HistoricalData")]
    public partial class BDLHistoricalData
    {
        [Key]
        [Column(Order = 0)]
        public int ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ScenarioId { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short ParameterId { get; set; }

        [Key]
        [Column(Order = 3)]
        public byte CountryId { get; set; }

        [Key]
        [Column(Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int SegmentId { get; set; }

        [Key]
        [Column(Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductId { get; set; }

        [Key]
        [Column(Order = 6, TypeName = "date")]
        public DateTime TransDate { get; set; }

        [Column(TypeName = "numeric")]
        public decimal? TransData { get; set; }

        public DateTime CreationDate { get; set; }

        [Key]
        [Column(Order = 7)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProjectVersionProductId { get; set; }

        public virtual BDLCountryMaster CountryMaster { get; set; }

        public virtual BDLParameterMaster ParameterMaster { get; set; }

        public virtual BDLProductMaster ProductMaster { get; set; }

        public virtual BDLProjectVersionProduct ProjectVersionProduct { get; set; }

        public virtual BDLScenarioMaster ScenarioMaster { get; set; }

        public virtual BDLSegmentMaster SegmentMaster { get; set; }
    }
}
