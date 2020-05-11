using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DataBaseModels.Models {
    public class EventType {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public Guid? IconId { get; set; }
        public Icon Icon { get; set; }
        public virtual List<EventTypeEvent> EventTypeEvents { get; set; }

        public EventType() {
            EventTypeEvents = new List<EventTypeEvent>();
        }
    }
}
