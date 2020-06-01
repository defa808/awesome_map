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
    public class ProblemService : IProblemService {
        private ApplicationDbContext _context;
        public ProblemService(ApplicationDbContext context) {
            _context = context;
        }

        public async void Change(Problem problem) {
            _context.Entry(problem).State = EntityState.Modified;
            await _context.SaveChangesAsync();
        }

        public async void Delete(Problem problem) {
            _context.Problems.Remove(problem);
            await _context.SaveChangesAsync();
        }

        public bool Exist(Guid id) {
            return _context.Problems.Any(e => e.Id == id);
        }

        public async Task<Problem> GetProblem(Guid id) {
            return await _context.Problems.FindAsync(id);
        }

        public async Task<List<Problem>> GetProblems() {
            return await _context.Problems
             .Include(x => x.Files)
             .Include(x => x.Subscribers)
             .Include(x => x.ProblemTypeProblems).ThenInclude(x => x.ProblemType)
             .ThenInclude(x => x.Icon)
             .ToListAsync();
        }

        public async void Save(Problem newProblem) {
            newProblem.CreateDate = DateTime.Now;
           
            _context.Problems.Add(newProblem);
            await _context.SaveChangesAsync();
        }

        public void Subscribe(Problem problem, string userId) {
            problem.Subscribers.Add(new ProblemUser() { ProblemId = problem.Id, UserId = userId });
            _context.SaveChanges();
        }

        public void Unsubscribe(Guid problemId, string userId) {
            _context.ProblemUsers.RemoveRange(_context.ProblemUsers.Where(x => x.ProblemId == problemId && x.UserId == userId).ToList());
            _context.SaveChanges();
        }
    }
}
