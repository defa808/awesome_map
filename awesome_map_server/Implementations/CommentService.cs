using Contracts;
using DataBaseContext;
using DataBaseModels.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Implementations {
    public class CommentService : ICommentService {
        private ApplicationDbContext _context;

        public CommentService(ApplicationDbContext context) {
            _context = context;
        }
        public async Task<Comment> Save(Comment entity) {
            _context.Comments.Add(entity);
            await _context.SaveChangesAsync();
            entity = _context.Comments.Where(x => x.Id == entity.Id).Include(x => x.UserSender).First();
            return entity;
        }
    }
}
