using System;
using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class SensitivityAndTornadoUtil : ForecastEntity
    {
        public override string BackgroundImage
        {
            get
            {
                return String.Empty;
            }
        }

        public override bool DisplayInitialModel
        {
            get
            {
                return true;
            }
        }

        public override bool IsUtil
        {
            get
            {
                return true;
            }
        }

        public override string LogoImagePath
        {
            get
            {
                return "../../Content/img/utilities-icon-70.jpg";
            }
        }

        public override HeaderType MenuType
        {
            get
            {
                return HeaderType.Utilities;
            }
        }

        public override string ModelLocation
        {
            get
            {
                return String.Empty;
            }
        }

        public override string ModelName
        {
            get
            {
                return "Waterfall_Chart.xlsb";
            }
        }

        public override string PageHeader
        {
            get
            {
                return "Sensitivity And Tornado";
            }
        }

        public override List<ForecastSection> Sections
        {
            set { }
            get
            {
                List<ForecastSection> sections = new List<ForecastSection>();
                return sections;
            }
        }
    }
}
