using Microsoft.EntityFrameworkCore.Migrations;

namespace DataBaseContext.Migrations
{
    public partial class v2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "IconCode",
                table: "ProblemType",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "IconCode",
                table: "EventType",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IconCode",
                table: "ProblemType");

            migrationBuilder.DropColumn(
                name: "IconCode",
                table: "EventType");
        }
    }
}
