namespace LawConnect.Application.DTOs.Consultations;

public class ConsultationListDto
{
    public List<ConsultationDto> Items { get; set; } = new();
    public int TotalCount { get; set; }
}
