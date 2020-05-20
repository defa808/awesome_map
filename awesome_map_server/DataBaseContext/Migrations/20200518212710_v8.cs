using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace DataBaseContext.Migrations
{
    public partial class v8 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Files_FileBodies_FileBodyFileId",
                table: "Files");

            migrationBuilder.DropIndex(
                name: "IX_Files_FileBodyFileId",
                table: "Files");

            migrationBuilder.DropPrimaryKey(
                name: "PK_FileBodies",
                table: "FileBodies");

            migrationBuilder.DropColumn(
                name: "FileBodyFileId",
                table: "Files");

            migrationBuilder.DropColumn(
                name: "FileId",
                table: "FileBodies");

            migrationBuilder.AddColumn<Guid>(
                name: "ServerFileId",
                table: "FileBodies",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddPrimaryKey(
                name: "PK_FileBodies",
                table: "FileBodies",
                column: "ServerFileId");

            migrationBuilder.AddForeignKey(
                name: "FK_FileBodies_Files_ServerFileId",
                table: "FileBodies",
                column: "ServerFileId",
                principalTable: "Files",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FileBodies_Files_ServerFileId",
                table: "FileBodies");

            migrationBuilder.DropPrimaryKey(
                name: "PK_FileBodies",
                table: "FileBodies");

            migrationBuilder.DropColumn(
                name: "ServerFileId",
                table: "FileBodies");

            migrationBuilder.AddColumn<Guid>(
                name: "FileBodyFileId",
                table: "Files",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "FileId",
                table: "FileBodies",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddPrimaryKey(
                name: "PK_FileBodies",
                table: "FileBodies",
                column: "FileId");

            migrationBuilder.CreateIndex(
                name: "IX_Files_FileBodyFileId",
                table: "Files",
                column: "FileBodyFileId");

            migrationBuilder.AddForeignKey(
                name: "FK_Files_FileBodies_FileBodyFileId",
                table: "Files",
                column: "FileBodyFileId",
                principalTable: "FileBodies",
                principalColumn: "FileId",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
