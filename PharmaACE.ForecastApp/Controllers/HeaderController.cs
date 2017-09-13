using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace PharmaKMWebApp.Controllers
{
    public class HeaderController : Controller
    {
        public ActionResult RenderHeader(HeaderType headerType)
        {
            TopHeader header = new TopHeader();
            switch (headerType)
            {
                case HeaderType.ForecastIndex:
                    header.LogoImagePath = "../../Content/img/Forecast_new.png";
                    header.PageHeader = "Forecast Platform";
                    header.LogoImageHref = Url.Action("Index", "Forecast");
                    header.PopalertDisplay = true;
                    break;
                case HeaderType.Forecast:
                    header.LogoImagePath = "../../Content/img/Forecast_new.png";
                    header.PageHeader = "Forecast Platform";
                    header.LogoImageHref = Url.Action("Index", "Forecast");
                    header.PageMenu = "ForecastMenu";
                    header.PopalertDisplay = true;
                    break;
                case HeaderType.Forecaster:
                    header.LogoImagePath = "../../Content/img/Forecast_new.png";
                    header.PageHeader = "Forecast Platform";
                    header.LogoImageHref = Url.Action("Index", "Forecast");
                    header.PageMenu = "ForecasterMenu";
                    header.PopalertDisplay = true;
                    break;

                case HeaderType.ForecastNoMenu:
                    header.LogoImagePath = "../../Content/img/Forecast_new.png";
                    header.PageHeader = "Forecast Platform";
                    header.LogoImageHref = Url.Action("Index", "Forecast");
                    header.PopalertDisplay = true;
                    break;
                case HeaderType.KM:
                    header.LogoImagePath = "../../Content/img/KM.PNG";
                    header.PageHeader = "Knowledge Base";
                    header.LogoImageHref = Url.Action("Index", "KM");
                    header.PageMenu = "KMHeaderMenu";
                    header.PopalertDisplay = true;
                    header.BreadcrumbDisplay = true;
                    break;
                case HeaderType.BI:
                    header.LogoImagePath = "../../Content/img/BI.PNG";
                    header.PageHeader = "Business Intelligence";
                    header.LogoImageHref = Url.Action("Index", "Reporting");
                    header.PopalertDisplay = true;
                    break;
                case HeaderType.Utilities:
                    header.LogoImagePath = "../../Content/img/Utilities.png";
                    header.PageHeader = "Forecast Utilities";
                    header.LogoImageHref = Url.Action("Utilities", "Forecast");
                    header.PopalertDisplay = false;
                    break;
                case HeaderType.CustomFeed:
                    header.LogoImagePath = "../../Content/img/Custom-Feed.png";
                    header.PageHeader = "Market Monitor";
                    header.LogoImageHref = Url.Action("Index", "LiveFeed");
                    header.PageMenu = "CFHeaderMenu";
                    header.PopalertDisplay = true;
                    break;
                case HeaderType.CommunityPractice:
                    header.LogoImagePath = "../../Content/img/CoP.PNG";
                    header.PageHeader = "Community of Practice";
                    header.LogoImageHref = Url.Action("Index", "CommunityPractice");
                    header.PopalertDisplay = true;
                    break;
                case HeaderType.HelpDesk:
                    header.LogoImagePath = "../../Content/img/Help.png";
                    header.PageHeader = "HelpDesk";
                    header.LogoImageHref = Url.Action("HelpDesk", "Home");
                    header.PopalertDisplay = true;
                    break;

                     case HeaderType.UserWorkSpace:
                    header.LogoImagePath = "../../Content/img/User-Workspace.png";
                    header.PageHeader = "User WorkSpace";
                    header.LogoImageHref = Url.Action("Index", "UserWorkSpace");
                  //  header.PageMenu = "CFHeaderMenu";
                    header.PopalertDisplay = true;
                    break;
            }
            return View(header);
        }
    }
}
