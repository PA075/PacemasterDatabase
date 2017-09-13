namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.AssumptionAttachmentMapping")]
    public partial class BDLAssumptionAttachmentMapping
    {
        public int Id { get; set; }

        public int AssumptionId { get; set; }

        public int AttachmentId { get; set; }

        public virtual BDLAssumptions Assumptions { get; set; }

        public virtual AttachamentMaster AttachamentMaster { get; set; }
    }
}
