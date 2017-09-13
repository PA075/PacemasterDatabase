namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.FTFHolderGenericMapping")]
    public partial class FTFHolderGenericMapping
    {
        public int id { get; set; }

        public int GenericAvailabilityId { get; set; }

        public int CompanyId { get; set; }

        public virtual CompanyMaster CompanyMaster { get; set; }

        public virtual GenericAvailability GenericAvailability { get; set; }
    }
}
