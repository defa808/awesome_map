using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace DataBaseModels.Models {
    public class Comment {
        public Guid Id { get; set; }
        [ForeignKey("Problem")]
        public Guid? ProblemId { get; set; }
        public virtual Problem Problem { get; set; }
        [ForeignKey("Event")]
        public Guid? EventId { get; set; }
        public virtual Event Event{ get; set; }
        public string Text { get; set; }
        [InverseProperty("ForwardComment")]
        public virtual List<ForwardComments> ForwardComments { get; set; }
        [InverseProperty("BackwardComment")]
        public virtual List<ForwardComments> BackwardComments { get; set; }
        public bool IsRead { get; set; }
        public bool IsEdited { get; set; }
        public DateTime TimeSend { get; set; }
        public string UserSenderId { get; set; }
        public string UserRecipientId { get; set; }
        public virtual ApplicationUser UserSender { get; set; }
        public virtual ApplicationUser UserRecipient { get; set; }

    }
}
