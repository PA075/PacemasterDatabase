namespace PharmaACE.ForecastApp.EntityProvider.pacemaster.NewTreatment
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class Model13we4r567 : DbContext
    {
        public Model13we4r567()
            : base("name=Model13we4r567")
        {
        }

        public virtual DbSet<PharmaClassMaster> PharmaClassMasters { get; set; }
        public virtual DbSet<TreatmentRegimenDetail> TreatmentRegimenDetails { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PharmaClassMaster>()
                .Property(e => e.PharmaClass)
                .IsUnicode(false);

            modelBuilder.Entity<PharmaClassMaster>()
                .HasMany(e => e.TreatmentRegimenDetails)
                .WithRequired(e => e.PharmaClassMaster)
                .WillCascadeOnDelete(false);
        }
    }
}
