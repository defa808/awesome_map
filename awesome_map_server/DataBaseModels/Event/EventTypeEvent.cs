﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DataBaseModels.Models {
    public class EventTypeEvent {
        public Guid TypeId { get; set; }
        public Guid EventId { get; set; }
        public virtual Event Event { get; set; }
        public virtual EventType Type { get; set; }
    }
}
