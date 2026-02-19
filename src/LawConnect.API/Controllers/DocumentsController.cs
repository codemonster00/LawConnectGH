using System.Security.Claims;
using LawConnect.Application.DTOs.Documents;
using LawConnect.Application.Interfaces;
using LawConnect.Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LawConnect.API.Controllers;

/// <summary>Endpoints for document templates and generation.</summary>
[ApiController]
[Route("api/v1/documents")]
public class DocumentsController : ControllerBase
{
    private readonly IApplicationDbContext _db;

    public DocumentsController(IApplicationDbContext db) => _db = db;

    /// <summary>List available document templates.</summary>
    [HttpGet("templates")]
    [ProducesResponseType(typeof(List<DocumentTemplateDto>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetTemplates()
    {
        var templates = await _db.DocumentTemplates
            .Include(t => t.LegalTopic)
            .Where(t => t.IsActive)
            .OrderBy(t => t.Name)
            .Select(t => new DocumentTemplateDto
            {
                Id = t.Id, Name = t.Name, Description = t.Description,
                LegalTopicName = t.LegalTopic != null ? t.LegalTopic.Name : null,
                FieldsSchema = t.FieldsSchema, Price = t.Price
            }).ToListAsync();

        return Ok(templates);
    }

    /// <summary>Generate a document from a template.</summary>
    [HttpPost("generate")]
    [Authorize]
    [ProducesResponseType(typeof(GeneratedDocumentDto), StatusCodes.Status201Created)]
    public async Task<IActionResult> Generate([FromBody] GenerateDocumentRequest dto)
    {
        var template = await _db.DocumentTemplates.FindAsync(dto.TemplateId);
        if (template == null) return NotFound(new { message = "Template not found" });

        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        var doc = new GeneratedDocument
        {
            UserId = userId,
            TemplateId = dto.TemplateId,
            ConsultationId = dto.ConsultationId,
            Title = dto.Title,
            FieldValues = System.Text.Json.JsonSerializer.Serialize(dto.FieldValues),
            GeneratedContent = template.TemplateBody // TODO: Use AI service for generation
        };
        _db.GeneratedDocuments.Add(doc);
        await _db.SaveChangesAsync();

        return CreatedAtAction(nameof(GetMyDocuments), new GeneratedDocumentDto
        {
            Id = doc.Id, Title = doc.Title, TemplateName = template.Name,
            Status = doc.Status.ToString(), CreatedAt = doc.CreatedAt
        });
    }

    /// <summary>Get current user's generated documents.</summary>
    [HttpGet("my")]
    [Authorize]
    [ProducesResponseType(typeof(List<GeneratedDocumentDto>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetMyDocuments()
    {
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        var docs = await _db.GeneratedDocuments
            .Include(d => d.Template)
            .Where(d => d.UserId == userId)
            .OrderByDescending(d => d.CreatedAt)
            .Select(d => new GeneratedDocumentDto
            {
                Id = d.Id, Title = d.Title, TemplateName = d.Template.Name,
                Status = d.Status.ToString(), FileUrl = d.FileUrl, CreatedAt = d.CreatedAt
            }).ToListAsync();

        return Ok(docs);
    }
}
