namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BDL.ProjectVersion")]
    public partial class BDLProjectVersion
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public BDLProjectVersion()
        {
            EPI_Data = new HashSet<BDLEPI_Data>();
            ParameterSelectionType = new HashSet<BDLParameterSelectionType>();
            ProjectVersionProduct = new HashSet<BDLProjectVersionProduct>();
            ScenarioDetails = new HashSet<BDLScenarioDetails>();
            SegmentDetailsData = new HashSet<BDLSegmentDetailsData>();
            SegmentVersion = new HashSet<BDLSegmentVersion>();
        }

        public int Id { get; set; }

        public int ProjectId { get; set; }

        public int ProjectDetailsId { get; set; }

        [Required]
        [StringLength(255)]
        public string VersionLabel { get; set; }

        public virtual BDLProjectDetails ProjectDetails { get; set; }

        public virtual BDLProjectMaster ProjectMaster { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BDLProjectVersionProduct> ProjectVersionProduct { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BDLEPI_Data> EPI_Data { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BDLParameterSelectionType> ParameterSelectionType { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BDLScenarioDetails> ScenarioDetails { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BDLSegmentDetailsData> SegmentDetailsData { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BDLSegmentVersion> SegmentVersion { get; set; }
    }
}
