namespace PharmaACE.ForecastApp.Models
{
    public class ForecastParameter
    {
        public string Name { get; set; }
        public int? StartRow { get; set; }
        public int? StartColumn { get; set; }
        public ForecastParameterScope Scope { get; set; }
    }
}