namespace PharmaACE.ForecastApp.Models
{
    public enum UserRole
    {
        Normal = 1,
        Admin,
        SuperAdmin
    }
    public enum ProjectType
    {
        Hospital=1,
        ARD=2
    }
    public enum Activity
    {
        CreateProject,
        CreateFolder,
        UploadFile,
        DownoadFile,
        RenameFile,
        RenameFolder,
        Rename,
        ModifyProject,
        changePermision,
        Share,
        delete
    }
    public enum ModuleMetadata
    {
        Forecast = 1,
        KM = 2,
        Reporting = 3,
        Community = 4,
        CI = 5
    }
    public enum ShareType
    {
        Forecast = 1,
        UserWorkSpace = 2
    }
    public enum ForecastModelType
    {
        Generic,
        BDL,        
        Acthar,
        Epicyclopedia = 10,
        ShareBuilder = 11,
        AnalogAnalysisEventImpact = 12,
        HistoricalTrendline = 13,
        WaterfallChart = 17,
        SensitivityAndTornado = 18
    }

    public enum StorageContext
    {
        Indication,
        Forum,
        report,
        WorkSpace,
        Forecast
    }

    public enum StorageType
    {
        Azure,
        SqlFileTable,
        OnPremises
        
    }


    public enum HeaderType
    {
        ForecastIndex,
        Forecast,
        Forecaster,
        ForecastNoMenu,
        KM,
        BI,
        Utilities,
        CustomFeed,
        CommunityPractice,
        UserWorkSpace,
        HelpDesk
    }

    public enum ForecastPeriod
    {
        Weekly,
        Monthly,
        Yearly,
        Quarterly
    }

    public enum ForecastCategory
    {
        BDL,
        Internal
    }

    public enum ForecastDataType
    {
        Units,
        TRx
    }

    public enum ProductType
    {
        Inline,
        Pipeline
    }

    public enum ProductBrand
    {
        NonBrand,
        Brand
    }

    public enum ForecastTrendingType
    {
        None,
        Linear,
        Logarithmic,
        Inverse,
        Power,
        Exponential,
        S_Shape
    }

    public enum ForecastProjectionType
    {
        Market,
        Competitor
    }

    public enum ForecastEventStatus
    {
        Off,
        On
    }

    public enum PenetrationType
    {
        Calculated = 1,
        Manual
    }

    public enum ForecastEventImpactType
    {
        None,
        Negative,
        Positive
    }

    public enum ForecastParameterScope
    {
        None,
        Forecast,
        Trend,
        Price
    }

    public enum ReportModelType
    {
        Generic,
        BDL,
        Acthar
    }

    public enum AuthenticationLevel
    {
        Create = 1,
        Edit,
        Read
    }

    public enum LoginStatus
    {
        Fail,
        Success,
        UserNotFound,
        PasswordNotMatched,
        SubscriptionExpired,
        Inactive
    }


    public enum DrugSearchContext
    {
        ByProductName = 1,
        ByMoleculeName,
        ByPharmaClass,
        ByIndication,
        ByManufacturer,
        ByCategory
    }

    public enum DiseaseAreaSearchContext
    {
        ByDisease = 1,
        ByIndication
    }

    public enum SearchCondition
    {
        Contains = 1,
        StartsWith,
        EndsWith,
        Exact
    }

    public enum DrugSearchModule
    {
        Both,
        Inline,
        Pipeline
    }

    public enum ShareCalculationType
    {
        OutputShares,
        FairShare,
        PeakShareWithSourceOfBusiness,
        SequentialShares,
        ShareTheft
    }

    public enum ForecastPermission
    {
        Author=1,
        Full =2,
        Edit=3,
        ReadOnly=4
    }


    //Added By Shubhada on 17-02-2017
    public enum ObjectPermission
    {
        //FullControl = 1,
        //Modify = 2,
        //ReadExecute = 3,
        //Read = 4,
        //Write = 5
        //Changed
        FullControl = 1,//delete,Rename,
        //Creator = 2,//delete on self folder level , Rename
        //Write = 3,//DownloadFile,Rename File
        //Read = 4,
       // Share = 5,
        //Download = 6,
        //Open = 7,
        //View = 8,
        Moderator=2,
       // Limited =2,
        NoAccess = 9   ,
        ContetFileShare=10     
    }
    public enum ObjectFilePermission
    {
        // FullControl = 1,
        // Limited = 2,

        Share = 5,
        Download = 6,
        Open = 7,
        View = 8,
        NoAccess = 9
    }
    public enum ObjectFolderPermission
    {
        FullControl = 1,
      //  Limited=2,
        Moderator=2,
        //Creator = 2,
        //Write = 3,
        //Read = 4,
        NoAccess = 9,
        ContetFileShare=10
    }

    public enum ObjectType
    {
        RootFolder = 0,
        SubFolder = 1,
        File = 2
    }
    public enum ProjectPriority
    {
        High=1,
        Medium=2,
        Low=3,
        NoPriority=4
    }

    public enum CurrencyType
    {
        Dollar = 1,
        Pound = 2,
        Euro = 3
        //Rupee = 4
    }

    public enum Extension
    {
        TXT,
        DOC,
        DOCX,
        XLS,
        XLSX,
        XLSM,
        XLSB,
        PPTX,
        PPT,
        PDF,                   
        JPG,
        PNG,
        BMP,
        TIF,
        XML,
        JPEG,
        GIF,
        XLR,
       DIF,
       XLA,
        XLAM,
      XLTX,
      XLTM,
      DOCM,
      DOTX,
      DOTM,
      ODT,
      XPS,     
       DOT,
     RTF,
     PPTM,
     POTX,
     POTM,
     POT,
     PPSX,
     PPSM,
     ODP,
     DOCB,
     XLT,
     XLM,
     PPS,
     ZIP,
     ZIPX,
     RAR,
     REV,
     R00,
     R01

    }
    public enum ExtensionType
    {

        Word,
        Excel,
        PDF,
        Image,
        PowerPoint,
        ZIP
        
    }
    
    public enum ParsersTypes
    {
        PDFType,
        XMLType,
        TextType

    }
}