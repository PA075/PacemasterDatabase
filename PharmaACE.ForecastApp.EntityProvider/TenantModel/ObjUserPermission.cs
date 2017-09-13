namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ObjUserPermission")]
    public partial class ObjUserPermission
    {
        

        public int Id { get; set; }

        public int ObjUserId { get; set; }

        public byte Permission { get; set; }

        public DateTime ModifiedDate { get; set; }

        [InverseProperty("ObjUserPermission")]
        public virtual ObjectUserMapping ObjectUserMapping { get; set; }
    }
}
