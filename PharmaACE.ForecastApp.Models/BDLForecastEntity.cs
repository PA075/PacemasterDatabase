using System;
using System.Collections.Generic;
using System.Linq;

namespace PharmaACE.ForecastApp.Models
{
    public class BDLForecastEntity : ForecastEntity
    {
        public override string LogoImagePath
        {
            get
            {
                return "../../Content/img/forecast-icon-70.jpg";
            }
        }

        public override string BackgroundImage
        {
            get
            {
                return "../Content/img/BDL_Cover_Pic.jpg";
            }
        }

        public override string ModelLocation
        {
            get
            {
                return "BDL";
            }
        }

        public override string ModelName
        {
            get
            {
                return "BDL Tool.xlsb";
            }
        }

        public override string PageHeader
        {
            get
            {
                return "BD&L Forecast Platform";
            }
        }

        public override bool DisplayInitialModel
        {
            get
            {
                return false;
            }
        }

        public override HeaderType MenuType
        {
            get
            {
                return HeaderType.Forecast;
            }
        }

        public override List<ForecastSection> Sections
        {
            set;
            get;
            
        }

        public override bool IsUtil
        {
            get
            {
                return false;
            }
        }
    }
}
