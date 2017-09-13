namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DivisionCompanyMaster")]
    public partial class DivisionCompanyMaster
    {
        public int ID { get; set; }

        public int DivisionID { get; set; }

        [Required]
        [StringLength(1000)]
        public string CompanyName { get; set; }

        public virtual DivisionMaster DivisionMaster { get; set; }
    }
}
