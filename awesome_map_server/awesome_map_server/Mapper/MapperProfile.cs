using AutoMapper;
using AutoMapper.Configuration;
using awesome_map_server.ViewModels;
using awesome_map_server.ViewModels.Comment;
using awesome_map_server.ViewModels.User;
using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.Mapper {
    public class MapperProfile : Profile {

        public MapperProfile() : base() {
            CreateMap<Problem, ProblemViewModel>();
            CreateMap<ProblemViewModel, Problem>();
            CreateMap<ProblemTypeViewModel, ProblemType>();
            CreateMap<ProblemType, ProblemTypeViewModel>();
            CreateMap<Event, EventViewModel>().ForMember(x => x.Duration, m => m.MapFrom(z => z.Duration.TotalMilliseconds * 1000));
            CreateMap<EventViewModel, Event>().ForMember(x => x.Duration, m => m.MapFrom(z => TimeSpan.FromMilliseconds(z.Duration) / 1000));
            CreateMap<EventTypeViewModel, EventType>();
            CreateMap<EventType, EventTypeViewModel>();
            CreateMap<Comment, CommentViewModel>();
            CreateMap<CommentViewModel, Comment>();
            CreateMap<UserLightViewModel, ApplicationUser>();
            CreateMap<ApplicationUser, UserLightViewModel>();
            CreateMap<ApplicationUser, UserFullViewModel>();
        }
    }
}
