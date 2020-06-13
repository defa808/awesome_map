using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Contracts {
    public interface ICommentService {
        Task<Comment> Save(Comment entity);
    }
}
