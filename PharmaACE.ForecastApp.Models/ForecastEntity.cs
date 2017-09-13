using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public abstract class ForecastEntity
    {
        public ForecastEntity()
        {
            ForecastDetails = new ForecastDetails();
        }
        public ForecastDetails ForecastDetails { get; set; }
        public ForecastAuxiliary ForecastAuxiliary { get; set; }
        public abstract string ModelName { get; }
        public abstract string LogoImagePath { get; }
        public abstract string BackgroundImage { get; }
        public abstract string PageHeader { get; }
        public abstract string ModelLocation { get; }
        public abstract bool DisplayInitialModel { get; }
        public abstract HeaderType MenuType { get; }
        public abstract List<ForecastSection> Sections { set; get; }
        //public List<ForecastSection> Sections { set; }
        public abstract bool IsUtil { get; }
    }
}