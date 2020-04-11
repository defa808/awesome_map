using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.Models {
    public class ProblemTypeProblem {
        public Guid ProblemId { get; set; }
        public Guid ProblemTypeId { get; set; }
        public virtual Problem Problem { get; set; }
        public virtual ProblemType ProblemType { get; set; }
    }
}
