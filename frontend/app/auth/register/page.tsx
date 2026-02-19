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
  // Lawyer fields
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
    if (!fullName || phone.length < 9) {
      setError("Name and phone are required");
      return;
    }
    setError("");
    setLoading(true);
    try {
      const phoneNum = `+233${phone}`;
      if (role === "client") {
        const res = await authApi.registerClient({
          phoneNumber: phoneNum,
          fullName,
          email: email || undefined,
          region: region || undefined,
          city: city || undefined,
        });
        login(res.token, res.userId, res.role);
      } else {
        if (!barNumber || !yearCalled || !fee15 || !fee30) {
          setError("Please fill all required lawyer fields");
          setLoading(false);
          return;
        }
        const res = await authApi.registerLawyer({
          phoneNumber: phoneNum,
          fullName,
          email: email || undefined,
          barNumber,
          yearCalledToBar: parseInt(yearCalled),
          bio: bio || undefined,
          lawFirm: lawFirm || undefined,
          consultationFee15Min: parseFloat(fee15),
          consultationFee30Min: parseFloat(fee30),
          specializationTopicIds: specializations,
        });
        login(res.token, res.userId, res.role);
      }
      router.push("/dashboard");
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "Registration failed");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-[80vh] flex items-center justify-center px-4 py-8">
      <div className="w-full max-w-lg">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-primary">Create Account</h1>
          <p className="text-gray-600 mt-2">Join LawConnect GH today</p>
        </div>

        {/* Role toggle */}
        <div className="flex bg-gray-100 rounded-full p-1 mb-6">
          {(["client", "lawyer"] as Role[]).map((r) => (
            <button
              key={r}
              type="button"
              onClick={() => setRole(r)}
              className={`flex-1 py-2 rounded-full text-sm font-semibold transition ${
                role === r ? "bg-primary text-white" : "text-gray-600"
              }`}
            >
              {r === "client" ? "I Need a Lawyer" : "I Am a Lawyer"}
            </button>
          ))}
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
            <input
              type="text"
              value={fullName}
              onChange={(e) => setFullName(e.target.value)}
              className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-primary"
              placeholder="Kwame Asante"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Phone Number *</label>
            <PhoneInput value={phone} onChange={setPhone} />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Email (optional)</label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-primary"
              placeholder="kwame@example.com"
            />
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Region</label>
              <select
                value={region}
                onChange={(e) => setRegion(e.target.value)}
                className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-primary"
              >
                <option value="">Select region</option>
                {GHANA_REGIONS.map((r) => (
                  <option key={r} value={r}>{r}</option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">City</label>
              <input
                type="text"
                value={city}
                onChange={(e) => setCity(e.target.value)}
                className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-primary"
                placeholder="Accra"
              />
            </div>
          </div>

          {role === "lawyer" && (
            <>
              <hr className="my-4" />
              <h3 className="font-bold text-gray-800">Professional Details</h3>
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Bar Number *</label>
                  <input
                    type="text"
                    value={barNumber}
                    onChange={(e) => setBarNumber(e.target.value)}
                    className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-primary"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Year Called to Bar *</label>
                  <input
                    type="number"
                    value={yearCalled}
                    onChange={(e) => setYearCalled(e.target.value)}
                    className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-primary"
                    placeholder="2015"
                  />
                </div>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Law Firm (optional)</label>
                <input
                  type="text"
                  value={lawFirm}
                  onChange={(e) => setLawFirm(e.target.value)}
                  className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-primary"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Bio</label>
                <textarea
                  value={bio}
                  onChange={(e) => setBio(e.target.value)}
                  rows={3}
                  className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-primary"
                  placeholder="Tell clients about your experience..."
                />
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">15min Fee (GHS) *</label>
                  <input
                    type="number"
                    value={fee15}
                    onChange={(e) => setFee15(e.target.value)}
                    className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-primary"
                    placeholder="30"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">30min Fee (GHS) *</label>
                  <input
                    type="number"
                    value={fee30}
                    onChange={(e) => setFee30(e.target.value)}
                    className="w-full border border-gray-300 rounded-xl px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-primary"
                    placeholder="50"
                  />
                </div>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Specializations</label>
                <div className="flex flex-wrap gap-2">
                  {LEGAL_TOPICS.map((t) => (
                    <button
                      key={t.id}
                      type="button"
                      onClick={() => toggleSpec(t.id)}
                      className={`px-3 py-1 rounded-full text-xs font-semibold border transition ${
                        specializations.includes(t.id)
                          ? "bg-primary text-white border-primary"
                          : "border-gray-300 text-gray-600 hover:border-primary"
                      }`}
                    >
                      {t.icon} {t.name}
                    </button>
                  ))}
                </div>
              </div>
            </>
          )}

          {error && <p className="text-red-500 text-sm">{error}</p>}
          <button
            type="submit"
            disabled={loading}
            className="w-full bg-primary text-white py-3 rounded-full font-semibold hover:bg-primary-light transition disabled:opacity-50"
          >
            {loading ? "Creating account..." : "Create Account"}
          </button>
        </form>

        <p className="text-center text-sm text-gray-600 mt-6">
          Already have an account?{" "}
          <Link href="/auth/login" className="text-primary font-semibold hover:underline">Login</Link>
        </p>
      </div>
    </div>
  );
}
