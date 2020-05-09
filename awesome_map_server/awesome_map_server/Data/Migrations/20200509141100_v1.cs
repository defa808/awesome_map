using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace awesome_map_server.Data.Migrations
{
    public partial class v1 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Events",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    X = table.Column<double>(nullable: false),
                    Y = table.Column<double>(nullable: false),
                    Title = table.Column<string>(nullable: true),
                    Description = table.Column<string>(nullable: true),
                    PlaceDescription = table.Column<string>(nullable: true),
                    StartDate = table.Column<DateTime>(nullable: false),
                    Duration = table.Column<TimeSpan>(nullable: false),
                    PeopleCount = table.Column<int>(nullable: true),
                    OwnerId = table.Column<string>(nullable: true),
                    IsClosed = table.Column<bool>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Events", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Events_AspNetUsers_OwnerId",
                        column: x => x.OwnerId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "EventType",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Name = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EventType", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "FileBodies",
                columns: table => new
                {
                    FileId = table.Column<Guid>(nullable: false),
                    Body = table.Column<byte[]>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FileBodies", x => x.FileId);
                });

            migrationBuilder.CreateTable(
                name: "Problems",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    X = table.Column<double>(nullable: false),
                    Y = table.Column<double>(nullable: false),
                    Title = table.Column<string>(nullable: true),
                    ProblemTypeId = table.Column<Guid>(nullable: false),
                    Description = table.Column<string>(nullable: true),
                    OwnerId = table.Column<string>(nullable: true),
                    Status = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Problems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Problems_AspNetUsers_OwnerId",
                        column: x => x.OwnerId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "ProblemType",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Name = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProblemType", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "EventUser",
                columns: table => new
                {
                    EventId = table.Column<Guid>(nullable: false),
                    UserId = table.Column<string>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EventUser", x => new { x.EventId, x.UserId });
                    table.ForeignKey(
                        name: "FK_EventUser_Events_EventId",
                        column: x => x.EventId,
                        principalTable: "Events",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_EventUser_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "EventTypeEvent",
                columns: table => new
                {
                    TypeId = table.Column<Guid>(nullable: false),
                    EventId = table.Column<Guid>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EventTypeEvent", x => new { x.EventId, x.TypeId });
                    table.ForeignKey(
                        name: "FK_EventTypeEvent_Events_EventId",
                        column: x => x.EventId,
                        principalTable: "Events",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_EventTypeEvent_EventType_TypeId",
                        column: x => x.TypeId,
                        principalTable: "EventType",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Comments",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    ProblemId = table.Column<Guid>(nullable: true),
                    EventId = table.Column<Guid>(nullable: true),
                    Text = table.Column<string>(nullable: true),
                    IsRead = table.Column<bool>(nullable: false),
                    IsEdited = table.Column<bool>(nullable: false),
                    TimeSend = table.Column<DateTime>(nullable: false),
                    UserSenderId = table.Column<string>(nullable: true),
                    UserRecipientId = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Comments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Comments_Events_EventId",
                        column: x => x.EventId,
                        principalTable: "Events",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Comments_Problems_ProblemId",
                        column: x => x.ProblemId,
                        principalTable: "Problems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Comments_AspNetUsers_UserRecipientId",
                        column: x => x.UserRecipientId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Comments_AspNetUsers_UserSenderId",
                        column: x => x.UserSenderId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Files",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Name = table.Column<string>(nullable: true),
                    Size = table.Column<double>(nullable: false),
                    FileBodyFileId = table.Column<Guid>(nullable: true),
                    ProblemId = table.Column<Guid>(nullable: true),
                    EventId = table.Column<Guid>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Files", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Files_Events_EventId",
                        column: x => x.EventId,
                        principalTable: "Events",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Files_FileBodies_FileBodyFileId",
                        column: x => x.FileBodyFileId,
                        principalTable: "FileBodies",
                        principalColumn: "FileId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Files_Problems_ProblemId",
                        column: x => x.ProblemId,
                        principalTable: "Problems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "ProblemUsers",
                columns: table => new
                {
                    ProblemId = table.Column<Guid>(nullable: false),
                    UserId = table.Column<string>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProblemUsers", x => new { x.ProblemId, x.UserId });
                    table.ForeignKey(
                        name: "FK_ProblemUsers_Problems_ProblemId",
                        column: x => x.ProblemId,
                        principalTable: "Problems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ProblemUsers_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProblemTypeProblems",
                columns: table => new
                {
                    ProblemId = table.Column<Guid>(nullable: false),
                    ProblemTypeId = table.Column<Guid>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProblemTypeProblems", x => new { x.ProblemId, x.ProblemTypeId });
                    table.ForeignKey(
                        name: "FK_ProblemTypeProblems_Problems_ProblemId",
                        column: x => x.ProblemId,
                        principalTable: "Problems",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ProblemTypeProblems_ProblemType_ProblemTypeId",
                        column: x => x.ProblemTypeId,
                        principalTable: "ProblemType",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ForwardComments",
                columns: table => new
                {
                    ForwardCommentId = table.Column<Guid>(nullable: false),
                    BackwardCommentId = table.Column<Guid>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ForwardComments", x => new { x.ForwardCommentId, x.BackwardCommentId });
                    table.ForeignKey(
                        name: "FK_ForwardComments_Comments_BackwardCommentId",
                        column: x => x.BackwardCommentId,
                        principalTable: "Comments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "FK_ForwardComments_Comments_ForwardCommentId",
                        column: x => x.ForwardCommentId,
                        principalTable: "Comments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Comments_EventId",
                table: "Comments",
                column: "EventId");

            migrationBuilder.CreateIndex(
                name: "IX_Comments_ProblemId",
                table: "Comments",
                column: "ProblemId");

            migrationBuilder.CreateIndex(
                name: "IX_Comments_UserRecipientId",
                table: "Comments",
                column: "UserRecipientId");

            migrationBuilder.CreateIndex(
                name: "IX_Comments_UserSenderId",
                table: "Comments",
                column: "UserSenderId");

            migrationBuilder.CreateIndex(
                name: "IX_Events_OwnerId",
                table: "Events",
                column: "OwnerId");

            migrationBuilder.CreateIndex(
                name: "IX_EventTypeEvent_TypeId",
                table: "EventTypeEvent",
                column: "TypeId");

            migrationBuilder.CreateIndex(
                name: "IX_EventUser_UserId",
                table: "EventUser",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Files_EventId",
                table: "Files",
                column: "EventId");

            migrationBuilder.CreateIndex(
                name: "IX_Files_FileBodyFileId",
                table: "Files",
                column: "FileBodyFileId");

            migrationBuilder.CreateIndex(
                name: "IX_Files_ProblemId",
                table: "Files",
                column: "ProblemId");

            migrationBuilder.CreateIndex(
                name: "IX_ForwardComments_BackwardCommentId",
                table: "ForwardComments",
                column: "BackwardCommentId");

            migrationBuilder.CreateIndex(
                name: "IX_Problems_OwnerId",
                table: "Problems",
                column: "OwnerId");

            migrationBuilder.CreateIndex(
                name: "IX_ProblemTypeProblems_ProblemTypeId",
                table: "ProblemTypeProblems",
                column: "ProblemTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_ProblemUsers_UserId",
                table: "ProblemUsers",
                column: "UserId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "EventTypeEvent");

            migrationBuilder.DropTable(
                name: "EventUser");

            migrationBuilder.DropTable(
                name: "Files");

            migrationBuilder.DropTable(
                name: "ForwardComments");

            migrationBuilder.DropTable(
                name: "ProblemTypeProblems");

            migrationBuilder.DropTable(
                name: "ProblemUsers");

            migrationBuilder.DropTable(
                name: "EventType");

            migrationBuilder.DropTable(
                name: "FileBodies");

            migrationBuilder.DropTable(
                name: "Comments");

            migrationBuilder.DropTable(
                name: "ProblemType");

            migrationBuilder.DropTable(
                name: "Events");

            migrationBuilder.DropTable(
                name: "Problems");
        }
    }
}
