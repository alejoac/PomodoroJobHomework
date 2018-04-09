using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models
{
    public class TaskModel
    {
        public string TaskDescription { get; set; }
        public string TaskName { get; set; }

        public bool? TaskIsCompleted { get; set; }

        public bool? TaskIsDiscarded { get; set; }

        public DateTime? CreatedDate { get; set; }

        public DateTime? CompletedDate { get; set; }

        public int UserId { get; set; }

        //public virtual UserModels User { get; set; }

    }
}