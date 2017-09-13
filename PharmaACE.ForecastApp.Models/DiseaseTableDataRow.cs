using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{

    public class TreatmentDetails
    {
        public int IndicationId { get; set; }

        public List<DiseaseTableDataRow> DiseasedtRow { get; set; }
}


    public class DiseaseTableDataRow
    {
     //   public int IndicationId { get; set; }

        [Display(Name = "Treatment Regimens")]
        public string TreatmentRegimens { get; set; }

        [Display(Name = "Class Summary")]
        public string ClassSummary { get; set; }

        [Display(Name = "Approved Molecules")]
        public List<MoleculeApproval> ApprovedMolecules { get; set; }
    }

    public class MoleculeApproval
    {
        public string Molecule { get; set; }
        public bool IsApproved { get; set; }
    }
}
