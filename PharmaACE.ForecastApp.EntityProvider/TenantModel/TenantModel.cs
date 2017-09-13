namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class TenantModel : DbContext
    {
        public TenantModel()
            : base("name=TenantModel")
        {
        }

        public virtual DbSet<ActharAssumptionAttachmentMapping> ActharAssumptionAttachmentMapping { get; set; }
        public virtual DbSet<ActharAssumptions> ActharAssumptions { get; set; }
        public virtual DbSet<BDLAssumptionAttachmentMapping> BDLAssumptionAttachmentMapping { get; set; }
        public virtual DbSet<BDLAssumptions> BDLAssumptions { get; set; }
        public virtual DbSet<BDLCountryMaster> BDLCountryMaster { get; set; }
        public virtual DbSet<BDLIndicationReference> BDLIndicationReference { get; set; }
        public virtual DbSet<BDLParameterMaster> BDLParameterMaster { get; set; }
        public virtual DbSet<BDLProductDetails> BDLProductDetails { get; set; }
        public virtual DbSet<BDLProductMaster> BDLProductMaster { get; set; }
        public virtual DbSet<BDLProjectDetails> BDLProjectDetails { get; set; }
        public virtual DbSet<BDLProjectMaster> BDLProjectMaster { get; set; }
        public virtual DbSet<BDLProjectVersion> BDLProjectVersion { get; set; }
        public virtual DbSet<BDLProjectVersionProduct> BDLProjectVersionProduct { get; set; }
        public virtual DbSet<BDLScenarioMaster> BDLScenarioMaster { get; set; }
        public virtual DbSet<BDLSectionMaster> BDLSectionMaster { get; set; }
        public virtual DbSet<BDLSectionDetails> BDLSectionDetails { get; set; }
        public virtual DbSet<BDLSegmentLevelMaster> BDLSegmentLevelMaster { get; set; }
        public virtual DbSet<BDLSegmentMaster> BDLSegmentMaster { get; set; }
        public virtual DbSet<BDLSource> BDLSource { get; set; }
        public virtual DbSet<BDLUserForecastMapping> BDLUserForecastMapping { get; set; }
        public virtual DbSet<BDLUserForecastSectionMapping> BDLUserForecastSectionMapping { get; set; }
        public virtual DbSet<AttachamentMaster> AttachamentMaster { get; set; }
        public virtual DbSet<FeedItemMapping> FeedItemMapping { get; set; }
        public virtual DbSet<FeedItemMaster> FeedItemMaster { get; set; }
        public virtual DbSet<FeedSettingMaster> FeedSettingMaster { get; set; }
        public virtual DbSet<FeedSourceMaster> FeedSourceMaster { get; set; }
        public virtual DbSet<FeedUserMaster> FeedUserMaster { get; set; }
        public virtual DbSet<ReportMaster> ReportMaster { get; set; }
        public virtual DbSet<GenericAssumptionAttachmentMapping> GenericAssumptionAttachmentMapping { get; set; }
        public virtual DbSet<GenericAssumptions> GenericAssumptions { get; set; }
        public virtual DbSet<GenericCompetitorMaster> GenericCompetitorMaster { get; set; }
        public virtual DbSet<GenericEvent> GenericEvent { get; set; }
        public virtual DbSet<GenericForecastData> GenericForecastData { get; set; }
        public virtual DbSet<GenericHistoricalData> GenericHistoricalData { get; set; }
        public virtual DbSet<GenericPackInfo> GenericPackInfo { get; set; }
        public virtual DbSet<GenericPackMaster> GenericPackMaster { get; set; }
        public virtual DbSet<GenericParameterMaster> GenericParameterMaster { get; set; }
        public virtual DbSet<GenericPenetrationTypeData> GenericPenetrationTypeData { get; set; }
        public virtual DbSet<GenericProductDetails> GenericProductDetails { get; set; }
        public virtual DbSet<GenericProductMaster> GenericProductMaster { get; set; }
        public virtual DbSet<GenericProjectMaster> GenericProjectMaster { get; set; }
        public virtual DbSet<GenericProjectVersion> GenericProjectVersion { get; set; }
        public virtual DbSet<GenericProjectVersionDetails> GenericProjectVersionDetails { get; set; }
        public virtual DbSet<GenericProjectVersionProduct> GenericProjectVersionProduct { get; set; }
        public virtual DbSet<GenericScenarioDetails> GenericScenarioDetails { get; set; }
        public virtual DbSet<GenericScenarioMaster> GenericScenarioMaster { get; set; }
        public virtual DbSet<GenericSectionMaster> GenericSectionMaster { get; set; }
        public virtual DbSet<GenericSKU_Details> GenericSKU_Details { get; set; }
        public virtual DbSet<GenericSKU_Master> GenericSKU_Master { get; set; }
        public virtual DbSet<GenericUserForecastMapping> GenericUserForecastMapping { get; set; }
        public virtual DbSet<ActharForecastData> ActharForecastData { get; set; }
        public virtual DbSet<ForecastDataVersions> ForecastDataVersions { get; set; }
        public virtual DbSet<ActharHistoricalData> ActharHistoricalData { get; set; }
        public virtual DbSet<ActharHistoricalDataVersions> ActharHistoricalDataVersions { get; set; }
        public virtual DbSet<ActharIndicationMaster> ActharIndicationMaster { get; set; }
        public virtual DbSet<ActharProjectMaster> ActharProjectMaster { get; set; }
        public virtual DbSet<ActharProjectVersion> ActharProjectVersion { get; set; }
        public virtual DbSet<ActharSubGroupMaster> ActharSubGroupMaster { get; set; }
        public virtual DbSet<ActharTotalData> ActharTotalData { get; set; }
        public virtual DbSet<ActharUserForecastMapping> ActharUserForecastMapping { get; set; }
        public virtual DbSet<BDLAdvancedPricing> BDLAdvancedPricing { get; set; }
        public virtual DbSet<BDLConversionData> BDLConversionData { get; set; }
        public virtual DbSet<BDLEPI_Data> BDLEPI_Data { get; set; }
        public virtual DbSet<BDLEvent> BDLEvent { get; set; }
        public virtual DbSet<BDLHistoricalData> BDLHistoricalData { get; set; }
        public virtual DbSet<MasterSendEmail> MasterSendEmail { get; set; }
        public virtual DbSet<BDLOutputData> BDLOutputData { get; set; }
        public virtual DbSet<BDLParameterSelectionType> BDLParameterSelectionType { get; set; }
        public virtual DbSet<BDLSegmentDetails> BDLSegmentDetails { get; set; }
        public virtual DbSet<BDLSegmentDetailsData> BDLSegmentDetailsData { get; set; }
        public virtual DbSet<BDLSegmentVersion> BDLSegmentVersion { get; set; }
        public virtual DbSet<BDLShare> BDLShare { get; set; }
        public virtual DbSet<BDLSourceData> BDLSourceData { get; set; }
        public virtual DbSet<UserMaster> UserMaster { get; set; }
        public virtual DbSet<DashboardMaster> DashboardMaster { get; set; }
        public virtual DbSet<DashboardUserMapping> DashboardUserMapping { get; set; }
        public virtual DbSet<DivisionProductMaster> DivisionProductMaster { get; set; }
        public virtual DbSet<ReportConfigurationMaster> ReportConfigurationMaster { get; set; }
        public virtual DbSet<ReportDashboardMapping> ReportDashboardMapping { get; set; }
        public virtual DbSet<ReportUserMapping> ReportUserMapping { get; set; }
        public virtual DbSet<TenantUserNotifications> UserNotifications { get; set; }
        public virtual DbSet<GenericCompetitorDetails> GenericCompetitorDetails { get; set; }
        public virtual DbSet<GenericNPA_Data> GenericNPA_Data { get; set; }
        public virtual DbSet<GenericNSP_Data> GenericNSP_Data { get; set; }
        public virtual DbSet<GenericRepackagers> GenericRepackagers { get; set; }
        public virtual DbSet<BDLForecastFlatFileMaster> BDLForecastFlatFileMaster { get; set; }
        public virtual DbSet<BDLForecastTemplateMaster> BDLForecastTemplateMaster { get; set; }
        public virtual DbSet<GenericForecastTemplateMaster> GenericForecastTemplateMaster { get; set; }
        public virtual DbSet<GenericForecastFlatFileMaster> GenericForecastFlatFileMaster { get; set; }

        public virtual DbSet<FilteredNews> FilteredNews { get; set; }


        //public virtual DbSet<ObjectMaster> ObjectMaster { get; set; }
        //public virtual DbSet<ObjectUserMapping> ObjectUserMapping { get; set; }
        //public virtual DbSet<ObjUserPermission> ObjUserPermission { get; set; }
        //public virtual DbSet<StageMaster> StageMaster { get; set; }
        //public virtual DbSet<DealDetail> DealDetails { get; set; }
        //public virtual DbSet<ActivityMaster> ActivityMasters { get; set; }




        public virtual DbSet<ProjectFolderList> ProjectFolderList { get; set; }

        public virtual DbSet<ActivityDetailsMaster> ActivityDetailsMaster { get; set; }
        public virtual DbSet<ActivityMaster> ActivityMasters { get; set; }
        public virtual DbSet<DealDetail> DealDetails { get; set; }
        public virtual DbSet<ObjectMaster> ObjectMaster { get; set; }
        public virtual DbSet<ObjectUserMapping> ObjectUserMapping { get; set; }
        public virtual DbSet<ObjUserPermission> ObjUserPermission { get; set; }
        public virtual DbSet<StageMaster> StageMaster { get; set; }



        //public virtual DbSet<ActivityDetailMaster> ActivityDetailMaster { get; set; }
        //public virtual DbSet<ActivityMaster> ActivityMaster { get; set; }
        //public virtual DbSet<DealDetail> DealDetail { get; set; }
        //public virtual DbSet<ObjectMaster> ObjectMaster { get; set; }
        //public virtual DbSet<ObjectUserMapping> ObjectUserMapping { get; set; }
        //public virtual DbSet<ObjUserPermission> ObjUserPermission { get; set; }
        //public virtual DbSet<StageMaster> StageMaster { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<FilteredNews>()
                .Property(e => e.RemovedLink)
                .IsUnicode(false);

            modelBuilder.Entity<GenericForecastTemplateMaster>()
               .HasMany(e => e.GenericForecastFlatFileMaster)
               .WithRequired(e => e.GenericForecastTemplateMaster)
               .HasForeignKey(e => e.TemplateID)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLForecastTemplateMaster>()
               .HasMany(e => e.BDLForecastFlatFileMaster)
               .WithRequired(e => e.BDLForecastTemplateMaster)
               .HasForeignKey(e => e.TemplateID)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<ActharAssumptions>()
                .Property(e => e.PROJECT)
                .IsUnicode(false);

            modelBuilder.Entity<ActharAssumptions>()
                .Property(e => e.VERSION)
                .IsUnicode(false);

            modelBuilder.Entity<ActharAssumptions>()
                .Property(e => e.DESCRIPTION)
                .IsUnicode(false);

            modelBuilder.Entity<ActharAssumptions>()
                .HasMany(e => e.AssumptionAttachmentMapping)
                .WithRequired(e => e.Assumptions)
                .HasForeignKey(e => e.AssumptionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLAssumptions>()
                .Property(e => e.PROJECT)
                .IsUnicode(false);

            modelBuilder.Entity<BDLAssumptions>()
                .Property(e => e.VERSION)
                .IsUnicode(false);

            modelBuilder.Entity<BDLAssumptions>()
                .Property(e => e.DESCRIPTION)
                .IsUnicode(false);

            modelBuilder.Entity<BDLAssumptions>()
                .HasMany(e => e.AssumptionAttachmentMapping)
                .WithRequired(e => e.Assumptions)
                .HasForeignKey(e => e.AssumptionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLCountryMaster>()
                .Property(e => e.Country)
                .IsUnicode(false);

            modelBuilder.Entity<BDLCountryMaster>()
                .HasMany(e => e.AdvancedPricing)
                .WithRequired(e => e.CountryMaster)
                .HasForeignKey(e => e.CountryId);

            modelBuilder.Entity<BDLCountryMaster>()
                .HasMany(e => e.ConversionData)
                .WithRequired(e => e.CountryMaster)
                .HasForeignKey(e => e.CountryId);

            modelBuilder.Entity<BDLCountryMaster>()
                .HasMany(e => e.EPI_Data)
                .WithRequired(e => e.CountryMaster)
                .HasForeignKey(e => e.CountryId);

            modelBuilder.Entity<BDLCountryMaster>()
                .HasMany(e => e.Event)
                .WithRequired(e => e.CountryMaster)
                .HasForeignKey(e => e.CountryId);

            modelBuilder.Entity<BDLCountryMaster>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.CountryMaster)
                .HasForeignKey(e => e.CountryId);

            modelBuilder.Entity<BDLCountryMaster>()
                .HasMany(e => e.OutputData)
                .WithRequired(e => e.CountryMaster)
                .HasForeignKey(e => e.CountryId);

            modelBuilder.Entity<BDLCountryMaster>()
                .HasMany(e => e.ParameterSelectionType)
                .WithRequired(e => e.CountryMaster)
                .HasForeignKey(e => e.CountryId);

            modelBuilder.Entity<BDLCountryMaster>()
                .HasMany(e => e.Share)
                .WithRequired(e => e.CountryMaster)
                .HasForeignKey(e => e.CountryId);

            modelBuilder.Entity<BDLCountryMaster>()
                .HasMany(e => e.Source)
                .WithRequired(e => e.CountryMaster)
                .HasForeignKey(e => e.CountryId);

            modelBuilder.Entity<BDLParameterMaster>()
                .Property(e => e.Parameter)
                .IsUnicode(false);

            modelBuilder.Entity<BDLParameterMaster>()
                .HasMany(e => e.AdvancedPricing)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterId);

            modelBuilder.Entity<BDLParameterMaster>()
                .HasMany(e => e.ConversionData)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterId);

            modelBuilder.Entity<BDLParameterMaster>()
                .HasMany(e => e.EPI_Data)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterId);

            modelBuilder.Entity<BDLParameterMaster>()
                .HasMany(e => e.Event)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterId);

            modelBuilder.Entity<BDLParameterMaster>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterId);

            modelBuilder.Entity<BDLParameterMaster>()
                .HasMany(e => e.OutputData)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterId);

            modelBuilder.Entity<BDLParameterMaster>()
                .HasMany(e => e.ParameterSelectionType)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterId);

            modelBuilder.Entity<BDLParameterMaster>()
                .HasMany(e => e.Share)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterId);

            modelBuilder.Entity<BDLParameterMaster>()
                .HasMany(e => e.Source)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterId);

            modelBuilder.Entity<BDLProductMaster>()
                .HasMany(e => e.ProductDetails)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProductMaster>()
                .HasMany(e => e.AdvancedPricing)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProductMaster>()
                .HasMany(e => e.ConversionData)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProductMaster>()
                .HasMany(e => e.Event)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProductMaster>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProductMaster>()
                .HasMany(e => e.OutputData)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProductMaster>()
                .HasMany(e => e.Share)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProductMaster>()
                .HasMany(e => e.Source)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectDetails>()
                .HasMany(e => e.ProjectVersion)
                .WithRequired(e => e.ProjectDetails)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectMaster>()
                .HasMany(e => e.ProjectVersion)
                .WithRequired(e => e.ProjectMaster)
                .HasForeignKey(e => e.ProjectId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersion>()
                .Property(e => e.VersionLabel)
                .IsUnicode(false);

            modelBuilder.Entity<BDLProjectVersion>()
                .HasMany(e => e.EPI_Data)
                .WithRequired(e => e.ProjectVersion)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersion>()
                .HasMany(e => e.ParameterSelectionType)
                .WithRequired(e => e.ProjectVersion)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersion>()
                .HasMany(e => e.ProjectVersionProduct)
                .WithRequired(e => e.ProjectVersion)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersion>()
                .HasMany(e => e.ScenarioDetails)
                .WithRequired(e => e.ProjectVersion)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersion>()
                .HasMany(e => e.SegmentDetailsData)
                .WithRequired(e => e.ProjectVersion)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersion>()
                .HasMany(e => e.SegmentVersion)
                .WithRequired(e => e.ProjectVersion)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersionProduct>()
                .HasMany(e => e.AdvancedPricing)
                .WithRequired(e => e.ProjectVersionProduct)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersionProduct>()
                .HasMany(e => e.ConversionData)
                .WithRequired(e => e.ProjectVersionProduct)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersionProduct>()
                .HasMany(e => e.Event)
                .WithRequired(e => e.ProjectVersionProduct)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersionProduct>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.ProjectVersionProduct)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersionProduct>()
                .HasMany(e => e.OutputData)
                .WithRequired(e => e.ProjectVersionProduct)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersionProduct>()
                .HasMany(e => e.Share)
                .WithRequired(e => e.ProjectVersionProduct)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLProjectVersionProduct>()
                .HasMany(e => e.SourceData)
                .WithRequired(e => e.ProjectVersionProduct)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLScenarioMaster>()
                .HasMany(e => e.ScenarioDetails)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLScenarioMaster>()
                .HasMany(e => e.AdvancedPricing)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLScenarioMaster>()
                .HasMany(e => e.ConversionData)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLScenarioMaster>()
                .HasMany(e => e.EPI_Data)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLScenarioMaster>()
                .HasMany(e => e.Event)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLScenarioMaster>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLScenarioMaster>()
                .HasMany(e => e.OutputData)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLScenarioMaster>()
                .HasMany(e => e.ParameterSelectionType)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLScenarioMaster>()
                .HasMany(e => e.Share)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLScenarioMaster>()
                .HasMany(e => e.Source)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLSectionMaster>()
                .Property(e => e.SectionName)
                .IsUnicode(false);

            modelBuilder.Entity<BDLSectionMaster>()
                .HasMany(e => e.IndicationReference)
                .WithRequired(e => e.SectionMaster)
                .HasForeignKey(e => e.SectionId);

            modelBuilder.Entity<BDLSectionMaster>()
                .HasMany(e => e.SectionDetails)
                .WithRequired(e => e.SectionMaster)
                .HasForeignKey(e => e.SectionID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLSegmentMaster>()
                .HasMany(e => e.AdvancedPricing)
                .WithRequired(e => e.SegmentMaster)
                .HasForeignKey(e => e.SegmentId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLSegmentMaster>()
                .HasMany(e => e.ConversionData)
                .WithRequired(e => e.SegmentMaster)
                .HasForeignKey(e => e.SegmentId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLSegmentMaster>()
                .HasMany(e => e.Event)
                .WithRequired(e => e.SegmentMaster)
                .HasForeignKey(e => e.SegmentId);

            modelBuilder.Entity<BDLSegmentMaster>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.SegmentMaster)
                .HasForeignKey(e => e.SegmentId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLSegmentMaster>()
                .HasMany(e => e.OutputData)
                .WithRequired(e => e.SegmentMaster)
                .HasForeignKey(e => e.SegmentId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLSegmentMaster>()
                .HasMany(e => e.Share)
                .WithRequired(e => e.SegmentMaster)
                .HasForeignKey(e => e.SegmentId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLSegmentMaster>()
                .HasMany(e => e.Source)
                .WithRequired(e => e.SegmentMaster)
                .HasForeignKey(e => e.SegmentId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLSource>()
                .HasMany(e => e.SourceData)
                .WithRequired(e => e.Source)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<BDLUserForecastMapping>()
                .Property(e => e.ProjectName)
                .IsUnicode(false);

            modelBuilder.Entity<BDLUserForecastMapping>()
                .Property(e => e.Version)
                .IsUnicode(false);

            modelBuilder.Entity<BDLUserForecastMapping>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<BDLUserForecastMapping>()
                .HasMany(e => e.BDLUserForecastSectionMapping)
                .WithRequired(e => e.UserForecastMapping)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<AttachamentMaster>()
                .HasMany(e => e.ActharAssumptionAttachmentMapping)
                .WithRequired(e => e.AttachamentMaster)
                .HasForeignKey(e => e.AttachmentId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<AttachamentMaster>()
                .HasMany(e => e.BDLAssumptionAttachmentMapping)
                .WithRequired(e => e.AttachamentMaster)
                .HasForeignKey(e => e.AttachmentId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<AttachamentMaster>()
                .HasMany(e => e.GenericAssumptionAttachmentMapping)
                .WithRequired(e => e.AttachamentMaster)
                .HasForeignKey(e => e.AttachmentId)
                .WillCascadeOnDelete(false);

            //modelBuilder.Entity<UserMaster1>()
            //    .Property(e => e.FirstName)
            //    .IsUnicode(false);

            //modelBuilder.Entity<UserMaster1>()
            //    .Property(e => e.LastName)
            //    .IsUnicode(false);

            //modelBuilder.Entity<UserMaster1>()
            //    .Property(e => e.UserEmail)
            //    .IsUnicode(false);

            //modelBuilder.Entity<UserMaster1>()
            //    .Property(e => e.SP_Account)
            //    .IsUnicode(false);

            modelBuilder.Entity<GenericAssumptions>()
                .Property(e => e.PROJECT)
                .IsUnicode(false);

            modelBuilder.Entity<GenericAssumptions>()
                .Property(e => e.VERSION)
                .IsUnicode(false);

            modelBuilder.Entity<GenericAssumptions>()
                .Property(e => e.DESCRIPTION)
                .IsUnicode(false);

            modelBuilder.Entity<GenericAssumptions>()
                .HasMany(e => e.AssumptionAttachmentMapping)
                .WithRequired(e => e.Assumptions)
                .HasForeignKey(e => e.AssumptionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericCompetitorMaster>()
                .HasMany(e => e.CompetitorDetails)
                .WithRequired(e => e.CompetitorMaster)
                .HasForeignKey(e => e.CompetitorID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericCompetitorMaster>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.CompetitorMaster)
                .HasForeignKey(e => e.CompetitorID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericEvent>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<GenericEvent>()
                .Property(e => e.UptakeCurve)
                .HasPrecision(10, 8);

            modelBuilder.Entity<GenericEvent>()
                .Property(e => e.StartShare)
                .HasPrecision(10, 8);

            modelBuilder.Entity<GenericEvent>()
                .Property(e => e.PeakShare)
                .HasPrecision(10, 8);

            modelBuilder.Entity<GenericForecastData>()
                .Property(e => e.ForecastValue)
                .HasPrecision(20, 8);

            modelBuilder.Entity<GenericForecastData>()
                .HasMany(e => e.ProjectVersion)
                .WithMany(e => e.ForecastData)
                .Map(m => m.ToTable("ForecastDataVersions", "Generic").MapLeftKey("ForecastDataID").MapRightKey("ProjectVersionID"));

            modelBuilder.Entity<GenericHistoricalData>()
                .Property(e => e.HistoricalValue)
                .HasPrecision(20, 5);

            modelBuilder.Entity<GenericHistoricalData>()
                .HasMany(e => e.ProjectVersion)
                .WithMany(e => e.HistoricalData)
                .Map(m => m.ToTable("HistoricalDataVersions", "Generic").MapLeftKey("HistoricalDataID").MapRightKey("Version"));

            modelBuilder.Entity<GenericPackInfo>()
                .Property(e => e.PackValue)
                .HasPrecision(20, 5);

            //modelBuilder.Entity<GenericPackInfo>()
            //    .HasMany(e => e.PackDataVersions)
            //    .WithRequired(e => e.PackInfo)
            //    .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericPackMaster>()
                .HasMany(e => e.PackInfo)
                .WithRequired(e => e.PackMaster)
                .HasForeignKey(e => e.PackID)
                .WillCascadeOnDelete(false);

            //modelBuilder.Entity<GenericPackMaster>()
            //    .HasMany(e => e.PackDataVersions)
            //    .WithRequired(e => e.PackMaster)
            //    .HasForeignKey(e => e.PackInfoID)
            //    .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericParameterMaster>()
                .HasMany(e => e.ForecastData)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericParameterMaster>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericParameterMaster>()
                .HasMany(e => e.PackInfo)
                .WithRequired(e => e.ParameterMaster)
                .HasForeignKey(e => e.ParameterID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericPenetrationTypeData>()
                .Property(e => e.PenetrationValue)
                .HasPrecision(20, 5);

            modelBuilder.Entity<GenericPenetrationTypeData>()
                .HasMany(e => e.ProjectVersion)
                .WithMany(e => e.PenetrationTypeData)
                .Map(m => m.ToTable("PenetrationTypeDataVersions", "Generic").MapLeftKey("PenetrationDataID").MapRightKey("ProjectVersionID"));

            modelBuilder.Entity<GenericProductDetails>()
                .HasMany(e => e.ProjectVersionProduct)
                .WithRequired(e => e.ProductDetails)
                .HasForeignKey(e => e.ProductDetailsID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProductMaster>()
                .HasMany(e => e.ForecastData)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProductMaster>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProductMaster>()
                .HasMany(e => e.PackInfo)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProductMaster>()
                .HasMany(e => e.PenetrationTypeData)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProductMaster>()
                .HasMany(e => e.ProjectVersionProduct)
                .WithRequired(e => e.ProductMaster)
                .HasForeignKey(e => e.ProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProjectMaster>()
                .HasMany(e => e.ProjectVersion)
                .WithRequired(e => e.ProjectMaster)
                .HasForeignKey(e => e.ProjectID)
                .WillCascadeOnDelete(false);

            //modelBuilder.Entity<GenericProjectVersion>()
            //    .HasMany(e => e.PackDataVersions)
            //    .WithRequired(e => e.ProjectVersion)
            //    .HasForeignKey(e => e.ProjectVersionID)
            //    .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProjectVersion>()
                .HasMany(e => e.ProjectVersionProduct)
                .WithRequired(e => e.ProjectVersion)
                .HasForeignKey(e => e.ProjectVersionID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProjectVersion>()
                .HasMany(e => e.ScenarioDetails)
                .WithRequired(e => e.ProjectVersion)
                .HasForeignKey(e => e.ProjectVersionID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProjectVersionDetails>()
                .HasMany(e => e.ProjectVersion)
                .WithRequired(e => e.ProjectVersionDetails)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProjectVersionProduct>()
                .HasMany(e => e.Events)
                .WithRequired(e => e.ProjectVersionProduct)
                .HasForeignKey(e => e.ProjectVersionProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProjectVersionProduct>()
                .HasMany(e => e.ForecastData)
                .WithRequired(e => e.ProjectVersionProduct)
                .HasForeignKey(e => e.ProjectVersionProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProjectVersionProduct>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.ProjectVersionProduct)
                .HasForeignKey(e => e.ProjectVersionProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProjectVersionProduct>()
                .HasMany(e => e.PackInfo)
                .WithRequired(e => e.ProjectVersionProduct)
                .HasForeignKey(e => e.ProjectVersionProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProjectVersionProduct>()
                .HasMany(e => e.PenetrationTypeData)
                .WithRequired(e => e.ProjectVersionProduct)
                .HasForeignKey(e => e.ProjectVersionProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProjectVersionProduct>()
                .HasMany(e => e.CompetitorDetails)
                .WithRequired(e => e.ProjectVersionProduct)
                .HasForeignKey(e => e.ProjectVersionProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericProjectVersionProduct>()
                .HasMany(e => e.SKU_Details)
                .WithRequired(e => e.ProjectVersionProduct)
                .HasForeignKey(e => e.ProjectVersionProductID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericScenarioMaster>()
                .HasMany(e => e.Events)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericScenarioMaster>()
                .HasMany(e => e.ForecastData)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericScenarioMaster>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericScenarioMaster>()
                .HasMany(e => e.PackInfo)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericScenarioMaster>()
                .HasMany(e => e.PenetrationTypeData)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericScenarioMaster>()
                .HasMany(e => e.ScenarioDetails)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericScenarioMaster>()
                .HasMany(e => e.CompetitorDetails)
                .WithRequired(e => e.ScenarioMaster)
                .HasForeignKey(e => e.ScenarioID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericSectionMaster>()
                .Property(e => e.SectionName)
                .IsUnicode(false);

            modelBuilder.Entity<GenericSKU_Master>()
                .HasMany(e => e.Events)
                .WithRequired(e => e.SKU_Master)
                .HasForeignKey(e => e.SKU_ID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericSKU_Master>()
                .HasMany(e => e.ForecastData)
                .WithRequired(e => e.SKU_Master)
                .HasForeignKey(e => e.SKU_ID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericSKU_Master>()
                .HasMany(e => e.HistoricalData)
                .WithRequired(e => e.SKU_Master)
                .HasForeignKey(e => e.SKU_ID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericSKU_Master>()
                .HasMany(e => e.PackInfo)
                .WithRequired(e => e.SKU_Master)
                .HasForeignKey(e => e.SKU_ID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericSKU_Master>()
                .HasMany(e => e.PenetrationTypeData)
                .WithRequired(e => e.SKU_Master)
                .HasForeignKey(e => e.SKU_ID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericSKU_Master>()
                .HasMany(e => e.SKU_Details)
                .WithRequired(e => e.SKU_Master)
                .HasForeignKey(e => e.SKU_ID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericSKU_Master>()
                .HasMany(e => e.CompetitorDetails)
                .WithRequired(e => e.SKU_Master)
                .HasForeignKey(e => e.SKU_ID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericUserForecastMapping>()
                .Property(e => e.ProjectName)
                .IsUnicode(false);

            modelBuilder.Entity<GenericUserForecastMapping>()
                .Property(e => e.Version)
                .IsUnicode(false);

            modelBuilder.Entity<GenericUserForecastMapping>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<ActharForecastData>()
                .Property(e => e.ForecastValue)
                .HasPrecision(38, 18);

            modelBuilder.Entity<ActharHistoricalData>()
                .Property(e => e.HistoricalValue)
                .HasPrecision(38, 18);

            modelBuilder.Entity<ActharTotalData>()
                .Property(e => e.Value)
                .HasPrecision(38, 18);

            modelBuilder.Entity<ActharUserForecastMapping>()
                .Property(e => e.ProjectName)
                .IsUnicode(false);

            modelBuilder.Entity<ActharUserForecastMapping>()
                .Property(e => e.Version)
                .IsUnicode(false);

            modelBuilder.Entity<ActharUserForecastMapping>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<BDLAdvancedPricing>()
                .Property(e => e.StartPrice)
                .HasPrecision(22, 10);

            modelBuilder.Entity<BDLAdvancedPricing>()
                .Property(e => e.Change)
                .HasPrecision(12, 10);

            modelBuilder.Entity<BDLConversionData>()
                .Property(e => e.TransData)
                .HasPrecision(22, 10);

            modelBuilder.Entity<BDLEPI_Data>()
                .Property(e => e.TransData)
                .HasPrecision(22, 10);

            modelBuilder.Entity<BDLEvent>()
                .Property(e => e.StartShare)
                .HasPrecision(12, 10);

            modelBuilder.Entity<BDLEvent>()
                .Property(e => e.PeakShare)
                .HasPrecision(12, 10);

            modelBuilder.Entity<BDLEvent>()
                .Property(e => e.CurveType)
                .HasPrecision(12, 10);

            modelBuilder.Entity<BDLHistoricalData>()
                .Property(e => e.TransData)
                .HasPrecision(22, 10);

            modelBuilder.Entity<MasterSendEmail>()
                .Property(e => e.Report_Name)
                .IsUnicode(false);

            modelBuilder.Entity<MasterSendEmail>()
                .Property(e => e.To)
                .IsUnicode(false);

            modelBuilder.Entity<MasterSendEmail>()
                .Property(e => e.Cc)
                .IsUnicode(false);

            modelBuilder.Entity<MasterSendEmail>()
                .Property(e => e.Bcc)
                .IsUnicode(false);

            modelBuilder.Entity<MasterSendEmail>()
                .Property(e => e.Subject)
                .IsUnicode(false);

            modelBuilder.Entity<MasterSendEmail>()
                .Property(e => e.eml_prfl_nm)
                .IsUnicode(false);

            modelBuilder.Entity<MasterSendEmail>()
                .Property(e => e.body)
                .IsUnicode(false);

            modelBuilder.Entity<MasterSendEmail>()
                .Property(e => e.body_format)
                .IsUnicode(false);

            modelBuilder.Entity<BDLOutputData>()
                .Property(e => e.TransData)
                .HasPrecision(22, 10);

            modelBuilder.Entity<BDLShare>()
                .Property(e => e.StartShare)
                .HasPrecision(22, 20);

            modelBuilder.Entity<BDLShare>()
                .Property(e => e.PeakShare)
                .HasPrecision(22, 20);

            modelBuilder.Entity<BDLShare>()
                .Property(e => e.CurveType)
                .HasPrecision(12, 10);

            modelBuilder.Entity<BDLSourceData>()
                .Property(e => e.MarketShare)
                .IsUnicode(false);

            modelBuilder.Entity<BDLSourceData>()
                .Property(e => e.ShareValue)
                .HasPrecision(22, 20);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.FirstName)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.LastName)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.UserEmail)
                .IsUnicode(false);

            modelBuilder.Entity<DashboardMaster>()
                .Property(e => e.Dashboard)
                .IsUnicode(false);

            modelBuilder.Entity<DashboardMaster>()
                .HasMany(e => e.DashboardUserMapping)
                .WithRequired(e => e.DashboardMaster)
                .HasForeignKey(e => e.DashboardId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<DashboardMaster>()
                .HasMany(e => e.ReportDashboardMapping)
                .WithRequired(e => e.DashboardMaster)
                .HasForeignKey(e => e.DashboardId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ReportConfigurationMaster>()
                .Property(e => e.ConfigurationString)
                .IsUnicode(false);

            modelBuilder.Entity<ReportConfigurationMaster>()
                .HasMany(e => e.ReportMaster)
                .WithRequired(e => e.ReportConfigurationMaster)
                .HasForeignKey(e => e.ConfigurationId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ReportMaster>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<ReportMaster>()
                .HasMany(e => e.ReportDashboardMapping)
                .WithRequired(e => e.ReportMaster)
                .HasForeignKey(e => e.ReportId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ReportMaster>()
                .HasMany(e => e.ReportUserMapping)
                .WithRequired(e => e.ReportMaster)
                .HasForeignKey(e => e.ReportId)
                .WillCascadeOnDelete(false);

            //modelBuilder.Entity<UserMaster>()
            //    .HasMany(e => e.SharedByDashboardUserMapping)
            //    .WithRequired(e => e.SharedByUser)
            //    .HasForeignKey(e => e.ShareById)
            //    .WillCascadeOnDelete(false);

            //modelBuilder.Entity<UserMaster>()
            //    .HasMany(e => e.SharedWithDashboardUserMapping)
            //    .WithRequired(e => e.SharedWithUser)
            //    .HasForeignKey(e => e.ShareWithId)
            //    .WillCascadeOnDelete(false);

            //modelBuilder.Entity<UserMaster>()
            //    .HasMany(e => e.SharedByReportUserMapping)
            //    .WithRequired(e => e.SharedByUser)
            //    .HasForeignKey(e => e.ShareByID)
            //    .WillCascadeOnDelete(false);

            //modelBuilder.Entity<UserMaster>()
            //    .HasMany(e => e.SharedWithReportUserMapping)
            //    .WithRequired(e => e.SharedWithUser)
            //    .HasForeignKey(e => e.ShareWithId)
            //    .WillCascadeOnDelete(false);

            modelBuilder.Entity<UserMaster>()
                .HasMany(e => e.UserNotifications)
                .WithRequired(e => e.UserMaster)
                .HasForeignKey(e => e.UserId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<FeedItemMaster>()
               .HasMany(e => e.FeedItemMapping)
               .WithRequired(e => e.FeedItemMaster)
               .HasForeignKey(e => e.FeedItemId)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<FeedItemMaster>()
                .HasMany(e => e.FeedUserMaster)
                .WithRequired(e => e.FeedItemMaster)
                .HasForeignKey(e => e.FeedItemID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<FeedSettingMaster>()
                .HasMany(e => e.FeedItemMapping)
                .WithRequired(e => e.FeedSettingMaster)
                .HasForeignKey(e => e.FeedSettingId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<FeedSourceMaster>()
                .HasMany(e => e.FeedItemMaster)
                .WithRequired(e => e.FeedSourceMaster)
                .HasForeignKey(e => e.SourceID)
                .WillCascadeOnDelete(false);


        
            //shubhada - user workspace
            //modelBuilder.Entity<ObjectMaster>()
            //   .Property(e => e.Name)
            //   .IsUnicode(false);



            //modelBuilder.Entity<ObjectMaster>()
            //    .HasMany(e => e.ObjectUserMapping)
            //    .WithRequired(e => e.ObjectMaster)
            //    .HasForeignKey(e => e.ObjectId)
            //    .WillCascadeOnDelete(false);

            //modelBuilder.Entity<ObjectUserMapping>()
            //    .Property(e => e.Description)
            //    .IsUnicode(false);

            //modelBuilder.Entity<ObjectUserMapping>()
            //    .HasMany(e => e.ObjUserPermission)
            //    .WithRequired(e => e.ObjectUserMapping)
            //    .HasForeignKey(e => e.ObjUserId)
            //    .WillCascadeOnDelete(false);



            ////For Deal details

            //modelBuilder.Entity<ActivityMaster>()
            //   .HasMany(e => e.DealDetails)
            //   .WithRequired(e => e.ActivityMaster)
            //   .HasForeignKey(e => e.ActivityID)
            //   .WillCascadeOnDelete(false);

            //modelBuilder.Entity<ObjectMaster>()
            //    .Property(e => e.Name)
            //    .IsUnicode(false);

            //modelBuilder.Entity<ObjectMaster>()
            //    .Property(e => e.Path)
            //    .IsUnicode(false);

            //modelBuilder.Entity<ObjectMaster>()
            //    .HasMany(e => e.DealDetails)
            //    .WithRequired(e => e.ObjectMaster)
            //    .HasForeignKey(e => e.ObjectID)
            //    .WillCascadeOnDelete(false);

            //modelBuilder.Entity<StageMaster>()
            //    .HasMany(e => e.DealDetails)
            //    .WithRequired(e => e.StageMaster)
            //    .HasForeignKey(e => e.StageID)
            //    .WillCascadeOnDelete(false);

            //modelBuilder.Entity<DealDetail>()
            //    .Property(e => e.Objective)
            //    .IsUnicode(false);




            modelBuilder.Entity<ProjectFolderList>()
             .Property(e => e.Name)
             .IsUnicode(false);

            modelBuilder.Entity<ProjectFolderList>()
                .Property(e => e.Size)
                .HasPrecision(18, 0);

            modelBuilder.Entity<ProjectFolderList>()
                .Property(e => e.Path)
                .IsUnicode(false);


            //For Deal details

            modelBuilder.Entity<ActivityMaster>()
               .HasMany(e => e.DealDetails)
               .WithRequired(e => e.ActivityMaster)
               .HasForeignKey(e => e.ActivityID)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<DealDetail>()
                .Property(e => e.Objective)
                .IsUnicode(false);

            modelBuilder.Entity<ObjectMaster>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<ObjectMaster>()
                .Property(e => e.Path)
                .IsUnicode(false);

            modelBuilder.Entity<ObjectMaster>()
                .HasMany(e => e.ActivityDetailsMaster)
                .WithRequired(e => e.ObjectMaster)
                .HasForeignKey(e => e.ObjectId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ObjectMaster>()
                .HasMany(e => e.DealDetails)
                .WithRequired(e => e.ObjectMaster)
                .HasForeignKey(e => e.ObjectID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ObjectMaster>()
                .HasMany(e => e.ObjectUserMapping)
                .WithRequired(e => e.ObjectMaster)
                .HasForeignKey(e => e.ObjectId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ObjectUserMapping>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<ObjectUserMapping>()
                .HasMany(e => e.ObjUserPermission)
                .WithRequired(e => e.ObjectUserMapping)
                .HasForeignKey(e => e.ObjUserId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<StageMaster>()
                .HasMany(e => e.DealDetails)
                .WithRequired(e => e.StageMaster)
                .HasForeignKey(e => e.StageID)
                .WillCascadeOnDelete(false);




            //modelBuilder.Entity<ActivityMaster>()
            //   .HasMany(e => e.DealDetail)
            //   .WithRequired(e => e.ActivityMaster)
            //   .HasForeignKey(e => e.ActivityID)
            //   .WillCascadeOnDelete(false);

            //modelBuilder.Entity<DealDetail>()
            //    .Property(e => e.Objective)
            //    .IsUnicode(false);

            ////modelBuilder.Entity<DealDetail>()
            ////    .HasOptional(e => e.ActivityDetailMaster)
            ////    .WithRequired(e => e.DealDetail);

            //modelBuilder.Entity<ObjectMaster>()
            //    .Property(e => e.Name)
            //    .IsUnicode(false);

            //modelBuilder.Entity<ObjectMaster>()
            //    .Property(e => e.Path)
            //    .IsUnicode(false);

            //modelBuilder.Entity<ObjectMaster>()
            //    .HasMany(e => e.ActivityDetailMaster)
            //    .WithRequired(e => e.ObjectMaster)
            //    .HasForeignKey(e => e.ObjectId)
            //    .WillCascadeOnDelete(false);

            //modelBuilder.Entity<ObjectMaster>()
            //    .HasMany(e => e.DealDetail)
            //    .WithRequired(e => e.ObjectMaster)
            //    .HasForeignKey(e => e.ObjectID)
            //    .WillCascadeOnDelete(false);

            //modelBuilder.Entity<ObjectMaster>()
            //    .HasMany(e => e.ObjectUserMapping)
            //    .WithRequired(e => e.ObjectMaster)
            //    .HasForeignKey(e => e.ObjectId)
            //    .WillCascadeOnDelete(false);

            //modelBuilder.Entity<ObjectUserMapping>()
            //    .Property(e => e.Description)
            //    .IsUnicode(false);

            //modelBuilder.Entity<ObjectUserMapping>()
            //    .HasMany(e => e.ObjUserPermission)
            //    .WithRequired(e => e.ObjectUserMapping)
            //    .HasForeignKey(e => e.ObjUserId)
            //    .WillCascadeOnDelete(false);

            //modelBuilder.Entity<StageMaster>()
            //    .HasMany(e => e.DealDetail)
            //    .WithRequired(e => e.StageMaster)
            //    .HasForeignKey(e => e.StageID)
            //    .WillCascadeOnDelete(false);




        }
    }
}
