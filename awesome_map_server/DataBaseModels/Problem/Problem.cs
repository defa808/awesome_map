using DataBaseModels.Models.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DataBaseModels.Models {
    public class Problem : Ticket {
        public Guid Id { get; set; }
        public string Title { get; set; }
        public Guid ProblemTypeId { get; set; }
        public virtual List<ProblemTypeProblem> ProblemTypes { get; set; }
        public string Description { get; set; }
        public string OwnerId { get; set; }
        public virtual ApplicationUser Owner { get; set; }
        public virtual List<ProblemUser> Subscribers { get; set; }
        public ProblemStatus Status { get; set; } = ProblemStatus.Open;
        public virtual List<ServerFile> Files { get; set; }
        public virtual List<Comment> Comments { get; set; }


        Problem() {
            ProblemTypes = new List<ProblemTypeProblem>();
            Subscribers = new List<ProblemUser>();
            Comments = new List<Comment>();
        }

    }
}
