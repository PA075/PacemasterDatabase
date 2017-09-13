namespace PharmaACE.ForecastApp.Models
{
    public class ForecastEvent
    {
        public string Name { get; set; }
        public bool? Status { get; set; }
        public ForecastEventImpactType ImpactType { get; set; }
        public decimal? UptakeCurve { get; set; }
        public decimal? StartShare { get; set; }
        public decimal? PeakShare { get; set; }
        public string LaunchDate { get; set; }
        public int? MonthsToPeak { get; set; }
        public int? Order { get; set; }
    }
}