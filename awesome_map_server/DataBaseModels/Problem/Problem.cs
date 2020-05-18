using DataBaseModels.Models.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DataBaseModels.Models {
    public class Problem : Ticket {
        public Guid Id { get; set; }
        public string Title { get; set; }
        public virtual List<ProblemTypeProblem> ProblemTypeProblems { get; set; }
        public string Description { get; set; }
        public string OwnerId { get; set; }
        public virtual ApplicationUser Owner { get; set; }
        public virtual List<ProblemUser> Subscribers { get; set; }
        public ProblemStatus Status { get; set; } = ProblemStatus.Open;
        public virtual List<ServerFile> Files { get; set; }
        public virtual List<Comment> Comments { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime? UpdateDate { get; set; }


        Problem() {
            ProblemTypeProblems = new List<ProblemTypeProblem>();
            Subscribers = new List<ProblemUser>();
            Comments = new List<Comment>();
        }

    }
}
