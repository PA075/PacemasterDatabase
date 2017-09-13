namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.ForecastTemplateMaster")]
    public partial class GenericForecastTemplateMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GenericForecastTemplateMaster()
        {
            GenericForecastFlatFileMaster = new HashSet<GenericForecastFlatFileMaster>();
        }

        public int ID { get; set; }

        [Required]
        public string ProjectName { get; set; }

        [Required]
        public string TemplateStorageID { get; set; }

        public DateTime? DateTime { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericForecastFlatFileMaster> GenericForecastFlatFileMaster { get; set; }
    }
}
