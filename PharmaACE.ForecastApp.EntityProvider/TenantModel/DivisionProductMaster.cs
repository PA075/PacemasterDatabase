namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DivisionProductMaster")]
    public partial class DivisionProductMaster
    {
        public int ID { get; set; }

        public int DivisionID { get; set; }

        [Required]
        [StringLength(1000)]
        public string ProductName { get; set; }

        [Required]
        [StringLength(2000)]
        public string Molecule { get; set; }
    }
}
