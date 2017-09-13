namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class DealDetail
    {
        //[Key]
        //[Column(Order = 0)]
        //[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        [Required]
        [StringLength(1000)]
        public string Name { get; set; }

        public int DealChampion { get; set; }

        public int Owner { get; set; }

        public int BDL_Lead { get; set; }

        public int StageID { get; set; }

        public int ActivityID { get; set; }

        public decimal Value { get; set; }

        public string Objective { get; set; }

        public int ObjectID { get; set; }

        public int Priority { get; set; }

        public int ProjectType { get; set; }
        public virtual ActivityMaster ActivityMaster { get; set; }

        public virtual ObjectMaster ObjectMaster { get; set; }

        public virtual StageMaster StageMaster { get; set; }

        public int Currency { get; set; }

        public DateTime CreatedDate { get; set; }

    }
}
