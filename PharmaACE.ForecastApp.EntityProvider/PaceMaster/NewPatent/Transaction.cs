namespace PharmaACE.ForecastApp.EntityProvider.pacemaster.n
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Inline.Transaction")]
    public partial class Transaction
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Transaction()
        {
            APIInformations = new HashSet<APIInformation>();
            GenericAvailabilities = new HashSet<GenericAvailability>();
            PatentInfoes = new HashSet<PatentInfo>();
            SalesInformations = new HashSet<SalesInformation>();
        }

        public int Id { get; set; }

        public int ProductCodeId { get; set; }

        public int ProductTypeId { get; set; }

        public int ProductCategoryId { get; set; }

        public int FormId { get; set; }

        public int ROAId { get; set; }

        public int? ProductId { get; set; }

        public int CompanyId { get; set; }

        public int MoleculeId { get; set; }

        public int NADACPricingUnitId { get; set; }

        public int PriceSourceId { get; set; }

        public string ApplicationShortNumber { get; set; }

        public string ProductUID { get; set; }

        [StringLength(50)]
        public string ProductNDC { get; set; }

        public string Strength { get; set; }

        [StringLength(30)]
        public string NADAC_Price { get; set; }

        public string MOA { get; set; }

        [Column(TypeName = "date")]
        public DateTime ApprovalDate { get; set; }

        [Column(TypeName = "date")]
        public DateTime StartMarketingDate { get; set; }

        public int SubstanceId { get; set; }

        [Required]
        public string DosageAdult { get; set; }

        [Required]
        public string DosagePediatric { get; set; }

        [Required]
        public string CodeAndNDC { get; set; }

        [Required]
        public string SubIndication { get; set; }

        [Required]
        public string DrugType { get; set; }

        public int? MarketingStatus { get; set; }

        public int? MarketingCompanyId { get; set; }

        public DateTime? LatestLabelDate { get; set; }

        public bool? RLD { get; set; }

        [StringLength(50)]
        public string TECode { get; set; }

        public virtual CompanyMaster CompanyMaster { get; set; }

        public virtual CompanyMaster CompanyMaster1 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<APIInformation> APIInformations { get; set; }

        public virtual ExclusivityInfo ExclusivityInfo { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericAvailability> GenericAvailabilities { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PatentInfo> PatentInfoes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SalesInformation> SalesInformations { get; set; }

        public virtual Transaction Transaction1 { get; set; }

        public virtual Transaction Transaction2 { get; set; }
    }
}
