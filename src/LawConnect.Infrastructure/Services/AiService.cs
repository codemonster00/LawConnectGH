using LawConnect.Application.Interfaces;

namespace LawConnect.Infrastructure.Services;

public class AiService : IAiService
{
    // TODO: Integrate with OpenAI GPT-4 API for real AI-powered triage, summarization, and document generation

    public async Task<string> TriageConsultationAsync(string problemDescription)
    {
        await Task.CompletedTask;
        return System.Text.Json.JsonSerializer.Serialize(new
        {
            suggestedTopic = "General Legal",
            urgency = "Medium",
            summary = $"Client needs legal assistance regarding: {problemDescription[..Math.Min(100, problemDescription.Length)]}...",
            recommendedActions = new[] { "Consult with a lawyer", "Gather relevant documents" }
        });
    }

    public async Task<string> SummarizeConsultationAsync(IEnumerable<string> messages)
    {
        await Task.CompletedTask;
        var messageList = messages.ToList();
        return $"Consultation summary: {messageList.Count} messages exchanged. Key topics discussed in the session.";
    }

    public async Task<string> GenerateDocumentAsync(string templateBody, Dictionary<string, string> fieldValues)
    {
        await Task.CompletedTask;
        var result = templateBody;
        foreach (var (key, value) in fieldValues)
        {
            result = result.Replace($"{{{{{key}}}}}", value);
            result = result.Replace($"[{key}]", value);
        }
        return result;
    }
}
