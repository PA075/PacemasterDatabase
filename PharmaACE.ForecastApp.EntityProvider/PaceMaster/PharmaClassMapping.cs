namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Inline.PharmaClassMapping")]
    public partial class PharmaClassMapping
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int PharmaClassTransactionId { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int PharmaClassId { get; set; }

        public int? PharmaClass2Id { get; set; }

        public int? PharmaClass3Id { get; set; }

        public int? ImsClassId { get; set; }

        public virtual PharmaClassMaster PrimaryPharmaClass { get; set; }

        public virtual PharmaClassMaster SecondaryPharmaClass { get; set; }

        public virtual PharmaClassMaster TartiaryPharmaClass { get; set; }

        public virtual PharmaClassMaster IMSPharmaClass { get; set; }

        public virtual InlineTransaction InlineTransaction { get; set; }
    }
}
