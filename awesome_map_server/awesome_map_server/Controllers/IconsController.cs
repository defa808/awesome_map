using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DataBaseContext;
using DataBaseModels.Models;

namespace awesome_map_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IconsController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public IconsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/Icons
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Icon>>> GetIcons()
        {
            return await _context.Icons.ToListAsync();
        }

        // GET: api/Icons/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Icon>> GetIcon(Guid id)
        {
            var icon = await _context.Icons.FindAsync(id);

            if (icon == null)
            {
                return NotFound();
            }

            return icon;
        }

        // PUT: api/Icons/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutIcon(Guid id, Icon icon)
        {
            if (id != icon.Id)
            {
                return BadRequest();
            }

            _context.Entry(icon).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IconExists(id))
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

        // POST: api/Icons
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<Icon>> PostIcon(Icon icon)
        {
            _context.Icons.Add(icon);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetIcon", new { id = icon.Id }, icon);
        }

        // DELETE: api/Icons/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Icon>> DeleteIcon(Guid id)
        {
            var icon = await _context.Icons.FindAsync(id);
            if (icon == null)
            {
                return NotFound();
            }

            _context.Icons.Remove(icon);
            await _context.SaveChangesAsync();

            return icon;
        }

        private bool IconExists(Guid id)
        {
            return _context.Icons.Any(e => e.Id == id);
        }
    }
}
