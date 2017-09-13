namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.SegmentVersion")]
    public partial class BDLSegmentVersion
    {
        [Key]
        [Column(Order = 0)]
        public int Id { get; set; }

        public int SegmentMasterId { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProjectVersionId { get; set; }

        public virtual BDLProjectVersion ProjectVersion { get; set; }

        public virtual BDLSegmentMaster SegmentMaster { get; set; }
    }
}
