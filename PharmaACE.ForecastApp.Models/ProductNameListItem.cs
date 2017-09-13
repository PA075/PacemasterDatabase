using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class ProductNameListItem
    {
        public string label { get; set; }
        public string value { get; set; }
    }

    public class MoleculeNameListItem
    {
        public string label { get; set; }
        public string value { get; set; }
    }

    public class PharmaClassNameListItem
    {
        public string label { get; set; }
        public string value { get; set; }
    }

    public class IndicationNameListItem
    {
        public string label { get; set; }
        public string value { get; set; }
    }








    public class AutocompleteListData
    {
        public List<ProductNameListItem> ProductList { get; set; }
        public List<MoleculeNameListItem> MoleculeList { get; set; }
        public List<PharmaClassNameListItem> PharmaClassList { get; set; }
        public List<IndicationNameListItem> IndicationList { get; set; }



        public List<string> CompanyList { get; set; }
        public List<string> ProductCategoryList { get; set; }
        public List<string> SubstanceList { get; set; }
        public List<string> FormList { get; set; }
        public List<string> ROA_MasterList { get; set; }
        public List<string> DiseaseAreaList { get; set; }
        public List<string> MOA_MasterList { get; set; }
        public List<string> ProductTypeList { get; set; }
        public List<string> PriceUnitList { get; set; }
        public List<string> PriceSourceList { get; set; }
        public List<string> DrugsTypeList { get; set; }
        public List<string> StrengthList { get; set; }

    }
}
