namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class MasterModel : DbContext
    {
        public MasterModel()
            : base("name=MasterModel")
        {
        }

        public virtual DbSet<GroupMaster> GroupMaster { get; set; }
        public virtual DbSet<GroupUserMapping> GroupUserMapping { get; set; }

        public virtual DbSet<AnalystEstimate> AnalystEstimate { get; set; }
        public virtual DbSet<CompanyMaster> CompanyMaster { get; set; }
        public virtual DbSet<DiseaseAreaMaster> DiseaseAreaMaster { get; set; }
        public virtual DbSet<DivisionCompanyMaster> DivisionCompanyMaster { get; set; }
        public virtual DbSet<DivisionMaster> DivisionMaster { get; set; }
        public virtual DbSet<DivisionRegulatoryMaster> DivisionRegulatoryMaster { get; set; }
        public virtual DbSet<DivisionUserMapping> DivisionUserMapping { get; set; }
        public virtual DbSet<Dosages> Dosages { get; set; }
        public virtual DbSet<FormMaster> FormMaster { get; set; }
        public virtual DbSet<ForumAnswer> ForumAnswer { get; set; }
        public virtual DbSet<ForumAttachment> ForumAttachment { get; set; }
        public virtual DbSet<ForumQuestion> ForumQuestion { get; set; }
        public virtual DbSet<IndicationMaster> IndicationMaster { get; set; }
        public virtual DbSet<MOA_Master> MOA_Master { get; set; }
        public virtual DbSet<MoleculeMaster> MoleculeMaster { get; set; }
        public virtual DbSet<NADAC_PricingUnitMaster> NADAC_PricingUnitMaster { get; set; }
        public virtual DbSet<PatentCodeMaster> PatentCodeMaster { get; set; }
        public virtual DbSet<PharmaClassMaster> PharmaClassMaster { get; set; }
        public virtual DbSet<PhaseMaster> PhaseMaster { get; set; }
        public virtual DbSet<PriceSourceMaster> PriceSourceMaster { get; set; }
        public virtual DbSet<ProductCategoryMaster> ProductCategoryMaster { get; set; }
        public virtual DbSet<ProductCodeMaster> ProductCodeMaster { get; set; }
        public virtual DbSet<ProductMaster> ProductMaster { get; set; }
        public virtual DbSet<ProductTypeMaster> ProductTypeMaster { get; set; }
        public virtual DbSet<RegimenMaster> RegimenMaster { get; set; }
        public virtual DbSet<ResetPasswordRequestDetails> ResetPasswordRequestDetails { get; set; }
        public virtual DbSet<ROA_Master> ROA_Master { get; set; }
        public virtual DbSet<SubscriberMaster> SubscriberMaster { get; set; }
        public virtual DbSet<SubstanceMaster> SubstanceMaster { get; set; }
        public virtual DbSet<UserMaster> UserMaster { get; set; }
        public virtual DbSet<UserNotifications> UserNotifications { get; set; }
        public virtual DbSet<DiseaseTransaction> DiseaseTransaction { get; set; }
        public virtual DbSet<ExclusivityCodeMaster> ExclusivityCodeMaster { get; set; }
        public virtual DbSet<ExclusivityTransaction> ExclusivityTransaction { get; set; }
        public virtual DbSet<InlineTransaction> InlineTransaction { get; set; }
        public virtual DbSet<PipelineTransaction> PipelineTransaction { get; set; }
        public virtual DbSet<IndicationMediaDetails> IndicationMediaDetails { get; set; }
        public virtual DbSet<UserAccess> UserAccess { get; set; }
        public virtual DbSet<UserAccessForecastPlatform> UserAccessForecastPlatform { get; set; }
        public virtual DbSet<IndicationMapping> IndicationMapping { get; set; }
        public virtual DbSet<PharmaClassMapping> PharmaClassMapping { get; set; }
        public virtual DbSet<CompanyTransactionMapping> CompanyTransactionMapping { get; set; }
        public virtual DbSet<IndicationTransactionMapping> IndicationTransactionMapping { get; set; }
        public virtual DbSet<MOA_TransactionMapping> MOA_TransactionMapping { get; set; }
        public virtual DbSet<MoleculeTransactionMapping> MoleculeTransactionMapping { get; set; }
        public virtual DbSet<PipelineProcessedData> PipelineProcessedData { get; set; }
        public virtual DbSet<PipelineSearchData> PipelineSearchData { get; set; }
        public virtual DbSet<ProductTransactionMapping> ProductTransactionMapping { get; set; }
        public virtual DbSet<RegimenTransactionMapping> RegimenTransactionMapping { get; set; }
        public virtual DbSet<ROA_TransactionMapping> ROA_TransactionMapping { get; set; }
        public virtual DbSet<DeviceUserMapping> DeviceUserMappings { get; set; }
        public virtual DbSet<MoleculeRegimenMapping> MoleculeRegimenMapping { get; set; }
        public virtual DbSet<DiseaseIndicationData> DiseaseIndicationData { get; set; }

        public virtual DbSet<TreatmentRegimenDetail> TreatmentRegimenDetail { get; set; }

        public virtual DbSet<ReferenceMaster> ReferenceMaster { get; set; }
        public virtual DbSet<IndicationReferenceMapping> IndicationReferenceMapping { get; set; }


        //hemant
        public virtual DbSet<DiseaseAreaMapping> DiseaseAreaMapping { get; set; }

        public virtual DbSet<InlineMoleculeMapping> InlineMoleculeMapping { get; set; }

       // public virtual DbSet<CompanyMaster> CompanyMasters { get; set; }
       // public virtual DbSet<Transaction> Transactions { get; set; }
        public virtual DbSet<APIInformation> APIInformations { get; set; }
        public virtual DbSet<AuthorizedGenericMapping> AuthorizedGenericMappings { get; set; }
        public virtual DbSet<CompanyGenericPlayersMapping> CompanyGenericPlayersMappings { get; set; }
        public virtual DbSet<DMFHolderName> DMFHolderNames { get; set; }
        public virtual DbSet<DosageForm> DosageForms { get; set; }
        public virtual DbSet<Exclusivity> Exclusivities { get; set; }
        public virtual DbSet<FTFHolderGenericMapping> FTFHolderGenericMappings { get; set; }
        public virtual DbSet<GenericAvailability> GenericAvailabilities { get; set; }
        public virtual DbSet<GenericName> GenericNames { get; set; }
        public virtual DbSet<Link> Links { get; set; }
        public virtual DbSet<PatentInfo> PatentInfoes { get; set; }
        public virtual DbSet<PatentType> PatentTypes { get; set; }
        public virtual DbSet<PatentUseCode> PatentUseCodes { get; set; }
        public virtual DbSet<Price> Prices { get; set; }
        public virtual DbSet<ProductCodeBrand> ProductCodeBrands { get; set; }
        public virtual DbSet<ProductInformation> ProductInformations { get; set; }
        public virtual DbSet<ProductSummary> ProductSummaries { get; set; }
        public virtual DbSet<RegulatoryStrategy> RegulatoryStrategies { get; set; }
        public virtual DbSet<SalesInformation> SalesInformations { get; set; }
        public virtual DbSet<Strength> Strengths { get; set; }
        public virtual DbSet<Unit> Units { get; set; }
        public virtual DbSet<ExclusivityInfo> ExclusivityInfoes { get; set; }
        public virtual DbSet<IndicationMediaDetail> IndicationMediaDetail { get; set; }











        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {


            modelBuilder.Entity<AnalystEstimate>()
                .Property(e => e.Descriptions)
                .IsUnicode(false);

            modelBuilder.Entity<CompanyMaster>()
                .Property(e => e.CompanyName)
                .IsUnicode(false);

            modelBuilder.Entity<DiseaseAreaMaster>()
                .Property(e => e.DiseaseArea)
                .IsUnicode(false);

            modelBuilder.Entity<DiseaseAreaMaster>()
                .HasMany(e => e.DiseaseTransaction)
                .WithOptional(e => e.DiseaseAreaMaster)
                .HasForeignKey(e => e.DiseaseAreaId);

            modelBuilder.Entity<DiseaseAreaMaster>()
                .HasMany(e => e.InlineTransaction)
                .WithMany(e => e.DiseaseAreaMaster)
                .Map(m => m.ToTable("DiseaseAreaTransactionMapping", "Inline").MapLeftKey("DiseaseId").MapRightKey("DiseaseTransactionId"));

            modelBuilder.Entity<DiseaseAreaMaster>()
               .HasMany(e => e.DiseaseIndicationData)
               .WithRequired(e => e.DiseaseAreaMaster)
               .HasForeignKey(e => e.DiseaseAreaId)
               .WillCascadeOnDelete(false);


            modelBuilder.Entity<DiseaseAreaMaster>()
                .HasMany(e => e.PipelineTransaction)
                .WithMany(e => e.DiseaseAreaMaster)
                .Map(m => m.ToTable("DiseaseAreaTransactionMapping", "Pipeline").MapLeftKey("DiseaseId").MapRightKey("DiseaseTransactionId"));

            modelBuilder.Entity<DivisionMaster>()
                .HasMany(e => e.DivisionCompanyMaster)
                .WithRequired(e => e.DivisionMaster)
                .HasForeignKey(e => e.DivisionID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<DivisionMaster>()
                .HasMany(e => e.DivisionRegulatoryMaster)
                .WithRequired(e => e.DivisionMaster)
                .HasForeignKey(e => e.DivisionID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<DivisionRegulatoryMaster>()
                .HasMany(e => e.DivisionUserMapping)
                .WithOptional(e => e.DivisionRegulatoryMaster)
                .HasForeignKey(e => e.DivisionRegulatoryId);

            modelBuilder.Entity<Dosages>()
                .Property(e => e.Descriptions)
                .IsUnicode(false);

            modelBuilder.Entity<Dosages>()
                .HasMany(e => e.Transaction2)
                .WithOptional(e => e.Dosages)
                .HasForeignKey(e => e.DosageId);

            modelBuilder.Entity<FormMaster>()
                .Property(e => e.FormName)
                .IsUnicode(false);

            modelBuilder.Entity<ForumAnswer>()
                .Property(e => e.Answer)
                .IsUnicode(false);

            modelBuilder.Entity<ForumAnswer>()
                .HasMany(e => e.ForumAttachment)
                .WithOptional(e => e.ForumAnswer)
                .HasForeignKey(e => e.AnswerId);

            modelBuilder.Entity<ForumAttachment>()
                .Property(e => e.AttachmentPath)
                .IsUnicode(false);

            modelBuilder.Entity<ForumAttachment>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<ForumQuestion>()
                .Property(e => e.Title)
                .IsUnicode(false);

            modelBuilder.Entity<ForumQuestion>()
                .Property(e => e.Question)
                .IsUnicode(false);

            modelBuilder.Entity<ForumQuestion>()
                .HasMany(e => e.ForumAnswer)
                .WithRequired(e => e.ForumQuestion)
                .HasForeignKey(e => e.QuestionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ForumQuestion>()
                .HasMany(e => e.ForumAttachment)
                .WithRequired(e => e.ForumQuestion)
                .HasForeignKey(e => e.QuestionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<IndicationMaster>()
                .HasMany(e => e.IndicationMapping)
                .WithRequired(e => e.IndicationMaster)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<IndicationMaster>()
                .HasMany(e => e.Transaction)
                .WithOptional(e => e.IndicationMaster)
                .HasForeignKey(e => e.PrimaryIndicationId);

            modelBuilder.Entity<MOA_Master>()
                .Property(e => e.MOA)
                .IsUnicode(false);

            modelBuilder.Entity<MoleculeMaster>()
                .HasMany(e => e.Transaction1)
                .WithOptional(e => e.MoleculeMaster)
                .HasForeignKey(e => e.MoleculeId);

            modelBuilder.Entity<MoleculeMaster>()
                .HasMany(e => e.Transaction)
                .WithMany(e => e.MoleculeMaster)
                .Map(m => m.ToTable("MoleculeMapping", "Disease").MapLeftKey("MoleculeId").MapRightKey("MoleculeTransactionId"));

            modelBuilder.Entity<MoleculeMaster>()
                .HasMany(e => e.Transaction11)
                .WithMany(e => e.MoleculeMaster1)
                .Map(m => m.ToTable("MoleculeMapping", "Inline").MapLeftKey("MoleculeId").MapRightKey("MoleculeTransactionId"));

            modelBuilder.Entity<NADAC_PricingUnitMaster>()
                .Property(e => e.NADACPricingUnit)
                .IsUnicode(false);

            modelBuilder.Entity<PharmaClassMaster>()
                .Property(e => e.PharmaClass)
                .IsUnicode(false);

            modelBuilder.Entity<PharmaClassMaster>()
                .HasMany(e => e.PharmaClassMapping)
                .WithRequired(e => e.PrimaryPharmaClass)
                .HasForeignKey(e => e.PharmaClassId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PharmaClassMaster>()
                .HasMany(e => e.PharmaClassMapping1)
                .WithOptional(e => e.SecondaryPharmaClass)
                .HasForeignKey(e => e.PharmaClass2Id);

            modelBuilder.Entity<PharmaClassMaster>()
                .HasMany(e => e.PharmaClassMapping2)
                .WithOptional(e => e.TartiaryPharmaClass)
                .HasForeignKey(e => e.PharmaClass3Id);

            modelBuilder.Entity<PharmaClassMaster>()
                .HasMany(e => e.PharmaClassMapping3)
                .WithOptional(e => e.IMSPharmaClass)
                .HasForeignKey(e => e.ImsClassId);

            modelBuilder.Entity<PharmaClassMaster>()
                .HasMany(e => e.Transaction2)
                .WithOptional(e => e.PharmaClassMaster)
                .HasForeignKey(e => e.PrimaryPharmaClassId);

            modelBuilder.Entity<PharmaClassMaster>()
                .HasMany(e => e.Transaction21)
                .WithOptional(e => e.PharmaClassMaster1)
                .HasForeignKey(e => e.SecondryPharmaClassId);

            modelBuilder.Entity<PharmaClassMaster>()
                .HasMany(e => e.Transaction22)
                .WithOptional(e => e.PharmaClassMaster2)
                .HasForeignKey(e => e.TertiaryPharmaClassId);

            modelBuilder.Entity<PhaseMaster>()
                .Property(e => e.Phase)
                .IsUnicode(false);

            modelBuilder.Entity<PhaseMaster>()
                .HasMany(e => e.Transaction2)
                .WithOptional(e => e.PhaseMaster)
                .HasForeignKey(e => e.PhaseId);

            modelBuilder.Entity<PriceSourceMaster>()
                .Property(e => e.PriceSource)
                .IsUnicode(false);

            modelBuilder.Entity<ProductCategoryMaster>()
                .Property(e => e.ProductCategory)
                .IsUnicode(false);

            modelBuilder.Entity<ProductCodeMaster>()
                .Property(e => e.ProductCode)
                .IsUnicode(false);

            modelBuilder.Entity<ProductMaster>()
                .Property(e => e.ProductName)
                .IsUnicode(false);

            modelBuilder.Entity<ProductTypeMaster>()
                .Property(e => e.ProductType)
                .IsUnicode(false);

            modelBuilder.Entity<ResetPasswordRequestDetails>()
                .Property(e => e.UserEmail)
                .IsUnicode(false);

            modelBuilder.Entity<ROA_Master>()
                .Property(e => e.RouteOfAdministration)
                .IsUnicode(false);

            modelBuilder.Entity<ROA_Master>()
                .HasMany(e => e.ROA_TransactionMapping)
                .WithOptional(e => e.ROA_Master)
                .HasForeignKey(e => e.ROA_Id);

            modelBuilder.Entity<SubscriberMaster>()
                .Property(e => e.SubscriberName)
                .IsUnicode(false);

            modelBuilder.Entity<SubscriberMaster>()
                .Property(e => e.FeedKeyword)
                .IsUnicode(false);

            modelBuilder.Entity<SubscriberMaster>()
                .Property(e => e.Archive)
                .IsUnicode(false);

            modelBuilder.Entity<SubscriberMaster>()
                .Property(e => e.SPAccount)
                .IsUnicode(false);

            modelBuilder.Entity<SubscriberMaster>()
                .HasMany(e => e.DivisionMaster)
                .WithRequired(e => e.SubscriberMaster)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<SubscriberMaster>()
                .HasMany(e => e.GroupMaster)
                .WithRequired(e => e.SubscriberMaster)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<SubscriberMaster>()
                .HasMany(e => e.UserMaster)
                .WithRequired(e => e.SubscriberMaster)
                .HasForeignKey(e => e.CompanyId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.FirstName)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.LastName)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.UserEmail)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.LoginPassword)
                .IsFixedLength();

            modelBuilder.Entity<UserMaster>()
                .HasMany(e => e.DivisionUserMapping)
                .WithOptional(e => e.UserMaster)
                .HasForeignKey(e => e.UserId)
                .WillCascadeOnDelete();

            modelBuilder.Entity<UserMaster>()
                .HasMany(e => e.ForumAnswer)
                .WithRequired(e => e.UserMaster)
                .HasForeignKey(e => e.UserId);

            modelBuilder.Entity<UserMaster>()
                .HasMany(e => e.ForumQuestion)
                .WithRequired(e => e.UserMaster)
                .HasForeignKey(e => e.UserId);

            modelBuilder.Entity<UserMaster>()
                .HasMany(e => e.UserAccess)
                .WithRequired(e => e.UserMaster)
                .HasForeignKey(e => e.UserID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<UserMaster>()
                .HasMany(e => e.UserAccessForecastPlatform)
                .WithRequired(e => e.UserMaster)
                .HasForeignKey(e => e.UserID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<UserMaster>()
                .HasMany(e => e.UserNotifications)
                .WithRequired(e => e.UserMaster)
                .HasForeignKey(e => e.UserId);

            modelBuilder.Entity<DiseaseTransaction>()
                .Property(e => e.SecondaryIndication)
                .IsUnicode(false);

            modelBuilder.Entity<ExclusivityCodeMaster>()
                .Property(e => e.ExclusivityCode)
                .IsUnicode(false);

            modelBuilder.Entity<ExclusivityCodeMaster>()
                .Property(e => e.Definition)
                .IsUnicode(false);

            modelBuilder.Entity<ExclusivityTransaction>()
                .Property(e => e.PatentNo)
                .IsUnicode(false);

            modelBuilder.Entity<InlineTransaction>()
                .Property(e => e.ApplicationShortNumber)
                .IsUnicode(false);

            modelBuilder.Entity<InlineTransaction>()
                .Property(e => e.ProductUID)
                .IsUnicode(false);

            modelBuilder.Entity<InlineTransaction>()
                .Property(e => e.ProductNDC)
                .IsUnicode(false);

            modelBuilder.Entity<InlineTransaction>()
                .Property(e => e.Strength)
                .IsUnicode(false);

            modelBuilder.Entity<InlineTransaction>()
                .Property(e => e.NADAC_Price)
                .IsUnicode(false);

            modelBuilder.Entity<InlineTransaction>()
                .Property(e => e.CodeAndNDC)
                .IsUnicode(false);

            modelBuilder.Entity<InlineTransaction>()
                .Property(e => e.DrugType)
                .IsUnicode(false);

            modelBuilder.Entity<InlineTransaction>()
                .HasMany(e => e.IndicationMapping)
                .WithRequired(e => e.Transaction1)
                .HasForeignKey(e => e.IndicationTransactionId)
                .WillCascadeOnDelete(false);

            //modelBuilder.Entity<InlineTransaction>()
            //    .HasMany(e => e.IndicationMapping1)
            //    .WithRequired(e => e.Transaction11)
            //    .HasForeignKey(e => e.IndicationTransactionId)
            //    .WillCascadeOnDelete(false);

            modelBuilder.Entity<InlineTransaction>()
                .HasMany(e => e.PharmaClassMapping)
                .WithRequired(e => e.InlineTransaction)
                .HasForeignKey(e => e.PharmaClassTransactionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PipelineTransaction>()
                .HasOptional(e => e.CompanyTransactionMapping)
                .WithRequired(e => e.Transaction2);

            modelBuilder.Entity<PipelineTransaction>()
                .HasOptional(e => e.IndicationTransactionMapping)
                .WithRequired(e => e.Transaction2);

            modelBuilder.Entity<PipelineTransaction>()
                .HasOptional(e => e.MOA_TransactionMapping)
                .WithRequired(e => e.Transaction2);

            modelBuilder.Entity<PipelineTransaction>()
                .HasOptional(e => e.MoleculeTransactionMapping)
                .WithRequired(e => e.Transaction2);

            modelBuilder.Entity<PipelineTransaction>()
                .HasOptional(e => e.ProductTransactionMapping)
                .WithRequired(e => e.PipelineTransaction);

            modelBuilder.Entity<PipelineTransaction>()
                .HasOptional(e => e.RegimenTransactionMapping)
                .WithRequired(e => e.Transaction2);

            modelBuilder.Entity<PipelineTransaction>()
                .HasOptional(e => e.ROA_TransactionMapping)
                .WithRequired(e => e.Transaction2);

            modelBuilder.Entity<IndicationMediaDetails>()
                .Property(e => e.DiseaseName)
                .IsUnicode(false);

            modelBuilder.Entity<IndicationMediaDetails>()
                .Property(e => e.IndicationName)
                .IsUnicode(false);

            modelBuilder.Entity<IndicationMediaDetails>()
                .Property(e => e.ImageUrl)
                .IsUnicode(false);

            modelBuilder.Entity<IndicationMediaDetails>()
                .Property(e => e.VideoUrl)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineProcessedData>()
                .Property(e => e.ProductName)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineProcessedData>()
                .Property(e => e.CompanyName)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineProcessedData>()
                .Property(e => e.ProductCategory)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineProcessedData>()
                .Property(e => e.PrimaryPharmaClass)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineProcessedData>()
                .Property(e => e.SecondryPharmaClass)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineProcessedData>()
                .Property(e => e.TertiaryPharmaClass)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineProcessedData>()
                .Property(e => e.IndicationName)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineProcessedData>()
                .Property(e => e.Phase)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineProcessedData>()
                .Property(e => e.ROA)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineSearchData>()
                .Property(e => e.ProductName)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineSearchData>()
                .Property(e => e.CompanyName)
                .IsUnicode(false);

            modelBuilder.Entity<PipelineSearchData>()
                .Property(e => e.Phase)
                .IsUnicode(false);


            //shubhada - user workspace
            modelBuilder.Entity<GroupMaster>()
               .Property(e => e.Name)
               .IsUnicode(false);

            modelBuilder.Entity<GroupMaster>()
                .HasMany(e => e.GroupUserMapping)
                .WithRequired(e => e.GroupMaster)
                .HasForeignKey(e => e.GroupId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<SubscriberMaster>()
                .Property(e => e.SubscriberName)
                .IsUnicode(false);

            modelBuilder.Entity<SubscriberMaster>()
                .Property(e => e.FeedKeyword)
                .IsUnicode(false);

            modelBuilder.Entity<SubscriberMaster>()
                .Property(e => e.Archive)
                .IsUnicode(false);

            modelBuilder.Entity<SubscriberMaster>()
                .Property(e => e.SPAccount)
                .IsUnicode(false);

            modelBuilder.Entity<SubscriberMaster>()
                .HasMany(e => e.UserMaster)
                .WithRequired(e => e.SubscriberMaster)
                .HasForeignKey(e => e.CompanyId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<UserMaster>()
               .HasMany(e => e.DeviceUserMappings)
               .WithRequired(e => e.UserMaster)
               .HasForeignKey(e => e.UserId)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<DeviceUserMapping>()
               .Property(e => e.DeviceKey)
               .IsUnicode(false);

			modelBuilder.Entity<UserMaster>()
                .HasMany(e => e.GroupUserMapping)
                .WithRequired(e => e.UserMaster)
                .HasForeignKey(e => e.UserId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<IndicationMaster>()
                .Property(e => e.IndicationName)
                .IsUnicode(false);

            modelBuilder.Entity<IndicationMaster>()
                .HasMany(e => e.DiseaseIndicationData)
                .WithRequired(e => e.IndicationMaster)
                .HasForeignKey(e => e.PrimaryIndicationId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<IndicationMaster>()
               .HasMany(e => e.DiseaseIndicationData1)
               .WithRequired(e => e.IndicationMaster1)
               .HasForeignKey(e => e.SecondaryIndicationId)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<DiseaseIndicationData>()
             .HasMany(e => e.TreatmentRegimenDetail)
             .WithRequired(e => e.DiseaseIndicationData)
             .WillCascadeOnDelete(false);

            //modelBuilder.Entity<RegimenMaster>()
            //    .HasMany(e => e.TreatmentRegimenDetail)
            //    .WithRequired(e => e.RegimenMaster)
            //    .WillCascadeOnDelete(false);

            //modelBuilder.Entity<MoleculeMaster>()
            //  //.HasMany(e => e.TreatmentRegimenDetails)
            //  //.WithMany(e => e.MoleculeMasters)
            //  .Map(m => m.ToTable("MoleculeRegimenMapping","Disease").MapLeftKey("MoleculeId").MapRightKey("TreatmentRegimenDetailId"));

            modelBuilder.Entity<TreatmentRegimenDetail>()
               .HasMany(e => e.MoleculeRegimenMapping)
               .WithRequired(e => e.TreatmentRegimenDetail)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<PharmaClassMaster>()
               .HasMany(e => e.TreatmentRegimenDetails)
               .WithRequired(e => e.PharmaClassMaster)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<MoleculeMaster>()
               .HasMany(e => e.MoleculeRegimenMapping)
               .WithRequired(e => e.MoleculeMaster)
               .WillCascadeOnDelete(false);


            modelBuilder.Entity<DiseaseIndicationData>()
              .HasMany(e => e.IndicationReferenceMapping)
              .WithRequired(e => e.DiseaseIndicationData)
              .WillCascadeOnDelete(false);

            modelBuilder.Entity<ReferenceMaster>()
                .HasMany(e => e.IndicationReferenceMapping)
                .WithRequired(e => e.ReferenceMaster)
                .WillCascadeOnDelete(false);



            /////////hemant
          
            modelBuilder.Entity<CompanyMaster>()
                .HasMany(e => e.Transaction1)
                .WithOptional(e => e.CompanyMaster1)
                .HasForeignKey(e => e.MarketingCompanyId)
                .WillCascadeOnDelete(false);

              modelBuilder.Entity<CompanyMaster>()
                .HasMany(e => e.Transaction)
                .WithRequired(e => e.CompanyMaster)
                .HasForeignKey(e => e.CompanyId)
                .WillCascadeOnDelete(false);

          modelBuilder.Entity<DiseaseAreaMaster>()
               .HasMany(e => e.DiseaseAreaMapping)
               .WithRequired(e => e.DiseaseAreaMaster)
               .HasForeignKey(e => e.DiseaseAreaId)
               .WillCascadeOnDelete(false);
            modelBuilder.Entity<InlineTransaction>()
               .HasMany(e => e.DiseaseAreaMapping)
               .WithRequired(e => e.InlineTransaction)
               .HasForeignKey(e => e.InlineTransactionId)
               .WillCascadeOnDelete(false);

         
               modelBuilder.Entity<FormMaster>()
                .HasMany(e => e.Transaction1)
                .WithRequired(e => e.FormMaster)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<MoleculeMaster>()
              .HasMany(e => e.MoleculeMapping)
              .WithRequired(e => e.MoleculeMaster)
              .WillCascadeOnDelete(false);

            modelBuilder.Entity<NADAC_PricingUnitMaster>()
              .HasMany(e => e.Transaction1)
              .WithRequired(e => e.NADAC_PricingUnitMaster)
              .WillCascadeOnDelete(false);

            modelBuilder.Entity<PriceSourceMaster>()
               .HasMany(e => e.Transaction1)
               .WithRequired(e => e.PriceSourceMaster)
               .WillCascadeOnDelete(false);


            modelBuilder.Entity<ProductCategoryMaster>()
               .HasMany(e => e.Transaction1)
               .WithRequired(e => e.ProductCategoryMaster)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<ProductCodeMaster>()
               .HasMany(e => e.InlineTransaction)
               .WithRequired(e => e.ProductCodeMaster)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<ProductTypeMaster>()
                .HasMany(e => e.Transaction1)
                .WithRequired(e => e.ProductTypeMaster)
                .WillCascadeOnDelete(false);


            modelBuilder.Entity<ROA_Master>()
               .HasMany(e => e.Transaction1)
               .WithRequired(e => e.ROA_Master)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<InlineTransaction>()
               .HasMany(e => e.DiseaseAreaMapping)
               .WithRequired(e => e.InlineTransaction)
               .HasForeignKey(e => e.InlineTransactionId)
               .WillCascadeOnDelete(false);

            modelBuilder.Entity<InlineTransaction>()
               .HasMany(e => e.MoleculeMapping)
               .WithRequired(e => e.Transaction1)
               .HasForeignKey(e => e.MoleculeTransactionId)
               .WillCascadeOnDelete(false);


            //////////////////////////////////////////////////////////////////////

            modelBuilder.Entity<CompanyMaster>()
                .HasMany(e => e.APIInformations)
                .WithRequired(e => e.CompanyMaster)
                .HasForeignKey(e => e.DMFComapnyId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CompanyMaster>()
                .HasMany(e => e.AuthorizedGenericMappings)
                .WithRequired(e => e.CompanyMaster)
                .HasForeignKey(e => e.ComapnyId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CompanyMaster>()
                .HasMany(e => e.CompanyGenericPlayersMappings)
                .WithRequired(e => e.CompanyMaster)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CompanyMaster>()
                .HasMany(e => e.FTFHolderGenericMappings)
                .WithRequired(e => e.CompanyMaster)
                .WillCascadeOnDelete(false);

            //modelBuilder.Entity<CompanyMaster>()
            //    .HasMany(e => e.Transactions)
            //    .WithRequired(e => e.CompanyMaster)
            //    .HasForeignKey(e => e.CompanyId)
            //    .WillCascadeOnDelete(false);

            modelBuilder.Entity<CompanyMaster>()
                .HasMany(e => e.Transaction1)
                .WithOptional(e => e.CompanyMaster1)
                .HasForeignKey(e => e.MarketingCompanyId);

            //modelBuilder.Entity<Transaction>()
            //    .Property(e => e.ApplicationShortNumber)
            //    .IsUnicode(false);

            //modelBuilder.Entity<Transaction>()
            //    .Property(e => e.ProductUID)
            //    .IsUnicode(false);

            //modelBuilder.Entity<Transaction>()
            //    .Property(e => e.ProductNDC)
            //    .IsUnicode(false);

            //modelBuilder.Entity<Transaction>()
            //    .Property(e => e.Strength)
            //    .IsUnicode(false);

            //modelBuilder.Entity<Transaction>()
            //    .Property(e => e.NADAC_Price)
            //    .IsUnicode(false);

            //modelBuilder.Entity<Transaction>()
            //    .Property(e => e.CodeAndNDC)
            //    .IsUnicode(false);

            //modelBuilder.Entity<Transaction>()
            //    .Property(e => e.DrugType)
            //    .IsUnicode(false);

            modelBuilder.Entity<InlineTransaction>()
                .HasMany(e => e.APIInformations)
                .WithRequired(e => e.Transaction)
                .HasForeignKey(e => e.InlineTransanctionId)
                .WillCascadeOnDelete(false);

            //modelBuilder.Entity<InlineTransaction>()
            //    .HasOptional(e => e.ExclusivityInfo)
            //    .WithRequired(e => e.Transaction);

            modelBuilder.Entity<InlineTransaction>()
                .HasMany(E => E.ExclusivityInfo)
            //.HasMany(e => e.ExclusivityInfo)
            .WithRequired(e => e.Transaction)
            .HasForeignKey(e => e.InlineTransactionId)
            .WillCascadeOnDelete(false);

            modelBuilder.Entity<Exclusivity>()
             .HasMany(e => e.ExclusivityInfoes)
             .WithRequired(e => e.Exclusivity)
             .WillCascadeOnDelete(false);



            modelBuilder.Entity<InlineTransaction>()
                .HasMany(e => e.GenericAvailabilities)
                .WithRequired(e => e.Transaction)
                .HasForeignKey(e => e.InlineTrasnactionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<InlineTransaction>()
                .HasMany(e => e.PatentInfoes)
                .WithRequired(e => e.Transaction)
                .HasForeignKey(e => e.InlineTransactionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<InlineTransaction>()
                .HasMany(e => e.SalesInformations)
                .WithRequired(e => e.Transaction)
                .HasForeignKey(e => e.InlineTransactionId)
                .WillCascadeOnDelete(false);

            //modelBuilder.Entity<InlineTransaction>()
            //    .HasOptional(e => e.Transaction1)
            //    .WithRequired(e => e.Transaction2);

            modelBuilder.Entity<GenericAvailability>()
                .HasMany(e => e.AuthorizedGenericMappings)
                .WithRequired(e => e.GenericAvailability)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericAvailability>()
                .HasMany(e => e.CompanyGenericPlayersMappings)
                .WithRequired(e => e.GenericAvailability)
                .HasForeignKey(e => e.GenericAvalabilityId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericAvailability>()
                .HasMany(e => e.FTFHolderGenericMappings)
                .WithRequired(e => e.GenericAvailability)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<GenericName>()
                .HasMany(e => e.ProductSummaries)
                .WithOptional(e => e.GenericName)
                .HasForeignKey(e => e.GenericID);

            modelBuilder.Entity<GenericName>()
                .HasMany(e => e.ProductInformations)
                .WithOptional(e => e.GenericName)
                .HasForeignKey(e => e.GenericID);

            modelBuilder.Entity<PatentInfo>()
                .HasMany(e => e.RegulatoryStrategies)
                .WithRequired(e => e.PatentInfo)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ProductCodeBrand>()
                .HasMany(e => e.Links)
                .WithOptional(e => e.ProductCodeBrand)
                .HasForeignKey(e => e.PatentCodeBrandID);

            modelBuilder.Entity<ProductCodeBrand>()
                .HasMany(e => e.Prices)
                .WithRequired(e => e.ProductCodeBrand)
                .HasForeignKey(e => e.PatentCodeBrandID)
                .WillCascadeOnDelete(false);


            modelBuilder.Entity<DiseaseIndicationData>()
               .HasMany(e => e.IndicationMediaDetail)
               .WithRequired(e => e.DiseaseIndicationData)
               .WillCascadeOnDelete(false);


            modelBuilder.Entity<ProductCodeBrand>()
                .HasMany(e => e.ProductSummaries)
                .WithRequired(e => e.ProductCodeBrand)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ProductCodeBrand>()
                .HasMany(e => e.ProductInformations)
                .WithOptional(e => e.ProductCodeBrand)
                .HasForeignKey(e => e.PatentCodeBrandID);

            modelBuilder.Entity<SalesInformation>()
                .Property(e => e.PercentChange)
                .HasPrecision(5, 2);

            modelBuilder.Entity<Unit>()
                .HasMany(e => e.Prices)
                .WithOptional(e => e.Unit)
                .HasForeignKey(e => e.UnitsID);






        }




    }
}
