namespace LawConnect.Application.DTOs.Consultations;

public class ConsultationDto
{
    public Guid Id { get; set; }
    public Guid ClientId { get; set; }
    public string ClientName { get; set; } = string.Empty;
    public Guid? LawyerId { get; set; }
    public string? LawyerName { get; set; }
    public string? LegalTopicName { get; set; }
    public string Status { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty;
    public int? DurationMinutes { get; set; }
    public string ProblemDescription { get; set; } = string.Empty;
    public DateTime? StartedAt { get; set; }
    public DateTime? EndedAt { get; set; }
    public int? ClientRating { get; set; }
    public decimal TotalFee { get; set; }
    public DateTime CreatedAt { get; set; }
}
