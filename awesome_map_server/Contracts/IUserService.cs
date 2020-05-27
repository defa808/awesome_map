using DataBaseModels.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace Contracts {
    public interface IUserService {
        Task<string> Authenticate(string email, string password);
        Task<string> Register(string email, string password);
        IEnumerable<ApplicationUser> GetAll();
        Task<ApplicationUser> GetInfo(string email);
    }

    
}
