namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Disease.TreatmentRegimenDetail")]
    public partial class TreatmentRegimenDetail
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]

        public TreatmentRegimenDetail()
        {
            MoleculeRegimenMapping = new HashSet<MoleculeRegimenMapping>();
        }

        public int Id { get; set; }

   //     public int RegimenId { get; set; }

        public string ClassSummary { get; set; }

        public int DiseaseIndicationDataId { get; set; }

        public virtual DiseaseIndicationData DiseaseIndicationData { get; set; }

        //  public virtual RegimenMaster RegimenMaster { get; set; }

        public int PharmaClassId { get; set; }
        public virtual PharmaClassMaster PharmaClassMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MoleculeRegimenMapping> MoleculeRegimenMapping { get; set; }
    }
}
