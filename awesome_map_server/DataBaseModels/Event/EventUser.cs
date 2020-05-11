using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DataBaseModels.Models {
    public class EventUser {
        public Guid EventId { get; set; }
        public string UserId { get; set; }
        public virtual Event Event { get; set; }
        public virtual ApplicationUser User { get; set; }
    }
}
