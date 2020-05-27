using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.ViewModels {
    public class EventTypeViewModel {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public Guid? IconId { get; set; }
        public Icon Icon { get; set; }
    }
}
