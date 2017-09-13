namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.ProductDetails")]
    public partial class BDLProductDetails
    {
        public int Id { get; set; }

        public int ProductId { get; set; }

        public DateTime? LaunchDate { get; set; }

        public DateTime? LOE_Date { get; set; }

        public bool IncludeinFinal { get; set; }

        public byte ProductType { get; set; }

        public virtual BDLProductMaster ProductMaster { get; set; }
    }
}
