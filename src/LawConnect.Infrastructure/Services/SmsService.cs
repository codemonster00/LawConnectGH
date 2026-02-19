using LawConnect.Application.Interfaces;

namespace LawConnect.Infrastructure.Services;

public class SmsService : ISmsService
{
    // TODO: Integrate with Hubtel or Arkesel SMS API for Ghana
    public async Task<bool> SendAsync(string phoneNumber, string message)
    {
        Console.WriteLine($"[SMS] To: {phoneNumber} | Message: {message}");
        await Task.CompletedTask;
        return true;
    }
}
