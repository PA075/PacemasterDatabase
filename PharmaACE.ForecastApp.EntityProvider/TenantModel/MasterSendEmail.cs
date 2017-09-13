namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.MasterSendEmail")]
    public partial class MasterSendEmail
    {
        [Key]
        [Column(Order = 0)]
        public int ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Report_Name { get; set; }

        [Key]
        [Column(Order = 2)]
        public string To { get; set; }

        public string Cc { get; set; }

        [StringLength(500)]
        public string Bcc { get; set; }

        [Key]
        [Column(Order = 3)]
        public string Subject { get; set; }

        [StringLength(128)]
        public string eml_prfl_nm { get; set; }

        public string body { get; set; }

        [StringLength(50)]
        public string body_format { get; set; }
    }
}
