namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Inline.Transaction")]
    public partial class InlineTransaction
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public InlineTransaction()
        {
            DiseaseAreaMapping = new HashSet<DiseaseAreaMapping>();
            MoleculeMapping = new HashSet<InlineMoleculeMapping>();
            IndicationMapping = new HashSet<IndicationMapping>();
            PharmaClassMapping = new HashSet<PharmaClassMapping>();
             DiseaseAreaMaster = new HashSet<DiseaseAreaMaster>();
            MoleculeMaster1 = new HashSet<MoleculeMaster>();

            ////////////////////////////////////////////////////////////

            APIInformations = new HashSet<APIInformation>();
            GenericAvailabilities = new HashSet<GenericAvailability>();
            PatentInfoes = new HashSet<PatentInfo>();
            SalesInformations = new HashSet<SalesInformation>();

            ExclusivityInfo = new HashSet<ExclusivityInfo>();



        }

        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        // [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }

        public int? ProductCodeId { get; set; }

        public int? ProductTypeId { get; set; }

        public int? ProductCategoryId { get; set; }

        public int? FormId { get; set; }

        public int? ROAId { get; set; }

        public int? ProductId { get; set; }

        public int? CompanyId { get; set; }

        public int? MoleculeId { get; set; }

        public int? NADACPricingUnitId { get; set; }

        public int? PriceSourceId { get; set; }

        public string ApplicationShortNumber { get; set; }

        public string ProductUID { get; set; }

        [StringLength(50)]
        public string ProductNDC { get; set; }

        public string Strength { get; set; }

        [StringLength(30)]
        public string NADAC_Price { get; set; }

        public string MOA { get; set; }

        [Column(TypeName = "date")]
        public DateTime? ApprovalDate { get; set; }

       
        [Column(TypeName = "date")]
        public DateTime? StartMarketingDate { get; set; }

        
        public int? SubstanceId { get; set; }

        public string DosageAdult { get; set; }

        public string DosagePediatric { get; set; }

        public string CodeAndNDC { get; set; }

        public string SubIndication { get; set; }

        [StringLength(50)]
        public string DrugType { get; set; }


        public int? MarketingStatus { get; set; }

        public int? MarketingCompanyId { get; set; }

        public DateTime? LatestLabelDate { get; set; }

        public bool? RLD { get; set; }

        [StringLength(50)]
        public string TECode { get; set; }







        public virtual CompanyMaster CompanyMaster { get; set; }

        public virtual CompanyMaster CompanyMaster1 { get; set; }

        public virtual FormMaster FormMaster { get; set; }

        public virtual MoleculeMaster MoleculeMaster { get; set; }

        public virtual NADAC_PricingUnitMaster NADAC_PricingUnitMaster { get; set; }

        public virtual PriceSourceMaster PriceSourceMaster { get; set; }

        public virtual ProductCategoryMaster ProductCategoryMaster { get; set; }

        public virtual ProductCodeMaster ProductCodeMaster { get; set; }

        public virtual ProductMaster ProductMaster { get; set; }

        public virtual ProductTypeMaster ProductTypeMaster { get; set; }

        public virtual ROA_Master ROA_Master { get; set; }

 public virtual SubstanceMaster SubstanceMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DiseaseAreaMapping> DiseaseAreaMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<InlineMoleculeMapping> MoleculeMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IndicationMapping> IndicationMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PharmaClassMapping> PharmaClassMapping { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DiseaseAreaMaster> DiseaseAreaMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MoleculeMaster> MoleculeMaster1 { get; set; }


        public virtual ICollection<APIInformation> APIInformations { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ExclusivityInfo> ExclusivityInfo { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GenericAvailability> GenericAvailabilities { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PatentInfo> PatentInfoes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SalesInformation> SalesInformations { get; set; }


        //public virtual Transaction Transaction1 { get; set; }

        //public virtual Transaction Transaction2 { get; set; }
    }
}
