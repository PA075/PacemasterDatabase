namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ForumAnswer")]
    public partial class ForumAnswer
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ForumAnswer()
        {
            ForumAttachment = new HashSet<ForumAttachment>();
        }

        public int Id { get; set; }

        public int? UserId { get; set; }

        public int QuestionId { get; set; }

        [Required]
        public string Answer { get; set; }

        public DateTime PostDate { get; set; }

        public DateTime? ModifyDate { get; set; }

        public virtual ForumQuestion ForumQuestion { get; set; }

        public virtual UserMaster UserMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ForumAttachment> ForumAttachment { get; set; }
    }
}
