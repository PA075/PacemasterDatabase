namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("UserAccessForecastPlatform")]
    public partial class UserAccessForecastPlatform
    {
        [Key]
        [Column(Order = 0)]
        public int ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int UserID { get; set; }

        
        [Column(Order = 2)]
        public bool GenericTool { get; set; }

        
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short AccessTypeGT { get; set; }

        
        [Column(Order = 4)]
        public bool BDLTool { get; set; }

        
        [Column(Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short AccessTypeBDL { get; set; }

        
        [Column(Order = 6)]
        public bool PatientFlow { get; set; }

        
        [Column(Order = 7)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short AccessTypePF { get; set; }

        
        [Column(Order = 8)]
        public byte AccessTypeGTforproject { get; set; }

        
        [Column(Order = 9)]
        public byte AccessTypeBDLforproject { get; set; }

       
        [Column(Order = 10)]
        public byte AccessTypePFforproject { get; set; }

        public virtual UserMaster UserMaster { get; set; }
    }
}
