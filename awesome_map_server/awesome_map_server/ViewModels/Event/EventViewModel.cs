using awesome_map_server.ViewModels.Comment;
using awesome_map_server.ViewModels.User;
using DataBaseModels.Event;
using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.ViewModels {
    public class EventViewModel {
        public Guid Id { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string PlaceDescription { get; set; }
        public EventStatus Status { get; set; }
        public DateTime StartDate { get; set; }
        public double Duration { get; set; }
        public int? PeopleCount { get; set; }

        public string OwnerId { get; set; }
        public virtual UserFullViewModel Owner { get; set; }

        public virtual List<EventTypeViewModel> EventTypes { get; set; }

        public int SubscribersCount { get; set; }
        public bool IsClosed { get; set; }
        public virtual List<CommentViewModel> Comments { get; set; }
        public virtual List<ServerFile> Files { get; set; }


        public EventViewModel() {
            EventTypes = new List<EventTypeViewModel>();
            Comments = new List<CommentViewModel>();
            Files = new List<ServerFile>();
        }
    }
}
