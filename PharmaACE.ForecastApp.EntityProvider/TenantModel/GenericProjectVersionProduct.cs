namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.ProjectVersionProduct")]
    public partial class GenericProjectVersionProduct
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GenericProjectVersionProduct()
        {
            Events = new HashSet<GenericEvent>();
            ForecastData = new HashSet<GenericForecastData>();
            HistoricalData = new HashSet<GenericHistoricalData>();
            PackInfo = new HashSet<GenericPackInfo>();
            PenetrationTypeData = new HashSet<GenericPenetrationTypeData>();
            CompetitorDetails = new HashSet<GenericCompetitorDetails>();
            SKU_Details = new HashSet<GenericSKU_Details>();
        }

        public int ID { get; set; }

        public int ProjectVersionID { get; set; }

        public int ProductID { get; set; }

        public int ProductDetailsID { get; set; }

        public int ProductOrder { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericEvent> Events { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericForecastData> ForecastData { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericHistoricalData> HistoricalData { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericPackInfo> PackInfo { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericPenetrationTypeData> PenetrationTypeData { get; set; }

        public virtual GenericProductDetails ProductDetails { get; set; }

        public virtual GenericProductMaster ProductMaster { get; set; }

        public virtual GenericProjectVersion ProjectVersion { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericCompetitorDetails> CompetitorDetails { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericSKU_Details> SKU_Details { get; set; }
    }
}
