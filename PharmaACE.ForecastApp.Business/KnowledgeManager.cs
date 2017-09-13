using Microsoft.Azure;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.StorageClient;
using PharmaACE.ForecastApp.EntityProvider.pacemaster;
using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using EntityFramework.Extensions;
using System.Data.Entity;
using System.Web.Mvc;
using PharmaACE.ForecastApp.EntityProvider.TenantModel;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;

namespace PharmaACE.ForecastApp.Business
{
    public class KnowledgeManager
    {
        private IUnitOfWork uow;
        public KnowledgeManager(IUnitOfWork uow)
        {
            this.uow = uow;
        }

        public AutocompleteListData GetAutocompleteListData()
        {
            AutocompleteListData autocompleteListData = new AutocompleteListData();


            try
            {
                var productsQueryable = uow.MasterContext.ProductMaster.
                    Select(p => new ProductNameListItem { label = p.ProductName, value = p.ProductName }).Distinct().Future();

                var moleculesQueryable = uow.MasterContext.MoleculeMaster.
                    Select(m => new MoleculeNameListItem { label = m.MoleculeName, value = m.MoleculeName }).Distinct().Future();

                var pharmaClassQueryable = uow.MasterContext.PharmaClassMaster.
                    Select(ph => new PharmaClassNameListItem { label = ph.PharmaClass, value = ph.PharmaClass }).Distinct().Future();

                var indicationNameQueryable = uow.MasterContext.IndicationMaster.
                    Select(ind => new IndicationNameListItem { label = ind.IndicationName, value = ind.IndicationName }).Distinct().Future();


                var companyQueryable = uow.MasterContext.CompanyMaster.
                       Select(c => c.CompanyName).ToList();

                var productCategoryQueryable = uow.MasterContext.ProductCategoryMaster.
                    Select(pc => pc.ProductCategory).ToList();

                var substanceQueryable = uow.MasterContext.SubstanceMaster.
                    Select(s => s.SubstanceName).ToList();

                var formNamelist = uow.MasterContext.FormMaster.
                    Select(f => f.FormName).ToList();

                var roaQueryable = uow.MasterContext.ROA_Master.
                      Select(roa => roa.RouteOfAdministration).ToList();

                var diseaseAreaQueryable = uow.MasterContext.DiseaseAreaMaster.
                    Select(dis => dis.DiseaseArea).ToList();

                var moaQueryable = uow.MasterContext.MOA_Master.
                    Select(moa => moa.MOA).ToList();

                var productTypeQueryable = uow.MasterContext.ProductTypeMaster.
                    Select(pt => pt.ProductType).ToList();

                var priceUnitQueryable = uow.MasterContext.NADAC_PricingUnitMaster.
                   Select(pu => pu.NADACPricingUnit).ToList();

                var priceSourceQueryable = uow.MasterContext.PriceSourceMaster.
                    Select(ps => ps.PriceSource).ToList();

                var drugeTypeQueryable = uow.MasterContext.InlineTransaction.
                   Select(dt => dt.DrugType).ToList();

                var strengthQueryable = uow.MasterContext.InlineTransaction.
                  Select(str => str.Strength).ToList();

                autocompleteListData.ProductList = productsQueryable.ToList();
                autocompleteListData.MoleculeList = moleculesQueryable.ToList();
                autocompleteListData.PharmaClassList = pharmaClassQueryable.ToList();
                autocompleteListData.IndicationList = indicationNameQueryable.ToList();

                autocompleteListData.CompanyList = companyQueryable;
                autocompleteListData.ProductCategoryList = productCategoryQueryable;
                autocompleteListData.SubstanceList = substanceQueryable;
                autocompleteListData.FormList = formNamelist;
                autocompleteListData.ROA_MasterList = roaQueryable;
                autocompleteListData.DiseaseAreaList = diseaseAreaQueryable;
                autocompleteListData.MOA_MasterList = moaQueryable;
                autocompleteListData.ProductTypeList = productTypeQueryable;
                autocompleteListData.PriceUnitList = priceUnitQueryable;
                autocompleteListData.PriceSourceList = priceSourceQueryable;
                autocompleteListData.DrugsTypeList = drugeTypeQueryable;
                autocompleteListData.StrengthList = strengthQueryable;
            }
            catch (Exception ex)
            {

            }

            return autocompleteListData;
        }

        public DrugSearchList GetDrugSearchResult(string searchKey, DrugSearchContext searchParam, SearchCondition searchCondition, DrugSearchModule searchModule, byte productCategory)
        {
            DrugSearchList result = new DrugSearchList();
            List<Drug> drugs = new List<Drug>();
            DrugSearchSummary summary = new DrugSearchSummary();
            List<int> inlineEntries = new List<int>();
            List<int> pipelineEntries = new List<int>();
            List<int> genericEntries = new List<int>();
            List<int> brandEntries = new List<int>();
            int count = 0;
            Drug drug = new Drug();
            
                try
                {
                    IQueryable<InlineTransaction> inlineQueryable = null;
                    IQueryable<PipelineSearchData> pipelineQueryable = null;

                    if (searchModule == DrugSearchModule.Inline || searchModule == DrugSearchModule.Both)
                    {
                        inlineQueryable = uow.MasterContext.InlineTransaction.AsQueryable();
                        if (productCategory != 0)
                            inlineQueryable = inlineQueryable.Where(it => it.ProductCategoryId == productCategory);
                        inlineQueryable = FilterInlineDrugsBySearchCriteria(inlineQueryable, searchKey, searchParam, searchCondition, searchModule);
                    }
                        var inlineDrugList = inlineQueryable == null ? null : inlineQueryable
                            .Select(it => new
                            {
                                inlineProductId = it.Id,
                                ProductName = it.ProductMaster.ProductName,
                                CompanyName = it.CompanyMaster.CompanyName,
                                MoleculeName = it.MoleculeMaster.MoleculeName,
                                ProductCategory = it.ProductCategoryMaster.ProductCategory,
                                PHARMA_CLASSES = it.PharmaClassMapping.Select(pcm => pcm.PrimaryPharmaClass.PharmaClass).Distinct(),
                                PHARMA_CLASSES2 = it.PharmaClassMapping.Select(pcm => pcm.SecondaryPharmaClass.PharmaClass).Distinct(),
                                PHARMA_CLASSES3 = it.PharmaClassMapping.Select(pcm => pcm.TartiaryPharmaClass.PharmaClass).Distinct(),
                                Indication = it.IndicationMapping.Select(im => im.IndicationMaster.IndicationName).Distinct(),
                                Phase = it.ProductMaster.InlineTransaction
                                          .Where(pmit => String.Compare(pmit.CompanyMaster.CompanyName, it.CompanyMaster.CompanyName) == 0)
                                          .Select(pmit => pmit.StartMarketingDate).Min(),
                                ROAType = it.ROA_Master.RouteOfAdministration,
                                FormName =it.FormMaster.FormName

                            })
                            .OrderBy(a => a.ProductName)
                            .ThenBy(a => a.CompanyName)
                            .ThenBy(a => a.Phase)
                            .ThenBy(a=>a.FormName)
                            .Future();

                    if (searchModule == DrugSearchModule.Pipeline || searchModule == DrugSearchModule.Both)
                    {
                        pipelineQueryable = uow.MasterContext.PipelineSearchData.AsQueryable();
                        if (productCategory != 0)
                            pipelineQueryable = pipelineQueryable.Where(it => String.Compare(it.ProductCategory, uow.MasterContext.ProductCategoryMaster.Where(pcm => pcm.ProductCategoryId == productCategory).Select(pcm => pcm.ProductCategory).Single(), true) == 0);
                        pipelineQueryable = FilterPipelineDrugsBySearchCriteria(pipelineQueryable, searchKey, searchParam, searchCondition, searchModule);
                    }
                var pipelineDrugList = pipelineQueryable == null ? null : pipelineQueryable
                    .Select(it => new Drug
                    {
                        ProductName = it.ProductName,
                        CompanyName = it.CompanyName,
                        MoleculeName = it.MoleculeName,
                        ProductCategory = it.ProductCategory,
                        PHARMA_CLASSES = it.PrimaryPharmaClass,
                        PHARMA_CLASSES2 = it.SecondaryPharmaClass,
                        PHARMA_CLASSES3 = it.TertiaryPharmaClass,
                        Indication = it.Indication,
                        Phase = it.Phase,
                        ROAType = it.ROA,
                        Module = (int)DrugSearchModule.Pipeline,
                        FormName = null
                        })
                            .Distinct()
                            .OrderBy(a => a.ProductName)
                            .ThenBy(a => a.CompanyName)
                            .ThenBy(a => a.Phase)
                         
                            .Future();


                    if (inlineDrugList != null)
                    {
                        drugs = inlineDrugList.ToList()
                            .Select(d => new Drug
                            {
                                InlineId = d.inlineProductId,
                                ProductName = d.ProductName,
                                CompanyName = d.CompanyName,
                                MoleculeName = d.MoleculeName,
                                ProductCategory = d.ProductCategory,
                                PHARMA_CLASSES = String.Join(",", d.PHARMA_CLASSES.OrderBy(pcm=>pcm)),
                                PHARMA_CLASSES2 = String.Join(",", d.PHARMA_CLASSES2.OrderBy(pcm1=>pcm1)),
                                PHARMA_CLASSES3 = String.Join(",", d.PHARMA_CLASSES3.OrderBy(pcm2=>pcm2)),
                                Indication = String.Join(",", d.Indication.OrderBy(ind => ind)),
                                Phase = String.Join(",", d.Phase.HasValue ? d.Phase.Value.ToString("MM/dd/yyyy") : String.Empty),
                                ROAType = d.ROAType,
                                Module = (int)DrugSearchModule.Inline,
                                FormName=d.FormName
                            })
                        .Distinct(new DrugComparer())
                        .ToList();
                    }
                    if(pipelineDrugList != null)
                    {
                        drugs = drugs.Union(pipelineDrugList).ToList();
                    }

                    foreach (var value in drugs)
                    {
                        if (value.Module == 1)
                        {
                            inlineEntries.Add(count);
                            if (String.Compare(value.ProductCategory, "Generic") == 0)
                                genericEntries.Add(count);
                            else if (String.Compare(value.ProductCategory, "Brand") == 0)
                                brandEntries.Add(count);
                        }
                        else
                            pipelineEntries.Add(count);
                        count++;
                    }
                    summary.InlineEntries = inlineEntries;
                    summary.PipelineEntries = pipelineEntries;
                    summary.GenericEntries = genericEntries;
                    summary.BrandEntries = brandEntries;
                    result.Summary = summary;
                    result.DrugsList = drugs;

                }
                catch (Exception ex)
                {

                }
            
            return result;
        }

        private IQueryable<InlineTransaction> FilterInlineDrugsBySearchCriteria(IQueryable<InlineTransaction> inlineQueryable, string searchKey, 
            DrugSearchContext searchContext, SearchCondition searchCondition, DrugSearchModule searchModule)
        {
            switch (searchCondition)
            {
                case SearchCondition.Contains:
                    inlineQueryable = FilterInlineDrugsIfContainsSearchContext(inlineQueryable, searchKey, searchContext);
                    break;
                case SearchCondition.StartsWith:
                    inlineQueryable = FilterInlineDrugsIfStartsWithSearchContext(inlineQueryable, searchKey, searchContext);
                    break;
                case SearchCondition.EndsWith:
                    inlineQueryable = FilterInlineDrugsIfEndsWithSearchContext(inlineQueryable, searchKey, searchContext);
                    break;
                case SearchCondition.Exact:
                    inlineQueryable = FilterInlineDrugsIfEqualsSearchContext(inlineQueryable, searchKey, searchContext);
                    break;
                default:
                    break;
            }

            return inlineQueryable;
        }

        private IQueryable<InlineTransaction> FilterInlineDrugsIfContainsSearchContext(IQueryable<InlineTransaction> inlineQueryable, string searchKey, 
            DrugSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DrugSearchContext.ByProductName:
                    inlineQueryable = inlineQueryable.Where(tr => tr.ProductMaster.ProductName.Contains(searchKey));
                    break;
                case DrugSearchContext.ByMoleculeName:
                    inlineQueryable = inlineQueryable.Where(tr => tr.MoleculeMaster.MoleculeName.Contains(searchKey));
                    break;
                case DrugSearchContext.ByPharmaClass:
                    inlineQueryable = inlineQueryable.Where(tr => tr.PharmaClassMapping.Any(pcm => pcm.PrimaryPharmaClass.PharmaClass.Contains(searchKey)
                                                                                                || pcm.SecondaryPharmaClass.PharmaClass.Contains(searchKey)
                                                                                                || pcm.TartiaryPharmaClass.PharmaClass.Contains(searchKey)));
                    break;
                case DrugSearchContext.ByIndication:
                    inlineQueryable = inlineQueryable.Where(tr => tr.IndicationMapping.Any(im => im.IndicationMaster.IndicationName.Contains(searchKey)));
                    break;
                case DrugSearchContext.ByManufacturer:
                    inlineQueryable = inlineQueryable.Where(tr => tr.CompanyMaster.CompanyName.Contains(searchKey));
                    break;
                case DrugSearchContext.ByCategory:
                    inlineQueryable = inlineQueryable.Where(tr => tr.ProductCategoryMaster.ProductCategory.Contains(searchKey));
                    break;
                default:
                    break;
            }

            return inlineQueryable;
        }

        private IQueryable<InlineTransaction> FilterInlineDrugsIfStartsWithSearchContext(IQueryable<InlineTransaction> inlineQueryable, string searchKey,
            DrugSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DrugSearchContext.ByProductName:
                    inlineQueryable = inlineQueryable.Where(tr => tr.ProductMaster.ProductName.StartsWith(searchKey));
                    break;
                case DrugSearchContext.ByMoleculeName:
                    inlineQueryable = inlineQueryable.Where(tr => tr.MoleculeMaster.MoleculeName.StartsWith(searchKey));
                    break;
                case DrugSearchContext.ByPharmaClass:
                    inlineQueryable = inlineQueryable.Where(tr => tr.PharmaClassMapping.Any(pcm => pcm.PrimaryPharmaClass.PharmaClass.StartsWith(searchKey)
                                                                                                || pcm.SecondaryPharmaClass.PharmaClass.StartsWith(searchKey)
                                                                                                || pcm.TartiaryPharmaClass.PharmaClass.StartsWith(searchKey)));
                    break;
                case DrugSearchContext.ByIndication:
                    inlineQueryable = inlineQueryable.Where(tr => tr.IndicationMapping.Any(im => im.IndicationMaster.IndicationName.StartsWith(searchKey)));
                    break;
                case DrugSearchContext.ByManufacturer:
                    inlineQueryable = inlineQueryable.Where(tr => tr.CompanyMaster.CompanyName.StartsWith(searchKey));
                    break;
                case DrugSearchContext.ByCategory:
                    inlineQueryable = inlineQueryable.Where(tr => tr.ProductCategoryMaster.ProductCategory.StartsWith(searchKey));
                    break;
                default:
                    break;
            }

            return inlineQueryable;
        }

        private IQueryable<InlineTransaction> FilterInlineDrugsIfEndsWithSearchContext(IQueryable<InlineTransaction> inlineQueryable, string searchKey,
            DrugSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DrugSearchContext.ByProductName:
                    inlineQueryable = inlineQueryable.Where(tr => tr.ProductMaster.ProductName.EndsWith(searchKey));
                    break;
                case DrugSearchContext.ByMoleculeName:
                    inlineQueryable = inlineQueryable.Where(tr => tr.MoleculeMaster.MoleculeName.EndsWith(searchKey));
                    break;
                case DrugSearchContext.ByPharmaClass:
                    inlineQueryable = inlineQueryable.Where(tr => tr.PharmaClassMapping.Any(pcm => pcm.PrimaryPharmaClass.PharmaClass.EndsWith(searchKey)
                                                                                                || pcm.SecondaryPharmaClass.PharmaClass.EndsWith(searchKey)
                                                                                                || pcm.TartiaryPharmaClass.PharmaClass.EndsWith(searchKey)));
                    break;
                case DrugSearchContext.ByIndication:
                    inlineQueryable = inlineQueryable.Where(tr => tr.IndicationMapping.Any(im => im.IndicationMaster.IndicationName.EndsWith(searchKey)));
                    break;
                case DrugSearchContext.ByManufacturer:
                    inlineQueryable = inlineQueryable.Where(tr => tr.CompanyMaster.CompanyName.EndsWith(searchKey));
                    break;
                case DrugSearchContext.ByCategory:
                    inlineQueryable = inlineQueryable.Where(tr => tr.ProductCategoryMaster.ProductCategory.EndsWith(searchKey));
                    break;
                default:
                    break;
            }

            return inlineQueryable;
        }

        private IQueryable<InlineTransaction> FilterInlineDrugsIfEqualsSearchContext(IQueryable<InlineTransaction> inlineQueryable, string searchKey,
            DrugSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DrugSearchContext.ByProductName:
                    inlineQueryable = inlineQueryable.Where(tr => String.Compare(tr.ProductMaster.ProductName, searchKey, true) == 0);
                    break;
                case DrugSearchContext.ByMoleculeName:
                    inlineQueryable = inlineQueryable.Where(tr => String.Compare(tr.MoleculeMaster.MoleculeName, searchKey, true) == 0);
                    break;
                case DrugSearchContext.ByPharmaClass:
                    inlineQueryable = inlineQueryable.Where(tr => tr.PharmaClassMapping.Any(pcm => String.Compare(pcm.PrimaryPharmaClass.PharmaClass, searchKey, true) == 0
                                                                                                || String.Compare(pcm.SecondaryPharmaClass.PharmaClass, searchKey, true) == 0
                                                                                                || String.Compare(pcm.TartiaryPharmaClass.PharmaClass, searchKey, true) == 0));
                    break;
                case DrugSearchContext.ByIndication:
                    inlineQueryable = inlineQueryable.Where(tr => tr.IndicationMapping.Any(im => String.Compare(im.IndicationMaster.IndicationName, searchKey, true) == 0));
                    break;
                case DrugSearchContext.ByManufacturer:
                    inlineQueryable = inlineQueryable.Where(tr => String.Compare(tr.CompanyMaster.CompanyName, searchKey, true) == 0);
                    break;
                case DrugSearchContext.ByCategory:
                    inlineQueryable = inlineQueryable.Where(tr => String.Compare(tr.ProductCategoryMaster.ProductCategory, searchKey, true) == 0);
                    break;
                default:
                    break;
            }

            return inlineQueryable;
        }

        private IQueryable<PipelineSearchData> FilterPipelineDrugsBySearchCriteria(IQueryable<PipelineSearchData> pipelineQueryable, string searchKey,
            DrugSearchContext searchContext, SearchCondition searchCondition, DrugSearchModule searchModule)
        {
            switch (searchCondition)
            {
                case SearchCondition.Contains:
                    pipelineQueryable = FilterPipelineDrugsIfContainsSearchContext(pipelineQueryable, searchKey, searchContext);
                    break;
                case SearchCondition.StartsWith:
                    pipelineQueryable = FilterPipelineDrugsIfStartsWithSearchContext(pipelineQueryable, searchKey, searchContext);
                    break;
                case SearchCondition.EndsWith:
                    pipelineQueryable = FilterPipelineDrugsIfEndsWithSearchContext(pipelineQueryable, searchKey, searchContext);
                    break;
                case SearchCondition.Exact:
                    pipelineQueryable = FilterPipelineDrugsIfEqualsSearchContext(pipelineQueryable, searchKey, searchContext);
                    break;
                default:
                    break;
            }

            return pipelineQueryable;
        }

        private IQueryable<PipelineSearchData> FilterPipelineDrugsIfContainsSearchContext(IQueryable<PipelineSearchData> pipelineQueryable, string searchKey,
            DrugSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DrugSearchContext.ByProductName:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.ProductName.Contains(searchKey));
                    break;
                case DrugSearchContext.ByMoleculeName:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.MoleculeName.Contains(searchKey));
                    break;
                case DrugSearchContext.ByPharmaClass:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.PrimaryPharmaClass.Contains(searchKey)
                                                                   || tr.SecondaryPharmaClass.Contains(searchKey)
                                                                   || tr.TertiaryPharmaClass.Contains(searchKey));
                    break;
                case DrugSearchContext.ByIndication:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.Indication.Contains(searchKey));
                    break;
                case DrugSearchContext.ByManufacturer:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.CompanyName.Contains(searchKey));
                    break;
                case DrugSearchContext.ByCategory:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.ProductCategory.Contains(searchKey));
                    break;
                default:
                    break;
            }

            return pipelineQueryable;
        }

        private IQueryable<PipelineSearchData> FilterPipelineDrugsIfStartsWithSearchContext(IQueryable<PipelineSearchData> pipelineQueryable, string searchKey,
            DrugSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DrugSearchContext.ByProductName:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.ProductName.StartsWith(searchKey));
                    break;
                case DrugSearchContext.ByMoleculeName:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.MoleculeName.StartsWith(searchKey));
                    break;
                case DrugSearchContext.ByPharmaClass:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.PrimaryPharmaClass.StartsWith(searchKey)
                                                               || tr.SecondaryPharmaClass.StartsWith(searchKey)
                                                               || tr.TertiaryPharmaClass.StartsWith(searchKey));
                    break;
                case DrugSearchContext.ByIndication:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.Indication.StartsWith(searchKey));
                    break;
                case DrugSearchContext.ByManufacturer:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.CompanyName.StartsWith(searchKey));
                    break;
                case DrugSearchContext.ByCategory:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.ProductCategory.StartsWith(searchKey));
                    break;
                default:
                    break;
            }

            return pipelineQueryable;
        }

        private IQueryable<PipelineSearchData> FilterPipelineDrugsIfEndsWithSearchContext(IQueryable<PipelineSearchData> pipelineQueryable, string searchKey,
            DrugSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DrugSearchContext.ByProductName:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.ProductName.EndsWith(searchKey));
                    break;
                case DrugSearchContext.ByMoleculeName:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.MoleculeName.EndsWith(searchKey));
                    break;
                case DrugSearchContext.ByPharmaClass:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.PrimaryPharmaClass.EndsWith(searchKey)
                                                                   || tr.SecondaryPharmaClass.EndsWith(searchKey)
                                                                   || tr.TertiaryPharmaClass.EndsWith(searchKey));
                    break;
                case DrugSearchContext.ByIndication:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.Indication.EndsWith(searchKey));
                    break;
                case DrugSearchContext.ByManufacturer:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.CompanyName.EndsWith(searchKey));
                    break;
                case DrugSearchContext.ByCategory:
                    pipelineQueryable = pipelineQueryable.Where(tr => tr.ProductCategory.EndsWith(searchKey));
                    break;
                default:
                    break;
            }

            return pipelineQueryable;
        }

        private IQueryable<PipelineSearchData> FilterPipelineDrugsIfEqualsSearchContext(IQueryable<PipelineSearchData> pipelineQueryable, string searchKey,
            DrugSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DrugSearchContext.ByProductName:
                    pipelineQueryable = pipelineQueryable.Where(tr => String.Compare(tr.ProductName, searchKey, true) == 0);
                    break;
                case DrugSearchContext.ByMoleculeName:
                    pipelineQueryable = pipelineQueryable.Where(tr => String.Compare(tr.MoleculeName, searchKey, true) == 0);
                    break;
                case DrugSearchContext.ByPharmaClass:
                    pipelineQueryable = pipelineQueryable.Where(tr => String.Compare(tr.PrimaryPharmaClass, searchKey, true) == 0
                                                                   || String.Compare(tr.SecondaryPharmaClass, searchKey, true) == 0
                                                                   || String.Compare(tr.TertiaryPharmaClass, searchKey, true) == 0);
                    break;
                case DrugSearchContext.ByIndication:
                    pipelineQueryable = pipelineQueryable.Where(tr => String.Compare(tr.Indication, searchKey, true) == 0);
                    break;
                case DrugSearchContext.ByManufacturer:
                    pipelineQueryable = pipelineQueryable.Where(tr => String.Compare(tr.CompanyName, searchKey, true) == 0);
                    break;
                case DrugSearchContext.ByCategory:
                    pipelineQueryable = pipelineQueryable.Where(tr => String.Compare(tr.ProductCategory, searchKey, true) == 0);
                    break;
                default:
                    break;
            }

            return pipelineQueryable;
        }

        public ProductDetail GetProductDetailByProductName(string productName, string companyName, string dosageForm)
        {
            ProductDetail productDetail = null;

            try
            {
                var productDetailAnonymousList = uow.MasterContext.InlineTransaction
                    .Where(it => it.ProductMaster.ProductName == productName && it.CompanyMaster.CompanyName == companyName && it.FormMaster.FormName == dosageForm)
                    .Select(it => new
                    {
                        DosageAdult = it.DosageAdult,
                        DosagePediatric = it.DosagePediatric,

                        FormNames = it.FormMaster.FormName,
                        Indication = it.IndicationMapping.Select(im => im.IndicationMaster.IndicationName).Distinct(),
                        MOA = it.MOA,
                        MoleculeName = it.MoleculeMapping.Select(mm => mm.MoleculeMaster.MoleculeName).Distinct(),
                        NADAC_Price = it.ProductMaster.InlineTransaction.Where(pmit => pmit.CompanyId == it.CompanyId && pmit.FormId == it.FormId).Select(pmit => pmit.Strength + "-" + (String.IsNullOrEmpty(pmit.NADAC_Price) ? " Not Available" : " $" + pmit.NADAC_Price)).Distinct(),
                        PharmaClass = it.PharmaClassMapping.Select(pcm => pcm.PrimaryPharmaClass.PharmaClass).Distinct(),
                        ProductCategory = it.ProductCategoryMaster.ProductCategory,
                        RouteOfAdministration = it.ROA_Master.RouteOfAdministration,
                        StartMarketingDate = it.ProductMaster.InlineTransaction.Where(pmit => pmit.CompanyId == it.CompanyId).Select(pmit => pmit.StartMarketingDate).Min(),
                        Strength = it.ProductMaster.InlineTransaction.Where(pmit => pmit.CompanyId == it.CompanyId && pmit.FormId == it.FormId).Select(pmit => pmit.Strength).Distinct(),
                        SubIndication = it.SubIndication,
                        NADACPricingUnit = it.NADAC_PricingUnitMaster.NADACPricingUnit,
                        ProductCode = it.ProductCodeMaster.ProductCode


                        ,
                        ApplicationShortNumber = it.ApplicationShortNumber,
                        ProductUID = it.ProductUID,
                        ProductNDC = it.ProductNDC,
                        SubstanceName = it.SubstanceMaster.SubstanceName,
                        PriceSource = it.PriceSourceMaster.PriceSource,
                        PHARMA_CLASSES2 = it.PharmaClassMapping.Select(pcm => pcm.SecondaryPharmaClass.PharmaClass).Distinct(),
                        PHARMA_CLASSES3 = it.PharmaClassMapping.Select(pcm => pcm.TartiaryPharmaClass.PharmaClass).Distinct(),
                        IMSClass = it.PharmaClassMapping.Select(pcm => pcm.IMSPharmaClass.PharmaClass).Distinct(),
                        MarketingPartner = it.CompanyMaster1.CompanyName,
                        Approval_Date = it.ApprovalDate,
                        Product_Type = it.ProductTypeMaster.ProductType,
                        Drug_Type = it.DrugType,
                        MarketingStatus = it.MarketingStatus,
                        LatestLabelDate = it.LatestLabelDate,
                        RLD = it.RLD,
                        TECode = it.TECode,
                        Price = it.NADAC_Price,
                        Disease_Area = it.DiseaseAreaMapping.Select(im => im.DiseaseAreaMaster.DiseaseArea).Distinct(),
                        InlineTransactionId = it.Id

                    })
                    .ToList();
                var productDetailAnonymous = productDetailAnonymousList.FirstOrDefault();

                productDetail = new ProductDetail
                {
                    CompanyName = companyName,
                    Dosage_Adult = productDetailAnonymous.DosageAdult,
                    Dosage_Pediatric = productDetailAnonymous.DosagePediatric,
                    FormName = String.Join(",", productDetailAnonymous.FormNames),
                    Indication = String.Join(",", productDetailAnonymous.Indication),
                    MOA = productDetailAnonymous.MOA,
                    MoleculeName = String.Join(",", productDetailAnonymous.MoleculeName),
                    NADAC_Price = String.Join(",", productDetailAnonymous.NADAC_Price),
                    PHARMA_CLASSES = String.Join(",", productDetailAnonymous.PharmaClass),
                    ProductCategory = productDetailAnonymous.ProductCategory,
                    ProductName = productName,
                    ROAType = productDetailAnonymous.RouteOfAdministration,
                    StartMarketingDate = productDetailAnonymous.StartMarketingDate ?? null,
                    Strength = String.Join(",", productDetailAnonymous.Strength).Trim(),
                    Sub_Indication = productDetailAnonymous.SubIndication,
                    NADAC_PricingUnit = productDetailAnonymous.NADACPricingUnit,
                    EPDetails = productDetailAnonymous.ProductCode,



                    Application_Short_Number = productDetailAnonymous.ApplicationShortNumber,
                    Product_ID = productDetailAnonymous.ProductUID,
                    Product_NDC = productDetailAnonymous.ProductNDC,
                    Product_Code = productDetailAnonymous.ProductCode,
                    Substance = productDetailAnonymous.SubstanceName,
                    Price_Source = productDetailAnonymous.PriceSource,
                    PHARMA_CLASSES2 = String.Join(",", productDetailAnonymous.PHARMA_CLASSES2),
                    PHARMA_CLASSES3 = String.Join(",", productDetailAnonymous.PHARMA_CLASSES3),
                    IMSClass = String.Join(",", productDetailAnonymous.IMSClass),
                    MarketingPartner = productDetailAnonymous.MarketingPartner,
                    Approval_Date = productDetailAnonymous.Approval_Date.SafeToDateTime(),
                    Product_Type = productDetailAnonymous.Product_Type,
                    Drug_Type = productDetailAnonymous.Drug_Type,
                    MarketingStatus = productDetailAnonymous.MarketingStatus.SafeToNum(),
                    LatestLabelDate = productDetailAnonymous.LatestLabelDate.SafeToDateTime(),
                    RLD = productDetailAnonymous.RLD.SafeToBool(),
                    TECode = productDetailAnonymous.TECode,
                    Price = productDetailAnonymous.Price,
                    Disease_Area = productDetailAnonymous.Disease_Area.ToList(),
                    InlineTransactionId = productDetailAnonymous.InlineTransactionId

                };
            }

            catch (Exception ex)
            {

            }

            return productDetail;
        }
        //public List<PipelineProductDetail> GetPipeLineProductDetailByProductName(string productName, string companyName, string phase)
        //{
        //    List<PipelineProductDetail> pipelineProductDetail = new List<PipelineProductDetail>();
        //    using (var context = new MasterModel(GenUtil.PaceMasterconnectionstringurl))
        //    {
        //        try
        //        {
        //            pipelineProductDetail = context.PipelineTransaction
        //                .Where(pt => String.Compare(pt.PhaseMaster.Phase, phase, true) == 0
        //                            && String.Compare(pt.ProductTransactionMapping.ProductMaster.ProductName, productName, true) == 0
        //                            && String.Compare(pt.CompanyTransactionMapping.CompanyMaster.CompanyName, companyName, true) == 0)
        //                .Select(pt => new
        //                {
        //                    MoleculeName = pt.MoleculeMaster.MoleculeName,
        //                    PharmaClass = pt.PharmaClassMapping.Select(pcm => pcm.PrimaryPharmaClass.PharmaClass).Distinct(),

        //                })
        //                .Select(d => new PipelineProductDetail
        //                {
        //                    AnalystEstimate = d.AnalystEstimates.SafeTrim(),
        //                    DetailedIndication = d.DetailedIndication.SafeTrim(),
        //                    DevelopmentPhase = d.DevelopmentPhase.SafeTrim(),
        //                    DiseaseArea = d.DiseaseArea.SafeTrim(),
        //                    // EstimateLaunchDate = d.EstimatedLaunchDate.HasValue ? d.EstimatedLaunchDate.ToString() : null   
        //                    EstimateLaunchDate = d.EstimatedLaunchDate.SafeToDateTime(),
        //                    ExpectedCompletionDate = d.ExpectedCompletionDate.SafeToDateTime(),
        //                    Indication = d.Indication.SafeTrim().Trim(','),
        //                    LatestDevelopmentStatus = d.LatestDevelopmentStatus,
        //                    MOA = d.MOA.SafeTrim(),
        //                    MoleculeName = d.MoleculeName.SafeTrim().Trim(','),
        //                    NCT = d.NCT.SafeTrim(),
        //                    PHARMA_CLASSES = d.PharmaClass.SafeTrim().Trim(','),
        //                    ProductName = d.ProductName.SafeTrim(),
        //                    StudyTitle = d.StudyTitle.SafeTrim(),
        //                    Regimen = d.TreatmentRegimen.SafeTrim(),
        //                    CompanyName = companyName,
        //                    Dosage_Adult = System.Net.WebUtility.HtmlDecode(d.dosage)
        //                    //Dosage_Adult = d.dosage
        //                }).ToList();
        //        }
        //        catch (Exception ex)
        //        {

        //        }
        //    }
        //    return pipelineProductDetail;
        //}


        public List<PipelineProductDetail> GetPipeLineProductDetailByProductName(string productName, string companyName, string phase)
        {
            DataTable tblProductDetail = null;
            List<PipelineProductDetail> pipelineProductDetail = new List<PipelineProductDetail>();
            try
            {
                using (var conn = new SqlConnection(GenUtil.MasterModelConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("[dbo].[uspGetPipelineProductDetails]", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter product = cmd.Parameters.Add("@ProductName", SqlDbType.VarChar, 500);
                    product.Direction = ParameterDirection.Input;
                    product.Value = productName;

                    SqlParameter company = cmd.Parameters.Add("@CompanyName", SqlDbType.VarChar, 500);
                    company.Direction = ParameterDirection.Input;
                    company.Value = companyName;

                    SqlParameter productPhase = cmd.Parameters.Add("@Phase", SqlDbType.VarChar, 500);
                    productPhase.Direction = ParameterDirection.Input;
                    productPhase.Value = phase;


                    SqlDataAdapter adp = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    adp.Fill(ds);
                   // if (ds.HasData())
                        tblProductDetail = ds.Tables[0];
                    if (tblProductDetail.Rows.Count>=1)
                    {
                        foreach (DataRow row in tblProductDetail.Rows)
                        {
                            PipelineProductDetail productDetail = new PipelineProductDetail();

                            productDetail.ProductName = row["ProductName"].SafeTrim();
                            productDetail.MoleculeName = row["MoleculeName"].SafeTrim().Trim(',');
                            productDetail.CompanyName = companyName;
                            productDetail.PHARMA_CLASSES = row["PharmaClass"].SafeTrim().Trim(',');
                            productDetail.MOA = row["MOA"].SafeTrim();
                            string AdultDosage = row["Dosage"].SafeTrim().Replace("\"Dosage :", string.Empty);
                            if (!String.IsNullOrEmpty(AdultDosage))
                                productDetail.Dosage_Adult = GenUtil.FormatStringWithBullet(AdultDosage, GenUtil.lineSeperator, GenUtil.BulletSeperator).Replace("\n", string.Empty);
                            productDetail.LatestDevelopmentStatus = row["LatestDevelopmentStatus"].SafeTrim();
                            if (row["EstimatedLaunchDate"].ToString() != "")
                                productDetail.EstimateLaunchDate = row["EstimatedLaunchDate"].SafeToDateTime();
                            productDetail.AnalystEstimate = row["AnalystEstimates"].SafeTrim();
                            productDetail.Regimen = row["TreatmentRegimen"].SafeTrim();
                            productDetail.DiseaseArea = row["DiseaseArea"].SafeTrim();
                            productDetail.Indication = row["Indication"].SafeTrim().Trim(',');
                            productDetail.DetailedIndication = row["DetailedIndication"].SafeTrim();
                            productDetail.StudyTitle = row["StudyTitle"].SafeTrim();
                            productDetail.DevelopmentPhase = row["StatsWithDevPhase"].SafeTrim();
                            productDetail.ExpectedCompletionDate = row["ExpectedCompletionDate"].SafeToDateTime();
                            productDetail.NCT = row["NCT"].SafeTrim();
                            // productDetail.ROAType = row["RouteOfAdministration"].SafeTrim();
                            // productDetail.ProductCategory = row["ProductCategory"].SafeTrim();

                            pipelineProductDetail.Add(productDetail);

                        }
                    }


                }

            }
            catch (Exception ex)
            {

            }

            return pipelineProductDetail;
        }


        public List<DevelopmentStatus> GetProductDetailByStatusName(DrugSearchModule status)
        {
            List<DevelopmentStatus> developmentStatusDetailsList = new List<DevelopmentStatus>();
            
            
                try
                {
                    //no data for pipeline
                    if (status == DrugSearchModule.Inline)
                    {
                        developmentStatusDetailsList = uow.MasterContext.InlineTransaction
                                .Select(it => new
                                {
                                    ProductName = it.ProductMaster.ProductName,
                                    CompanyName = it.CompanyMaster.CompanyName,
                                    FormNames = it.ProductMaster.InlineTransaction.Where(pmit => pmit.CompanyId == it.CompanyId).Select(pmit => pmit.FormMaster.FormName).Distinct(),
                                    PharmaClass = it.PharmaClassMapping.Select(pcm => pcm.PrimaryPharmaClass.PharmaClass).Distinct(),
                                    PharmaClass2 = it.PharmaClassMapping.Select(pcm => pcm.SecondaryPharmaClass.PharmaClass).Distinct(),
                                    PharmaClass3 = it.PharmaClassMapping.Select(pcm => pcm.TartiaryPharmaClass.PharmaClass).Distinct(),
                                    ImsClass = it.PharmaClassMapping.Select(pcm => pcm.IMSPharmaClass.PharmaClass).Distinct(),
                                    StartMarketingDate = it.ProductMaster.InlineTransaction.Select(pmit => pmit.StartMarketingDate).Min()
                                })
                                .ToList()
                            .Select(d => new DevelopmentStatus
                            {
                                ProductName = d.ProductName,
                                PHARMA_CLASSES = String.Join(",", d.PharmaClass),
                                PHARMA_CLASSES2 = String.Join(",", d.PharmaClass2),
                                PHARMA_CLASSES3 = String.Join(",", d.PharmaClass3),
                                IMSClass = String.Join(",", d.ImsClass),
                                CompanyName = String.Join(",", d.CompanyName),
                                FormName = String.Join(",", d.FormNames),
                                StartMarketingdate = d.StartMarketingDate.SafeToDateTime()
                            }).ToList();
                    }
                }
                catch (Exception ex)
                {

                }
            
            return developmentStatusDetailsList;
        }

        public List<PatentDetail> GetPatentDetailByProductCode(string productCode)
        {
            List<PatentDetail> patentDetaislList = new List<PatentDetail>();
            
                try
                {
                    patentDetaislList = uow.MasterContext.ExclusivityTransaction
                        .Where(et => String.Compare(et.ProductCodeMaster.ProductCode, productCode) == 0
                                    && et.ProductCodeId != null 
                                    && et.PatentCodeId != null)
                        .Select(et => new PatentDetail
                        {
                            ProductCode = productCode,
                            PatentCode = et.PatentCodeMaster.PatentCode,
                            PatentDefinition = et.PatentCodeMaster.Definition,
                            ExclusivityCode = et.ExclusivityCodeMaster.ExclusivityCode,
                            ExclusivityDefinition = et.ExclusivityCodeMaster.Definition,
                            PatentNo = et.PatentNo,
                            PatentExpireDate = et.PatentExpireDate,
                            ExclusivityDate = et.ExclusivityDate
                        })
                        .Distinct()
                        .ToList();
                }
                catch (Exception ex)
                {

                }
            
            return patentDetaislList;
        }

        public NewsDetails GetNewsDetailsProductWise(string productName, int subscriberId)
        {
            NewsDetails newsDetails = new NewsDetails();
            List<string> indicationList = new List<string>();
            List<string> diseaseList = new List<string>();
            
                try
                {
                    var lst = uow.MasterContext.InlineTransaction
                        .Where(it => String.Compare(it.ProductMaster.ProductName, productName, true) == 0)
                        .Select(it => new
                        {
                            DiseaseAreas = it.DiseaseAreaMaster.Select(dam => dam.DiseaseArea).Distinct(),
                            Indications = it.IndicationMapping.Select(im => im.IndicationMaster.IndicationName).Distinct()
                        })
                        .ToList();

                    newsDetails.DiseaseAreas = lst.SelectMany(item => item.DiseaseAreas).Distinct().ToList();
                    newsDetails.Indications = lst.SelectMany(item => item.Indications).Distinct().ToList();
                }

                catch (Exception ex)
                {

                }
            
            return newsDetails;
        }

        public List<Indications> GetIndicationsByDiseaseAreaName(string diseaseAreaName)
        {
            List<Indications> result = new List<Indications>();
            
                try
                {
                    result = uow.MasterContext.DiseaseIndicationData
                        .Where(dt => String.Compare(dt.DiseaseAreaMaster.DiseaseArea, diseaseAreaName, true) == 0)
                        .Select(dt => new Indications { Indication = dt.IndicationMaster1.IndicationName }).Distinct()
                        .ToList();
                }
                catch (Exception ex)
                {

                }
            
            return result;
        }

        public DiseaseAreaSearchResult GetDiseaseAreaSearchResultbySearchKey(string keyword, SearchCondition searchCondition)
        {
            DiseaseAreaSearchResult searchResult = new DiseaseAreaSearchResult();
            
                try
                {
                    var diseaseTransQueryable = uow.MasterContext.DiseaseIndicationData.AsQueryable();
                    var therapyAreas = FilterDiseaseAreaBySearchCriteria(diseaseTransQueryable, keyword, DiseaseAreaSearchContext.ByDisease, searchCondition)
                        .Select(dq => new TherapyAreas { TherapyArea = dq.DiseaseAreaMaster.DiseaseArea })
                        .Distinct()
                        .Future();
                    var indications = FilterDiseaseAreaBySearchCriteria(diseaseTransQueryable, keyword, DiseaseAreaSearchContext.ByIndication, searchCondition)
                        .Select(dq => new Indications { Indication = dq.IndicationMaster.IndicationName })
                        .Distinct()
                        .Future();

                    searchResult.TherapyAreasList = therapyAreas.ToList();
                    searchResult.IndicationsList = indications.ToList();
                }
                catch (Exception ex)
                {

                }
            
            return searchResult;
        }

        private IQueryable<DiseaseIndicationData> FilterDiseaseAreaBySearchCriteria(IQueryable<DiseaseIndicationData> daQueryable, string searchKey,
            DiseaseAreaSearchContext searchContext, SearchCondition searchCondition)
        {
            switch (searchCondition)
            {
                case SearchCondition.Contains:
                    daQueryable = FilterDiseaseAreaIfContainsSearchContext(daQueryable, searchKey, searchContext);
                    break;
                case SearchCondition.StartsWith:
                    daQueryable = FilterDiseaseAreaIfStartsWithSearchContext(daQueryable, searchKey, searchContext);
                    break;
                case SearchCondition.EndsWith:
                    daQueryable = FilterDiseaseAreaIfEndsWithSearchContext(daQueryable, searchKey, searchContext);
                    break;
                case SearchCondition.Exact:
                    daQueryable = FilterDiseaseAreaIfEqualsSearchContext(daQueryable, searchKey, searchContext);
                    break;
                default:
                    break;
            }

            return daQueryable;
        }

        private IQueryable<DiseaseIndicationData> FilterDiseaseAreaIfContainsSearchContext(IQueryable<DiseaseIndicationData> daQueryable, string searchKey,
            DiseaseAreaSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DiseaseAreaSearchContext.ByDisease:
                    daQueryable = daQueryable.Where(tr => tr.DiseaseAreaMaster.DiseaseArea.Contains(searchKey));
                    break;
                case DiseaseAreaSearchContext.ByIndication:
                    daQueryable = daQueryable.Where(tr => tr.IndicationMaster.IndicationName.Contains(searchKey));
                    break;                
                default:
                    break;
            }

            return daQueryable;
        }

        private IQueryable<DiseaseIndicationData> FilterDiseaseAreaIfStartsWithSearchContext(IQueryable<DiseaseIndicationData> daQueryable, string searchKey,
            DiseaseAreaSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DiseaseAreaSearchContext.ByDisease:
                    daQueryable = daQueryable.Where(tr => tr.DiseaseAreaMaster.DiseaseArea.StartsWith(searchKey));
                    break;
                case DiseaseAreaSearchContext.ByIndication:
                    daQueryable = daQueryable.Where(tr => tr.IndicationMaster.IndicationName.StartsWith(searchKey));
                    break;                
                default:
                    break;
            }

            return daQueryable;
        }

        private IQueryable<DiseaseIndicationData> FilterDiseaseAreaIfEndsWithSearchContext(IQueryable<DiseaseIndicationData> daQueryable, string searchKey,
            DiseaseAreaSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DiseaseAreaSearchContext.ByDisease:
                    daQueryable = daQueryable.Where(tr => tr.DiseaseAreaMaster.DiseaseArea.EndsWith(searchKey));
                    break;
                case DiseaseAreaSearchContext.ByIndication:
                    daQueryable = daQueryable.Where(tr => tr.IndicationMaster.IndicationName.EndsWith(searchKey));
                    break;                
                default:
                    break;
            }


            return daQueryable;
        }

        private IQueryable<DiseaseIndicationData> FilterDiseaseAreaIfEqualsSearchContext(IQueryable<DiseaseIndicationData> daQueryable, string searchKey,
            DiseaseAreaSearchContext searchContext)
        {
            switch (searchContext)
            {
                case DiseaseAreaSearchContext.ByDisease:
                    daQueryable = daQueryable.Where(tr => String.Compare(tr.DiseaseAreaMaster.DiseaseArea, searchKey, true) == 0);
                    break;
                case DiseaseAreaSearchContext.ByIndication:
                    daQueryable = daQueryable.Where(tr => String.Compare(tr.IndicationMaster.IndicationName, searchKey, true) == 0);
                    break;                
                default:
                    break;
            }

            return daQueryable;
        }

        public DiseaseListModel GetDiseaseNameList()
        {
            DiseaseListModel diseaseList = new DiseaseListModel();
                        
                try
                {
                    diseaseList.DiseaseList = uow.MasterContext.DiseaseAreaMaster
                        .Select(dam => new SelectListItem { Text = dam.DiseaseArea })
                        .OrderBy(sli => sli.Text)
                        .ToList();

                    diseaseList.DiseaseList.Insert(0, new SelectListItem() { Text = "---------Select---------", Value = "0", Selected = false });
                }
                catch (Exception ex)
                {

                }
            
            
            return diseaseList;
        }

        public IndicationListModel IndicationIdNameListByDiseaseName(String diseaseName)
        {
            IndicationListModel indicationList = new IndicationListModel();
            
                try
                {
                    indicationList.IndicationList = uow.MasterContext.DiseaseIndicationData
                        .Where(dt => String.Compare(dt.DiseaseAreaMaster.DiseaseArea, diseaseName, true) == 0)
                        .Select(dt => new SelectListItem { Text = dt.IndicationMaster.IndicationName })
                        .Distinct()
                        .OrderBy(sli => sli.Text)
                        .ToList();
                    
                    indicationList.IndicationList.Insert(0, new SelectListItem() { Text = "---------Select---------", Value = "0", Selected = false });

                }
                catch (Exception ex)
                {

                }
            
            return indicationList;

        }

        public List<DiseaseIndicationMapper> GetAllDiseaseAreaIndications()
        {
            List<DiseaseIndicationMapper> mapper = null;

            try
            {
                mapper = uow.MasterContext.DiseaseIndicationData
                    .Where(dt => !String.IsNullOrEmpty(dt.DiseaseAreaMaster.DiseaseArea)
                                && !String.IsNullOrEmpty(dt.IndicationMaster.IndicationName))
                    .Select(dt => new
                    {

                        DiseaseArea = dt.DiseaseAreaMaster.DiseaseArea,
                        IndicationName = dt.IndicationMaster.IndicationName
                    })
                    .Distinct()
                    .OrderBy(a => a.DiseaseArea)
                    .GroupBy(di => di.DiseaseArea, di => di.IndicationName,
                    (key, g) => new DiseaseIndicationMapper
                    {
                       
                        DiseaseAreaId =uow.MasterContext.DiseaseAreaMaster
                                       .Where(dn=>dn.DiseaseArea==key)
                                       .Select(di=>di.DiseaseId).FirstOrDefault(),
                        DiseaseName = key,
                        Indications = g.OrderBy(gi => gi).ToList()
                    }).ToList();
            }
            catch (Exception ex)
            {

            }
            
            return mapper;
        }
        //public DiseaseDetails GetDiseaseAreaDetails(string indication)
        //{
        //    DiseaseDetails diseaseDetails = new DiseaseDetails();
        //    byte[] fileStream;

        //    try
        //    {

        //        var diseaseInfoQueryable = uow.MasterContext.DiseaseIndicationData
        //                                 .Where(d => String.Compare(d.IndicationMaster.IndicationName, indication, true) == 0)
        //                                 .Select(d => new DiseaseIndicationInfo
        //                                 {
        //                                     Id = d.Id,
        //                                     PrimaryIndicationId = d.PrimaryIndicationId,
        //                                     DiseaseOverview = d.DiseaseOverview,
        //                                     DetailedIndication = d.DetailedIndication,
        //                                     MediaDetails = uow.MasterContext.IndicationMediaDetails
        //                                     .Where(imd => String.Compare(imd.IndicationName, indication, true) == 0)
        //                                      .Select(imd => new MediaDetail
        //                                      {
        //                                          ImageUrl = imd.ImageUrl ?? String.Empty,
        //                                          VideoUrl = imd.VideoUrl ?? String.Empty
        //                                      })

        //                                  .FirstOrDefault(),
                                             
        //                                 }).Future();
                
        //  var tableDataQueryable = uow.MasterContext.DiseaseIndicationData
        //    .Where(d => String.Compare(d.IndicationMaster.IndicationName, indication, true) == 0)
        //    .SelectMany(di => di.TreatmentRegimenDetail)
        //   .Select(t => new DiseaseTableDataRow
        //   {
        //       ClassSummary = t.ClassSummary,
        //       TreatmentRegimens = t.RegimenMaster.TreatmentRegimen,
        //       ApprovedMolecules = t.MoleculeRegimenMapping.Select(dmm => new MoleculeApproval
        //       {
        //           Molecule = dmm.MoleculeMaster.MoleculeName,
        //           IsApproved = uow.MasterContext.InlineTransaction
        //                                                .Any(it => it.IndicationMapping
        //                                                               .Any(itim => String.Compare(itim.IndicationMaster.IndicationName, indication, true) == 0)
        //                                                          && it.MoleculeMaster1
        //                                                               .Any(itmm => itmm.MoleculeId == dmm.MoleculeId)
        //                                                       )
        //       }).ToList()
        //   })
        //     .Future();


             



        //        #region gettreatmentregimenFordropdown

        //        List<regimenDetail> regimens = new List<regimenDetail>();

        //        var anonymous = uow.MasterContext.RegimenMaster.Select(
        //                o => new
        //                {
        //                    RegId = o.RegimenId,
        //                    RegName = o.TreatmentRegimen

        //                }).ToList();

        //        foreach (var item in anonymous)
        //        {
        //            regimenDetail regimen = new regimenDetail
        //            {
        //                regId = item.RegId,
        //                treatmentRegimen = item.RegName


        //            };

        //            regimens.Add(regimen);


        //        }

        //        diseaseDetails.regimens = regimens;
        //        #endregion

        //        #region ListOfmolecule
        //        List<moleculeDetails> molecules = new List<moleculeDetails>();

        //        var anonymousForMolecules = uow.MasterContext.MoleculeMaster.Select(
        //                o => new
        //                {
        //                    molId = o.MoleculeId,
        //                    molName = o.MoleculeName
        //                }).ToList();

        //        foreach (var item in anonymousForMolecules)
        //        {
        //            moleculeDetails molecule = new moleculeDetails
        //            {
        //                moleculeId = item.molId,
        //                moleculeName = item.molName


        //            };

        //            molecules.Add(molecule);


        //        }

        //        #endregion



        //        var existTreatmentList = uow.MasterContext.DiseaseIndicationData.Where(d => String.Compare(d.IndicationMaster.IndicationName, indication, true) == 0)
        //          .FirstOrDefault().TreatmentRegimenDetail.Select(
        //         o => new treatmentDetailsForPopup
        //         {
        //             treatRegId=o.RegimenId,
        //             isNewlyAdded=0,
        //             treatmentRegimen = o.RegimenMaster.TreatmentRegimen,
        //             classSummary = o.ClassSummary,
        //             moleculeNames = o.MoleculeRegimenMapping.Select(m => m.MoleculeMaster.MoleculeName).ToList()
        //         }).ToList();

        //        diseaseDetails.ExistTreatmentListData = existTreatmentList;
        //        diseaseDetails.regimens = regimens;
        //        diseaseDetails.molecules = molecules;
        //        diseaseDetails.diseaseIndicationInfo = diseaseInfoQueryable.FirstOrDefault();
        //        if (diseaseDetails.diseaseIndicationInfo.MediaDetails != null)
        //        {
        //            if (diseaseDetails.diseaseIndicationInfo.MediaDetails.ImageUrl != "")
        //            {
        //                fileStream = getFileStream(diseaseDetails.diseaseIndicationInfo.MediaDetails.ImageUrl);
        //                diseaseDetails.diseaseIndicationInfo.MediaDetails.ImageByte = fileStream;
        //            }
        //        }
        //        diseaseDetails.diseaseTableData = tableDataQueryable.ToList();
        //    }


        //    catch (Exception ex)
        //    {

        //    }


        //    return diseaseDetails;
        //}
        public List<string> FetchRefernces()
        {
            List<string> result = null;
            try
            {
                var refList = uow.MasterContext.ReferenceMaster
                             .Select(rl => rl.ReferenceLink).ToList();
                result = refList;
                
            }
            catch (Exception)
            {
                result = null;
               
            }

            return result;
        }

        public DiseaseDetails GetDiseaseAreaDetailsBySecondInd(int diseaseId, string secondIndName)
        {
            DiseaseDetails diseaseDetails = new DiseaseDetails();
            byte[] fileStream;

            try
            {

                var diseaseInfoQueryable = uow.MasterContext.DiseaseIndicationData
                                         .Where(d => String.Compare(d.IndicationMaster1.IndicationName, secondIndName, true) == 0
                                         && d.DiseaseAreaId == diseaseId

                                         )
                                         .Select(d => new DiseaseIndicationInfo
                                         {
                                             Id = d.Id,
                                             PrimaryIndicationId = d.PrimaryIndicationId,
                                             DiseaseOverview = d.DiseaseOverview,
                                             DetailedIndication = d.DetailedIndication,
                                             MediaDetails = d.IndicationMediaDetail
                                                      .Select(imd => new MediaDetail
                                                      {
                                                          isPathoImage = imd.IsPathoImage,
                                                          ImageUrl = imd.ImageUrl ?? String.Empty,
                                                          VideoUrl = imd.VideoUrl ?? String.Empty
                                                      }).ToList(),
                                             ReferenceList = d.IndicationReferenceMapping
                                                            .Select(rf => new References()
                                                            {
                                                                ReferenceId = rf.ReferenceId,
                                                                ReferenceLink = rf.ReferenceMaster.ReferenceLink

                                                            }).ToList()
                                                            
                                                }).Future();
                var diseaseInfoQueryable1 = uow.MasterContext.DiseaseIndicationData
                                      .Where(d => String.Compare(d.IndicationMaster1.IndicationName, secondIndName, true) == 0
                                      && d.DiseaseAreaId == diseaseId

                                      )
                                      .Select(d => new DiseaseIndicationInfo
                                      {
                                          Id = d.Id,
                                          PrimaryIndicationId = d.PrimaryIndicationId,
                                          DiseaseOverview = d.DiseaseOverview,
                                          DetailedIndication = d.DetailedIndication,
                                          MediaDetails = d.IndicationMediaDetail
                                                      .Select(imd => new MediaDetail
                                                      {   isPathoImage=imd.IsPathoImage,
                                                          ImageUrl = imd.ImageUrl ?? String.Empty,
                                                          VideoUrl = imd.VideoUrl ?? String.Empty
                                                      }).ToList(),
                                          

                                         
                                          ReferenceList = d.IndicationReferenceMapping
                                                            .Select(rf => new References()
                                                            {
                                                                ReferenceId = rf.ReferenceId,
                                                                ReferenceLink = rf.ReferenceMaster.ReferenceLink

                                                            }).ToList()


                                      }).ToList();

                //var tableDataQueryable = uow.MasterContext.DiseaseIndicationData
                //  .Where(d => String.Compare(d.IndicationMaster1.IndicationName, secondIndName, true) == 0)
                //  .SelectMany(di => di.TreatmentRegimenDetail)
                // .Select(t => new DiseaseTableDataRow
                // {
                //     ClassSummary = t.ClassSummary,
                //     TreatmentRegimens = t.RegimenMaster.TreatmentRegimen,
                //     ApprovedMolecules = t.MoleculeRegimenMapping.Select(dmm => new MoleculeApproval
                //     {
                //         Molecule = dmm.MoleculeMaster.MoleculeName,
                //         // IsApproved=true
                //         IsApproved = uow.MasterContext.InlineTransaction
                //                                              .Any(it => it.IndicationMapping
                //                                                             .Any(itim => String.Compare(itim.IndicationMaster.IndicationName, secondIndName, true) == 0)
                //                                                        && it.MoleculeMaster1
                //                                                             .Any(itmm => itmm.MoleculeId == dmm.MoleculeId)
                //                                                     )
                //     }).ToList()
                // })
                //   .Future();

                var tableDataQueryable1 = uow.MasterContext.DiseaseIndicationData
                 .Where(d => String.Compare(d.IndicationMaster1.IndicationName, secondIndName, true) == 0)
                 .SelectMany(di => di.TreatmentRegimenDetail)
                .Select(t => new DiseaseTableDataRow
                {
                    ClassSummary = t.ClassSummary,
                    TreatmentRegimens = t.PharmaClassMaster.PharmaClass,
                    ApprovedMolecules = t.MoleculeRegimenMapping.Select(dmm => new MoleculeApproval
                    {
                        Molecule = dmm.MoleculeMaster.MoleculeName,
                        //IsApproved = false

                        IsApproved = uow.MasterContext.InlineTransaction
                                                             .Any(it => it.IndicationMapping
                                                                            .Any(itim => String.Compare(itim.IndicationMaster.IndicationName, secondIndName, true) == 0)
                                                                       && it.MoleculeMapping
                                                                            .Any(itmm => itmm.MoleculeMaster.MoleculeId == dmm.MoleculeId)
                                                                    )
                    }).ToList()
                }).ToList();

                #region gettreatmentregimenFordropdown

                List<regimenDetail> regimens = new List<regimenDetail>();

                var anonymous = uow.MasterContext.PharmaClassMaster.Select(
                        o => new
                        {
                            RegId = o.PharmaClassId,
                            RegName = o.PharmaClass

                        }).ToList();

                foreach (var item in anonymous)
                {
                    regimenDetail regimen = new regimenDetail
                    {
                        regId = item.RegId,
                        treatmentRegimen = item.RegName
                        
                    };

                    regimens.Add(regimen);


                }

                diseaseDetails.regimens = regimens;
                #endregion

                #region ListOfmolecule
                List<moleculeDetails> molecules = new List<moleculeDetails>();

                var anonymousForMolecules = uow.MasterContext.MoleculeMaster.Select(
                        o => new
                        {
                            molId = o.MoleculeId,
                            molName = o.MoleculeName
                        }).ToList();

                foreach (var item in anonymousForMolecules)
                {
                    moleculeDetails molecule = new moleculeDetails
                    {
                        moleculeId = item.molId,
                        moleculeName = item.molName


                    };

                    molecules.Add(molecule);


                }

                #endregion


                var IsPresent=  uow.MasterContext.DiseaseIndicationData.Where(d => String.Compare(d.IndicationMaster1.IndicationName, secondIndName, true) == 0)
                   .FirstOrDefault();

                if (IsPresent!=null)
                {
                    var existTreatmentList = IsPresent.TreatmentRegimenDetail.Select(
                o => new treatmentDetailsForPopup
                {
                    treatRegId = o.PharmaClassId,
                    isNewlyAdded = 0,
                    treatmentRegimen = o.PharmaClassMaster.PharmaClass,
                    classSummary = o.ClassSummary,
                    moleculeNames = o.MoleculeRegimenMapping.Select(m => m.MoleculeMaster.MoleculeName).ToList()
                }).ToList();

                    // var existTreatmentList = uow.MasterContext.DiseaseIndicationData.Where(d => String.Compare(d.IndicationMaster.IndicationName, secondIndName, true) == 0)
                    // .FirstOrDefault().TreatmentRegimenDetail.Select(
                    //o => new treatmentDetailsForPopup
                    //{
                    //    treatRegId = o.RegimenId,
                    //    isNewlyAdded = 0,
                    //    treatmentRegimen = o.RegimenMaster.TreatmentRegimen,
                    //    classSummary = o.ClassSummary,
                    //    moleculeNames = o.MoleculeRegimenMapping.Select(m => m.MoleculeMaster.MoleculeName).ToList()
                    //}).ToList();



                    diseaseDetails.ExistTreatmentListData = existTreatmentList;
                }
                
                diseaseDetails.regimens = regimens;
                diseaseDetails.molecules = molecules;
                // diseaseDetails.diseaseIndicationInfo = diseaseInfoQueryable.FirstOrDefault();
                diseaseDetails.diseaseIndicationInfo = diseaseInfoQueryable1.FirstOrDefault();

                if (diseaseDetails.diseaseIndicationInfo.MediaDetails != null)
                {
                   
                    foreach (var item in diseaseDetails.diseaseIndicationInfo.MediaDetails)
                    {
                        if (item.ImageUrl != "")
                        {
                            fileStream = getFileStream(item.ImageUrl);
                            item.ImageByte = fileStream;
                        }
                    }
                }
                diseaseDetails.diseaseTableData = tableDataQueryable1.ToList();
            }


            catch (Exception ex)
            {

            }


            return diseaseDetails;
        }





        public int AddNewSubIndication(string newSubIndicationName, string primaryIndication, int diseaseAreaId)

        {

            try
            {
                var isAlreadyPresent = uow.MasterContext.IndicationMaster
                                     .Where(dn => (dn.IndicationName).Trim().ToLower() == newSubIndicationName.Trim().ToLower()).FirstOrDefault();

                if (isAlreadyPresent == null)
                {
                    var newIndication = new IndicationMaster()
                    {
                        IndicationName = newSubIndicationName
                    };
                    int primaryIndicationId = uow.MasterContext.IndicationMaster
                                            .Where(ind => (ind.IndicationName).Trim().ToLower() == primaryIndication.Trim().ToLower())
                                            .Select(ind => ind.IndicationId).FirstOrDefault();
                    uow.MasterContext.IndicationMaster.Add(newIndication);
                    var indicationData = new DiseaseIndicationData()
                    {
                        DiseaseAreaId = diseaseAreaId,
                        PrimaryIndicationId = primaryIndicationId,
                        SecondaryIndicationId = newIndication.IndicationId,
                        DiseaseOverview = null,
                        DetailedIndication = null
                    };
                    uow.MasterContext.DiseaseIndicationData.Add(indicationData);
                    uow.MasterContext.SaveChanges();
                    return 0;

                }
                else
                {
                    return 1;

                }
            }
            catch (Exception ex)
            {

                return 2;
            }


     }

    

    public List<SecondaryIndication> GetSecondaryIndication(string primaryIndication, int diseaseAreaId)
   {

        
                int primaryIndicationId = uow.MasterContext.IndicationMaster
                                   .Where(ind => ind.IndicationName.Trim().ToLower() == primaryIndication.Trim().ToLower())
                                   .Select(ind => ind.IndicationId).FirstOrDefault();

                var secondaryIndicationobj = uow.MasterContext.DiseaseIndicationData
                                             .Where(di => di.DiseaseAreaId == diseaseAreaId && di.PrimaryIndicationId == primaryIndicationId)
                                             .Select(nm => new SecondaryIndication()
                                             {
                                                 diseaseAreaId = diseaseAreaId,
                                                 secondaryIndicationId = nm.SecondaryIndicationId,
                                                 secondaryIndicationName = nm.IndicationMaster1.IndicationName,
                                                 primaryIndicationName = nm.IndicationMaster.IndicationName
                                             }).ToList();

            List<SecondaryIndication> secondaryIndObject = new List<SecondaryIndication>();

            foreach (var item in secondaryIndicationobj)
            {

                SecondaryIndication secondaryObject = new SecondaryIndication
                {
                    diseaseAreaId=item.diseaseAreaId,
                    secondaryIndicationId=item.secondaryIndicationId,
                    primaryIndicationName=item.primaryIndicationName,
                    secondaryIndicationName=item.secondaryIndicationName
                   
                };
                secondaryIndObject.Add(secondaryObject);
            }

            return secondaryIndObject;
  }

        public int AddNewIndication(string newIndicationName,int diseaseAreaId)

        {
            int result = 0;
            try
            {
                var isAlreadyPresent = uow.MasterContext.IndicationMaster
                                     .Where(dn => (dn.IndicationName).Trim().ToLower() == newIndicationName.Trim().ToLower()).FirstOrDefault();

                if (isAlreadyPresent == null)
                {
                    var newIndication = new IndicationMaster()
                    {
                        IndicationName= newIndicationName
                    };

                    uow.MasterContext.IndicationMaster.Add(newIndication);
                    var indicationData = new DiseaseIndicationData()
                    {
                        DiseaseAreaId = diseaseAreaId,
                        PrimaryIndicationId = newIndication.IndicationId,
                        SecondaryIndicationId = newIndication.IndicationId,
                        DiseaseOverview = null,
                        DetailedIndication = null
                    };
                    uow.MasterContext.DiseaseIndicationData.Add(indicationData);
                    uow.MasterContext.SaveChanges();
                    result = 0;
                    return result;

                }
                else
                {
                    result = 1;
                    return result;

                }
            }
            catch (Exception ex)
            {

                return 2;
            }


        }

        public int AddNewDiseaseArea(string newDiseaseAreaName,string newIndName)

        {
            int result = 0;
            try
            {
               
                var isAlreadyPresent = uow.MasterContext.DiseaseAreaMaster
                                     .Where(dn => (dn.DiseaseArea).Trim().ToLower() == newDiseaseAreaName.Trim().ToLower()).FirstOrDefault();

                if(isAlreadyPresent==null)
                {
                    var newDiseaseArea = new DiseaseAreaMaster()
                    {
                        DiseaseArea = newDiseaseAreaName
                    };
                    uow.MasterContext.DiseaseAreaMaster.Add(newDiseaseArea);

                    int indicationId = 0;

                    var checkIsIndicationPresent = uow.MasterContext.IndicationMaster
                                                 .Where(ind => ind.IndicationName.Trim().ToLower() == newIndName.Trim().ToLower()).FirstOrDefault();

                    if(checkIsIndicationPresent!=null)

                    {
                        indicationId = checkIsIndicationPresent.IndicationId;


                    }
                    else
                    {
                        var newIndication = new IndicationMaster()
                        {
                            IndicationName = newIndName

                        };
                        uow.MasterContext.IndicationMaster.Add(newIndication);
                        uow.MasterContext.SaveChanges();

                        indicationId = newIndication.IndicationId;

                    }
                   

                    var diseaseIndicationObj = new DiseaseIndicationData()
                    {
                        DiseaseAreaId = newDiseaseArea.DiseaseId,
                        PrimaryIndicationId = indicationId,
                        SecondaryIndicationId = indicationId,
                        DiseaseOverview = null,
                        DetailedIndication = null
                    };
                    uow.MasterContext.DiseaseIndicationData.Add(diseaseIndicationObj);
                    uow.MasterContext.SaveChanges();

                    int NewDiseaseId = newDiseaseArea.DiseaseId;
                    result = newDiseaseArea.DiseaseId;
                    return result;

                }
                else
                {
                    result = -1;
                    return result;

                }
            }
            catch (Exception ex)
            {

                return result;
            }


        }
        public int SaveEditedDiseaseOverViewDetails(string editedData, string indication)
        {


            DiseaseDetails diseaseDetails = new DiseaseDetails();
            int result = 0;

            try
            {
                var tId = uow.MasterContext.DiseaseIndicationData
                         .Where(d => String.Compare(d.IndicationMaster1.IndicationName, indication, true) == 0)
                         .Select(d => new
                         {
                             Id = d.Id
                         }
                         ).FirstOrDefault()
                         ;


                DiseaseIndicationData resetDiseaseOverview = uow.MasterContext.DiseaseIndicationData.Find(tId.Id);
                resetDiseaseOverview.DiseaseOverview = editedData;

                uow.MasterContext.SaveChanges();

                result = 1;
            }
            catch (Exception ex)
            {
                result = 0;

            }


            return result;
        }

        public int SaveEditedDiseaseOverViewDetails_copy(string editedData, string indication)
        {


            DiseaseDetails diseaseDetails = new DiseaseDetails();
            int result = 0;

            try
            {
                var tId = uow.MasterContext.DiseaseIndicationData
                         .Where(d => String.Compare(d.IndicationMaster.IndicationName, indication, true) == 0)
                         .Select(d => new
                         {
                             Id = d.Id
                         }
                         ).FirstOrDefault()
                         ;


                DiseaseIndicationData resetDiseaseOverview = uow.MasterContext.DiseaseIndicationData.Find(tId.Id);
                resetDiseaseOverview.DiseaseOverview = editedData;

                uow.MasterContext.SaveChanges();

                result = 1;
            }
            catch (Exception ex)
            {
                result = 0;

            }


            return result;
        }
        public int SaveEditedDetailndication(string editedData, string indication)
        {
            DiseaseDetails diseaseDetails = new DiseaseDetails();
            int result = 0;

            try
            {
                var tId = uow.MasterContext.DiseaseIndicationData
                       .Where(d => String.Compare(d.IndicationMaster1.IndicationName, indication, true) == 0)
                       .Select(d => new
                       {
                           Id = d.Id
                       }
                       ).FirstOrDefault()
                       ;


                DiseaseIndicationData resetDetailndication = uow.MasterContext.DiseaseIndicationData.Find(tId.Id);
                resetDetailndication.DetailedIndication = editedData;


                uow.MasterContext.SaveChanges();
                result = 1;
            }
            catch (Exception ex)
            {
                result = 0;

            }


            return result;
        }

        public int SaveNewReferences(List<NewRefernce> ListOfRefernces, string indication)
        {
            int result = 0;

            try
            {
                var tId = uow.MasterContext.DiseaseIndicationData
                       .Where(d => String.Compare(d.IndicationMaster1.IndicationName, indication, true) == 0)
                       .Select(d => new
                       {
                           Id = d.Id
                       }
                       ).FirstOrDefault()
                       ;
                foreach (var item in ListOfRefernces)
                {
                    var reference = item.reference;
                    var isReferncePresent = uow.MasterContext.ReferenceMaster
                                          .Where(rl => rl.ReferenceLink.ToLower().Trim() == reference.ToLower().Trim()).FirstOrDefault();
                    var referenceId = 0;
                    if (isReferncePresent == null)
                    {
                        var newRefObj = new ReferenceMaster()
                        {
                            ReferenceLink = item.reference

                        };
                        uow.MasterContext.ReferenceMaster.Add(newRefObj);
                        referenceId = newRefObj.ReferenceId;

                    }
                    else
                    {
                        referenceId = isReferncePresent.ReferenceId;

                    }

                    var isindicationRefenceMappingPresent = uow.MasterContext.IndicationReferenceMapping
                        .Where(irm => irm.ReferenceId == referenceId && irm.DiseaseIndicationDataId == tId.Id).FirstOrDefault();
                    if (isindicationRefenceMappingPresent == null)
                    {
                        var indicationRefernceObj = new IndicationReferenceMapping()
                        {
                            DiseaseIndicationDataId = tId.Id,
                            ReferenceId = referenceId

                        };
                        uow.MasterContext.IndicationReferenceMapping.Add(indicationRefernceObj);
                        uow.MasterContext.SaveChanges();
                    }
                    result = 1;
                }


            }
            catch (Exception ex)
            {
                result = 0;

            }


            return result;
        }

        public int DeleteCurrentRefernce(int refernceId, string indicationName)
        {
            int result = 0;

            try
            {
                var tId = uow.MasterContext.DiseaseIndicationData
                       .Where(d => String.Compare(d.IndicationMaster1.IndicationName, indicationName, true) == 0)
                       .Select(d => new
                       {
                           Id = d.Id
                       }
                       ).FirstOrDefault();

                var refernceMappingList = uow.MasterContext.IndicationReferenceMapping
                                        .Where(ir => ir.ReferenceId == refernceId).ToList();
                if (refernceMappingList != null)
                {
                    foreach (var item in refernceMappingList)
                    {
                        uow.MasterContext.IndicationReferenceMapping.Remove(item);

                    }
                }
                var isReferByOtherDisease = uow.MasterContext.IndicationReferenceMapping
                                          .Where(ir => ir.ReferenceId == refernceId && ir.DiseaseIndicationDataId != tId.Id).ToList();

                if (isReferByOtherDisease.Count() == 0)
                {

                   var refernceMasterObj = uow.MasterContext.ReferenceMaster
                                      .Where(rm => rm.ReferenceId == refernceId).FirstOrDefault();
                    uow.MasterContext.ReferenceMaster.Remove(refernceMasterObj);

                }
                uow.MasterContext.SaveChanges();

                result = 1;


            }

            catch (Exception ex)
            {
                result=0;

            }


            return result;
        }

        public int SaveEditedDetailndication_copy(string editedData, string indication)
        {
            DiseaseDetails diseaseDetails = new DiseaseDetails();
            int result = 0;

            try
            {
                var tId = uow.MasterContext.DiseaseIndicationData
                       .Where(d => String.Compare(d.IndicationMaster.IndicationName, indication, true) == 0)
                       .Select(d => new
                       {
                           Id = d.Id
                       }
                       ).FirstOrDefault()
                       ;


                DiseaseIndicationData resetDetailndication = uow.MasterContext.DiseaseIndicationData.Find(tId.Id);
                resetDetailndication.DetailedIndication = editedData;


                uow.MasterContext.SaveChanges();
                result = 1;
            }
            catch (Exception ex)
            {
                result = 0;

            }


            return result;
        }

        public int SaveTreatmentRegimenDetail(List<treatmentDetailsForPopup> ListTreatmentdetails, string indication)
        {
            int result = 0;

            try
            {
                foreach (var item in ListTreatmentdetails)

                {

                    if (item.isNewlyAdded == 1)
                    {
                        SaveNewTreatMentRegimenDetails(item, indication);  //Insert Newly added treatment

                    }
                    else
                    {
                        SavePreviosTreatMentRegimenDetails(item, indication); //update previous traetment Regimen
                    }
                    uow.MasterContext.SaveChanges();
                    result = 1;

                }

            }
            catch (Exception ex)
            {
                result = 0;

            }


            return result;
        }

        public int SaveNewTreatMentRegimenDetails(treatmentDetailsForPopup item, string indication)
        {
            try
            {
                if (item.treatmentRegimen != null && item.treatmentRegimen != "")
                {
                   var isTreatRecordPresent= uow.MasterContext.TreatmentRegimenDetail
                     .Where(tr => tr.PharmaClassMaster.PharmaClass == item.treatmentRegimen && tr.DiseaseIndicationData.IndicationMaster.IndicationName == indication).FirstOrDefault();
                   

                    string treatmentReg = item.treatmentRegimen;
                    var isTreatmentRegimenPresent = uow.MasterContext.PharmaClassMaster
                                                  .Where(tr => tr.PharmaClass == treatmentReg).FirstOrDefault();
                    int regimenId = 0;
                    if (isTreatmentRegimenPresent == null)
                    {
                        var newTreatmentRegimen = new PharmaClassMaster
                        {
                            PharmaClass = treatmentReg
                        };

                        uow.MasterContext.PharmaClassMaster.Add(newTreatmentRegimen);
                        uow.MasterContext.SaveChanges();
                        regimenId = newTreatmentRegimen.PharmaClassId;

                    }

                    if (regimenId == 0)
                    {
                        regimenId = uow.MasterContext.PharmaClassMaster
                                   .Where(d => d.PharmaClass == treatmentReg)
                                   .Select(d => d.PharmaClassId).FirstOrDefault();
                    }

                    var treat = new TreatmentRegimenDetail
                    {
                        PharmaClassId = regimenId,
                        ClassSummary = item.classSummary,

                        DiseaseIndicationDataId = uow.MasterContext.DiseaseIndicationData
                       .Where(d => d.IndicationMaster1.IndicationName == indication)
                       .Select(d => d.Id).FirstOrDefault(),
                    };

                    foreach (string Molecule in item.moleculeNames)
                    {
                        if (Molecule != null)
                        {
                            var isMolPresent = uow.MasterContext.MoleculeMaster
                                                    .Where(tr => tr.MoleculeName == Molecule).FirstOrDefault();
                            int molId = 0;
                            if (isMolPresent == null)
                            {

                                var newMolecule = new MoleculeMaster
                                {
                                    MoleculeName = Molecule
                                };

                                uow.MasterContext.MoleculeMaster.Add(newMolecule);
                                uow.MasterContext.SaveChanges();
                                molId = newMolecule.MoleculeId;
                            }
                            if (molId == 0)
                            {
                                molId = uow.MasterContext.MoleculeMaster
                                               .Where(mn => mn.MoleculeName == Molecule)
                                               .Select(mi => mi.MoleculeId).FirstOrDefault();
                            }

                            var mol = new MoleculeRegimenMapping()
                            {

                                TreatmentRegimenDetailId = treat.Id,
                                MoleculeId = molId

                            };
                            treat.MoleculeRegimenMapping.Add(mol);
                        }

                    }
                    uow.MasterContext.TreatmentRegimenDetail.Add(treat);

                }


                return 0;
            }
            catch (Exception ex)
            {
                return 1;

            }

        }

        public int SavePreviosTreatMentRegimenDetails(treatmentDetailsForPopup item, string indication)
        {
            try
            {
                if (item.treatmentRegimen != null && item.treatmentRegimen != "")
                {
                    var treatmentRecord = uow.MasterContext.TreatmentRegimenDetail
                                         .Where(tId => tId.PharmaClassId == item.treatRegId).FirstOrDefault();

                    if (item.treatmentRegimen == treatmentRecord.PharmaClassMaster.PharmaClass)

                    {
                        InsertOnRegimenNameNotChange(item, treatmentRecord);
                    }
                    else
                    {

                        InsertOnRegimenNameChange(item, treatmentRecord);


                    }

                }
                return 0;
            }
            catch (Exception ex)
            {

                return 1;
            }

        }
        public int InsertOnRegimenNameNotChange(treatmentDetailsForPopup item, TreatmentRegimenDetail treatmentRecord)

        {
            try
            {
                treatmentRecord.ClassSummary = item.classSummary;

                var prevMolList = uow.MasterContext.MoleculeRegimenMapping
                                  .Where(trId => trId.TreatmentRegimenDetailId == treatmentRecord.Id)
                                  .Select(mn => mn.MoleculeMaster.MoleculeName).ToList();

                foreach (string Molecule in item.moleculeNames)
                {

                    if (Molecule != null & Molecule != "")
                    {
                        if (!prevMolList.Contains(Molecule))
                        {
                            var isMolPresent = uow.MasterContext.MoleculeMaster
                                           .Where(tr => tr.MoleculeName == Molecule).FirstOrDefault();
                            int molId = 0;
                            if (isMolPresent == null)
                            {

                                var newMolecule = new MoleculeMaster
                                {
                                    MoleculeName = Molecule

                                };

                                uow.MasterContext.MoleculeMaster.Add(newMolecule);
                                uow.MasterContext.SaveChanges();
                                molId = newMolecule.MoleculeId;
                            }
                            if (molId == 0)
                            {
                                molId = uow.MasterContext.MoleculeMaster
                                               .Where(mn => mn.MoleculeName == Molecule)
                                               .Select(mi => mi.MoleculeId).FirstOrDefault();
                            }

                            var mol = new MoleculeRegimenMapping()
                            {

                                TreatmentRegimenDetailId = treatmentRecord.Id,
                                MoleculeId = molId

                            };
                            treatmentRecord.MoleculeRegimenMapping.Add(mol);
                        }


                    }

                }



                foreach (string Molecule in prevMolList)
                {

                    if (Molecule != null & Molecule != "")
                    {
                        if (!item.moleculeNames.Contains(Molecule))
                        {
                            var prevMolId = uow.MasterContext.MoleculeMaster.Where(mn => mn.MoleculeName == Molecule)
                                           .Select(mId => mId.MoleculeId).FirstOrDefault();
                            var deleteMolRef = uow.MasterContext.MoleculeRegimenMapping
                                             .Where(trId => trId.TreatmentRegimenDetailId == treatmentRecord.Id && trId.MoleculeId == prevMolId).FirstOrDefault();
                            uow.MasterContext.MoleculeRegimenMapping.Remove(deleteMolRef);

                        }


                    }

                }
                return 0;
            }
            catch (Exception ex)
            {

                return 1;
            }

        }
        public int InsertOnRegimenNameChange(treatmentDetailsForPopup item, TreatmentRegimenDetail treatmentRecord)
        {

            try
            {

                var isRegimenPresent = uow.MasterContext.PharmaClassMaster
                                     .Where(rn => rn.PharmaClass == item.treatmentRegimen).FirstOrDefault();
                int regId = 0;
                if (isRegimenPresent == null)
                {
                    var regimenEntry = new PharmaClassMaster()
                    {
                        PharmaClass = item.treatmentRegimen
                    };
                    uow.MasterContext.PharmaClassMaster.Add(regimenEntry);
                    regId = regimenEntry.PharmaClassId;
                }
                else
                {
                    regId = isRegimenPresent.PharmaClassId;

                }
                treatmentRecord.PharmaClassId = regId;
                treatmentRecord.ClassSummary = item.classSummary;

                var prevMolList = uow.MasterContext.MoleculeRegimenMapping
                         .Where(trId => trId.TreatmentRegimenDetailId == treatmentRecord.Id)
                         .Select(mn => mn.MoleculeMaster.MoleculeName).ToList();

                foreach (string Molecule in item.moleculeNames)
                {

                    if (Molecule != null & Molecule != "")
                    {
                        if (!prevMolList.Contains(Molecule))
                        {
                            var isMolPresent = uow.MasterContext.MoleculeMaster
                                           .Where(tr => tr.MoleculeName == Molecule).FirstOrDefault();
                            int molId = 0;
                            if (isMolPresent == null)
                            {

                                var newMolecule = new MoleculeMaster
                                {
                                    MoleculeName = Molecule

                                };

                                uow.MasterContext.MoleculeMaster.Add(newMolecule);
                                uow.MasterContext.SaveChanges();
                                molId = newMolecule.MoleculeId;
                            }
                            if (molId == 0)
                            {
                                molId = uow.MasterContext.MoleculeMaster
                                               .Where(mn => mn.MoleculeName == Molecule)
                                               .Select(mi => mi.MoleculeId).FirstOrDefault();
                            }

                            var mol = new MoleculeRegimenMapping()
                            {

                                TreatmentRegimenDetailId = treatmentRecord.Id,
                                MoleculeId = molId

                            };
                            treatmentRecord.MoleculeRegimenMapping.Add(mol);
                        }


                    }

                }



                foreach (string Molecule in prevMolList)
                {

                    if (Molecule != null & Molecule != "")
                    {
                        if (!item.moleculeNames.Contains(Molecule))
                        {
                            var prevMolId = uow.MasterContext.MoleculeMaster.Where(mn => mn.MoleculeName == Molecule)
                                           .Select(mId => mId.MoleculeId).FirstOrDefault();
                            var deleteMolRef = uow.MasterContext.MoleculeRegimenMapping
                                             .Where(trId => trId.TreatmentRegimenDetailId == treatmentRecord.Id && trId.MoleculeId == prevMolId).FirstOrDefault();
                            uow.MasterContext.MoleculeRegimenMapping.Remove(deleteMolRef);

                        }


                    }

                }


                return 0;
            }
            catch (Exception ex)
            {
                return 1;
            }

        }
        public int SaveEditedDetailndication1(string editedData, string indication)
        {
            DiseaseDetails diseaseDetails = new DiseaseDetails();
            int result = 0;

            try
            {
                var diseaseInfoQueryable = uow.MasterContext.DiseaseTransaction
                       .Where(d => String.Compare(d.IndicationMaster.IndicationName, indication, true) == 0)

                       .ToList();


                List<int> transactionIds = diseaseInfoQueryable.Select(o => o.TransactionId).ToList();

                foreach (var tId in transactionIds)
                {
                    DiseaseTransaction presetDiseaseDetails = uow.MasterContext.DiseaseTransaction.Find(tId);
                    presetDiseaseDetails.DetailedIndication = editedData;
                }
                uow.MasterContext.SaveChanges();
                result = 1;
            }
            catch (Exception ex)
            {
                result = 0;

            }


            return result;
        }
        private byte[] getFileStream(string fileStream)
        {
            StorageTypeFactory factory = new ConcreteStorageFactory();
            StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
            var byteArr = storagefactory.Download(uow, fileStream, StorageContext.Indication);
            return byteArr;
        }

        public string SaveMedia(int diseaseId, string indication,bool isPathoImage, HttpPostedFileBase file,string videoLink = "")
        {
            string msg = string.Empty;
            
                try
                {

                if (file != null && file.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(file.FileName);

                   
                    var diseaseIndicationData = uow.MasterContext.DiseaseIndicationData
                                              .Where(di => di.DiseaseAreaId == diseaseId && di.IndicationMaster1.IndicationName.ToLower().Trim() == indication.ToLower().Trim()).FirstOrDefault();
                    if (diseaseIndicationData != null)
                    {
                        int diseaseIndicationDataId = diseaseIndicationData.Id;
                        //string key = disease + "|" + indication;
                        string key = diseaseIndicationDataId.ToString()+"|"+Convert.ToInt32(isPathoImage);

                        StorageTypeFactory factory = new ConcreteStorageFactory();
                        StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                        string path = storagefactory.Upload(uow, key, file, StorageContext.Indication, ForecastModelType.Generic, 1, videoLink);
                    }
                }
                }
                
                catch (Exception ex)
            {
                msg = ex.Message;
            }
        
            return msg;

        }


        public string SaveMedia_OLD(string disease, string indication, string videoLink, HttpPostedFileBase file)
        {
            string msg = string.Empty;

            try
            {

                if (file != null && file.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(file.FileName);

                    string key = disease + "|" + indication;

                    StorageTypeFactory factory = new ConcreteStorageFactory();
                    StorageIFactory storagefactory = factory.getSTorageType(GenUtil.GetStorageType());
                    string path = storagefactory.Upload(uow, key, file, StorageContext.Indication, ForecastModelType.Generic, 1, videoLink);
                }
            }

            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg;

        }


        //public string SaveMedia(string disease, string indication, string videoLink, HttpPostedFileBase file)
        //{
        //    string msg = string.Empty;
        //    using (var context = new MasterModel(GenUtil.MasterModelConnectionString))
        //    {
        //        try
        //        {
        // BlobUploadResult blobUploadResult = GenUtil.UploadImageInBlob(disease + "_" + indication + "_" + Guid.NewGuid().ToString(), file, StorageContext.Indication);

        //            if (blobUploadResult != null && blobUploadResult.Message == "Success")
        //            {
        //                IndicationMediaDetails indicationMediaDetails = new IndicationMediaDetails
        //                {
        //                    DiseaseName = disease,
        //                    IndicationName = indication,
        //                    ImageUrl = blobUploadResult.BlobUrl,
        //                    VideoUrl = videoLink
        //                };

        //                var existingIMD = context.IndicationMediaDetails
        //                    .Where(imd => String.Compare(imd.DiseaseName, disease, true) == 0 && String.Compare(imd.IndicationName, indication, true) == 0)
        //                    .Select(imd => new { ImageUrl = imd.ImageUrl, VideoUrl = imd.VideoUrl })
        //                    .FirstOrDefault();
        //                bool create = existingIMD == null;
        //                bool modify = String.Compare(existingIMD.ImageUrl, indicationMediaDetails.ImageUrl, true) != 0
        //                                || String.Compare(existingIMD.VideoUrl, indicationMediaDetails.VideoUrl, true) != 0;

        //                context.Entry(indicationMediaDetails).State = create ? EntityState.Added : modify ? EntityState.Modified : EntityState.Unchanged;
        //                context.SaveChanges();
        //                msg = "Success";
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            msg = ex.Message;
        //        }
        //    }
        //    return msg;

    //public string SaveMedia(string disease, string indication, string videoLink, HttpPostedFileBase file)
    //{
    //    string msg = string.Empty;
    //    using (var context = new MasterModel(GenUtil.MasterModelConnectionString))
    //    {
    //        try
    //        {
            // BlobUploadResult blobUploadResult = GenUtil.UploadImageInBlob(disease + "_" + indication + "_" + Guid.NewGuid().ToString(), file, StorageContext.Indication);

    //            if (blobUploadResult != null && blobUploadResult.Message == "Success")
    //            {
    //                IndicationMediaDetails indicationMediaDetails = new IndicationMediaDetails
    //                {
    //                    DiseaseName = disease,
    //                    IndicationName = indication,
    //                    ImageUrl = blobUploadResult.BlobUrl,
    //                    VideoUrl = videoLink
    //                };

    //                var existingIMD = context.IndicationMediaDetails
    //                    .Where(imd => String.Compare(imd.DiseaseName, disease, true) == 0 && String.Compare(imd.IndicationName, indication, true) == 0)
    //                    .Select(imd => new { ImageUrl = imd.ImageUrl, VideoUrl = imd.VideoUrl })
    //                    .FirstOrDefault();
    //                bool create = existingIMD == null;
    //                bool modify = String.Compare(existingIMD.ImageUrl, indicationMediaDetails.ImageUrl, true) != 0
    //                                || String.Compare(existingIMD.VideoUrl, indicationMediaDetails.VideoUrl, true) != 0;

    //                context.Entry(indicationMediaDetails).State = create ? EntityState.Added : modify ? EntityState.Modified : EntityState.Unchanged;
    //                context.SaveChanges();
    //                msg = "Success";
    //            }
    //        }
    //        catch (Exception ex)
    //        {
    //            msg = ex.Message;
    //        }
    //    }
    //    return msg;

    //}

    //public ForecastReference GetIndicationDetails(string indicationName, int tenantId)
    //{            
    //    ForecastReference indicationInfo = new ForecastReference();

    //    String connectionString = GenUtil.GetTenantConnectionString(tenantId);
    //    using (var context = new TenantModel(connectionString))
    //    {
    //        try
    //        {
    //            var sectionReferences = context.BDLIndicationReference
    //                .Where(ir => String.Compare(ir.IndicationName, indicationName, true) == 0)
    //                .Select(ir => new
    //                {
    //                    Section = ir.SectionMaster.SectionName,
    //                    Reference = ir.Reference
    //                })
    //                .ToList();

    //            foreach (var sectionReference in sectionReferences)
    //            {
    //                if(String.Compare(sectionReference.Section.SafeTrim(), "Epidemiology", true) == 0)
    //                    indicationInfo.Epidemiology = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
    //                if (String.Compare(sectionReference.Section.SafeTrim(), "Historical Data", true) == 0)
    //                    indicationInfo.HistoricalData = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
    //                if (String.Compare(sectionReference.Section.SafeTrim(), "Compliance", true) == 0)
    //                    indicationInfo.Compliance = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
    //                if (String.Compare(sectionReference.Section.SafeTrim(), "Dosing", true) == 0)
    //                    indicationInfo.Dosing = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
    //                if (String.Compare(sectionReference.Section.SafeTrim(), "DoT", true) == 0)
    //                    indicationInfo.DoT = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
    //                if (String.Compare(sectionReference.Section.SafeTrim(), "Pricing", true) == 0)
    //                    indicationInfo.Pricing = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
    //                if (String.Compare(sectionReference.Section.SafeTrim(), "Market Access", true) == 0)
    //                    indicationInfo.MarketAccess = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
    //                if (String.Compare(sectionReference.Section.SafeTrim(), "Events", true) == 0)
    //                    indicationInfo.Events = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
    //                if (String.Compare(sectionReference.Section.SafeTrim(), "Treatment Algorithm", true) == 0)
    //                    indicationInfo.TreatmentAlgorithm = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
    //            }
    //        }
    //        catch (Exception ex)
    //        {

    //        }
    //    }

    //    return indicationInfo;
    //}
    public ForecastReference GetIndicationDetails(string indicationName, int tenantId)
        {
            // ForecastReference indicationInfo = new ForecastReference();
            ForecastReference indicationInfo = null;
            
                try
                {
                    var sectionReferences = uow.TenantContext.BDLIndicationReference
                        .Where(ir => String.Compare(ir.IndicationName, indicationName, true) == 0)
                        .Select(ir => new
                        {
                            Section = ir.SectionMaster.SectionName,
                            Reference = ir.Reference
                        })
                        .ToList();
                    if (sectionReferences.Count > 0)
                        indicationInfo = new ForecastReference();

                    foreach (var sectionReference in sectionReferences)
                    {

                        if (String.Compare(sectionReference.Section.SafeTrim(), "Epidemiology", true) == 0)
                            indicationInfo.Epidemiology = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
                        if (String.Compare(sectionReference.Section.SafeTrim(), "Historical Data", true) == 0)
                            indicationInfo.HistoricalData = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
                        if (String.Compare(sectionReference.Section.SafeTrim(), "Compliance", true) == 0)
                            indicationInfo.Compliance = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
                        if (String.Compare(sectionReference.Section.SafeTrim(), "Dosing", true) == 0)
                            indicationInfo.Dosing = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
                        if (String.Compare(sectionReference.Section.SafeTrim(), "DoT", true) == 0)
                            indicationInfo.DoT = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
                        if (String.Compare(sectionReference.Section.SafeTrim(), "Pricing", true) == 0)
                            indicationInfo.Pricing = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
                        if (String.Compare(sectionReference.Section.SafeTrim(), "Market Access", true) == 0)
                            indicationInfo.MarketAccess = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
                        if (String.Compare(sectionReference.Section.SafeTrim(), "Events", true) == 0)
                            indicationInfo.Events = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
                        if (String.Compare(sectionReference.Section.SafeTrim(), "Treatment Algorithm", true) == 0)
                            indicationInfo.TreatmentAlgorithm = WebUtility.HtmlDecode(sectionReference.Reference.SafeTrim());
                    }
                }
                catch (Exception ex)
                {

                }
            

            return indicationInfo;
        }
        public int AddInlineDurgs(ProductDetail dr)
        {
            int result = 0;
            try
            {
                InlineTransaction inlineTransactionData = uow.MasterContext.InlineTransaction
                   .Where(it => it.ProductMaster.ProductName == dr.ProductName && it.CompanyMaster.CompanyName == dr.CompanyName && it.FormMaster.FormName == dr.FormName).FirstOrDefault();

                if (inlineTransactionData == null)
                {
                    ProductCodeMaster productCodeMaster = uow.MasterContext.ProductCodeMaster.Where(o => o.ProductCode.Equals(dr.Product_Code)).FirstOrDefault();
                    if (productCodeMaster == null)
                    {
                        productCodeMaster = new ProductCodeMaster
                        {
                            ProductCode = dr.Product_Code
                        };
                        uow.MasterContext.ProductCodeMaster.Add(productCodeMaster);
                    }
                    ProductTypeMaster productTypeMaster = uow.MasterContext.ProductTypeMaster.Where(o => o.ProductType.Equals(dr.Product_Type)).FirstOrDefault();
                    if (productTypeMaster == null)
                    {
                        productTypeMaster = new ProductTypeMaster
                        {
                            ProductType = dr.Product_Type
                        };
                        uow.MasterContext.ProductTypeMaster.Add(productTypeMaster);

                    }

                    ProductCategoryMaster productCategoryMaster = uow.MasterContext.ProductCategoryMaster.Where(o => o.ProductCategory.Equals(dr.ProductCategory)).FirstOrDefault();
                    if (productCategoryMaster == null)
                    {
                        productCategoryMaster = new ProductCategoryMaster
                        {
                            ProductCategory = dr.ProductCategory
                        };
                        uow.MasterContext.ProductCategoryMaster.Add(productCategoryMaster);
                    }

                    FormMaster formMaster = uow.MasterContext.FormMaster.Where(o => o.FormName.Equals(dr.FormName)).FirstOrDefault();
                    if (formMaster == null)
                    {
                        formMaster = new FormMaster
                        {
                            FormName = dr.FormName
                        };
                        uow.MasterContext.FormMaster.Add(formMaster);
                    }

                    ROA_Master roa_Master = uow.MasterContext.ROA_Master.Where(o => o.RouteOfAdministration.Equals(dr.ROAType)).FirstOrDefault();
                    if (roa_Master == null)
                    {
                        roa_Master = new ROA_Master
                        {
                            RouteOfAdministration = dr.ROAType
                        };
                        uow.MasterContext.ROA_Master.Add(roa_Master);
                    }
                    ProductMaster productMaster = uow.MasterContext.ProductMaster.Where(o => o.ProductName.Equals(dr.ProductName)).FirstOrDefault();
                    if (productMaster == null)
                    {
                        productMaster = new ProductMaster
                        {
                            ProductName = dr.ProductName
                        };
                        uow.MasterContext.ProductMaster.Add(productMaster);
                    }

                    CompanyMaster companyMaster = uow.MasterContext.CompanyMaster.Where(o => o.CompanyName.Equals(dr.CompanyName)).FirstOrDefault();
                    if (companyMaster == null)
                    {
                        companyMaster = new CompanyMaster
                        {
                            CompanyName = dr.CompanyName
                        };
                        uow.MasterContext.CompanyMaster.Add(companyMaster);
                    }

                    CompanyMaster marketingPartner = null;
                    if (dr.MarketingPartner != null)
                    {
                        marketingPartner = uow.MasterContext.CompanyMaster.Where(o => o.CompanyName.Equals(dr.MarketingPartner)).FirstOrDefault();
                        if (marketingPartner == null)
                        {
                            marketingPartner = new CompanyMaster
                            {
                                CompanyName = dr.MarketingPartner
                            };
                            uow.MasterContext.CompanyMaster.Add(marketingPartner);
                        }
                    }

                    NADAC_PricingUnitMaster pricingUnitMaster = uow.MasterContext.NADAC_PricingUnitMaster.Where(o => o.NADACPricingUnit.Equals(dr.NADAC_PricingUnit)).FirstOrDefault();
                    if (pricingUnitMaster == null)
                    {
                        pricingUnitMaster = new NADAC_PricingUnitMaster
                        {
                            NADACPricingUnit = dr.NADAC_PricingUnit
                        };
                        uow.MasterContext.NADAC_PricingUnitMaster.Add(pricingUnitMaster);
                    }

                    PriceSourceMaster priceSourceMaster = uow.MasterContext.PriceSourceMaster.Where(o => o.PriceSource.Equals(dr.Price_Source)).FirstOrDefault();
                    if (priceSourceMaster == null)
                    {
                        priceSourceMaster = new PriceSourceMaster
                        {
                            PriceSource = dr.Price_Source
                        };
                        uow.MasterContext.PriceSourceMaster.Add(priceSourceMaster);
                    }

                    SubstanceMaster substanceMaster = uow.MasterContext.SubstanceMaster.Where(o => o.SubstanceName.Equals(dr.Substance)).FirstOrDefault();
                    if (substanceMaster == null)
                    {
                        substanceMaster = new SubstanceMaster
                        {
                            SubstanceName = dr.Substance
                        };
                        uow.MasterContext.SubstanceMaster.Add(substanceMaster);
                    }

                    string moleculeName1 = dr.Molecule[0];
                    MoleculeMaster moleculeMaster = uow.MasterContext.MoleculeMaster.Where(o => o.MoleculeName.Equals(moleculeName1)).FirstOrDefault();
                    if (moleculeMaster == null)
                    {
                        moleculeMaster = new MoleculeMaster
                        {
                            MoleculeName = moleculeName1
                        };
                        uow.MasterContext.MoleculeMaster.Add(moleculeMaster);
                    }

                    InlineTransaction inlineTransaction = new InlineTransaction
                    {
                        ProductCodeMaster = productCodeMaster,
                        ProductTypeMaster = productTypeMaster,
                        ProductCategoryMaster = productCategoryMaster,
                        FormMaster = formMaster,
                        ROA_Master = roa_Master,
                        ProductMaster = productMaster,
                        //CompanyId = companyId,
                        MoleculeMaster = moleculeMaster,
                        NADAC_PricingUnitMaster = pricingUnitMaster,
                        PriceSourceMaster = priceSourceMaster,
                        ApplicationShortNumber = dr.Application_Short_Number,
                        ProductUID = dr.Product_ID,
                        ProductNDC = dr.Product_NDC,
                        Strength = dr.Strength,
                        NADAC_Price = dr.NADAC_Price,
                        MOA = dr.MOA,
                        ApprovalDate = dr.Approval_Date,
                        StartMarketingDate = dr.StartMarketingDate,
                        SubstanceMaster = substanceMaster,
                        DosageAdult = dr.Dosage_Adult,
                        DosagePediatric = dr.Dosage_Pediatric,
                        CodeAndNDC = dr.Code_and_NDC,
                        SubIndication = dr.Sub_Indication,
                        DrugType = dr.Drug_Type,
                        MarketingStatus = dr.MarketingStatus,
                        LatestLabelDate = dr.LatestLabelDate,
                        RLD = dr.RLD,
                        TECode = dr.TECode,
                        //MarketingCompanyId = marketingPartnerId,
                        // MarketingCompany = marketingPartnerId
                        CompanyMaster1 = marketingPartner,
                        CompanyMaster = companyMaster
                    };
                    uow.MasterContext.InlineTransaction.Add(inlineTransaction);
                    foreach (var item in dr.Molecule)
                    {
                        MoleculeMaster moleculeMaster1 = null;
                        moleculeMaster1 = uow.MasterContext.MoleculeMaster.Where(o => o.MoleculeName.Equals(item)).FirstOrDefault();
                        if (moleculeMaster1 == null)
                        {
                            moleculeMaster1 = new MoleculeMaster()
                            {
                                MoleculeName = item
                            };
                            uow.MasterContext.MoleculeMaster.Add(moleculeMaster1);
                        }

                        InlineMoleculeMapping inlineMoleculeMapping = new InlineMoleculeMapping
                        {
                            Transaction1 = inlineTransaction,
                            MoleculeMaster = moleculeMaster1
                        };
                        uow.MasterContext.InlineMoleculeMapping.Add(inlineMoleculeMapping);
                    }
                    //foreach (var item in dr.IndicationName)
                    //{
                    //    IndicationMaster indicationMaster = null;
                    //    indicationMaster = uow.MasterContext.IndicationMaster.Where(o => o.IndicationName.Equals(item)).FirstOrDefault();
                    //    if (indicationMaster == null)
                    //    {
                    //        indicationMaster = new IndicationMaster
                    //        {
                    //            IndicationName = item
                    //        };
                    //        uow.MasterContext.IndicationMaster.Add(indicationMaster);
                    //    }
                    //    IndicationMapping indicationMapping = new IndicationMapping
                    //    {
                    //        Transaction1 = inlineTransaction,
                    //        IndicationMaster = indicationMaster
                    //    };
                    //    uow.MasterContext.IndicationMapping.Add(indicationMapping);
                    //}

                    foreach (var item in dr.Disease_Area)
                    {
                        DiseaseAreaMaster diseaseArea = null;
                        diseaseArea = uow.MasterContext.DiseaseAreaMaster.Where(o => o.DiseaseArea.Equals(item)).FirstOrDefault();
                        if (diseaseArea == null)
                        {
                            diseaseArea = new DiseaseAreaMaster
                            {
                                DiseaseArea = item
                            };
                            uow.MasterContext.DiseaseAreaMaster.Add(diseaseArea);
                        }

                        DiseaseAreaMapping diseaseAreaMapping = new DiseaseAreaMapping
                        {
                            InlineTransaction = inlineTransaction,
                            DiseaseAreaMaster = diseaseArea
                        };
                        uow.MasterContext.DiseaseAreaMapping.Add(diseaseAreaMapping);

                    }
                    List<PharmaClassMaster> pharmaClassMasterList = new List<PharmaClassMaster>();
                    PharmaClassMaster pharmaClassMaster = uow.MasterContext.PharmaClassMaster.Where(o => o.PharmaClass.Equals(dr.PHARMA_CLASSES)).FirstOrDefault();
                    if (pharmaClassMaster == null)
                    {
                        pharmaClassMaster = new PharmaClassMaster
                        {
                            PharmaClass = dr.PHARMA_CLASSES
                        };
                        uow.MasterContext.PharmaClassMaster.Add(pharmaClassMaster);
                    }
                    pharmaClassMasterList.Add(pharmaClassMaster);
                    PharmaClassMaster pharmaClassMaster_2 = null;
                    if (dr.PHARMA_CLASSES2 != null)
                    {
                        pharmaClassMaster_2 = uow.MasterContext.PharmaClassMaster.Where(o => o.PharmaClass.Equals(dr.PHARMA_CLASSES2)).FirstOrDefault();
                        if (pharmaClassMaster_2 == null)
                        {
                            pharmaClassMaster_2 = new PharmaClassMaster
                            {
                                PharmaClass = dr.PHARMA_CLASSES2
                            };

                            uow.MasterContext.PharmaClassMaster.Add(pharmaClassMaster_2);
                        }
                        pharmaClassMasterList.Add(pharmaClassMaster_2);
                    }
                    PharmaClassMaster pharmaClassMaster_3 = null;
                    if (dr.PHARMA_CLASSES3 != null)
                    {
                        pharmaClassMaster_3 = uow.MasterContext.PharmaClassMaster.Where(o => o.PharmaClass.Equals(dr.PHARMA_CLASSES3)).FirstOrDefault();
                        if (pharmaClassMaster_3 == null)
                        {
                            pharmaClassMaster_3 = new PharmaClassMaster
                            {
                                PharmaClass = dr.PHARMA_CLASSES3
                            };
                            uow.MasterContext.PharmaClassMaster.Add(pharmaClassMaster_3);
                        }
                        pharmaClassMasterList.Add(pharmaClassMaster_3);
                    }
                    PharmaClassMaster pharmaClassMaster_Ims = null;
                    if (dr.IMSClass != null)
                    {
                        pharmaClassMaster_Ims = uow.MasterContext.PharmaClassMaster.Where(o => o.PharmaClass.Equals(dr.IMSClass)).FirstOrDefault();
                        if (pharmaClassMaster_Ims == null)
                        {
                            pharmaClassMaster_Ims = new PharmaClassMaster
                            {
                                PharmaClass = dr.IMSClass
                            };
                            uow.MasterContext.PharmaClassMaster.Add(pharmaClassMaster_Ims);
                        }
                        pharmaClassMasterList.Add(pharmaClassMaster_Ims);
                    }
                    MOA_Master moa_Master = uow.MasterContext.MOA_Master.Where(o => o.MOA.Equals(dr.MOA)).FirstOrDefault();

                    moa_Master = new MOA_Master
                    {
                        MOA = dr.MOA
                    };
                    uow.MasterContext.MOA_Master.Add(moa_Master);


                    PharmaClassMapping pharmaClassMapping = new PharmaClassMapping
                    {
                        InlineTransaction = inlineTransaction,
                        PrimaryPharmaClass = pharmaClassMaster,
                        SecondaryPharmaClass = pharmaClassMaster_2,
                        TartiaryPharmaClass = pharmaClassMaster_3,
                        IMSPharmaClass = pharmaClassMaster_Ims

                    };
                    uow.MasterContext.PharmaClassMapping.Add(pharmaClassMapping);

                    foreach (var item in dr.IndicationName)
                    {
                        //IndicationMaster indicationMaster = null;
                        IndicationMaster indicationMaster = uow.MasterContext.IndicationMaster.Where(o => o.IndicationName.Equals(item)).FirstOrDefault();
                        //if (indicationMaster == null)
                        //{
                        //    indicationMaster = new IndicationMaster
                        //    {
                        //        IndicationName = item
                        //    };
                        //    uow.MasterContext.IndicationMaster.Add(indicationMaster);
                        //}
                        IndicationMapping indicationMapping = new IndicationMapping
                        {
                            Transaction1 = inlineTransaction,
                            IndicationMaster = indicationMaster
                        };
                        uow.MasterContext.IndicationMapping.Add(indicationMapping);

                        DiseaseIndicationData diseaseIndicationData = uow.MasterContext.DiseaseIndicationData.Where(dir => dir.SecondaryIndicationId == indicationMaster.IndicationId).FirstOrDefault();
                        if (diseaseIndicationData != null)
                        {
                            TreatmentRegimenDetail treatmantRegimenDetaildata = uow.MasterContext.TreatmentRegimenDetail.Where(tr => tr.DiseaseIndicationDataId == diseaseIndicationData.Id).FirstOrDefault();
                            if (treatmantRegimenDetaildata == null)
                            {
                                foreach (var pharmaClass in pharmaClassMasterList)
                                {
                                    TreatmentRegimenDetail treatmantRegimenDetail = new TreatmentRegimenDetail
                                    {
                                        DiseaseIndicationData = diseaseIndicationData,
                                        PharmaClassMaster = pharmaClass
                                    };
                                    uow.MasterContext.TreatmentRegimenDetail.Add(treatmantRegimenDetail);

                                }

                            }
                        }
                    }
                    uow.MasterContext.SaveChanges();
                    result = 1;
                }
                else
                    result = 2;
            }
            catch (Exception ex)
            {
                return 0;
            }
            return result;
        }


        public int EditInlineDurgs(ProductDetail dr)
        {
            int result = 0;
            try
            {
                InlineTransaction inlineTransaction = uow.MasterContext.InlineTransaction.Where(inline => inline.Id == dr.InlineTransactionId).FirstOrDefault();

                ProductCodeMaster productCodeMaster = uow.MasterContext.ProductCodeMaster.Where(o => o.ProductCode.Equals(dr.Product_Code)).FirstOrDefault();
                if (productCodeMaster == null)
                {
                    productCodeMaster = new ProductCodeMaster
                    {
                        ProductCode = dr.Product_Code
                    };
                    uow.MasterContext.ProductCodeMaster.Add(productCodeMaster);
                }
                ProductTypeMaster productTypeMaster = uow.MasterContext.ProductTypeMaster.Where(o => o.ProductType.Equals(dr.Product_Type)).FirstOrDefault();
                if (productTypeMaster == null)
                {
                    productTypeMaster = new ProductTypeMaster
                    {
                        ProductType = dr.Product_Type
                    };
                    uow.MasterContext.ProductTypeMaster.Add(productTypeMaster);

                }

                ProductCategoryMaster productCategoryMaster = uow.MasterContext.ProductCategoryMaster.Where(o => o.ProductCategory.Equals(dr.ProductCategory)).FirstOrDefault();
                if (productCategoryMaster == null)
                {
                    productCategoryMaster = new ProductCategoryMaster
                    {
                        ProductCategory = dr.ProductCategory
                    };
                    uow.MasterContext.ProductCategoryMaster.Add(productCategoryMaster);
                }

                FormMaster formMaster = uow.MasterContext.FormMaster.Where(o => o.FormName.Equals(dr.FormName)).FirstOrDefault();
                if (formMaster == null)
                {
                    formMaster = new FormMaster
                    {
                        FormName = dr.FormName
                    };
                    uow.MasterContext.FormMaster.Add(formMaster);
                }

                ROA_Master roa_Master = uow.MasterContext.ROA_Master.Where(o => o.RouteOfAdministration.Equals(dr.ROAType)).FirstOrDefault();
                if (roa_Master == null)
                {
                    roa_Master = new ROA_Master
                    {
                        RouteOfAdministration = dr.ROAType
                    };
                    uow.MasterContext.ROA_Master.Add(roa_Master);
                }

                ProductMaster productMaster = uow.MasterContext.ProductMaster.Where(o => o.ProductName.Equals(inlineTransaction.ProductMaster.ProductName)).FirstOrDefault();
                productMaster.ProductName = dr.ProductName;
                CompanyMaster companyMaster = uow.MasterContext.CompanyMaster.Where(o => o.CompanyName.Equals(dr.CompanyName)).FirstOrDefault();
                if (companyMaster == null)
                {
                    companyMaster = new CompanyMaster
                    {
                        CompanyName = dr.CompanyName
                    };
                    uow.MasterContext.CompanyMaster.Add(companyMaster);
                }

                CompanyMaster marketingPartner = null;
                if (dr.MarketingPartner != null)
                {
                    marketingPartner = uow.MasterContext.CompanyMaster.Where(o => o.CompanyName.Equals(dr.MarketingPartner)).FirstOrDefault();
                    if (marketingPartner == null)
                    {
                        marketingPartner = new CompanyMaster
                        {
                            CompanyName = dr.MarketingPartner
                        };
                        uow.MasterContext.CompanyMaster.Add(marketingPartner);
                    }
                }

                NADAC_PricingUnitMaster pricingUnitMaster = uow.MasterContext.NADAC_PricingUnitMaster.Where(o => o.NADACPricingUnit.Equals(dr.NADAC_PricingUnit)).FirstOrDefault();
                if (pricingUnitMaster == null)
                {
                    pricingUnitMaster = new NADAC_PricingUnitMaster
                    {
                        NADACPricingUnit = dr.NADAC_PricingUnit
                    };
                    uow.MasterContext.NADAC_PricingUnitMaster.Add(pricingUnitMaster);
                }

                PriceSourceMaster priceSourceMaster = uow.MasterContext.PriceSourceMaster.Where(o => o.PriceSource.Equals(dr.Price_Source)).FirstOrDefault();
                if (priceSourceMaster == null)
                {
                    priceSourceMaster = new PriceSourceMaster
                    {
                        PriceSource = dr.Price_Source
                    };
                    uow.MasterContext.PriceSourceMaster.Add(priceSourceMaster);
                }

                SubstanceMaster substanceMaster = uow.MasterContext.SubstanceMaster.Where(o => o.SubstanceName.Equals(dr.Substance)).FirstOrDefault();
                if (substanceMaster == null)
                {
                    substanceMaster = new SubstanceMaster
                    {
                        SubstanceName = dr.Substance
                    };
                    uow.MasterContext.SubstanceMaster.Add(substanceMaster);
                }

                //MoleculeMaster moleculeMaster = uow.MasterContext.MoleculeMaster.Where(o => o.MoleculeName.Equals(inlineTransaction.MoleculeMaster.MoleculeName)).FirstOrDefault();
                //moleculeMaster.MoleculeName = dr.Molecule[0];

                inlineTransaction.ProductCodeMaster = productCodeMaster;
                inlineTransaction.ProductTypeMaster = productTypeMaster;
                inlineTransaction.ProductCategoryMaster = productCategoryMaster;
                inlineTransaction.FormMaster = formMaster;
                inlineTransaction.ROA_Master = roa_Master;
                inlineTransaction.ProductMaster = productMaster;
                //CompanyId = companyId,
                // inlineTransaction.MoleculeMaster = moleculeMaster;
                inlineTransaction.NADAC_PricingUnitMaster = pricingUnitMaster;
                inlineTransaction.PriceSourceMaster = priceSourceMaster;
                inlineTransaction.ApplicationShortNumber = dr.Application_Short_Number;
                inlineTransaction.ProductUID = dr.Product_ID;
                inlineTransaction.ProductNDC = dr.Product_NDC;
                inlineTransaction.Strength = dr.Strength;
                inlineTransaction.NADAC_Price = dr.NADAC_Price;
                inlineTransaction.MOA = dr.MOA;
                inlineTransaction.ApprovalDate = dr.Approval_Date;
                inlineTransaction.StartMarketingDate = dr.StartMarketingDate;
                inlineTransaction.SubstanceMaster = substanceMaster;
                inlineTransaction.DosageAdult = dr.Dosage_Adult;
                inlineTransaction.DosagePediatric = dr.Dosage_Pediatric;
                inlineTransaction.CodeAndNDC = dr.Code_and_NDC;
                inlineTransaction.SubIndication = dr.Sub_Indication;
                inlineTransaction.DrugType = dr.Drug_Type;
                inlineTransaction.MarketingStatus = dr.MarketingStatus;
                inlineTransaction.LatestLabelDate = dr.LatestLabelDate;
                inlineTransaction.RLD = dr.RLD;
                inlineTransaction.TECode = dr.TECode;
                //MarketingCompanyId = marketingPartnerId,
                // MarketingCompany = marketingPartnerId
                inlineTransaction.CompanyMaster1 = marketingPartner;
                inlineTransaction.CompanyMaster = companyMaster;


                var moleculelist = uow.MasterContext.InlineMoleculeMapping.Where(mom => mom.MoleculeTransactionId == dr.InlineTransactionId).Select(mom => mom.MoleculeMaster.MoleculeName).ToList();
                foreach (var newItem in dr.Molecule)
                {
                    if (!(moleculelist.Contains(newItem)))
                    {
                        MoleculeMaster moleculeMaster1 = null;
                        moleculeMaster1 = uow.MasterContext.MoleculeMaster.Where(o => o.MoleculeName.Equals(newItem)).FirstOrDefault();
                        if (moleculeMaster1 == null)
                        {
                            moleculeMaster1 = new MoleculeMaster()
                            {
                                MoleculeName = newItem
                            };
                            uow.MasterContext.MoleculeMaster.Add(moleculeMaster1);
                        }
                        InlineMoleculeMapping inlineMoleculeMapping = new InlineMoleculeMapping
                        {
                            Transaction1 = inlineTransaction,
                            MoleculeMaster = moleculeMaster1
                        };
                        uow.MasterContext.InlineMoleculeMapping.Add(inlineMoleculeMapping);
                    }
                }
                foreach (var olditem in moleculelist)
                {
                    if (!(dr.Molecule.Contains(olditem)))
                    {
                        InlineMoleculeMapping inlineMoleculeMapping = uow.MasterContext.InlineMoleculeMapping.Where(o => o.MoleculeMaster.MoleculeName.Equals(olditem)).FirstOrDefault();
                        uow.MasterContext.InlineMoleculeMapping.Remove(inlineMoleculeMapping);

                    }

                }
                var indicationList = uow.MasterContext.IndicationMapping.Where(ind => ind.IndicationTransactionId == dr.InlineTransactionId).Select(ind => ind.IndicationMaster.IndicationName).ToList();
                foreach (var newItem in dr.IndicationName)
                {
                    if (!(indicationList.Contains(newItem)))
                    {
                        IndicationMaster indicationMaster = null;
                        indicationMaster = uow.MasterContext.IndicationMaster.Where(o => o.IndicationName.Equals(newItem)).FirstOrDefault();
                        //if (indicationMaster == null)
                        //{
                        //    indicationMaster = new IndicationMaster
                        //    {
                        //        IndicationName = newItem
                        //    };
                        //}
                        // uow.MasterContext.IndicationMaster.Add(indicationMaster);

                        IndicationMapping indicationMapping = new IndicationMapping
                        {
                            Transaction1 = inlineTransaction,
                            IndicationMaster = indicationMaster
                        };
                        uow.MasterContext.IndicationMapping.Add(indicationMapping);
                    }

                }
                foreach (var olditem in indicationList)
                {
                    if (!(dr.IndicationName.Contains(olditem)))
                    {
                        IndicationMapping indicationMapping = uow.MasterContext.IndicationMapping.Where(o => o.IndicationMaster.IndicationName.Equals(olditem)).FirstOrDefault();
                        uow.MasterContext.IndicationMapping.Remove(indicationMapping);

                    }

                }
                if (dr.Disease_Area != null)
                {
                    var DiseaseAreaList = uow.MasterContext.DiseaseAreaMapping.Where(dis => dis.InlineTransactionId == dr.InlineTransactionId).Select(dis => dis.DiseaseAreaMaster.DiseaseArea).ToList();
                    foreach (var newItem in dr.Disease_Area)
                    {
                        if (!(DiseaseAreaList.Contains(newItem)))
                        {
                            DiseaseAreaMaster diseaseArea = null;
                            diseaseArea = uow.MasterContext.DiseaseAreaMaster.Where(o => o.DiseaseArea.Equals(newItem)).FirstOrDefault();
                            if (diseaseArea == null)
                            {
                                diseaseArea = new DiseaseAreaMaster
                                {
                                    DiseaseArea = newItem
                                };
                                uow.MasterContext.DiseaseAreaMaster.Add(diseaseArea);
                            }
                            DiseaseAreaMapping diseaseAreaMapping = new DiseaseAreaMapping
                            {
                                InlineTransaction = inlineTransaction,
                                DiseaseAreaMaster = diseaseArea
                            };
                            uow.MasterContext.DiseaseAreaMapping.Add(diseaseAreaMapping);
                        }

                    }
                    foreach (var olditem in DiseaseAreaList)
                    {
                        if (!(dr.Disease_Area.Contains(olditem)))
                        {
                            DiseaseAreaMapping diseaseAreaMapping = uow.MasterContext.DiseaseAreaMapping.Where(o => o.DiseaseAreaMaster.DiseaseArea.Equals(olditem)).FirstOrDefault();
                            uow.MasterContext.DiseaseAreaMapping.Remove(diseaseAreaMapping);

                        }

                    }
                }
                PharmaClassMaster pharmaClassMaster = uow.MasterContext.PharmaClassMaster.Where(o => o.PharmaClass.Equals(dr.PHARMA_CLASSES)).FirstOrDefault();
                if (pharmaClassMaster == null)
                {
                    pharmaClassMaster = new PharmaClassMaster
                    {
                        PharmaClass = dr.PHARMA_CLASSES
                    };
                    uow.MasterContext.PharmaClassMaster.Add(pharmaClassMaster);
                }
                PharmaClassMaster pharmaClassMaster_2 = null;
                if (dr.PHARMA_CLASSES2 != null)
                {
                    pharmaClassMaster_2 = uow.MasterContext.PharmaClassMaster.Where(o => o.PharmaClass.Equals(dr.PHARMA_CLASSES2)).FirstOrDefault();
                    if (pharmaClassMaster_2 == null)
                    {
                        pharmaClassMaster_2 = new PharmaClassMaster
                        {
                            PharmaClass = dr.PHARMA_CLASSES2
                        };

                        uow.MasterContext.PharmaClassMaster.Add(pharmaClassMaster_2);
                    }
                }

                PharmaClassMaster pharmaClassMaster_3 = null;
                if (dr.PHARMA_CLASSES3 != null)
                {
                    pharmaClassMaster_3 = uow.MasterContext.PharmaClassMaster.Where(o => o.PharmaClass.Equals(dr.PHARMA_CLASSES3)).FirstOrDefault();
                    if (pharmaClassMaster_3 == null)
                    {
                        pharmaClassMaster_3 = new PharmaClassMaster
                        {
                            PharmaClass = dr.PHARMA_CLASSES3
                        };
                        uow.MasterContext.PharmaClassMaster.Add(pharmaClassMaster_3);
                    }

                }
                PharmaClassMaster pharmaClassMaster_Ims = null;
                if (dr.IMSClass != null)
                {
                    pharmaClassMaster_Ims = uow.MasterContext.PharmaClassMaster.Where(o => o.PharmaClass.Equals(dr.IMSClass)).FirstOrDefault();
                    if (pharmaClassMaster_Ims == null)
                    {
                        pharmaClassMaster_Ims = new PharmaClassMaster
                        {
                            PharmaClass = dr.IMSClass
                        };
                        uow.MasterContext.PharmaClassMaster.Add(pharmaClassMaster_Ims);
                    }
                }
                MOA_Master moa_Master = uow.MasterContext.MOA_Master.Where(o => o.MOA.Equals(dr.MOA)).FirstOrDefault();
                if (moa_Master == null)
                {
                    moa_Master = new MOA_Master
                    {
                        MOA = dr.MOA
                    };
                    uow.MasterContext.MOA_Master.Add(moa_Master);
                }

                PharmaClassMapping pharmaClassMapping = uow.MasterContext.PharmaClassMapping.Where(da => da.PharmaClassTransactionId == dr.InlineTransactionId).FirstOrDefault();
                pharmaClassMapping.PrimaryPharmaClass = pharmaClassMaster;
                pharmaClassMapping.SecondaryPharmaClass = pharmaClassMaster_2;
                pharmaClassMapping.TartiaryPharmaClass = pharmaClassMaster_3;
                pharmaClassMapping.IMSPharmaClass = pharmaClassMaster_Ims;

                uow.MasterContext.SaveChanges();
                result = 1;

            }
            catch (Exception ex)
            {
                return 0;
            }
            return result;
        }
        public List<ExclusivityData> GetExclusivityListData()

        {
            try
            {
                List<ExclusivityData> exclusivityList = uow.MasterContext.Exclusivities
                .Select(ex => new ExclusivityData()
                {
                    Exclusivity = ex.Exclusivity1,
                    Description = ex.Description

                }).ToList();

                return exclusivityList;

            }
            catch (Exception ex)
            {

                return null;
            }


        }

        public int AddPatentDetails(PatentData patentData)
        {
            int result = 0;
            try
            {
                patentData.generic.CompanyId = 1;
                InlineTransaction inline = uow.MasterContext.InlineTransaction.Where(it => it.Id == 1).FirstOrDefault();

                #region AddingGenericData
                GenericAvailability GenericAvailabilities = new GenericAvailability()
                {
                    GenericAvailability1 = patentData.generic.GenericAvailability.SafeToBool(),
                    FTFApprovalDate = patentData.generic.FTFApprovalDate,
                    FTFfilingDate = patentData.generic.FTFfilingDate,
                    FTFLaunchDate = patentData.generic.FTFLaunchDate,
                    Transaction = inline
                };

                if (patentData.generic.FTFHolders != null)
                {
                    foreach (var item in patentData.generic.FTFHolders)
                    {
                        var holders = uow.MasterContext.CompanyMaster.Where(c => c.CompanyName == item).FirstOrDefault();
                        if (holders == null)
                        {
                            holders = new CompanyMaster()
                            {
                                CompanyName = item
                            };
                            uow.MasterContext.CompanyMaster.Add(holders);
                        }

                        FTFHolderGenericMapping ftfGen = new FTFHolderGenericMapping()
                        {
                            CompanyMaster = holders,
                            GenericAvailability = GenericAvailabilities
                        };
                        uow.MasterContext.FTFHolderGenericMappings.Add(ftfGen);
                    }
                }
                if (patentData.generic.AuthorisedGenerics != null)
                {
                    foreach (var item in patentData.generic.AuthorisedGenerics)
                    {
                        var authorised = uow.MasterContext.CompanyMaster.Where(c => c.CompanyName == item).FirstOrDefault();
                        if (authorised == null)
                        {
                            authorised = new CompanyMaster()
                            {
                                CompanyName = item
                            };
                            uow.MasterContext.CompanyMaster.Add(authorised);
                        }
                        AuthorizedGenericMapping authogen = new AuthorizedGenericMapping()
                        {
                            CompanyMaster = authorised,
                            GenericAvailability = GenericAvailabilities
                        };
                        uow.MasterContext.AuthorizedGenericMappings.Add(authogen);
                    }
                }

                if (patentData.generic.GenericPlayers != null)
                {
                    foreach (var item in patentData.generic.GenericPlayers)
                    {
                        var players = uow.MasterContext.CompanyMaster.Where(c => c.CompanyName == item).FirstOrDefault();
                        if (players == null)
                        {
                            players = new CompanyMaster()
                            {
                                CompanyName = item
                            };
                            uow.MasterContext.CompanyMaster.Add(players);
                        }
                        CompanyGenericPlayersMapping genPlayers = new CompanyGenericPlayersMapping()
                        {
                            CompanyMaster = players,
                            GenericAvailability = GenericAvailabilities
                        };
                        uow.MasterContext.CompanyGenericPlayersMappings.Add(genPlayers);
                    }                  
                }

                uow.MasterContext.GenericAvailabilities.Add(GenericAvailabilities);


                #endregion

                #region AddingSalesInfo

                SalesInformation sales = new SalesInformation()
                {
                    Transaction = inline,
                    CurrentYear = patentData.saleInfo.CurrentYear,
                    PreviousYear = patentData.saleInfo.PrevYear,
                    PercentChange = patentData.saleInfo.Change
                };

                uow.MasterContext.SalesInformations.Add(sales);
                #endregion

                #region AddingExclusivityData

                foreach (var item in patentData.exclusivity)
                {
                    Exclusivity exl = uow.MasterContext.Exclusivities
                                  .Where(e => e.Exclusivity1.Trim() == item.Exclusivity.Trim() && e.Description.Trim() == item.Description.Trim()).FirstOrDefault();

                    if (exl == null)
                    {

                        exl = new Exclusivity()
                        {
                            Exclusivity1 = item.Exclusivity,
                            Description = item.Description
                        };
                        uow.MasterContext.Exclusivities.Add(exl);
                    }

                    ExclusivityInfo excl = new ExclusivityInfo()
                    {
                        Transaction = inline,
                        Exclusivity = exl,
                        Expiry = item.Expiry
                    };

                    uow.MasterContext.ExclusivityInfoes.Add(excl);

                }
                #endregion

                #region AddingPatentInfoData

                foreach (var item in patentData.piData)
                {
                    PatentType pt = uow.MasterContext.PatentTypes.Where(p => p.PatentType1 == item.TypeOfPatent).FirstOrDefault();
                    if (pt==null)
                    {
                        pt = new PatentType()
                        {
                            PatentType1 = item.TypeOfPatent
                        };
                        uow.MasterContext.PatentTypes.Add(pt);
                    }
                    PatentUseCode puc = uow.MasterContext.PatentUseCodes.Where(pu => pu.PatentUseCode1 == item.PatentUseCode).FirstOrDefault();
                    if (puc == null)
                    {
                        puc = new PatentUseCode()
                        {
                            PatentUseCode1=item.PatentUseCode
                        };
                        uow.MasterContext.PatentTypes.Add(pt);
                    }
                    PatentInfo pi = new PatentInfo()
                    {
                        Transaction = inline,
                        DelistRequested = item.DelistRequested,
                        Expiry = item.ExpiryDate,
                        IndependentClaims = item.IndependentClaims,
                        PatentLicensingInfo = item.PatentLicensingInfo,
                        PatentNo = item.PatentNo,
                        PatentType = pt,
                        PatentUseCode = puc,
                        PTEGranted = item.PTEGranted,

                    };
                    uow.MasterContext.PatentInfoes.Add(pi);
                }

                #endregion


                uow.MasterContext.SaveChanges();
                return 1;

            }
            catch (Exception ex)
            {

                return 0;
            }



            return result;
        }


        public PatentData FetchPatentDetails(int inlineTransId)
        {
            PatentData patent = new PatentData();
            try
            {
                inlineTransId = 1;
                GenericAvailability general = uow.MasterContext.GenericAvailabilities.Where(p => p.InlineTrasnactionId == inlineTransId).FirstOrDefault();

                PatentGenericAvailability pg = new PatentGenericAvailability();
                pg.FTFfilingDate = general.FTFfilingDate;
                pg.FTFApprovalDate = general.FTFApprovalDate;
                pg.FTFLaunchDate = general.FTFLaunchDate;
                pg.AuthorisedGenerics = general.AuthorizedGenericMappings.Select(a => a.CompanyMaster.CompanyName).ToList();
                pg.GenericPlayers=general.CompanyGenericPlayersMappings.Select(a => a.CompanyMaster.CompanyName).ToList();
                pg.FTFHolders= general.FTFHolderGenericMappings.Select(a => a.CompanyMaster.CompanyName).ToList();

                patent.generic = pg;
                //Sales Information
                SalesInformation salesInfo = uow.MasterContext.SalesInformations.Where(st => st.InlineTransactionId == inlineTransId).FirstOrDefault();
                SaleINfo si = new SaleINfo();

                si.CurrentYear = salesInfo.CurrentYear;
                si.PrevYear = salesInfo.PreviousYear;
                si.Change = salesInfo.PercentChange;

                patent.saleInfo = si;

                //Exclusvity Information
                var PatentExclusivityListData = uow.MasterContext.ExclusivityInfoes.Where(exi => exi.InlineTransactionId == inlineTransId).ToList();
                if (PatentExclusivityListData != null)
                {
                    List<ExclusivityData> exclusivityList = new List<ExclusivityData>();

                    foreach (var item in PatentExclusivityListData)
                    {
                        var exclusivity = new ExclusivityData()
                        {
                            Exclusivity = item.Exclusivity.Exclusivity1,
                            Description = item.Exclusivity.Description,
                            Expiry = item.Expiry

                        };

                        exclusivityList.Add(exclusivity);

                    }

                    patent.exclusivity = exclusivityList;

                }


                //apiInformation
                var apiInfoList = uow.MasterContext.APIInformations
                                          .Where(api => api.InlineTransanctionId == inlineTransId).ToList();
                if (apiInfoList.Count() != 0)
                {
                    List<APIINfo> listApiInfoData = new List<APIINfo>();
                    foreach (var item in apiInfoList)
                    {
                        var apiInfoObj = new APIINfo()
                        {
                            SubmissionDate = item.SubmissionDate,
                           DMFHolders = item.CompanyMaster.CompanyName,
                            ANDAHolder = item.ANDAHolderAgainstTheFiledDMF,
                            DMFStatus = item.DMFStatus,
                            OrganizationFinishedProducts = item.OrganizationFinishedProducts

                        };

                        listApiInfoData.Add(apiInfoObj);


                    }

                    patent.apiInfoList = listApiInfoData;
                }

                //PatentInformation

                var listPatentInfoData = uow.MasterContext.PatentInfoes
                                       .Where(pi => pi.InlineTransactionId == inlineTransId).ToList();
                if(listPatentInfoData.Count()!=0)
                {

                    List<PatentInfoData> patentInfoData = new List<PatentInfoData>();

                    foreach (var item in listPatentInfoData)
                    {
                        PatentInfoData piData = new PatentInfoData()
                        {

                            PatentNo=item.PatentNo,
                            TypeOfPatent=Convert.ToString(item.PatentType),
                            PatentUseCode=Convert.ToString(item.PatentUseCode),
                            ExpiryDate=item.Expiry,
                            PTEGranted=item.PTEGranted,
                            IndependentClaims=item.IndependentClaims,
                            DelistRequested=item.DelistRequested,
                            PatentLicensingInfo=item.PatentLicensingInfo


                        };

                        patentInfoData.Add(piData);



                    }


                    patent.piData = patentInfoData;

                }

            }
            catch (Exception e)
            {

               
            }
            return patent;
                

        }


        public Patent GetPatentData()
        {

            var patentInfo = new Patent();

            var brandList = uow.MasterContext.GenericAvailabilities.Select(
                p => new BrandInfo()
                {
                    InlineTransId = p.InlineTrasnactionId,
                    BrandName = p.Transaction.ProductMaster.ProductName
                }).ToList();

            patentInfo.brandList = brandList;
            return patentInfo;


        }

        public PatentData GetPatentInfo(int inlineTransId)
        {
            PatentData patent = new PatentData();
            try
            {
                inlineTransId = 1;
                GenericAvailability general = uow.MasterContext.GenericAvailabilities.Where(p => p.InlineTrasnactionId == inlineTransId).FirstOrDefault();
                //Generic Availabilty
                PatentGenericAvailability pg = new PatentGenericAvailability();
                pg.FTFfilingDate = general.FTFfilingDate;
                pg.FTFApprovalDate = general.FTFApprovalDate;
                pg.FTFLaunchDate = general.FTFLaunchDate;
                pg.AuthorisedGenerics = general.AuthorizedGenericMappings.Select(a => a.CompanyMaster.CompanyName).ToList();
                pg.GenericPlayers = general.CompanyGenericPlayersMappings.Select(a => a.CompanyMaster.CompanyName).ToList();
                pg.FTFHolders = general.FTFHolderGenericMappings.Select(a => a.CompanyMaster.CompanyName).ToList();

                patent.generic = pg;

                //Sales Information
                SalesInformation salesInfo = uow.MasterContext.SalesInformations.Where(st => st.InlineTransactionId == inlineTransId).FirstOrDefault();
                SaleINfo si = new SaleINfo();

                si.CurrentYear =salesInfo.CurrentYear;
                si.PrevYear = salesInfo.PreviousYear;
                si.Change = salesInfo.PercentChange;

                patent.saleInfo = si;

                //Exclusvity Information
                var PatentExclusivityListData = uow.MasterContext.ExclusivityInfoes.Where(exi => exi.InlineTransactionId == inlineTransId).ToList();
                if (PatentExclusivityListData != null)
                {
                    List<ExclusivityData> exclusivityList = new List<ExclusivityData>();

                    foreach (var item in PatentExclusivityListData)
                    {
                        var exclusivity = new ExclusivityData()
                        {
                            Exclusivity = item.Exclusivity.Exclusivity1,
                            Description = item.Exclusivity.Description,
                            Expiry = item.Expiry

                        };

                        exclusivityList.Add(exclusivity);

                    }

                    patent.exclusivity = exclusivityList;

                }

                //apiInformation
                var apiInfoList = uow.MasterContext.APIInformations
                                          .Where(api => api.InlineTransanctionId == inlineTransId).ToList();
                if(apiInfoList.Count()!=0)
                {
                    List<APIINfo> listApiInfoData = new List<APIINfo>();
                    foreach (var item in apiInfoList)
                    {
                        var apiInfoObj = new APIINfo()
                        {
                            SubmissionDate=item.SubmissionDate,
                            DMFHolders=item.CompanyMaster.CompanyName,
                            ANDAHolder=item.ANDAHolderAgainstTheFiledDMF,
                            DMFStatus=item.DMFStatus,
                            OrganizationFinishedProducts=item.OrganizationFinishedProducts

                        };

                        listApiInfoData.Add(apiInfoObj);


                    }

                    patent.apiInfoList = listApiInfoData;
                }

                //PatentInformation

                var listPatentInfoData = uow.MasterContext.PatentInfoes
                                       .Where(pi => pi.InlineTransactionId == inlineTransId).ToList();
                if (listPatentInfoData.Count() != 0)
                {

                    List<PatentInfoData> patentInfoData = new List<PatentInfoData>();

                    foreach (var item in listPatentInfoData)
                    {
                        PatentInfoData piData = new PatentInfoData()
                        {

                            PatentNo = item.PatentNo,
                            TypeOfPatent = Convert.ToString(item.PatentType),
                            PatentUseCode = Convert.ToString(item.PatentUseCode),
                            ExpiryDate = item.Expiry,
                            PTEGranted = item.PTEGranted,
                            IndependentClaims = item.IndependentClaims,
                            DelistRequested = item.DelistRequested,
                            PatentLicensingInfo = item.PatentLicensingInfo


                        };

                        patentInfoData.Add(piData);



                    }


                    patent.piData = patentInfoData;

                }


            }
            catch (Exception e)
            {


            }
            return patent;





        }




        //public int AddPatentDetails(PatentData generic)
        //{
        //    int result = 0;
        //    try
        //    {
        //        generic.CompanyId = 1;
        //        InlineTransaction inline = uow.MasterContext.InlineTransaction.Where(it => it.Id == 1).FirstOrDefault();

        //        GenericAvailability GenericAvailabilities = new GenericAvailability()
        //        {
        //            GenericAvailability1 = generic.GenericAvailability.SafeToBool(),
        //            FTFApprovalDate = generic.FTFApprovalDate,
        //            FTFfilingDate = generic.FTFfilingDate,
        //            FTFLaunchDate = generic.FTFLaunchDate,
        //            Transaction = inline
        //        };

        //        foreach (var item in generic.FTFHolders)
        //        {
        //            var holders = uow.MasterContext.CompanyMaster.Where(c => c.CompanyName == item).FirstOrDefault();
        //            if (holders == null)
        //            {
        //                holders = new CompanyMaster()
        //                {
        //                    CompanyName = item
        //                };
        //                uow.MasterContext.CompanyMaster.Add(holders);
        //            }

        //            FTFHolderGenericMapping ftfGen = new FTFHolderGenericMapping()
        //            {
        //                CompanyMaster = holders,
        //                GenericAvailability = GenericAvailabilities
        //            };
        //            uow.MasterContext.FTFHolderGenericMappings.Add(ftfGen);
        //        }

        //        foreach (var item in generic.AuthorisedGenerics)
        //        {
        //            var authorised = uow.MasterContext.CompanyMaster.Where(c => c.CompanyName == item).FirstOrDefault();
        //            if (authorised == null)
        //            {
        //                authorised = new CompanyMaster()
        //                {
        //                    CompanyName = item
        //                };
        //                uow.MasterContext.CompanyMaster.Add(authorised);
        //            }
        //            AuthorizedGenericMapping authogen = new AuthorizedGenericMapping()
        //            {
        //                CompanyMaster = authorised,
        //                GenericAvailability = GenericAvailabilities
        //            };
        //            uow.MasterContext.AuthorizedGenericMappings.Add(authogen);
        //        }

        //        foreach (var item in generic.GenericPlayers)
        //        {
        //            var players = uow.MasterContext.CompanyMaster.Where(c => c.CompanyName == item).FirstOrDefault();
        //            if (players == null)
        //            {
        //                players = new CompanyMaster()
        //                {
        //                    CompanyName = item
        //                };
        //                uow.MasterContext.CompanyMaster.Add(players);
        //            }
        //            CompanyGenericPlayersMapping genPlayers = new CompanyGenericPlayersMapping()
        //            {
        //                CompanyMaster = players,
        //                GenericAvailability = GenericAvailabilities
        //            };
        //            uow.MasterContext.CompanyGenericPlayersMappings.Add(genPlayers);
        //        }
        //        uow.MasterContext.GenericAvailabilities.Add(GenericAvailabilities);
        //        uow.MasterContext.SaveChanges();
        //        return 1;

        //    }
        //    catch (Exception ex)
        //    {

        //        return 0;
        //    }



        //    return result;
        //}
    }
}