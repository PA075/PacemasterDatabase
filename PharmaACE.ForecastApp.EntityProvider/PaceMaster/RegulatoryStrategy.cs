namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.RegulatoryStrategy")]
    public partial class RegulatoryStrategy
    {
        public int Id { get; set; }

        public int PatentInfoId { get; set; }

        public int? CompanyId { get; set; }

        public int? TypeOfRegFilling { get; set; }

        public int? TypeOfPatentCertificate { get; set; }

        public string PIVStrategy { get; set; }

        public virtual CompanyMaster CompanyMaster { get; set; }

        public virtual PatentInfo PatentInfo { get; set; }
    }
}
