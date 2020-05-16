using Microsoft.EntityFrameworkCore.Migrations;

namespace DataBaseContext.Migrations
{
    public partial class v4 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "X",
                table: "Problems");

            migrationBuilder.DropColumn(
                name: "Y",
                table: "Problems");

            migrationBuilder.DropColumn(
                name: "X",
                table: "Events");

            migrationBuilder.DropColumn(
                name: "Y",
                table: "Events");

            migrationBuilder.AddColumn<double>(
                name: "Latitude",
                table: "Problems",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "Longitude",
                table: "Problems",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "Latitude",
                table: "Events",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "Longitude",
                table: "Events",
                nullable: false,
                defaultValue: 0.0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Latitude",
                table: "Problems");

            migrationBuilder.DropColumn(
                name: "Longitude",
                table: "Problems");

            migrationBuilder.DropColumn(
                name: "Latitude",
                table: "Events");

            migrationBuilder.DropColumn(
                name: "Longitude",
                table: "Events");

            migrationBuilder.AddColumn<double>(
                name: "X",
                table: "Problems",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "Y",
                table: "Problems",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "X",
                table: "Events",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "Y",
                table: "Events",
                type: "float",
                nullable: false,
                defaultValue: 0.0);
        }
    }
}
