namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.AssumptionAttachmentMapping")]
    public partial class GenericAssumptionAttachmentMapping
    {
        public int Id { get; set; }

        public int AssumptionId { get; set; }

        public int AttachmentId { get; set; }

        public virtual AttachamentMaster AttachamentMaster { get; set; }

        public virtual GenericAssumptions Assumptions { get; set; }
    }
}
