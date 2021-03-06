﻿using Contracts;
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

        public async Task Change(Problem problem) {
            problem.UpdateDate = DateTime.Now;
            _context.Entry(problem).State = EntityState.Modified;
            await _context.SaveChangesAsync();
        }

        public async Task Delete(Problem problem) {
            _context.Problems.Remove(problem);
            await _context.SaveChangesAsync();
        }

        public bool Exist(Guid id) {
            return _context.Problems.Any(e => e.Id == id);
        }

        public Problem GetProblem(Guid id) {
            return _context.Problems.Include(x => x.Files)
             .Include(x => x.Subscribers)
             .Include(x => x.Comments)
             .Include(x => x.ProblemTypeProblems).ThenInclude(x => x.ProblemType)
             .ThenInclude(x => x.Icon).FirstOrDefault(x => x.Id == id);
        }

        public async Task<List<Problem>> GetProblems() {
            return await _context.Problems
             .Include(x => x.Files)
             .Include(x => x.Subscribers)
             .Include(x => x.Comments)
             .Include(x => x.ProblemTypeProblems).ThenInclude(x => x.ProblemType)
             .ThenInclude(x => x.Icon)
             .ToListAsync();
        }

        public async Task Save(Problem newProblem) {
            newProblem.CreateDate = DateTime.Now;

            _context.Problems.Add(newProblem);
            await _context.SaveChangesAsync();
        }

        public void Subscribe(Problem problem, string userId) {
            problem.Subscribers.Add(new ProblemUser() { ProblemId = problem.Id, UserId = userId });
            _context.SaveChanges();
        }

        public async Task<bool> Unsubscribe(Guid problemId, string userId) {
            Problem problem =  GetProblem(problemId);
            if (problem.OwnerId == userId)
                return false;
            _context.ProblemUsers.RemoveRange(_context.ProblemUsers.Where(x => x.ProblemId == problemId && x.UserId == userId).ToList());
            _context.SaveChanges();
            return true;
        }

        public bool UpdateStatus(Guid id, int status) {
            Problem problem = _context.Problems.FirstOrDefault(x => x.Id == id);
            if (problem == null)
                throw new ArgumentException();
            problem.Status =  (ProblemStatus)status;
            _context.SaveChanges();
            return true;
        }
    }
}
