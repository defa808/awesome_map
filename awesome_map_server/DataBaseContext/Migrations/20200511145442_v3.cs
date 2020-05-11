using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace DataBaseContext.Migrations
{
    public partial class v3 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IconCode",
                table: "ProblemType");

            migrationBuilder.DropColumn(
                name: "IconCode",
                table: "EventType");

            migrationBuilder.AddColumn<Guid>(
                name: "IconId",
                table: "ProblemType",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "IconId",
                table: "EventType",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Icons",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    IconCode = table.Column<int>(nullable: false),
                    FontFamily = table.Column<string>(nullable: true),
                    FontPackage = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Icons", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProblemType_IconId",
                table: "ProblemType",
                column: "IconId");

            migrationBuilder.CreateIndex(
                name: "IX_EventType_IconId",
                table: "EventType",
                column: "IconId");

            migrationBuilder.AddForeignKey(
                name: "FK_EventType_Icons_IconId",
                table: "EventType",
                column: "IconId",
                principalTable: "Icons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_ProblemType_Icons_IconId",
                table: "ProblemType",
                column: "IconId",
                principalTable: "Icons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_EventType_Icons_IconId",
                table: "EventType");

            migrationBuilder.DropForeignKey(
                name: "FK_ProblemType_Icons_IconId",
                table: "ProblemType");

            migrationBuilder.DropTable(
                name: "Icons");

            migrationBuilder.DropIndex(
                name: "IX_ProblemType_IconId",
                table: "ProblemType");

            migrationBuilder.DropIndex(
                name: "IX_EventType_IconId",
                table: "EventType");

            migrationBuilder.DropColumn(
                name: "IconId",
                table: "ProblemType");

            migrationBuilder.DropColumn(
                name: "IconId",
                table: "EventType");

            migrationBuilder.AddColumn<int>(
                name: "IconCode",
                table: "ProblemType",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "IconCode",
                table: "EventType",
                type: "int",
                nullable: true);
        }
    }
}
