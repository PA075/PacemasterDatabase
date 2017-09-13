using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    [Table("BDL.UserForecastSectionMapping")]
    public partial class BDLUserForecastSectionMapping
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        [Key]
        [Column(Order = 1)]
        public int UserForecastMappingID { get; set; }

        [StringLength(100)]
        public string SectionIdCombination { get; set; }

        public int UserId { get; set; }

        public virtual BDLUserForecastMapping UserForecastMapping { get; set; }
    }
}
