using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.ViewModels {
    public class ProblemViewModel {
        public Guid Id { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string Title { get; set; }
        public virtual List<ProblemTypeViewModel> ProblemTypes { get; set; }
        public string Description { get; set; }
        public string OwnerId { get; set; }
        public virtual ApplicationUser Owner { get; set; }
        public virtual List<ProblemUser> Subscribers { get; set; }
        public ProblemStatus Status { get; set; } = ProblemStatus.Open;
        public virtual List<ServerFile> Files { get; set; }
        public virtual List<Comment> Comments { get; set; }

        ProblemViewModel() {
            ProblemTypes = new List<ProblemTypeViewModel>();
            Subscribers = new List<ProblemUser>();
            Comments = new List<Comment>();
        }
    }
}
