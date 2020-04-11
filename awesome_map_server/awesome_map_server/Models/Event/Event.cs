using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.Models{
    public class Event {
        public Guid Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public double X { get; set; }
        public double Y { get; set; }
        public string PlaceDescription { get; set; }
        public DateTime StartDate { get; set; }
        public TimeSpan Duration { get; set; }
        public DateTime EndDate { get { return StartDate + Duration; } }
        public int? PeopleCount { get; set; }

        public string OwnerId { get; set; }
        public virtual ApplicationUser Owner { get; set; }

        public virtual List<EventTypeEvent> EventTypeEvents { get; set; }

        public virtual List<EventUser> Subscribers { get; set; }
        public bool IsClosed { get; set; }
        public virtual List<Comment> Comments { get; set; }
        public virtual List<ServerFile> Files { get; set; }


        public Event() {
            EventTypeEvents = new List<EventTypeEvent>();
            Subscribers = new List<EventUser>();
            Comments = new List<Comment>();
            Files = new List<ServerFile>();
        }
    }
}
