namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("MoleculeMaster")]
    public partial class MoleculeMaster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public MoleculeMaster()
        {
            MoleculeMapping = new HashSet<InlineMoleculeMapping>();
            MoleculeTransactionMapping = new HashSet<MoleculeTransactionMapping>();
            Transaction1 = new HashSet<InlineTransaction>();
            Transaction2 = new HashSet<PipelineTransaction>();
            Transaction = new HashSet<DiseaseTransaction>();
            Transaction11 = new HashSet<InlineTransaction>();
            MoleculeRegimenMapping = new HashSet<MoleculeRegimenMapping>();

        }

        [Key]
        public int MoleculeId { get; set; }

        [Required]
        [StringLength(4000)]
        public string MoleculeName { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MoleculeTransactionMapping> MoleculeTransactionMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InlineTransaction> Transaction1 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PipelineTransaction> Transaction2 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DiseaseTransaction> Transaction { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InlineTransaction> Transaction11 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MoleculeRegimenMapping> MoleculeRegimenMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InlineMoleculeMapping> MoleculeMapping { get; set; }
    }
}
