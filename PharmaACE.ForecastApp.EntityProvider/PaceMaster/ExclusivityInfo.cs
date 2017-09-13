namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Patent.ExclusivityInfo")]
    public partial class ExclusivityInfo
    {
       

       // [Key]
        //[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        public int InlineTransactionId { get; set; }

        public int ExclusivityID { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Expiry { get; set; }

        public virtual InlineTransaction Transaction { get; set; }

        public virtual Exclusivity Exclusivity { get; set; }
    }
}
