namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.ForecastTemplateMaster")]
    public partial class BDLForecastTemplateMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public BDLForecastTemplateMaster()
        {
            BDLForecastFlatFileMaster = new HashSet<BDLForecastFlatFileMaster>();
        }

        public int ID { get; set; }

        [Required]
        public string ProjectName { get; set; }

        [Required]
        public string TemplateStorageID { get; set; }

        public DateTime DateTime { get; set; }

        [Required]
        public int UserId { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BDLForecastFlatFileMaster> BDLForecastFlatFileMaster { get; set; }
    }
}
