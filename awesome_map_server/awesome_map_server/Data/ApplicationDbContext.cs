using awesome_map_server.Models;
using IdentityServer4.EntityFramework.Options;
using Microsoft.AspNetCore.ApiAuthorization.IdentityServer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace awesome_map_server.Data {
    public class ApplicationDbContext : ApiAuthorizationDbContext<ApplicationUser> {
        public ApplicationDbContext(
            DbContextOptions options,
            IOptions<OperationalStoreOptions> operationalStoreOptions) : base(options, operationalStoreOptions) {
        }

        public DbSet<Problem> Problems { get; set; }
        public DbSet<ProblemType> ProblemType { get; set; }
        public DbSet<ProblemTypeProblem> ProblemTypeProblems { get; set; }
        public DbSet<ProblemUser> ProblemUsers { get; set; }
        public DbSet<Event> Events { get; set; }
        public DbSet<EventType> EventType { get; set; }
        public DbSet<EventTypeEvent> EventTypeEvent { get; set; }
        public DbSet<EventUser> EventUser { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<ServerFile> Files { get; set; }
        public DbSet<FileBody> FileBodies { get; set; }

        protected override void OnModelCreating(ModelBuilder builder) {
            base.OnModelCreating(builder);
            builder.Entity<ProblemTypeProblem>().HasKey(x => new { x.ProblemId, x.ProblemTypeId });
            builder.Entity<ProblemUser>().HasKey(x => new { x.ProblemId, x.UserId });
            builder.Entity<EventTypeEvent>().HasKey(x => new { x.EventId, x.TypeId });
            builder.Entity<EventUser>().HasKey(x => new { x.EventId, x.UserId });
            builder.Entity<ForwardComments>().HasKey(x => new { x.ForwardCommentId, x.BackwardCommentId });
        }
    }
}
