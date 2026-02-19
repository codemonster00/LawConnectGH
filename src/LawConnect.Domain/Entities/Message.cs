using LawConnect.Domain.Enums;

namespace LawConnect.Domain.Entities;

public class Message
{
    public Guid Id { get; set; }
    public Guid ConsultationId { get; set; }
    public Guid SenderId { get; set; }
    public string Content { get; set; } = string.Empty;
    public MessageType MessageType { get; set; }
    public string? AttachmentUrl { get; set; }
    public bool IsRead { get; set; }
    public DateTime CreatedAt { get; set; }

    // Navigation
    public Consultation Consultation { get; set; } = null!;
    public User Sender { get; set; } = null!;
}
