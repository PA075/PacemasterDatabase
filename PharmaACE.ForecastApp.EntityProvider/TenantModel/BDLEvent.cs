namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.Event")]
    public partial class BDLEvent
    {
        [Key]
        [Column(Order = 0)]
        public int Id { get; set; }

        [Key]
        [Column(Order = 1)]
        public byte CountryId { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ScenarioId { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short ParameterId { get; set; }

        [Key]
        [Column(Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int SegmentId { get; set; }

        [Key]
        [Column(Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductId { get; set; }

        [Key]
        [Column(Order = 6)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int EventOrder { get; set; }

        [Key]
        [Column(Order = 7)]
        [StringLength(510)]
        public string Name { get; set; }

        [Key]
        [Column(Order = 8)]
        [StringLength(510)]
        public string Impact { get; set; }

        [Key]
        [Column(Order = 9, TypeName = "date")]
        public DateTime LaunchDate { get; set; }

        public decimal? StartShare { get; set; }

        public decimal? PeakShare { get; set; }

        public int? MonthstoPeak { get; set; }

        public decimal? CurveType { get; set; }

        [Key]
        [Column(Order = 10, TypeName = "date")]
        public DateTime CreationDate { get; set; }

        [Key]
        [Column(Order = 11)]
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
