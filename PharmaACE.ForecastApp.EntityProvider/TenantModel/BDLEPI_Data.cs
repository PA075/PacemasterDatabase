namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.EPI_Data")]
    public partial class BDLEPI_Data
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
        [Column(Order = 2, TypeName = "date")]
        public DateTime TransDate { get; set; }

        [Key]
        [Column(Order = 3)]
        public decimal? TransData { get; set; }

        [Key]
        [Column(Order = 4)]
        public DateTime CreationDate { get; set; }

        [Key]
        [Column(Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProjectVersionId { get; set; }

        public virtual BDLCountryMaster CountryMaster { get; set; }

        public virtual BDLParameterMaster ParameterMaster { get; set; }

        public virtual BDLProjectVersion ProjectVersion { get; set; }

        public virtual BDLScenarioMaster ScenarioMaster { get; set; }
    }
}
