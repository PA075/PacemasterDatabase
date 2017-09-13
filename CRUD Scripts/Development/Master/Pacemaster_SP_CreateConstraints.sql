USE [PACEMASTER]
GO

/****** Object:  StoredProcedure [dbo].[uspCreateForeignKeyConstraints]    Script Date: 12/22/2016 6:20:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[uspCreateForeignKeyConstraints]
AS
BEGIN


IF (OBJECT_ID( 'FK_DivisionRegulatoryId_ID','F') IS NULL)
ALTER TABLE dbo.DivisionUserMapping ADD CONSTRAINT FK_DivisionRegulatoryId_ID FOREIGN KEY (DivisionRegulatoryId) REFERENCES dbo.DivisionRegulatoryMaster(Id)

IF (OBJECT_ID( 'FK_UserId_ID','F') IS NULL)
ALTER TABLE dbo.DivisionUserMapping ADD CONSTRAINT FK_UserId_ID FOREIGN KEY (UserId) REFERENCES dbo.UserMaster(Id)

IF (OBJECT_ID( 'FK_DivisionCompanyMaster_DivisionMaster','F') IS NULL)
ALTER TABLE dbo.DivisionCompanyMaster ADD CONSTRAINT FK_DivisionCompanyMaster_DivisionMaster FOREIGN KEY (DivisionID) REFERENCES dbo.DivisionMaster(Id)

IF (OBJECT_ID( 'FK_DivisionMaster_SubscriberMaster','F') IS NULL)
ALTER TABLE dbo.DivisionMaster ADD CONSTRAINT FK_DivisionMaster_SubscriberMaster FOREIGN KEY (SubscriberID) REFERENCES dbo.SubscriberMaster(SubscriberId)

IF (OBJECT_ID( 'FK_DivisionRegulatoryMaster_DivisionMaster','F') IS NULL)
ALTER TABLE dbo.DivisionRegulatoryMaster ADD CONSTRAINT FK_DivisionRegulatoryMaster_DivisionMaster FOREIGN KEY (DivisionID) REFERENCES dbo.DivisionMaster(Id)

IF (OBJECT_ID( 'FK_UserMaster_SubscriberMaster','F') IS NULL)
ALTER TABLE dbo.UserMaster ADD CONSTRAINT FK_UserMaster_SubscriberMaster FOREIGN KEY (CompanyId) REFERENCES dbo.SubscriberMaster(SubscriberId)

IF (OBJECT_ID( 'FK_Transaction_DiseaseArea','F') IS NULL)
ALTER TABLE Disease.[Transaction] ADD CONSTRAINT FK_Transaction_DiseaseArea FOREIGN KEY (DiseaseAreaId) REFERENCES dbo.DiseaseAreaMaster(DiseaseId)

IF (OBJECT_ID( 'FK_Transaction_Indication','F') IS NULL)
ALTER TABLE Disease.[Transaction] ADD CONSTRAINT FK_Transaction_Indication FOREIGN KEY (PrimaryIndicationId) REFERENCES dbo.IndicationMaster(IndicationId)

IF (OBJECT_ID( 'FK_MoleculeTransactionMapping_Transaction','F') IS NULL)
ALTER TABLE Pipeline.MoleculeTransactionMapping ADD CONSTRAINT FK_MoleculeTransactionMapping_Transaction FOREIGN KEY (MoleculeTransactionId) REFERENCES Pipeline.[Transaction](Id)

IF (OBJECT_ID( 'FK_ForumAttachment_ForumAnswer_Id','F') IS NULL)

ALTER TABLE [dbo].[ForumAttachment] ADD CONSTRAINT [FK_ForumAttachment_ForumAnswer_Id] FOREIGN KEY ([AnswerId]) REFERENCES [dbo].[ForumAnswer]([Id]);

IF (OBJECT_ID( 'Pipeline.FK_Transaction_PhaseMaster','F') IS NULL)

ALTER TABLE [Pipeline].[Transaction] ADD CONSTRAINT [FK_Transaction_PhaseMaster] FOREIGN KEY ([PhaseId]) REFERENCES [dbo].[PhaseMaster]([Id]);

IF (OBJECT_ID( 'Pipeline.FK_Transaction_ProductCategoryMaster','F') IS NULL)

ALTER TABLE [Pipeline].[Transaction] ADD CONSTRAINT [FK_Transaction_ProductCategoryMaster] FOREIGN KEY ([ProductCategoryId]) REFERENCES [dbo].[ProductCategoryMaster]([ProductCategoryId]);

IF (OBJECT_ID( 'Inline.FK_Transaction_ProductCategoryMaster','F') IS NULL)

ALTER TABLE [Inline].[Transaction] ADD CONSTRAINT [FK_Transaction_ProductCategoryMaster] FOREIGN KEY ([ProductCategoryId]) REFERENCES [dbo].[ProductCategoryMaster]([ProductCategoryId]);

IF (OBJECT_ID( 'Inline.FK_Transaction_ProductCodeMaster','F') IS NULL)

ALTER TABLE [Inline].[Transaction] ADD CONSTRAINT [FK_Transaction_ProductCodeMaster] FOREIGN KEY ([ProductCodeId]) REFERENCES [dbo].[ProductCodeMaster]([ProductcodeId]);

IF (OBJECT_ID( 'Inline.FK_ExclusivityTransaction_ProductCodeMaster','F') IS NULL)

ALTER TABLE [Inline].[ExclusivityTransaction] ADD CONSTRAINT [FK_ExclusivityTransaction_ProductCodeMaster] FOREIGN KEY ([ProductCodeId]) REFERENCES [dbo].[ProductCodeMaster]([ProductcodeId]);

IF (OBJECT_ID( 'Pipeline.FK_ProductTransactionMapping_ProductMaster','F') IS NULL)

ALTER TABLE [Pipeline].[ProductTransactionMapping] ADD CONSTRAINT [FK_ProductTransactionMapping_ProductMaster] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[ProductMaster]([ProductId]);

IF (OBJECT_ID( 'Inline.FK_Transaction_ProductMaster','F') IS NULL)

ALTER TABLE [Inline].[Transaction] ADD CONSTRAINT [FK_Transaction_ProductMaster] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[ProductMaster]([ProductId]);

IF (OBJECT_ID( 'Inline.FK_Transaction_ProductTypeMaster','F') IS NULL)

ALTER TABLE [Inline].[Transaction] ADD CONSTRAINT [FK_Transaction_ProductTypeMaster] FOREIGN KEY ([ProductTypeId]) REFERENCES [dbo].[ProductTypeMaster]([ProductTypeId]);

IF (OBJECT_ID( 'Pipeline.FK_RegimenTransactionMapping_RegimenMaster','F') IS NULL)

ALTER TABLE [Pipeline].[RegimenTransactionMapping] ADD CONSTRAINT [FK_RegimenTransactionMapping_RegimenMaster] FOREIGN KEY ([RegimenId]) REFERENCES [dbo].[RegimenMaster]([RegimenId]);

IF (OBJECT_ID( 'Pipeline.FK_ROA_TransactionMapping_ROA_Master','F') IS NULL)

ALTER TABLE [Pipeline].[ROA_TransactionMapping] ADD CONSTRAINT [FK_ROA_TransactionMapping_ROA_Master] FOREIGN KEY ([ROA_Id]) REFERENCES [dbo].[ROA_Master]([ROAId]);

IF (OBJECT_ID( 'Inline.FK_Transaction_ROA_Master','F') IS NULL)

ALTER TABLE [Inline].[Transaction] ADD CONSTRAINT [FK_Transaction_ROA_Master] FOREIGN KEY ([ROAId]) REFERENCES [dbo].[ROA_Master]([ROAId]);

IF (OBJECT_ID( 'Inline.FK_Transaction_SubstanceMaster','F') IS NULL)

ALTER TABLE [Inline].[Transaction] ADD CONSTRAINT [FK_Transaction_SubstanceMaster] FOREIGN KEY ([SubstanceId]) REFERENCES [dbo].[SubstanceMaster]([SubstanceId]);

IF (OBJECT_ID( 'Inline.FK_MoleculeMapping_Transaction','F') IS NULL)

ALTER TABLE [Inline].[MoleculeMapping] ADD CONSTRAINT [FK_MoleculeMapping_Transaction] FOREIGN KEY ([MoleculeTransactionId]) REFERENCES [Inline].[Transaction]([Id]);

IF (OBJECT_ID( 'Inline.FK_IndicationMapping_Transaction','F') IS NULL)

ALTER TABLE [Inline].[IndicationMapping] ADD CONSTRAINT [FK_IndicationMapping_Transaction] FOREIGN KEY ([IndicationTransactionId]) REFERENCES [Inline].[Transaction]([Id]);







IF (OBJECT_ID( 'Inline.FK_DiseaseAreaTransactionMapping_Transaction','F') IS NULL)

ALTER TABLE [Inline].[DiseaseAreaTransactionMapping] ADD CONSTRAINT [FK_DiseaseAreaTransactionMapping_Transaction] FOREIGN KEY ([DiseaseTransactionId]) REFERENCES [Inline].[Transaction]([Id]);

IF (OBJECT_ID( 'Inline.FK_PharmaClassMapping_Transaction','F') IS NULL)

ALTER TABLE [Inline].[PharmaClassMapping] ADD CONSTRAINT [FK_PharmaClassMapping_Transaction] FOREIGN KEY ([PharmaClassTransactionId]) REFERENCES [Inline].[Transaction]([Id]);


IF (OBJECT_ID( 'Disease.FK_MoleculeMapping_Transaction','F') IS NULL)

ALTER TABLE [Disease].[MoleculeMapping] ADD CONSTRAINT [FK_MoleculeMapping_Transaction] FOREIGN KEY ([MoleculeTransactionId]) REFERENCES [Disease].[Transaction]([TransactionId]);

IF (OBJECT_ID( 'Pipeline.FK_Transaction_AnalystEstimate','F') IS NULL)

ALTER TABLE [Pipeline].[Transaction] ADD CONSTRAINT [FK_Transaction_AnalystEstimate] FOREIGN KEY ([AnalystEstimateId]) REFERENCES [dbo].[AnalystEstimate]([Id]);

IF (OBJECT_ID( 'Pipeline.FK_CompanyTransactionMapping_CompanyMaster','F') IS NULL)

ALTER TABLE [Pipeline].[CompanyTransactionMapping] ADD CONSTRAINT [FK_CompanyTransactionMapping_CompanyMaster] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[CompanyMaster]([CompanyId]);

IF (OBJECT_ID( 'Inline.FK_Transaction_CompanyMaster','F') IS NULL)

ALTER TABLE [Inline].[Transaction] ADD CONSTRAINT [FK_Transaction_CompanyMaster] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[CompanyMaster]([CompanyId]);

IF (OBJECT_ID( 'Pipeline.FK_DiseaseAreaTransactionMapping_DiseaseAreaMaster','F') IS NULL)

ALTER TABLE [Pipeline].[DiseaseAreaTransactionMapping] ADD CONSTRAINT [FK_DiseaseAreaTransactionMapping_DiseaseAreaMaster] FOREIGN KEY ([DiseaseId]) REFERENCES [dbo].[DiseaseAreaMaster]([DiseaseId]);

IF (OBJECT_ID( 'Inline.FK_DiseaseAreaTransactionMapping_DiseaseAreaMaster','F') IS NULL)

ALTER TABLE [Inline].[DiseaseAreaTransactionMapping] ADD CONSTRAINT [FK_DiseaseAreaTransactionMapping_DiseaseAreaMaster] FOREIGN KEY ([DiseaseId]) REFERENCES [dbo].[DiseaseAreaMaster]([DiseaseId]);

IF (OBJECT_ID( 'Inline.FK_ExclusivityTransaction_ExclusivityCodeMaster','F') IS NULL)

ALTER TABLE [Inline].[ExclusivityTransaction] ADD CONSTRAINT [FK_ExclusivityTransaction_ExclusivityCodeMaster] FOREIGN KEY ([ExclusivityCodeId]) REFERENCES [Inline].[ExclusivityCodeMaster]([ExclusivityCodeId]);

IF (OBJECT_ID( 'FK_ForumQuestion_UserMaster','F') IS NULL)

ALTER TABLE [dbo].[ForumQuestion] ADD CONSTRAINT [FK_ForumQuestion_UserMaster] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserMaster]([Id]);

IF (OBJECT_ID( 'FK_ForumAnswer_UserMaster','F') IS NULL)

ALTER TABLE [dbo].[ForumAnswer] ADD CONSTRAINT [FK_ForumAnswer_UserMaster] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserMaster]([Id]);

IF (OBJECT_ID( 'Pipeline.FK_Transaction_Dosages','F') IS NULL)

ALTER TABLE [Pipeline].[Transaction] ADD CONSTRAINT [FK_Transaction_Dosages] FOREIGN KEY ([DosageId]) REFERENCES [dbo].[Dosages]([Id]);

--IF (OBJECT_ID( 'fk_feedSetting_id','F') IS NULL)

--ALTER TABLE [dbo].[FeedItemMapping] ADD CONSTRAINT [fk_feedSetting_id] FOREIGN KEY ([FeedSettingId]) REFERENCES [dbo].[FeedSettingMaster]([id]);

--IF (OBJECT_ID( 'fk_feedItem_id','F') IS NULL)

--ALTER TABLE [dbo].[FeedItemMapping] ADD CONSTRAINT [fk_feedItem_id] FOREIGN KEY ([FeedItemId]) REFERENCES [dbo].[FeedItemMaster]([ID]);

IF (OBJECT_ID( 'Pipeline.FK_CompanyTransactionMapping_Transaction','F') IS NULL)

ALTER TABLE [Pipeline].[CompanyTransactionMapping] ADD CONSTRAINT [FK_CompanyTransactionMapping_Transaction] FOREIGN KEY ([CompanyTransactionId]) REFERENCES [Pipeline].[Transaction]([ID]);

IF (OBJECT_ID( 'Pipeline.FK_RegimenTransactionMapping_Transaction','F') IS NULL)

ALTER TABLE [Pipeline].[RegimenTransactionMapping] ADD CONSTRAINT [FK_RegimenTransactionMapping_Transaction] FOREIGN KEY ([RegimenTransactionId]) REFERENCES [Pipeline].[Transaction]([ID]);

IF (OBJECT_ID( 'Pipeline.FK_ROA_TransactionMapping_Transaction','F') IS NULL)

ALTER TABLE [Pipeline].[ROA_TransactionMapping] ADD CONSTRAINT [FK_ROA_TransactionMapping_Transaction] FOREIGN KEY ([ROA_TransactionId]) REFERENCES [Pipeline].[Transaction]([ID]);

IF (OBJECT_ID( 'Pipeline.FK_ProductTransactionMapping_Transaction','F') IS NULL)

ALTER TABLE [Pipeline].[ProductTransactionMapping] ADD CONSTRAINT [FK_ProductTransactionMapping_Transaction] FOREIGN KEY ([ProductTransactionId]) REFERENCES [Pipeline].[Transaction]([ID]);

IF (OBJECT_ID( 'Pipeline.FK_IndicationTransactionMapping_Transaction','F') IS NULL)

ALTER TABLE [Pipeline].[IndicationTransactionMapping] ADD CONSTRAINT [FK_IndicationTransactionMapping_Transaction] FOREIGN KEY ([IndicationTransactionId]) REFERENCES [Pipeline].[Transaction]([ID]);

IF (OBJECT_ID( 'Pipeline.FK_DiseaseAreaTransactionMapping_Transaction','F') IS NULL)

ALTER TABLE [Pipeline].[DiseaseAreaTransactionMapping] ADD CONSTRAINT [FK_DiseaseAreaTransactionMapping_Transaction] FOREIGN KEY ([DiseaseTransactionId]) REFERENCES [Pipeline].[Transaction]([ID]);

IF (OBJECT_ID( 'Pipeline.FK_MOA_TransactionMapping_Transaction','F') IS NULL)

ALTER TABLE [Pipeline].[MOA_TransactionMapping] ADD CONSTRAINT [FK_MOA_TransactionMapping_Transaction] FOREIGN KEY ([MOA_TransactionId]) REFERENCES [Pipeline].[Transaction]([ID]);

IF (OBJECT_ID( 'Inline.FK_IndicationMapping_IndicationMaster','F') IS NULL)

ALTER TABLE [Inline].[IndicationMapping] ADD CONSTRAINT [FK_IndicationMapping_IndicationMaster] FOREIGN KEY ([IndicationId]) REFERENCES [dbo].[IndicationMaster]([IndicationId]);

IF (OBJECT_ID( 'Pipeline.FK_IndicationTransactionMapping_IndicationMaster','F') IS NULL)

ALTER TABLE [Pipeline].[IndicationTransactionMapping] ADD CONSTRAINT [FK_IndicationTransactionMapping_IndicationMaster] FOREIGN KEY ([IndicationId]) REFERENCES [dbo].[IndicationMaster]([IndicationId]);

IF (OBJECT_ID( 'Pipeline.FK_MOA_TransactionMapping_MOA_Master','F') IS NULL)

ALTER TABLE [Pipeline].[MOA_TransactionMapping] ADD CONSTRAINT [FK_MOA_TransactionMapping_MOA_Master] FOREIGN KEY ([MOA_Id]) REFERENCES [dbo].[MOA_Master]([MOA_Id]);

IF (OBJECT_ID( 'Disease.FK_MoleculeMapping_MoleculeMaster','F') IS NULL)

ALTER TABLE [Disease].[MoleculeMapping] ADD CONSTRAINT [FK_MoleculeMapping_MoleculeMaster] FOREIGN KEY ([MoleculeId]) REFERENCES [dbo].[MoleculeMaster]([MoleculeId]);

IF (OBJECT_ID( 'Inline.FK_MoleculeMapping_MoleculeMaster','F') IS NULL)

ALTER TABLE [Inline].[MoleculeMapping] ADD CONSTRAINT [FK_MoleculeMapping_MoleculeMaster] FOREIGN KEY ([MoleculeId]) REFERENCES [dbo].[MoleculeMaster]([MoleculeId]);

IF (OBJECT_ID( 'Pipeline.FK_Transaction_MoleculeMaster','F') IS NULL)

ALTER TABLE [Pipeline].[Transaction] ADD CONSTRAINT [FK_Transaction_MoleculeMaster] FOREIGN KEY ([MoleculeId]) REFERENCES [dbo].[MoleculeMaster]([MoleculeId]);

IF (OBJECT_ID( 'Pipeline.FK_MoleculeTransactionMapping_MoleculeMaster','F') IS NULL)

ALTER TABLE [Pipeline].[MoleculeTransactionMapping] ADD CONSTRAINT [FK_MoleculeTransactionMapping_MoleculeMaster] FOREIGN KEY ([MoleculeId]) REFERENCES [dbo].[MoleculeMaster]([MoleculeId]);

IF (OBJECT_ID( 'Inline.FK_ExclusivityTransaction_PatentCodeMaster','F') IS NULL)

ALTER TABLE [Inline].[ExclusivityTransaction] ADD CONSTRAINT [FK_ExclusivityTransaction_PatentCodeMaster] FOREIGN KEY ([PatentCodeId]) REFERENCES [dbo].[PatentCodeMaster]([PatentCodeId]);

IF (OBJECT_ID( 'FK_ForumAttachment_ForumQuestion','F') IS NULL)

ALTER TABLE [dbo].[ForumAttachment] ADD CONSTRAINT [FK_ForumAttachment_ForumQuestion] FOREIGN KEY ([QuestionId]) REFERENCES [dbo].[ForumQuestion]([Id]);

IF (OBJECT_ID( 'FK_ForumAnswer_ForumQuestion','F') IS NULL)

ALTER TABLE [dbo].[ForumAnswer] ADD CONSTRAINT [FK_ForumAnswer_ForumQuestion] FOREIGN KEY ([QuestionId]) REFERENCES [dbo].[ForumQuestion]([Id]);

IF (OBJECT_ID( 'Inline.FK_PharmaClassMapping_PharmaClassMaster','F') IS NULL)

ALTER TABLE [Inline].[PharmaClassMapping] ADD CONSTRAINT [FK_PharmaClassMapping_PharmaClassMaster] FOREIGN KEY ([PharmaClassId]) REFERENCES [dbo].[PharmaClassMaster]([PharmaClassId]);

IF (OBJECT_ID( 'Inline.FK_PharmaClassMapping_PharmaClassMaster1','F') IS NULL)

ALTER TABLE [Inline].[PharmaClassMapping] ADD CONSTRAINT [FK_PharmaClassMapping_PharmaClassMaster1] FOREIGN KEY ([PharmaClass2Id]) REFERENCES [dbo].[PharmaClassMaster]([PharmaClassId]);

IF (OBJECT_ID( 'Inline.FK_PharmaClassMapping_PharmaClassMaster2','F') IS NULL)

ALTER TABLE [Inline].[PharmaClassMapping] ADD CONSTRAINT [FK_PharmaClassMapping_PharmaClassMaster2] FOREIGN KEY ([PharmaClass3Id]) REFERENCES [dbo].[PharmaClassMaster]([PharmaClassId]);

IF (OBJECT_ID( 'Inline.FK_PharmaClassMapping_PharmaClassMaster3','F') IS NULL)

ALTER TABLE [Inline].[PharmaClassMapping] ADD CONSTRAINT [FK_PharmaClassMapping_PharmaClassMaster3] FOREIGN KEY ([ImsClassId]) REFERENCES [dbo].[PharmaClassMaster]([PharmaClassId]);

IF (OBJECT_ID( 'Pipeline.FK_Transaction_PharmaClassMaster','F') IS NULL)

ALTER TABLE [Pipeline].[Transaction] ADD CONSTRAINT [FK_Transaction_PharmaClassMaster] FOREIGN KEY ([PrimaryPharmaClassId]) REFERENCES [dbo].[PharmaClassMaster]([PharmaClassId]);

IF (OBJECT_ID( 'Pipeline.FK_Transaction_PharmaClassMaster1','F') IS NULL)

ALTER TABLE [Pipeline].[Transaction] ADD CONSTRAINT [FK_Transaction_PharmaClassMaster1] FOREIGN KEY ([SecondryPharmaClassId]) REFERENCES [dbo].[PharmaClassMaster]([PharmaClassId]);

IF (OBJECT_ID( 'Pipeline.FK_Transaction_PharmaClassMaster2','F') IS NULL)
ALTER TABLE [Pipeline].[Transaction] ADD CONSTRAINT [FK_Transaction_PharmaClassMaster2] FOREIGN KEY ([TertiaryPharmaClassId]) REFERENCES [dbo].[PharmaClassMaster]([PharmaClassId]);

IF (OBJECT_ID( 'Inline.FK_Transaction_PriceSourceMaster','F') IS NULL)
ALTER TABLE [Inline].[Transaction] ADD CONSTRAINT [FK_Transaction_PriceSourceMaster] FOREIGN KEY ([PriceSourceId]) REFERENCES [dbo].PriceSourceMaster(PriceSourceId);

IF (OBJECT_ID( 'Inline.FK_Transaction_NADAC_PricingUnitMaster','F') IS NULL)
ALTER TABLE [Inline].[Transaction] ADD CONSTRAINT FK_Transaction_NADAC_PricingUnitMaster FOREIGN KEY (NADACPricingUnitId) REFERENCES [dbo].NADAC_PricingUnitMaster(NADACPricingUnitId);

--IF (OBJECT_ID( 'Inline.FK_Transaction_MoleculeMaster','F') IS NULL)
--ALTER TABLE [Inline].[Transaction] ADD CONSTRAINT FK_Transaction_MoleculeMaster FOREIGN KEY ([MoleculeId]) REFERENCES [dbo].[MoleculeMaster](MoleculeId);

IF (OBJECT_ID( 'Inline.FK_Transaction_FormMaster','F') IS NULL)
ALTER TABLE [Inline].[Transaction] ADD CONSTRAINT FK_Transaction_FormMaster FOREIGN KEY ([FormId]) REFERENCES [dbo].[FormMaster]([FormId]);


IF (OBJECT_ID( 'Disease.FK_Transaction_RegimenMaster','F') IS NULL)
ALTER TABLE Disease.[Transaction] ADD CONSTRAINT FK_Transaction_RegimenMaster FOREIGN KEY (RegimenId) REFERENCES [dbo].[RegimenMaster](RegimenId);

IF (OBJECT_ID( 'FK_UserAccess_UserMaster','F') IS NULL)
ALTER TABLE UserAccess ADD CONSTRAINT [FK_UserAccess_UserMaster] FOREIGN KEY (UserId) REFERENCES [dbo].[UserMaster]([Id]);

IF (OBJECT_ID( 'FK_UserAccessForecastPlatform_UserMaster','F') IS NULL)
ALTER TABLE UserAccessForecastPlatform ADD CONSTRAINT [FK_UserAccessForecastPlatform_UserMaster] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserMaster]([Id]);

IF (OBJECT_ID( 'FK_UserNotifications_UserMaster','F') IS NULL)
ALTER TABLE [UserNotifications] ADD CONSTRAINT [FK_UserNotifications_UserMaster] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserMaster]([Id]);

END
GO






