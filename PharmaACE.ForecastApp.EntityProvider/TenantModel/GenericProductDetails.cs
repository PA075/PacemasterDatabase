namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.ProductDetails")]
    public partial class GenericProductDetails
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GenericProductDetails()
        {
            ProjectVersionProduct = new HashSet<GenericProjectVersionProduct>();
        }

        public int ID { get; set; }

        public bool Type { get; set; }

        public byte? TrendingType { get; set; }

        public byte? NumberOfEvents { get; set; }

        public byte Projection { get; set; }

        public bool? EnableSKU { get; set; }

        public byte SKUCount { get; set; }

        public byte? NumberOfPacks { get; set; }

        public byte? NumberOfCompetitors { get; set; }

        public byte Brand { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericProjectVersionProduct> ProjectVersionProduct { get; set; }
    }
}
