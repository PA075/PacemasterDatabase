using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{

    public class PatentData
    {
        public PatentGenericAvailability generic { get; set; }
        public SaleINfo saleInfo { get; set; }
        public List<ExclusivityData> exclusivity { get; set; }
        
        public List<APIINfo> apiInfoList { get; set; }
        public List<PatentInfoData> piData { get; set; }
    }


  public  class PatentGenericAvailability
    {
        public int Id { get; set; }
        public int CompanyId { get; set; }
        public int InlineTrasnactionId { get; set; }       
        public int GenericAvailability { get; set; }
        public DateTime? FTFfilingDate { get; set; }
        public DateTime? FTFApprovalDate { get; set; }
        public DateTime? FTFLaunchDate { get; set; }

        public List<string> FTFHolders { get; set; }
        public List<string> GenericPlayers { get; set; }
        public List<string> AuthorisedGenerics { get; set; }

    }

    public class APIINfo
    {
        public int Id { get; set; }
        public int InlineTrasnactionId { get; set; }
        public int DMFStatus { get; set; }

        public bool ANDAHolder { get; set; }
        public bool OrganizationFinishedProducts { get; set; }
        public DateTime? SubmissionDate { get; set; }
        public string DMFHolders { get; set; }
        
    }

    //class SaleINfo
    //{     
    //    public DateTime? CurrentYear { get; set; }
    //    public DateTime? PrevYear { get; set; }
    //    public double Change { get; set; }

    //}

   public class SaleINfo
    {
        public decimal? CurrentYear { get; set; }
        public decimal? PrevYear { get; set; }
        public decimal? Change { get; set; }

    }

    public class PatentInfoData
    {
        public string PatentNo { get; set; }
        public string TypeOfPatent { get; set; }
        public string PatentUseCode { get; set; }
        public DateTime? ExpiryDate { get; set; }
        public bool PTEGranted { get; set; }
        public string IndependentClaims { get; set; }

        public bool? DelistRequested { get; set; }

        public string PatentLicensingInfo { get; set; }

    }

    public class ExclusivityData
    {
        public int exclusivityId { get; set; }

        public string Exclusivity { get; set; }

        public DateTime? Expiry { get; set; }

        public string Description { get; set; }

    }
}
