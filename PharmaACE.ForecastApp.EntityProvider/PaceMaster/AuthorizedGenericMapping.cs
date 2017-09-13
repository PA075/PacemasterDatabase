namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{ 
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.AuthorizedGenericMapping")]
    public partial class AuthorizedGenericMapping
    {
        public int id { get; set; }

        public int GenericAvailabilityId { get; set; }

        public int ComapnyId { get; set; }

        public virtual CompanyMaster CompanyMaster { get; set; }

        public virtual GenericAvailability GenericAvailability { get; set; }
    }
}
