namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ProjectFolderList")]
    public partial class ProjectFolderList
    {
        public int Id { get; set; }

        public byte Type { get; set; }

        [Required]
        [StringLength(255)]
        public string Name { get; set; }

        public int Extn { get; set; }

        [Required]
        public string Lineage { get; set; }

        public decimal? Size { get; set; }

        public int? ParentId { get; set; }

        public string Path { get; set; }
    }
}
