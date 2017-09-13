using System;
using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastSection
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Start { get; set; }
        public int End { get; set; }
        public bool HasAssumption { get; set; }
        public int? Parent { get; set; }
        public List<ForecastSection> SubSections { get; set; }
        public ForecastParameterScope Scope { get; set; }
    }

    public class UserSectionSetting
    {
        public string Version { get; set; }
        public DateTime When { get; set; }
        public string SectionSetting { get; set; }
    }
}