using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.Models {
    public class EventType {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public virtual List<EventTypeEvent> EventTypeEvents { get; set; }

        public EventType() {
            EventTypeEvents = new List<EventTypeEvent>();
        }
    }
}
