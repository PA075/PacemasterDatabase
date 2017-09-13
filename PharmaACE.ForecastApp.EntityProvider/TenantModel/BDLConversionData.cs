namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.ConversionData")]
    public partial class BDLConversionData
    {
        [Key]
        [Column(Order = 0)]
        public int ID { get; set; }

        public byte CountryId { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ScenarioId { get; set; }

        public short ParameterId { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int SegmentId { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductId { get; set; }

        [Key]
        [Column(Order = 4, TypeName = "date")]
        public DateTime TransDate { get; set; }

        [Column(TypeName = "numeric")]
        public decimal? TransData { get; set; }

        public DateTime CreationDate { get; set; }

        [Key]
        [Column(Order = 5)]
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
