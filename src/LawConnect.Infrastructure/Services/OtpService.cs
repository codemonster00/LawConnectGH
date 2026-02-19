using LawConnect.Application.Interfaces;

namespace LawConnect.Infrastructure.Services;

public class OtpService : IOtpService
{
    public string GenerateOtp()
    {
        return Random.Shared.Next(100000, 999999).ToString();
    }

    public async Task<bool> SendOtpAsync(string phoneOrEmail, string otp)
    {
        // TODO: Integrate with Hubtel/Arkesel SMS gateway for production
        Console.WriteLine($"[OTP] Sending OTP {otp} to {phoneOrEmail}");
        await Task.CompletedTask;
        return true;
    }
}
