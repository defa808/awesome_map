using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace DataBaseModels.Models {
    public class ApplicationUser : IdentityUser {
        [InverseProperty("Owner")]
        public virtual List<Problem> MyProblems { get; set; }
        public virtual List<ProblemUser> ObservedProblems { get; set; }

        public virtual List<Event> MyEvents { get; set; }
        public virtual List<EventUser> ObservedEvents { get; set; }

        [InverseProperty("UserRecipient")]
        public virtual List<Comment> Inbox { get; set; }
        [InverseProperty("UserSender")]
        public virtual List<Comment> Sent { get; set; }
        public Guid? AvatarId { get; set; }
        public ServerFile Avatar { get; set; }

        public ApplicationUser() {
            ObservedProblems = new List<ProblemUser>();
            MyProblems = new List<Problem>();
            MyEvents = new List<Event>();
            Inbox = new List<Comment>();
            Sent = new List<Comment>();
        }
    }
}
