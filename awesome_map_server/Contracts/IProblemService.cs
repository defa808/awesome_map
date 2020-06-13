using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Contracts {
    public interface IProblemService {
        Task<List<Problem>> GetProblems();
        Problem GetProblem(Guid id);
        Task Change(Problem problem);
        Task Save(Problem newProblem);
        Task Delete(Problem problem);
        bool Exist(Guid id);
        void Subscribe(Problem problem, string userId);
        Task<bool> Unsubscribe(Guid problemId, string userId);
        bool UpdateStatus(Guid id, int status);
    }
}
