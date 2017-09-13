namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.SKU_Details")]
    public partial class GenericSKU_Details
    {
        public int ID { get; set; }

        public int ProjectVersionProductID { get; set; }

        public int SKU_ID { get; set; }

        public int SKU_Order { get; set; }

        public virtual GenericProjectVersionProduct ProjectVersionProduct { get; set; }

        public virtual GenericSKU_Master SKU_Master { get; set; }
    }
}
