using System;
using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ActharForecastEntity : ForecastEntity
    {
        public override string BackgroundImage
        {
            get
            {
                return "../Content/img/Patient Flow Models.jpg";
            }
        }

        public override bool DisplayInitialModel
        {
            get
            {
                return false;
            }
        }

        public override bool IsUtil
        {
            get
            {
                return false;
            }
        }

        public override string LogoImagePath
        {
            get
            {
                return "../../Content/img/forecast-icon-70.jpg";
            }
        }

        public override HeaderType MenuType
        {
            get
            {
                return HeaderType.Forecast;
            }
        }

        public override string ModelLocation
        {
            get
            {
                return "Acthar";
            }
        }

        public override string ModelName
        {
            get
            {
                return "Acthar_Model.xlsb";
            }
        }

        public override string PageHeader
        {
            get
            {
                return "BD&L Forecast Platform";
            }
        }

        public override List<ForecastSection> Sections
        {
            //get
            //{
            //    List<ForecastSection> sections = new List<ForecastSection>();
            //    return sections;
            //}
            set { }
            get
            {
                List<ForecastSection> sections = new List<ForecastSection>();

                sections.Add(
                    new ForecastSection
                    {
                        Name = "Received Referals",
                        HasAssumption = true,
                        Start = 12,
                        End = 88
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Closed Rate",
                        HasAssumption = false,
                        Start = 89,
                        End = 110
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Closed Referals",
                        HasAssumption = true,
                        Start = 111,
                        End = 116
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Shipped Rate",
                        HasAssumption = false,
                        Start = 117,
                        End = 145
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Paid Referals",
                        HasAssumption = true,
                        Start = 146,
                        End = 157
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Vials/Rx",
                        HasAssumption = false,
                        Start = 158,
                        End = 167
                    }
                    );
                sections.Add(
                    new ForecastSection
                    {
                        Name = "Vials",
                        HasAssumption = true,
                        Start = 168,
                        End = 169
                    }
                    );


                return sections;
            }
        }
    }
}
