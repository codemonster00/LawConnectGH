using FluentValidation;
using LawConnect.Application.DTOs.Auth;

namespace LawConnect.Application.Validators;

public class RegisterClientRequestValidator : AbstractValidator<RegisterClientRequest>
{
    public RegisterClientRequestValidator()
    {
        RuleFor(x => x.PhoneNumber).NotEmpty().Matches(@"^\+?233\d{9}$").WithMessage("Valid Ghana phone number required");
        RuleFor(x => x.FullName).NotEmpty().MinimumLength(2).MaximumLength(100);
        RuleFor(x => x.Email).EmailAddress().When(x => !string.IsNullOrEmpty(x.Email));
    }
}
