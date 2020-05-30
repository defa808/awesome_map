using AutoMapper;
using awesome_map_server.ViewModels;
using awesome_map_server.ViewModels.Comment;
using awesome_map_server.ViewModels.User;
using Contracts;
using DataBaseModels.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
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
        public async Task<IActionResult> Info() {
            string userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            ApplicationUser user = await _userService.GetInfo(userId);
            if (user == null)
                return BadRequest(new { message = "Register is failed. Please try it again later." });
            UserFullViewModel userViewModel = _mapper.Map<UserFullViewModel>(user);
            userViewModel.MyEventIds = user.MyEvents.Select(x => x.Id).ToList();
            userViewModel.MyProblemIds = user.MyProblems.Select(x => x.Id).ToList();
            userViewModel.ObservedProblemIds = user.ObservedProblems.Select(x => x.ProblemId).ToList();
            userViewModel.ObservedEventIds = user.ObservedEvents.Select(x => x.EventId).ToList();
            return Ok(userViewModel);
        }

        [Authorize]
        [HttpPost]
        public async Task<IActionResult> LogOut() {
            if (await _userService.LogOut())
                return Ok(true);
            else return Ok(false);

        }
    }
}
