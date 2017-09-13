namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ForumAttachment")]
    public partial class ForumAttachment
    {
        public int Id { get; set; }

        [Required]
        [StringLength(1000)]
        public string AttachmentPath { get; set; }

        [Required]
        [StringLength(2000)]
        public string Name { get; set; }

        public int QuestionId { get; set; }

        public int? AnswerId { get; set; }

        public virtual ForumAnswer ForumAnswer { get; set; }

        public virtual ForumQuestion ForumQuestion { get; set; }
    }
}
