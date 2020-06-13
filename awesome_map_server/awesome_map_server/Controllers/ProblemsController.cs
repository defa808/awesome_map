using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using AutoMapper;
using awesome_map_server.ViewModels;
using awesome_map_server.ViewModels.Comment;
using Contracts;
using DataBaseContext;
using DataBaseModels.Models;
using IdentityServer4.Extensions;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace awesome_map_server.Controllers {

    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class ProblemsController : ControllerBase {
        private IMapper _mapper;
        private IProblemService _problemService;
        private ICommentService _commentService;
        public ProblemsController(IMapper autoMapper, IProblemService problemService, ICommentService commentService) {
            _mapper = autoMapper;
            _problemService = problemService;
            _commentService = commentService;
        }

        // GET: api/Problems
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProblemViewModel>>> GetProblems() {
            List<Problem> problems = await _problemService.GetProblems();
            List<ProblemViewModel> problemsViewModel = new List<ProblemViewModel>();
            foreach (var item in problems) {
                ProblemViewModel viewModel = _mapper.Map<ProblemViewModel>(item);
                viewModel.ProblemTypes = _mapper.ProjectTo<ProblemTypeViewModel>(item.ProblemTypeProblems.Select(x => x.ProblemType).AsQueryable()).ToList();
                viewModel.SubscribersCount = item.Subscribers.Count;
                viewModel.CommentsLength = item.Comments.Count;
                problemsViewModel.Add(viewModel);
            }
            return problemsViewModel;
        }

        // GET: api/Problems/5
        [HttpGet("{id}")]
        [Authorize(Roles = "Administrator")]
        public ActionResult<ProblemViewModel> GetProblem(Guid id) {
            Problem problem = _problemService.GetProblem(id);

            if (problem == null) {
                return NotFound();
            }

            return _mapper.Map<ProblemViewModel>(problem);
        }

        // PUT: api/Problems/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProblem(Guid id, [FromBody] ProblemViewModel problem) {
            if (id != problem.Id) {
                return BadRequest();
            }
            try {
                Problem newProblem = _mapper.Map<Problem>(problem);
                foreach (var item in problem.ProblemTypes)
                    newProblem.ProblemTypeProblems.Add(new ProblemTypeProblem() { Problem = newProblem, ProblemTypeId = item.Id });
                await _problemService.Change(newProblem);
                newProblem = _problemService.GetProblem(newProblem.Id);
                ProblemViewModel loadedProblem = _mapper.Map<ProblemViewModel>(newProblem);
                loadedProblem.ProblemTypes = problem.ProblemTypes;
                loadedProblem.SubscribersCount = newProblem.Subscribers.Count;
                return CreatedAtAction("GetProblem", new { id = newProblem.Id }, loadedProblem);
            } catch (DbUpdateConcurrencyException) {
                if (!_problemService.Exist(id)) {
                    return NotFound();
                } else {
                    throw;
                }
            }
        }

        [HttpPut("{id}/{status}")]
        public async Task<IActionResult> UpdateStatus(Guid id, int status, [FromBody] string comment = null) {
            try {
                if (_problemService.UpdateStatus(id, status)) {
                    if (comment != null && comment.Length > 0) {
                        Comment newComment = await _commentService.Save(new Comment() {
                            ProblemId = id,
                            TimeSend = DateTime.Now,
                            UserSenderId = User.FindFirstValue(ClaimTypes.NameIdentifier),
                            Text = comment
                        });
                        CommentViewModel viewModel = _mapper.Map<CommentViewModel>(newComment);
                        return Ok(viewModel);
                    }
                    return Ok(true);
                }
            } catch (DbUpdateConcurrencyException) {
                if (!_problemService.Exist(id)) {
                    return NotFound();
                } else {
                    throw;
                }
            }
            return Ok(false);
        }

        // POST: api/Problems
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<ProblemViewModel>> PostProblem(ProblemViewModel problem) {
            string userId = User.FindFirstValue(ClaimTypes.NameIdentifier);

            Problem newProblem = _mapper.Map<Problem>(problem);
            foreach (var item in problem.ProblemTypes)
                newProblem.ProblemTypeProblems.Add(new ProblemTypeProblem() { Problem = newProblem, ProblemTypeId = item.Id });
            newProblem.OwnerId = userId;
            await _problemService.Save(newProblem);
            _problemService.Subscribe(newProblem, userId);

            ProblemViewModel loadedProblem = _mapper.Map<ProblemViewModel>(newProblem);
            loadedProblem.ProblemTypes = problem.ProblemTypes;
            loadedProblem.SubscribersCount = newProblem.Subscribers.Count;
            return CreatedAtAction("GetProblem", new { id = newProblem.Id }, loadedProblem);
        }

        // DELETE: api/Problems/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Problem>> DeleteProblem(Guid id) {
            var problem = _problemService.GetProblem(id);
            if (problem == null) {
                return NotFound();
            }
            _problemService.Delete(problem);
            return problem;
        }

        [HttpPost("Subscribe")]
        public async Task<IActionResult> Subscribe([FromBody] Guid problemId) {
            string userId = User.FindFirstValue(ClaimTypes.NameIdentifier);

            Problem problem = _problemService.GetProblem(problemId);
            if (problem == null)
                return NotFound();
            try {
                _problemService.Subscribe(problem, userId);

            } catch (Exception e) {
                return BadRequest();
            }
            return Ok(true);
        }

        [HttpPost("Unsubscribe")]
        public async Task<IActionResult> Unsubscribe([FromBody] Guid problemId) {
            string userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!_problemService.Exist(problemId))
                return NotFound();
            try {
                if (await _problemService.Unsubscribe(problemId, userId))
                    return Ok(true);
                else
                    return BadRequest();
            } catch (Exception e) {
                return BadRequest();
            }

        }
    }
}
