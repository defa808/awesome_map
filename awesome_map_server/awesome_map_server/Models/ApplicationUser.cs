using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.Models {
    public class ApplicationUser : IdentityUser {
        [InverseProperty("Owner")]
        public virtual List<Problem> MyProblem { get; set; }
        public virtual List<ProblemUser> ObservedProblems { get; set; }

        public virtual List<Event> MyEvents { get; set; }
        [InverseProperty("UserRecipient")]
        public virtual List<Comment> Inbox { get; set; }
        [InverseProperty("UserSender")]
        public virtual List<Comment> Sent { get; set; }

        ApplicationUser() {
            ObservedProblems = new List<ProblemUser>();
        }
    }
}
