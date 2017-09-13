namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Acthar.IndicationMaster")]
    public partial class ActharIndicationMaster
    {
        public int ID { get; set; }

        public int? ProjectVersionID { get; set; }

        [StringLength(100)]
        public string Name { get; set; }
    }
}
