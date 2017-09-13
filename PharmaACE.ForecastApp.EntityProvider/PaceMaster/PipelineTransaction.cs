namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pipeline.Transaction")]
    public partial class PipelineTransaction
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PipelineTransaction()
        {
            DiseaseAreaMaster = new HashSet<DiseaseAreaMaster>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ID { get; set; }

        public int? ProductCategoryId { get; set; }

        public int? PrimaryPharmaClassId { get; set; }

        public int? SecondryPharmaClassId { get; set; }

        public int? TertiaryPharmaClassId { get; set; }

        public int? MoleculeId { get; set; }

        public int? PhaseId { get; set; }

        [StringLength(255)]
        public string DetailedIndication { get; set; }

        public int? DosageId { get; set; }

        public DateTime? ExpectedCompletionDate { get; set; }

        [StringLength(255)]
        public string LTE { get; set; }

        [StringLength(255)]
        public string PhaseSuccess { get; set; }

        [StringLength(255)]
        public string PhaseLOA { get; set; }

        public int? AnalystEstimateId { get; set; }

        [StringLength(255)]
        public string Status { get; set; }

        [StringLength(255)]
        public string NCT { get; set; }

        public string StudyTitle { get; set; }

        [StringLength(255)]
        public string Note { get; set; }

        public short? ProductTypeID { get; set; }

        public virtual AnalystEstimate AnalystEstimate { get; set; }

        public virtual Dosages Dosages { get; set; }

        public virtual MoleculeMaster MoleculeMaster { get; set; }

        public virtual PharmaClassMaster PharmaClassMaster { get; set; }

        public virtual PharmaClassMaster PharmaClassMaster1 { get; set; }

        public virtual PharmaClassMaster PharmaClassMaster2 { get; set; }

        public virtual PhaseMaster PhaseMaster { get; set; }

        public virtual ProductCategoryMaster ProductCategoryMaster { get; set; }

        public virtual CompanyTransactionMapping CompanyTransactionMapping { get; set; }

        public virtual IndicationTransactionMapping IndicationTransactionMapping { get; set; }

        public virtual MOA_TransactionMapping MOA_TransactionMapping { get; set; }

        public virtual MoleculeTransactionMapping MoleculeTransactionMapping { get; set; }

        public virtual ProductTransactionMapping ProductTransactionMapping { get; set; }

        public virtual RegimenTransactionMapping RegimenTransactionMapping { get; set; }

        public virtual ROA_TransactionMapping ROA_TransactionMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DiseaseAreaMaster> DiseaseAreaMaster { get; set; }
    }
}
