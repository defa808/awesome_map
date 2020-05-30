using awesome_map_server.ViewModels.Comment;
using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.ViewModels.User {
    public class UserFullViewModel {
        public string Id { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }

        public ServerFile Avatar { get; set; }
        public  List<Guid> MyProblemIds { get; set; }
        public  List<Guid> MyEventIds { get; set; }
        public  List<CommentViewModel> Inbox { get; set; }
        public  List<Guid> ObservedProblemIds { get; set; }
        public  List<Guid> ObservedEventIds { get; set; }
    }
}
