using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.ViewModels.User {
    public class UserLightViewModel {
        public string Id { get; set; }
        public string UserName { get; set; }
        public string Email{ get; set; }

        public ServerFile Avatar { get; set; }

    }
}
