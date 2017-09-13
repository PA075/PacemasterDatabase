using System;
using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class GenericForecastEntityForForecaster:ForecastEntity
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
                return "../Content/img/Forecast_Gx.jpg";
            }
        }

        public override string ModelLocation
        {
            get
            {
                return "Generics";
            }
        }

        public override string ModelName
        {
            get
            {
                return "PharmaACE Forecast Tool.xlsb";
            }
        }

        public override string PageHeader
        {
            get
            {
                return "Generic Forecast Platform";
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
                return HeaderType.Forecaster;
            }
        }


        public override List<ForecastSection> Sections
        {
            set { }
            get
            {
                List<ForecastSection> sections = new List<ForecastSection>();

                sections.Add(
                    new ForecastSection
                    {
                        Name = "Historical Data",
                        HasAssumption = true,
                        Start = 12,
                        End = 88
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Projections",
                        HasAssumption = true,
                        Start = 89,
                        End = 110
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Penetration",
                        HasAssumption = true,
                        Start = 111,
                        End = 116
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Events",
                        HasAssumption = true,
                        Start = 117,
                        End = 145
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Conversion Parameters",
                        HasAssumption = true,
                        Start = 146,
                        End = 157
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Output",
                        HasAssumption = false,
                        Start = 158,
                        End = 167
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Pack Split",
                        HasAssumption = false,
                        Start = 168,
                        End = 169
                    }
                    );


                return sections;
            }
        }

        public override bool IsUtil
        {
            get
            {
                return false;
            }
        }
    }
    public class GenericForecastEntity : ForecastEntity
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
                return "../Content/img/Forecast_Gx.jpg";
            }
        }

        public override string ModelLocation
        {
            get
            {
                return "Generics";
            }
        }

        public override string ModelName
        {
            get
            {
                return "PharmaACE Forecast Tool.xlsb";
            }
        }

        public override string PageHeader
        {
            get
            {
                return "Generic Forecast Platform";
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
            set { }
            get
            {
                List<ForecastSection> sections = new List<ForecastSection>();

                sections.Add(
                    new ForecastSection
                    {
                        Name = "Historical Data",
                        HasAssumption = true,
                        Start = 12,
                        End = 88
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Projections",
                        HasAssumption = true,
                        Start = 89,
                        End = 110
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Penetration",
                        HasAssumption = true,
                        Start = 111,
                        End = 116
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Events",
                        HasAssumption = true,
                        Start = 117,
                        End = 145
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Conversion Parameters",
                        HasAssumption = true,
                        Start = 146,
                        End = 157
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Output",
                        HasAssumption = false,
                        Start = 158,
                        End = 167
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Pack Split",
                        HasAssumption = false,
                        Start = 168,
                        End = 169
                    }
                    );


                return sections;
            }
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
