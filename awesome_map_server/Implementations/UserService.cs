using Contracts;
using DataBaseModels.Models;
using DataBaseModels.User;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace Implementations {
    public class UserService : IUserService {
        // users hardcoded for simplicity, store in a db with hashed passwords in production applications
        private List<ApplicationUser> _users = new List<ApplicationUser>
        {
            new ApplicationUser { Id = "adminAdmin", Email = "admin@gmail.com", EmailConfirmed = true, UserName="admin@gmail.com", }
        };

        private readonly IConfiguration configuration;
        private readonly RoleManager<IdentityRole> roleManager;
        private readonly SignInManager<ApplicationUser> signInManager;

        public UserService(IConfiguration configuration,
            RoleManager<IdentityRole> roleManager,
            SignInManager<ApplicationUser> signInManager,
            UserManager<ApplicationUser> userManager) {
            this.configuration = configuration;
            this.roleManager = roleManager;
            this.signInManager = signInManager;
        }

        public async Task<string> Authenticate(string email, string password) {

            ApplicationUser user = await signInManager.UserManager.FindByEmailAsync(email);
            if (user == null)
                return null;
            SignInResult result = await signInManager.CheckPasswordSignInAsync(user, password, false);
            if (!result.Succeeded)
                return null;
            IList<string> roles = await signInManager.UserManager.GetRolesAsync(user);
            // authentication successful so generate jwt token
            return GenerateJWTToken(user, roles);
        }

        private string GenerateJWTToken(ApplicationUser user, IList<string> roles) {
            var tokenHandler = new JwtSecurityTokenHandler();
            string secret = this.configuration["JWTTokenSecret"];
            var key = Encoding.UTF8.GetBytes(secret);
            var tokenDescriptor = new SecurityTokenDescriptor {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                    new Claim(ClaimTypes.Name, user.UserName.ToString()),
                    new Claim(ClaimTypes.Email, user.Email.ToString()),
                    new Claim(ClaimTypes.Role, string.Join(',',roles)),
                }),
                Expires = DateTime.UtcNow.AddDays(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256) //SecurityAlgorithms.HmacSha512Signature
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        public IEnumerable<ApplicationUser> GetAll() {
            return _users;
        }

        public async Task<string> Register(string email, string password) {
            ApplicationUser user = await signInManager.UserManager.FindByEmailAsync(email);
            if (user != null)
                return null;
            user = new ApplicationUser() { Email = email, UserName = email.Split('@')[0] };
            IdentityResult result = await signInManager.UserManager.CreateAsync(user, password);
            if (!result.Succeeded)
                return null;
            result = await signInManager.UserManager.AddToRoleAsync(user, Enum.GetName(typeof(Role), Role.User));
            if (!result.Succeeded) {
                await signInManager.UserManager.DeleteAsync(user);
                return null;
            }
            IList<string> roles = await signInManager.UserManager.GetRolesAsync(user);
            // authentication successful so generate jwt token
            return GenerateJWTToken(user, roles);


        }

        public async Task<ApplicationUser> GetInfo(string userId) {
            ApplicationUser user = await signInManager.UserManager.FindByIdAsync(userId);
            return user;
        }

        public async Task<bool> LogOut() {
            try {
                await signInManager.SignOutAsync();
                return true;
            }catch(Exception e) {
                return false;
            }
        }
    }
}
