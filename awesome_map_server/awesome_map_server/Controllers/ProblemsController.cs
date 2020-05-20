using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using awesome_map_server.ViewModels;
using DataBaseContext;
using DataBaseModels.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace awesome_map_server.Controllers {

    [Route("api/[controller]")]
    [ApiController]
    public class ProblemsController : ControllerBase {
        private readonly ApplicationDbContext _context;
        private IMapper _mapper;
        public ProblemsController(ApplicationDbContext context, IMapper autoMapper) {
            _context = context;
            _mapper = autoMapper;
        }

        // GET: api/Problems
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProblemViewModel>>> GetProblems() {
            List<Problem> problems = await _context.Problems
                .Include(x=> x.Files)
                .Include(x=> x.ProblemTypeProblems).ThenInclude(x=> x.ProblemType)
                .ThenInclude(x=> x.Icon)
                .ToListAsync();
            List<ProblemViewModel> problemsViewModel = new List<ProblemViewModel>();
            foreach (var item in problems) {
                ProblemViewModel viewModel = _mapper.Map<ProblemViewModel>(item);
                viewModel.ProblemTypes = _mapper.ProjectTo<ProblemTypeViewModel>(item.ProblemTypeProblems.Select(x => x.ProblemType).AsQueryable()).ToList();
                viewModel.SubscribersCount = item.Subscribers.Count;
                problemsViewModel.Add(viewModel);
            }
            return problemsViewModel;
        }

        // GET: api/Problems/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ProblemViewModel>> GetProblem(Guid id) {
            var problem = await _context.Problems.FindAsync(id);

            if (problem == null) {
                return NotFound();
            }

            return _mapper.Map<ProblemViewModel>(problem);
        }

        // PUT: api/Problems/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProblem(Guid id, [FromBody] Problem problem) {
            if (id != problem.Id) {
                return BadRequest();
            }

            _context.Entry(problem).State = EntityState.Modified;

            try {
                await _context.SaveChangesAsync();
            } catch (DbUpdateConcurrencyException) {
                if (!ProblemExists(id)) {
                    return NotFound();
                } else {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Problems
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<Problem>> PostProblem(ProblemViewModel problem) {
            Problem newProblem = _mapper.Map<Problem>(problem);
            newProblem.CreateDate = DateTime.Now;

            foreach (var item in problem.ProblemTypes)
                newProblem.ProblemTypeProblems.Add(new ProblemTypeProblem() { Problem = newProblem, ProblemTypeId = item.Id });

            _context.Problems.Add(newProblem);
            await _context.SaveChangesAsync();

            ProblemViewModel loadedProblem = _mapper.Map<ProblemViewModel>(newProblem);
            loadedProblem.ProblemTypes = problem.ProblemTypes;
            loadedProblem.SubscribersCount = newProblem.Subscribers.Count;
            return CreatedAtAction("GetProblem", new { id = newProblem.Id },loadedProblem);
        }

        // DELETE: api/Problems/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Problem>> DeleteProblem(Guid id) {
            var problem = await _context.Problems.FindAsync(id);
            if (problem == null) {
                return NotFound();
            }

            _context.Problems.Remove(problem);
            await _context.SaveChangesAsync();

            return problem;
        }

        private bool ProblemExists(Guid id) {
            return _context.Problems.Any(e => e.Id == id);
        }
    }
}
