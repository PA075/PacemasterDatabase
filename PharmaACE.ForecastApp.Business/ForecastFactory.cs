using PharmaACE.ForecastApp.EntityProvider.TenantModel;
using PharmaACE.ForecastApp.Models;
using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Business
{
    public class ForecastFactory
    {
        public static ForecastManager CreateForecastManager(IUnitOfWork uow, int userId, UserRole userRole, ForecastModelType type, byte accessType)
        {
            ForecastManager forecastManager = default(ForecastManager);
            switch (type)
            {
                case ForecastModelType.Generic:
                    forecastManager = new GenericForecastManager(uow, userId, userRole, accessType);
                    break;
                case ForecastModelType.BDL:
                    forecastManager = new BDLForecastManager(uow, userId, userRole, accessType);
                    break;
                case ForecastModelType.Acthar:
                    forecastManager = new ActharForecastManager(uow, userId, userRole, accessType);
                    break;
                default:
                    break;
            }
            
            return forecastManager;
        }

        public static ForecastManager GetDefaultForecastManager(IUnitOfWork uow, int userId)
        {
            return new ForecastManager(uow, userId);
        }

        public static ForecastEntity CreateForecastEntity(ForecastModelType type)
        {
            ForecastEntity forecastEntity = default(ForecastEntity);
            switch (type)
            {
                case ForecastModelType.Generic:
                    forecastEntity = new GenericForecastEntity();
                    break;
                case ForecastModelType.BDL:
                    forecastEntity = new BDLForecastEntity();
                    break;
                case ForecastModelType.Acthar:
                    forecastEntity = new ActharForecastEntity();
                    break;
                case ForecastModelType.Epicyclopedia:
                    forecastEntity = new EpicyclopediaUtil();
                    break;
                case ForecastModelType.ShareBuilder:
                    forecastEntity = new ShareBuilderUtil();
                    break;
                case ForecastModelType.AnalogAnalysisEventImpact:
                    forecastEntity = new AnalogAnalysisEventImpactUtil();
                    break;
                case ForecastModelType.HistoricalTrendline:
                    forecastEntity = new HistoricalTrendlineUtil();
                    break;
                case ForecastModelType.WaterfallChart:
                    forecastEntity = new WaterfallChartUtil();
                    break;
                case ForecastModelType.SensitivityAndTornado:
                    forecastEntity = new SensitivityAndTornadoUtil();
                    break;
                default:
                    break;
            }

            forecastEntity.ForecastAuxiliary = new ForecastAuxiliary();
            return forecastEntity;
        }
        
        public static List<string> GetModelLocations()
        {
            List<string> modelLocations = new List<string>();
            modelLocations.Add(new GenericForecastEntity().ModelLocation);
            modelLocations.Add(new BDLForecastEntity().ModelLocation);
            modelLocations.Add(new ActharForecastEntity().ModelLocation);
            return modelLocations;
        }
    }
}
