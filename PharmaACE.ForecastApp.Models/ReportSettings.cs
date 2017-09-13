using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class ReportSettings
    {
        public List<string> Projects { get; set; }
        public List<string> Versions { get; set; }
        public List<string> Products { get; set; }
        public List<string> SKUs { get; set; }
        public List<string> Scenarios { get; set; }
        public List<string> Parameters { get; set; }
        public int Frequency { get; set; }
        public int ChartType { get; set; }
        public int ValueType { get; set; }
        public int ShowTableData { get; set; }
    }

    public class DistinctReportSettings
    {
        public ReportModelType ReportType { get; set; }
        public List<string> Axes { get; set; }
        public List<string> Parameters { get; set; }
        public List<string> Countrys { get; set; }
        public int Frequency { get; set; }
        public int ChartType { get; set; }
        public int NumberFormat { get; set; }
        public int DecimalPrecision { get; set; }
        public int CurrencySymbol { get; set; }
        public int TableData { get; set; }
        public string MinStartDate { get; set; }
        public string MaxEndDate { get; set; }

        //Formatting
        public string ColorTheme { get; set; }
        public int AxisFontSize { get; set; }
        public string AxisFontColor { get; set; }
        public string ChartBgColor { get; set; }
        public string ChartBorderColor { get; set; }
        public int ChartBorderWidth { get; set; }
        //public int ChartBorderLineStyle { get; set; }
        public int TitleFontSize { get; set; }
        public int TitleColor { get; set; }
        public int Shadow { get; set; }
        public int ShowLegend { get; set; }
        public int VersionFlag { get; set; }
        public int ConsolidatorFlag { get; set; }
        public int HistoricalData { get; set; }
    }

    public class SaveReportSettings
    {
        public string DashboardName { get; set; }
        public string ReportName { get; set; }
        public int ReportId { get; set; }
        public DistinctReportSettings ReportSettings { get; set; }
        public bool overWrite { get; set; }
        public ReportModelType Type { get; set; }
       
    }

    public class ExportReportSettings
    {
        public string ReportName { get; set; }
        public int Format { get; set; }
        public DistinctReportSettings ReportSettings { get; set; }
    }

    public class ReportSettingSKU
    {
        public string SKUName { get; set; }
    }

    public class ReportSettingProduct
    {
        public string ProductName { get; set; }
        List<ReportSettingSKU> SkuList = new List<ReportSettingSKU>();
    }

    public class ReportSettingVersion
    {
        public string VersionName { get; set; }
        public string Scenario { get; set; }
        List<ReportSettingProduct> ProductList = new List<ReportSettingProduct>();
    }

    public class ReportSettingForecast
    {
        public string ProjectName { get; set; }
        List<ReportSettingVersion> VersionList = new List<ReportSettingVersion>();
        List<string> Parameter = new List<string>();
    }

    public class ReportingProject
    {
        public int ID { get; set; }
        public string Name { get; set; }
    }

    public class ReportingProjectVersion
    {
        public int ProjectID { get; set; }
        public int VersionID { get; set; }
        public string Label { get; set; }
    }

    public class ReportingProduct
    {
        public int ProjectVersionID { get; set; }
        public int ProjectVersionProductID { get; set; }
        public string Name { get; set; }
    }

    public class ReportForecast
    {
        public string Name { get; set; }
        public List<ReportForecastVersion> Versions { get; set; }
    }

    public class ReportForecasts
    {
        public List<ReportForecast> Forecasts { get; set; }
        public string MinStartDate { get; set; }
        public string MaxEndDate { get; set; }
    }

    public class ReportingModel
    {
        public ReportingModel()
        {
            parameterList = new List<string>();
            countrys = new List<string>();
        }
        public ReportModelType ReportType { get; set; }
        public List<string> parameterList { get; set; }
        public List<string> countrys { get; set; }
        public ReportForecasts reportAxes { get; set; }
        public List<SaveReportSettings> reportList { get; set; }
        public List<Dashboard> dashboardList { get; set; }
        public string Url { get; set; }
    }

    public class Dashboard
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class QlikConfig
    {
        public string Url { get; set; }
    }

}
