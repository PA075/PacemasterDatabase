namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.SegmentDetailsData")]
    public partial class BDLSegmentDetailsData
    {
        public int Id { get; set; }

        [Required]
        [StringLength(1000)]
        public string Segment { get; set; }

        [StringLength(1000)]
        public string SegmentValue { get; set; }

        public int SegmentDetailsId { get; set; }

        public int ProjectVersionId { get; set; }

        public DateTime CreationDate { get; set; }

        public byte SegmentOrder { get; set; }

        public virtual BDLProjectVersion ProjectVersion { get; set; }

        public virtual BDLSegmentDetails SegmentDetails { get; set; }
    }
}
