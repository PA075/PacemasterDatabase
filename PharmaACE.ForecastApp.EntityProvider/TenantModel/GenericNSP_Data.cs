namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.NSP_Data")]
    public partial class GenericNSP_Data
    {
        [Key]
        [Column(Order = 0)]
        public int ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(1000)]
        public string Molecule { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(1000)]
        public string Salt { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(1000)]
        public string Manufacturer { get; set; }

        [Key]
        [Column(Order = 4)]
        [StringLength(1000)]
        public string Product { get; set; }

        [Key]
        [Column("Form/Strength", Order = 5)]
        [StringLength(1000)]
        public string Form_Strength { get; set; }

        [Key]
        [Column("NDC Code", Order = 6)]
        [StringLength(255)]
        public string NDC_Code { get; set; }

        [Key]
        [Column("Product Pack", Order = 7)]
        [StringLength(255)]
        public string Product_Pack { get; set; }

        [Key]
        [Column(Order = 8)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Year { get; set; }

        [Key]
        [Column(Order = 9)]
        [StringLength(255)]
        public string Quarter { get; set; }

        [Key]
        [Column(Order = 10)]
        [StringLength(255)]
        public string Month { get; set; }

        [Key]
        [Column(Order = 11)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Dollars { get; set; }

        [Key]
        [Column(Order = 12)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Units { get; set; }

        [Key]
        [Column("Ext Units", Order = 13)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Ext_Units { get; set; }

        [Key]
        [Column(Order = 14)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Eaches { get; set; }

        [Key]
        [Column(Order = 15)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProjectID { get; set; }

        [Key]
        [Column(Order = 16)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int VersionID { get; set; }
    }
}
