namespace LawConnect.Application.DTOs.Auth;

public class RegisterLawyerRequest
{
    public string PhoneNumber { get; set; } = string.Empty;
    public string FullName { get; set; } = string.Empty;
    public string? Email { get; set; }
    public string BarNumber { get; set; } = string.Empty;
    public int YearCalledToBar { get; set; }
    public string? Bio { get; set; }
    public string? LawFirm { get; set; }
    public decimal ConsultationFee15Min { get; set; }
    public decimal ConsultationFee30Min { get; set; }
    public List<Guid> SpecializationTopicIds { get; set; } = new();
}
