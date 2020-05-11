using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DataBaseModels.Models {
    public class ProblemType {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public Guid? IconId { get; set; }
        public Icon Icon { get; set; }

        ProblemType() {
            ProblemTypeProblem = new List<ProblemTypeProblem>();
        }

        public virtual List<ProblemTypeProblem> ProblemTypeProblem { get; set; }
    }
}
