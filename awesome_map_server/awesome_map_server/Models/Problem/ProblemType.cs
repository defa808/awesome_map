using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.Models {
    public class ProblemType {
        public Guid Id { get; set; }
        public string Name { get; set; }

        ProblemType() {
            ProblemTypes = new List<ProblemTypeProblem>();
        }

        public virtual List<ProblemTypeProblem> ProblemTypes { get; set; }
    }
}
