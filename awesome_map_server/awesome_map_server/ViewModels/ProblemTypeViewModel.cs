using DataBaseModels.Models;
using System;

namespace awesome_map_server.ViewModels {
    public class ProblemTypeViewModel {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public Guid? IconId { get; set; }
        public Icon Icon { get; set; }
    }
}