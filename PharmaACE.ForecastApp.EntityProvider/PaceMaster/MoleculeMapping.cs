namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Inline.InlineMoleculeMapping")]
    public partial class InlineMoleculeMapping
    {
        [Key]
        public int Id { get; set; }

        public int MoleculeTransactionId { get; set; }

        public int MoleculeId { get; set; }

        public virtual MoleculeMaster MoleculeMaster { get; set; }

        public virtual InlineTransaction Transaction1 { get; set; }
    }
}
