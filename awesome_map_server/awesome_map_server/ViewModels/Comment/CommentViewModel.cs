using awesome_map_server.ViewModels.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.ViewModels.Comment {
    public class CommentViewModel {
        public Guid Id { get; set; }
        public Guid? ProblemId { get; set; }
        public Guid? EventId { get; set; }
        public string Text { get; set; }
        public DateTime TimeSend { get; set; }
        public UserViewModel UserSender { get; set; }
    }
}
