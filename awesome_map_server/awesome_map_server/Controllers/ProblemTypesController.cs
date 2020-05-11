using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DataBaseModels.Models;
using DataBaseContext;

namespace awesome_map_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProblemTypesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public ProblemTypesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/ProblemTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProblemType>>> GetProblemType()
        {
            return await _context.ProblemType.Include(x => x.Icon).ToListAsync();
        }

        // GET: api/ProblemTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ProblemType>> GetProblemType(Guid id)
        {
            var problemType = await _context.ProblemType.FindAsync(id);

            if (problemType == null)
            {
                return NotFound();
            }

            return problemType;
        }

        // PUT: api/ProblemTypes/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProblemType(Guid id, ProblemType problemType)
        {
            if (id != problemType.Id)
            {
                return BadRequest();
            }

            _context.Entry(problemType).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProblemTypeExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/ProblemTypes
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<ProblemType>> PostProblemType(ProblemType problemType)
        {
            _context.ProblemType.Add(problemType);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProblemType", new { id = problemType.Id }, problemType);
        }

        // DELETE: api/ProblemTypes/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<ProblemType>> DeleteProblemType(Guid id)
        {
            var problemType = await _context.ProblemType.FindAsync(id);
            if (problemType == null)
            {
                return NotFound();
            }

            _context.ProblemType.Remove(problemType);
            await _context.SaveChangesAsync();

            return problemType;
        }

        private bool ProblemTypeExists(Guid id)
        {
            return _context.ProblemType.Any(e => e.Id == id);
        }
    }
}
