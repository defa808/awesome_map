using AutoMapper;
using AutoMapper.Configuration;
using awesome_map_server.ViewModels;
using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.Mapper {
    public class MapperProfile:Profile {

        public MapperProfile() :base() {
            CreateMap<Problem, ProblemViewModel>();
            CreateMap<ProblemViewModel, Problem>();
            CreateMap<ProblemTypeViewModel, ProblemType>();
            CreateMap<ProblemType, ProblemTypeViewModel>();
        }
    }
}
