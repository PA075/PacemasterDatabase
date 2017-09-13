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
       
    }
}
