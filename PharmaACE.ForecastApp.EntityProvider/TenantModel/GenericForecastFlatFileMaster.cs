namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.ForecastFlatFileMaster")]
    public partial class GenericForecastFlatFileMaster
    {
        [Key]
        [Column(Order = 0)]
        public int ID { get; set; }

        [Key]
        [Column(Order = 1)]
        public string StorageID { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int TemplateID { get; set; }

        public int? MajorVersion { get; set; }

        public DateTime? DateTime { get; set; }

        public virtual GenericForecastTemplateMaster GenericForecastTemplateMaster { get; set; }
    }
}
