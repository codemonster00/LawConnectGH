using LawConnect.Domain.Enums;

namespace LawConnect.Application.DTOs.Consultations;

public class CreateConsultationRequest
{
    public Guid? LawyerId { get; set; }
    public Guid? LegalTopicId { get; set; }
    public ConsultationType Type { get; set; }
    public string ProblemDescription { get; set; } = string.Empty;
}
