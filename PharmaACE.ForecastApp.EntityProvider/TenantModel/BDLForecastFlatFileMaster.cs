namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.ForecastFlatFileMaster")]
    public partial class BDLForecastFlatFileMaster
    {
        public int ID { get; set; }

        [Required]
        public string StorageID { get; set; }

        public int TemplateID { get; set; }

        public int? MajorVersion { get; set; }

        public DateTime DateTime { get; set; }

        public virtual BDLForecastTemplateMaster BDLForecastTemplateMaster { get; set; }
    }
}
