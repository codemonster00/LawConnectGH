namespace LawConnect.Application.DTOs.Lawyers;

public class LawyerProfileDto
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public string FullName { get; set; } = string.Empty;
    public string? AvatarUrl { get; set; }
    public string BarNumber { get; set; } = string.Empty;
    public int YearCalledToBar { get; set; }
    public string? Bio { get; set; }
    public string? LawFirm { get; set; }
    public decimal ConsultationFee15Min { get; set; }
    public decimal ConsultationFee30Min { get; set; }
    public bool IsAvailable { get; set; }
    public string VerificationStatus { get; set; } = string.Empty;
    public double RatingAvg { get; set; }
    public int RatingCount { get; set; }
    public int TotalConsultations { get; set; }
    public double ResponseTimeAvgMin { get; set; }
    public List<string> Specializations { get; set; } = new();
}
