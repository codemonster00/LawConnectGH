using FluentValidation;
using LawConnect.Application.DTOs.Auth;

namespace LawConnect.Application.Validators;

public class RegisterLawyerRequestValidator : AbstractValidator<RegisterLawyerRequest>
{
    public RegisterLawyerRequestValidator()
    {
        RuleFor(x => x.PhoneNumber).NotEmpty().Matches(@"^\+?233\d{9}$").WithMessage("Valid Ghana phone number required");
        RuleFor(x => x.FullName).NotEmpty().MinimumLength(2).MaximumLength(100);
        RuleFor(x => x.BarNumber).NotEmpty();
        RuleFor(x => x.YearCalledToBar).InclusiveBetween(1950, DateTime.UtcNow.Year);
        RuleFor(x => x.ConsultationFee15Min).GreaterThan(0);
        RuleFor(x => x.ConsultationFee30Min).GreaterThan(0);
    }
}
