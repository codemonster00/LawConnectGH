"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import PhoneInput from "@/components/PhoneInput";
import { useAuth } from "@/components/AuthProvider";
import { authApi } from "@/lib/api";
import { GHANA_REGIONS, LEGAL_TOPICS } from "@/lib/constants";

type Role = "client" | "lawyer";

export default function RegisterPage() {
  const [role, setRole] = useState<Role>("client");
  const [phone, setPhone] = useState("");
  const [fullName, setFullName] = useState("");
  const [email, setEmail] = useState("");
  const [city, setCity] = useState("");
  const [region, setRegion] = useState("");
  const [barNumber, setBarNumber] = useState("");
  const [yearCalled, setYearCalled] = useState("");
  const [bio, setBio] = useState("");
  const [lawFirm, setLawFirm] = useState("");
  const [fee15, setFee15] = useState("");
  const [fee30, setFee30] = useState("");
  const [specializations, setSpecializations] = useState<string[]>([]);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const { login } = useAuth();
  const router = useRouter();

  const toggleSpec = (id: string) => {
    setSpecializations((prev) =>
      prev.includes(id) ? prev.filter((s) => s !== id) : [...prev, id]
    );
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!fullName || phone.length < 9) { setError("Name and phone are required"); return; }
    setError("");
    setLoading(true);
    try {
      const phoneNum = `+233${phone}`;
      if (role === "client") {
        const res = await authApi.registerClient({ phoneNumber: phoneNum, fullName, email: email || undefined, region: region || undefined, city: city || undefined });
        login(res.token, res.userId, res.role);
      } else {
        if (!barNumber || !yearCalled || !fee15 || !fee30) { setError("Please fill all required lawyer fields"); setLoading(false); return; }
        const res = await authApi.registerLawyer({ phoneNumber: phoneNum, fullName, email: email || undefined, barNumber, yearCalledToBar: parseInt(yearCalled), bio: bio || undefined, lawFirm: lawFirm || undefined, consultationFee15Min: parseFloat(fee15), consultationFee30Min: parseFloat(fee30), specializationTopicIds: specializations });
        login(res.token, res.userId, res.role);
      }
      router.push("/dashboard");
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "Registration failed");
    } finally {
      setLoading(false);
    }
  };

  const inputClass = "w-full bg-white/5 border border-white/10 rounded-xl px-4 py-3 text-sm text-white outline-none focus:border-[#d4a843] focus:ring-1 focus:ring-[#d4a843]/30 transition placeholder-gray-500";
  const labelClass = "block text-sm font-medium text-gray-400 mb-1";

  return (
    <div className="min-h-[85vh] flex items-center justify-center px-4 py-8 bg-[#0a1628] dot-pattern">
      <div className="grid md:grid-cols-2 gap-12 max-w-5xl w-full items-start">
        {/* Left: Decorative */}
        <div className="hidden md:flex flex-col items-center justify-center sticky top-24 pt-12">
          <div className="perspective">
            <div className="preserve-3d animate-scale-float">
              <div className="text-8xl mb-6">⚖️</div>
            </div>
          </div>
          <h2 className="text-2xl font-bold gradient-text mt-4">Join LawConnect GH</h2>
          <p className="text-gray-500 mt-2 text-center max-w-xs">Whether you need legal help or you&apos;re a lawyer ready to serve, we&apos;ve got you covered.</p>
          <div className="mt-8 glass rounded-2xl p-6 max-w-xs">
            <div className="flex items-center gap-3 mb-3">
              <span className="text-2xl">🇬🇭</span>
              <span className="text-sm text-gray-400">Trusted across all 16 regions</span>
            </div>
            <div className="flex items-center gap-3 mb-3">
              <span className="text-2xl">🔒</span>
              <span className="text-sm text-gray-400">End-to-end encrypted</span>
            </div>
            <div className="flex items-center gap-3">
              <span className="text-2xl">⚡</span>
              <span className="text-sm text-gray-400">Get matched in minutes</span>
            </div>
          </div>
        </div>

        {/* Right: Form */}
        <div className="glass-strong rounded-2xl p-8">
          <div className="text-center mb-6">
            <h1 className="text-3xl font-bold text-white">Create Account</h1>
            <p className="text-gray-400 mt-2">Join LawConnect GH today</p>
          </div>

          {/* Role toggle */}
          <div className="flex bg-white/5 rounded-full p-1 mb-6 border border-white/10">
            {(["client", "lawyer"] as Role[]).map((r) => (
              <button
                key={r}
                type="button"
                onClick={() => setRole(r)}
                className={`flex-1 py-2 rounded-full text-sm font-semibold transition ${
                  role === r ? "bg-gradient-to-r from-[#d4a843] to-[#e0be6a] text-[#0a1628]" : "text-gray-400"
                }`}
              >
                {r === "client" ? "I Need a Lawyer" : "I Am a Lawyer"}
              </button>
            ))}
          </div>

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className={labelClass}>Full Name *</label>
              <input type="text" value={fullName} onChange={(e) => setFullName(e.target.value)} className={inputClass} placeholder="Kwame Asante" />
            </div>
            <div>
              <label className={labelClass}>Phone Number *</label>
              <PhoneInput value={phone} onChange={setPhone} />
            </div>
            <div>
              <label className={labelClass}>Email (optional)</label>
              <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} className={inputClass} placeholder="kwame@example.com" />
            </div>
            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className={labelClass}>Region</label>
                <select value={region} onChange={(e) => setRegion(e.target.value)} className={inputClass}>
                  <option value="">Select region</option>
                  {GHANA_REGIONS.map((r) => (<option key={r} value={r}>{r}</option>))}
                </select>
              </div>
              <div>
                <label className={labelClass}>City</label>
                <input type="text" value={city} onChange={(e) => setCity(e.target.value)} className={inputClass} placeholder="Accra" />
              </div>
            </div>

            {role === "lawyer" && (
              <>
                <div className="border-t border-white/10 pt-4 mt-4">
                  <h3 className="font-bold text-gray-300 mb-3">Professional Details</h3>
                </div>
                <div className="grid grid-cols-2 gap-3">
                  <div>
                    <label className={labelClass}>Bar Number *</label>
                    <input type="text" value={barNumber} onChange={(e) => setBarNumber(e.target.value)} className={inputClass} />
                  </div>
                  <div>
                    <label className={labelClass}>Year Called to Bar *</label>
                    <input type="number" value={yearCalled} onChange={(e) => setYearCalled(e.target.value)} className={inputClass} placeholder="2015" />
                  </div>
                </div>
                <div>
                  <label className={labelClass}>Law Firm (optional)</label>
                  <input type="text" value={lawFirm} onChange={(e) => setLawFirm(e.target.value)} className={inputClass} />
                </div>
                <div>
                  <label className={labelClass}>Bio</label>
                  <textarea value={bio} onChange={(e) => setBio(e.target.value)} rows={3} className={inputClass} placeholder="Tell clients about your experience..." />
                </div>
                <div className="grid grid-cols-2 gap-3">
                  <div>
                    <label className={labelClass}>15min Fee (GHS) *</label>
                    <input type="number" value={fee15} onChange={(e) => setFee15(e.target.value)} className={inputClass} placeholder="30" />
                  </div>
                  <div>
                    <label className={labelClass}>30min Fee (GHS) *</label>
                    <input type="number" value={fee30} onChange={(e) => setFee30(e.target.value)} className={inputClass} placeholder="50" />
                  </div>
                </div>
                <div>
                  <label className={labelClass}>Specializations</label>
                  <div className="flex flex-wrap gap-2">
                    {LEGAL_TOPICS.map((t) => (
                      <button
                        key={t.id}
                        type="button"
                        onClick={() => toggleSpec(t.id)}
                        className={`px-3 py-1 rounded-full text-xs font-semibold border transition ${
                          specializations.includes(t.id)
                            ? "bg-[#d4a843] text-[#0a1628] border-[#d4a843]"
                            : "border-white/20 text-gray-400 hover:border-[#d4a843]/50"
                        }`}
                      >
                        {t.icon} {t.name}
                      </button>
                    ))}
                  </div>
                </div>
              </>
            )}

            {error && <p className="text-red-400 text-sm">{error}</p>}
            <button
              type="submit"
              disabled={loading}
              className="w-full btn-shimmer bg-gradient-to-r from-[#d4a843] to-[#e0be6a] text-[#0a1628] py-3 rounded-full font-semibold hover:shadow-[0_0_30px_rgba(212,168,67,0.3)] transition-all disabled:opacity-50"
            >
              {loading ? "Creating account..." : "Create Account"}
            </button>
          </form>

          <p className="text-center text-sm text-gray-500 mt-6">
            Already have an account?{" "}
            <Link href="/auth/login" className="text-[#d4a843] font-semibold hover:underline">Login</Link>
          </p>
        </div>
      </div>
    </div>
  );
}
