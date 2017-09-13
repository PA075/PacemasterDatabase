namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ResetPasswordRequestDetails
    {
        public int Id { get; set; }

        [Required]
        [StringLength(320)]
        public string UserEmail { get; set; }

        public Guid GUID { get; set; }

        public DateTime ExpiryDate { get; set; }

        public Boolean IsActive { get; set; }
    }
}
