using System;

namespace DataBaseModels.Models {
    public class ProblemUser {
        public Guid ProblemId { get; set; }
        public string  UserId { get; set; }
        public virtual Problem Problem { get; set; }
        public virtual ApplicationUser User { get; set; }
    }
}