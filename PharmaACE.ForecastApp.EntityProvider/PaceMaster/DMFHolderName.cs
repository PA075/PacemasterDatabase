namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{ 
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.DMFHolderName")]
    public partial class DMFHolderName
    {
        public int Id { get; set; }

        [Column("DMFHolderName")]
        [StringLength(500)]
        public string DMFHolderName1 { get; set; }
    }
}
