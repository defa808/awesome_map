using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.Models {
    public class ForwardComments {
        public Guid ForwardCommentId { get; set; }
        public Guid BackwardCommentId { get; set; }
        public virtual Comment BackwardComment { get; set; }
        public virtual Comment ForwardComment { get; set; }

    }
}
