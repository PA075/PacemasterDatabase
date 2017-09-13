using System.Collections.Generic;

namespace PharmaACE.ForecastApp.Models
{
    public class ForecastFactory
    {
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

        public static ForecastEntity CreateForecasterEntity(ForecastModelType type)
        {
            ForecastEntity forecastEntity = default(ForecastEntity);
            switch (type)
            {
                case ForecastModelType.Generic:
                    forecastEntity = new GenericForecastEntityForForecaster();  
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
