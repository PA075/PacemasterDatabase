namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Generic.UserForecastMapping")]
    public partial class GenericUserForecastMapping
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        public int ShareWithID { get; set; }

        [Required]
        public string ProjectName { get; set; }

        [StringLength(1000)]
        public string Version { get; set; }

        public int Authorization { get; set; }

        public int ShareByID { get; set; }
                
        public string Description { get; set; }

        public DateTime CreationDate { get; set; }
    }
}
