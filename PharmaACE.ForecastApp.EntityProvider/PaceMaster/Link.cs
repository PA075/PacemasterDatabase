namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.Links")]
    public partial class Link
    {
        public int Id { get; set; }

        public int? PatentCodeBrandID { get; set; }

        [StringLength(500)]
        public string Links { get; set; }

        [StringLength(500)]
        public string Description { get; set; }

        public virtual ProductCodeBrand ProductCodeBrand { get; set; }
    }
}
