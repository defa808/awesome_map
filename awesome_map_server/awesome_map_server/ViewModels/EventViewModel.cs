using DataBaseModels.Event;
using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.ViewModels {
    public class EventViewModel {
        public Guid Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string PlaceDescription { get; set; }
        public EventStatus Status { get; set; }
        public DateTime StartDate { get; set; }
        public long Duration { get; set; }
        public int? PeopleCount { get; set; }

        public string OwnerId { get; set; }
        public virtual ApplicationUser Owner { get; set; }

        public virtual List<EventType> EventTypes { get; set; }

        public virtual List<EventUser> Subscribers { get; set; }
        public int SubscribersCount { get; set; }
        public bool IsClosed { get; set; }
        public virtual List<Comment> Comments { get; set; }
        public virtual List<ServerFile> Files { get; set; }


        public EventViewModel() {
            EventTypes = new List<EventType>();
            Subscribers = new List<EventUser>();
            Comments = new List<Comment>();
            Files = new List<ServerFile>();
        }
    }
}
