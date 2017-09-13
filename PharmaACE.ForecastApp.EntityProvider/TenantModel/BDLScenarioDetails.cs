namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.ScenarioDetails")]
    public partial class BDLScenarioDetails
    {
        public int ID { get; set; }

        public int ProjectVersionID { get; set; }

        public int ScenarioID { get; set; }

        public int ScenarioOrder { get; set; }

        public virtual BDLProjectVersion ProjectVersion { get; set; }

        public virtual BDLScenarioMaster ScenarioMaster { get; set; }
    }
}
