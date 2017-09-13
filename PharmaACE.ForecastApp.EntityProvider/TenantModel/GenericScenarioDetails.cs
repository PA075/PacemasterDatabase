namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.ScenarioDetails")]
    public partial class GenericScenarioDetails
    {
        public int ID { get; set; }

        public int ProjectVersionID { get; set; }

        public int ScenarioID { get; set; }

        public int ScenarioOrder { get; set; }

        public virtual GenericProjectVersion ProjectVersion { get; set; }

        public virtual GenericScenarioMaster ScenarioMaster { get; set; }
    }
}
