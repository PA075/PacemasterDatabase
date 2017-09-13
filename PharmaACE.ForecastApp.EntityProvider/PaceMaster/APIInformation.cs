namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.APIInformation")]
    public partial class APIInformation
    {
        public int Id { get; set; }

        public int InlineTransanctionId { get; set; }

        [Column(TypeName = "date")]
        public DateTime? SubmissionDate { get; set; }

        public int DMFComapnyId { get; set; }

        public int DMFStatus { get; set; }

        public bool ANDAHolderAgainstTheFiledDMF { get; set; }

        public bool OrganizationFinishedProducts { get; set; }

        public virtual CompanyMaster CompanyMaster { get; set; }

        public virtual InlineTransaction Transaction { get; set; }
    }
}
