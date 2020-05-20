using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DataBaseContext;
using DataBaseModels.Models;
using System.IO;
using System.Web;
using Newtonsoft.Json;

namespace awesome_map_server.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class ServerFilesController : ControllerBase {
        private readonly ApplicationDbContext _context;

        public ServerFilesController(ApplicationDbContext context) {
            _context = context;
        }

        // GET: api/ServerFiles
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ServerFile>>> GetFiles() {
            return await _context.Files.ToListAsync();
        }

        // GET: api/ServerFiles/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ServerFile>> GetServerFile(Guid id) {
            var serverFile = await _context.Files.FindAsync(id);

            if (serverFile == null) {
                return NotFound();
            }

            return serverFile;
        }

        // PUT: api/ServerFiles/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutServerFile(Guid id, ServerFile serverFile) {
            if (id != serverFile.Id) {
                return BadRequest();
            }

            _context.Entry(serverFile).State = EntityState.Modified;

            try {
                await _context.SaveChangesAsync();
            } catch (DbUpdateConcurrencyException) {
                if (!ServerFileExists(id)) {
                    return NotFound();
                } else {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/ServerFiles
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<ServerFile>> PostServerFile(IList<IFormFile> files) {
            ServerFile serverFile = JsonConvert.DeserializeObject<ServerFile>(HttpContext.Request.Form["serverFile"]);
            if (files.Count == 0)
                return BadRequest();

            serverFile.Name = files[0].FileName;
            FileBody fileBody;

            using (var streamReader = new MemoryStream()) {
                IFormFile file = files[0];
                if (file.ContentType != "text/plain"
                    && file.ContentType != "text/html"
                    && file.ContentType != "text/richtext"
                    && file.ContentType != "text/xml")
                    files[0].OpenReadStream().CopyTo(streamReader);
                fileBody = new FileBody() { Body = streamReader.ToArray(), ContentType = file.ContentType };

            }
            serverFile.FileBody = fileBody;
            serverFile.Size = files[0].Length;

            _context.Files.Add(serverFile);
            await _context.SaveChangesAsync();
            serverFile.FileBody = null;
            return CreatedAtAction("GetServerFile", new { id = serverFile.Id }, serverFile);
        }

        // DELETE: api/ServerFiles/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<ServerFile>> DeleteServerFile(Guid id) {
            var serverFile = await _context.Files.FindAsync(id);
            if (serverFile == null) {
                return NotFound();
            }

            _context.Files.Remove(serverFile);
            await _context.SaveChangesAsync();

            return serverFile;
        }

        private bool ServerFileExists(Guid id) {
            return _context.Files.Any(e => e.Id == id);
        }
    }
}
