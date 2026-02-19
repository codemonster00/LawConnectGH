"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import PhoneInput from "@/components/PhoneInput";
import OtpInput from "@/components/OtpInput";
import { useAuth } from "@/components/AuthProvider";
import { authApi } from "@/lib/api";

export default function LoginPage() {
  const [step, setStep] = useState<"phone" | "otp">("phone");
  const [phone, setPhone] = useState("");
  const [otp, setOtp] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const { login } = useAuth();
  const router = useRouter();

  const phoneForApi = `+233${phone}`;

  const handleRequestOtp = async (e: React.FormEvent) => {
    e.preventDefault();
    if (phone.length < 9) { setError("Enter a valid phone number"); return; }
    setError("");
    setLoading(true);
    try {
      await authApi.requestOtp({ phoneOrEmail: phoneForApi });
      setStep("otp");
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "Failed to send OTP");
    } finally {
      setLoading(false);
    }
  };

  const handleVerifyOtp = async (e: React.FormEvent) => {
    e.preventDefault();
    if (otp.length !== 6) { setError("Enter the 6-digit code"); return; }
    setError("");
    setLoading(true);
    try {
      const res = await authApi.verifyOtp({ phoneOrEmail: phoneForApi, code: otp });
      login(res.token, res.userId, res.role);
      router.push("/dashboard");
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "Invalid OTP");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-[85vh] flex items-center justify-center px-4 bg-[#0a1628] dot-pattern">
      <div className="grid md:grid-cols-2 gap-12 max-w-4xl w-full items-center">
        {/* Left: Decorative */}
        <div className="hidden md:flex flex-col items-center justify-center">
          <div className="perspective">
            <div className="preserve-3d animate-scale-float">
              <div className="text-8xl mb-6">⚖️</div>
            </div>
          </div>
          <h2 className="text-2xl font-bold gradient-text mt-4">Justice Made Accessible</h2>
          <p className="text-gray-500 mt-2 text-center max-w-xs">Connect with verified lawyers across all 16 regions of Ghana.</p>
        </div>

        {/* Right: Form */}
        <div className="glass-strong rounded-2xl p-8">
          <div className="text-center mb-8">
            <h1 className="text-3xl font-bold text-white">Welcome Back</h1>
            <p className="text-gray-400 mt-2">Log in with your phone number</p>
          </div>

          {step === "phone" ? (
            <form onSubmit={handleRequestOtp} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-400 mb-1">Phone Number</label>
                <PhoneInput value={phone} onChange={setPhone} />
              </div>
              {error && <p className="text-red-400 text-sm">{error}</p>}
              <button
                type="submit"
                disabled={loading}
                className="w-full btn-shimmer bg-gradient-to-r from-[#d4a843] to-[#e0be6a] text-[#0a1628] py-3 rounded-full font-semibold hover:shadow-[0_0_30px_rgba(212,168,67,0.3)] transition-all disabled:opacity-50"
              >
                {loading ? "Sending..." : "Send OTP"}
              </button>
            </form>
          ) : (
            <form onSubmit={handleVerifyOtp} className="space-y-4">
              <p className="text-center text-sm text-gray-400">
                Enter the 6-digit code sent to +233{phone}
              </p>
              <OtpInput value={otp} onChange={setOtp} />
              {error && <p className="text-red-400 text-sm text-center">{error}</p>}
              <button
                type="submit"
                disabled={loading}
                className="w-full btn-shimmer bg-gradient-to-r from-[#d4a843] to-[#e0be6a] text-[#0a1628] py-3 rounded-full font-semibold hover:shadow-[0_0_30px_rgba(212,168,67,0.3)] transition-all disabled:opacity-50"
              >
                {loading ? "Verifying..." : "Verify & Login"}
              </button>
              <button type="button" onClick={() => { setStep("phone"); setOtp(""); }} className="w-full text-sm text-gray-500 hover:text-[#d4a843]">
                ← Change phone number
              </button>
            </form>
          )}

          <p className="text-center text-sm text-gray-500 mt-6">
            Don&apos;t have an account?{" "}
            <Link href="/auth/register" className="text-[#d4a843] font-semibold hover:underline">Register</Link>
          </p>
        </div>
      </div>
    </div>
  );
}
