using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DataBaseContext;
using DataBaseModels.Models;
using System.Text;

namespace awesome_map_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FileBodiesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public FileBodiesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/FileBodies
        [HttpGet]
        public async Task<ActionResult<IEnumerable<FileBody>>> GetFileBodies()
        {
            return await _context.FileBodies.ToListAsync();
        }

        // GET: api/FileBodies/5
        [HttpGet("{id}")]
        public async Task<ActionResult<string>> GetFileBody(Guid id)
        {
            var fileBody = await _context.FileBodies.FindAsync(id);

            if (fileBody == null)
            {
                return NotFound();
            }
            return Convert.ToBase64String(fileBody.Body);
        }

        // PUT: api/FileBodies/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutFileBody(Guid id, FileBody fileBody)
        {
            if (id != fileBody.ServerFileId)
            {
                return BadRequest();
            }

            _context.Entry(fileBody).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!FileBodyExists(id))
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

        // POST: api/FileBodies
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<FileBody>> PostFileBody(FileBody fileBody)
        {
            _context.FileBodies.Add(fileBody);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (FileBodyExists(fileBody.ServerFileId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetFileBody", new { id = fileBody.ServerFileId }, fileBody);
        }

        // DELETE: api/FileBodies/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<FileBody>> DeleteFileBody(Guid id)
        {
            var fileBody = await _context.FileBodies.FindAsync(id);
            if (fileBody == null)
            {
                return NotFound();
            }

            _context.FileBodies.Remove(fileBody);
            await _context.SaveChangesAsync();

            return fileBody;
        }

        private bool FileBodyExists(Guid id)
        {
            return _context.FileBodies.Any(e => e.ServerFileId == id);
        }
    }
}
