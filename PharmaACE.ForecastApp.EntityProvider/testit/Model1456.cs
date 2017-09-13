namespace PharmaACE.ForecastApp.EntityProvider.testit
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class Model1456 : DbContext
    {
        public Model1456()
            : base("name=Model1456")
        {
        }

        public virtual DbSet<DiseaseIndicationData> DiseaseIndicationData { get; set; }
        public virtual DbSet<ReferenceMaster> ReferenceMaster { get; set; }
        public virtual DbSet<IndicationReferenceMapping> IndicationReferenceMapping { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DiseaseIndicationData>()
                .HasMany(e => e.IndicationReferenceMapping)
                .WithRequired(e => e.DiseaseIndicationData)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ReferenceMaster>()
                .HasMany(e => e.IndicationReferenceMapping)
                .WithRequired(e => e.ReferenceMaster)
                .WillCascadeOnDelete(false);
        }
    }
}
