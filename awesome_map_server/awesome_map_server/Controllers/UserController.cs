using AutoMapper;
using awesome_map_server.ViewModels;
using awesome_map_server.ViewModels.User;
using Contracts;
using DataBaseModels.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.Controllers {
    [Authorize]
    [ApiController]
    [Route("api/[controller]/[action]")]

    public class UsersController : ControllerBase {
        private IUserService _userService;
        private IMapper _mapper;

        public UsersController(IUserService userService, IMapper mapper) {
            _userService = userService;
            _mapper = mapper;
        }

        [AllowAnonymous]
        [HttpPost]
        public async Task<IActionResult> Login([FromBody]AuthenticateModel model) {
            string token = await _userService.Authenticate(model.Email, model.Password);

            if (token == null)
                return BadRequest(new { message = "Email or password is incorrect" });

            return Ok(token);
        }

        [AllowAnonymous]
        [HttpPost]
        public async Task<IActionResult> Register([FromBody]AuthenticateModel model) {
            string token = await _userService.Register(model.Email, model.Password);

            if (token == null)
                return BadRequest(new { message = "Register is failed. Please try it again later." });

            return Ok(token);
        }


        [Authorize]
        [HttpPost]
        public async Task<IActionResult> Info([FromBody]AuthenticateModel model) {
            ApplicationUser user = await _userService.GetInfo(model.Email);
            if (user == null)
                return BadRequest(new { message = "Register is failed. Please try it again later." });
            UserViewModel userViewModel = _mapper.Map<UserViewModel>(user);
            return Ok(userViewModel);
        }
    }
}
