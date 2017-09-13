namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Disease.MoleculeRegimenMapping")]
    public partial class MoleculeRegimenMapping
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int TreatmentRegimenDetailId { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int MoleculeId { get; set; }

        public virtual MoleculeMaster MoleculeMaster { get; set; }

        public virtual TreatmentRegimenDetail TreatmentRegimenDetail { get; set; }

    }
}
