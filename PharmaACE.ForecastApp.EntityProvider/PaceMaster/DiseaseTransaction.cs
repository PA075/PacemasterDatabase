namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Disease.Transaction")]
    public partial class DiseaseTransaction
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DiseaseTransaction()
        {
            MoleculeMaster = new HashSet<MoleculeMaster>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int TransactionId { get; set; }

        public int? DiseaseAreaId { get; set; }

        public int? PrimaryIndicationId { get; set; }

        [StringLength(500)]
        public string SecondaryIndication { get; set; }

        public int? RegimenId { get; set; }

        public string Definition { get; set; }

        public string QuickFacts { get; set; }

        public string RiskFactors { get; set; }

        public string Symptoms { get; set; }

        public string Diagnosis { get; set; }

        public string Stages { get; set; }

        public string Classification { get; set; }

        public string ClassSummary { get; set; }

        public string Compliance { get; set; }

        public string DosingAndDot { get; set; }

        public string Pricing { get; set; }

        public string Events { get; set; }

        public string Probability { get; set; }

        public string References { get; set; }

        public string DetailedIndication { get; set; }

        public virtual DiseaseAreaMaster DiseaseAreaMaster { get; set; }

        public virtual IndicationMaster IndicationMaster { get; set; }

        public virtual RegimenMaster RegimenMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MoleculeMaster> MoleculeMaster { get; set; }
    }
}
