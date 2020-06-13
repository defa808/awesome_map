using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DataBaseContext;
using DataBaseModels.Models;
using awesome_map_server.ViewModels.Comment;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using Contracts;

namespace awesome_map_server.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class CommentsController : ControllerBase {
        private IMapper _mapper;
        private readonly ApplicationDbContext _context;
        private ICommentService _commentService;
        public CommentsController(ApplicationDbContext context, IMapper mapper, ICommentService commentService) {
            _context = context;
            _mapper = mapper;
            _commentService = commentService;
        }

        // GET: api/Comments
        //[HttpGet]
        //public async Task<ActionResult<IEnumerable<Comment>>> GetComments() {
        //    return await _context.Comments.ToListAsync();
        //}

        // GET: api/Comments/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Comment>> GetComment(Guid id) {
            var comment = await _context.Comments.FindAsync(id);

            if (comment == null) {
                return NotFound();
            }

            return comment;
        }

        [HttpGet]
        public IActionResult GetComments(Guid problemId, Guid eventId) {
            if (problemId != Guid.Empty)
                return Ok(_mapper.ProjectTo<CommentViewModel>(_context.Comments.Where(x => x.ProblemId == problemId).Include(x=> x.UserSender).OrderBy(x=> x.TimeSend).AsQueryable()).ToList());

            if (eventId != Guid.Empty)
                return Ok(_mapper.ProjectTo<CommentViewModel>(_context.Comments.Where(x => x.EventId == eventId).OrderBy(x => x.TimeSend).AsQueryable()).ToList());

            return NotFound();
        }

        // PUT: api/Comments/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutComment(Guid id, Comment comment) {
            if (id != comment.Id) {
                return BadRequest();
            }

            _context.Entry(comment).State = EntityState.Modified;

            try {
                await _context.SaveChangesAsync();
            } catch (DbUpdateConcurrencyException) {
                if (!CommentExists(id)) {
                    return NotFound();
                } else {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Comments
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [Authorize]
        [HttpPost]
        public async Task<ActionResult<Comment>> PostComment(CommentViewModel comment) {
            
            Comment entity = _mapper.Map<Comment>(comment);
            entity.UserSenderId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            entity = await _commentService.Save(entity);
            CommentViewModel commentViewModel = _mapper.Map<CommentViewModel>(entity);
            return CreatedAtAction("GetComment", new { id = comment.Id }, commentViewModel);
        }

        // DELETE: api/Comments/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Comment>> DeleteComment(Guid id) {
            var comment = await _context.Comments.FindAsync(id);
            if (comment == null) {
                return NotFound();
            }

            _context.Comments.Remove(comment);
            await _context.SaveChangesAsync();

            return comment;
        }

        private bool CommentExists(Guid id) {
            return _context.Comments.Any(e => e.Id == id);
        }
    }
}
