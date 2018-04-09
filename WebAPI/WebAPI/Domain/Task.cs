namespace WebAPI.Domain
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Task
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int TaskId { get; set; }

        [Required]
        [StringLength(50)]
        public string TaskName { get; set; }

        [StringLength(250)]
        public string TaskDescription { get; set; }

        public bool? TaskIsCompleted { get; set; }

        public bool? TaskIsDiscarded { get; set; }

        public DateTime? CreatedDate { get; set; }

        public DateTime? CompletedDate { get; set; }

        public int UserId { get; set; }

        public virtual User User { get; set; }
    }
}
