using System.Collections.Generic;
namespace PharmaACE.ForecastApp.Models
{
    public class DiseaseDetails
    {
        public DiseaseInfo diseaseDetails { get; set; }

        public DiseaseIndicationInfo diseaseIndicationInfo { get; set; }
        public List<DiseaseTableDataRow> diseaseTableData { get; set; }

        public List<regimenDetail> regimens { get; set; }

        public List<moleculeDetails> molecules { get; set; }

        public List<treatmentDetailsForPopupid> alreadyExistTreatment { get; set; }

        public List<treatmentDetailsForPopup> ExistTreatmentListData { get; set; }

    }
    public class regimenDetail
    {
        public int regId { get; set; }

        public string treatmentRegimen { get; set; }


    }
    public class moleculeDetails
    {
        public int moleculeId { get; set; }

        public string moleculeName { get; set; }


    }

    public class  treatmentDetailsForPopup
    {
        public int treatRegId { get; set;}
        public string treatmentRegimen { get; set; }

        public string classSummary { get; set; }

        public List<string> moleculeNames { get; set; } 

        public int isNewlyAdded { get; set; }


    }

    public class treatmentDetailsForPopupid
    {
        public int RegId { get; set; }

        public string classSummary { get; set; }

        public List<int> MolIds { get; set; }


    }

    public class NewRefernce
    {
        public string reference { get; set; }

    }



}