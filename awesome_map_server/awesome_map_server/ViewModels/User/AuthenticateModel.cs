using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.ViewModels {
    public class AuthenticateModel {
        [Required]
        public string Email { get; set; }

        [Required]
        public string Password { get; set; }
    }
}
