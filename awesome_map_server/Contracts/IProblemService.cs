using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Contracts {
    public interface IProblemService {
        Task<List<Problem>> GetProblems();
        Task<Problem> GetProblem(Guid id);
        void Change(Problem problem);
        void Save(Problem newProblem);
        void Delete(Problem problem);
        bool Exist(Guid id);
        void Subscribe(Problem problem, string userId);
        void Unsubscribe(Guid problemId, string userId);
    }
}
