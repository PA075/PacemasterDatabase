namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Inline.ExclusivityTransaction")]
    public partial class ExclusivityTransaction
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }

        public int? ProductCodeId { get; set; }

        public int? PatentCodeId { get; set; }

        public int? ExclusivityCodeId { get; set; }

        [StringLength(100)]
        public string PatentNo { get; set; }

        [Column(TypeName = "date")]
        public DateTime? PatentExpireDate { get; set; }

        [Column(TypeName = "date")]
        public DateTime? ExclusivityDate { get; set; }

        public virtual PatentCodeMaster PatentCodeMaster { get; set; }

        public virtual ProductCodeMaster ProductCodeMaster { get; set; }

        public virtual ExclusivityCodeMaster ExclusivityCodeMaster { get; set; }
    }
}
