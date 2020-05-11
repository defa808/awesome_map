using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DataBaseModels.Models {
    public class ServerFile {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public double Size { get; set; }
        public FileBody FileBody { get; set; }
        public Guid? ProblemId { get; set; }
        public Guid? EventId { get; set; }
    }
}
