namespace LawConnect.Application.Interfaces;

public interface IAiService
{
    Task<string> TriageConsultationAsync(string problemDescription);
    Task<string> SummarizeConsultationAsync(IEnumerable<string> messages);
    Task<string> GenerateDocumentAsync(string templateBody, Dictionary<string, string> fieldValues);
}
