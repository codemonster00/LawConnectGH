"use client";

import { useEffect, useState } from "react";
import ProtectedRoute from "@/components/ProtectedRoute";
import LoadingSpinner from "@/components/LoadingSpinner";
import EmptyState from "@/components/EmptyState";
import { adminApi } from "@/lib/api";
import { LawyerProfileDto } from "@/lib/types";

function AdminContent() {
  const [lawyers, setLawyers] = useState<LawyerProfileDto[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    adminApi.getPendingLawyers().then(setLawyers).catch(() => setLawyers([])).finally(() => setLoading(false));
  }, []);

  const handleVerify = async (id: string, approve: boolean) => {
    try {
      await adminApi.verifyLawyer(id, approve);
      setLawyers((prev) => prev.filter((l) => l.id !== id));
    } catch {}
  };

  if (loading) return <LoadingSpinner />;

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-8">Admin Panel</h1>

      {/* Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-10">
        {[
          { label: "Total Users", value: "1,247", icon: "👥" },
          { label: "Consultations", value: "856", icon: "💬" },
          { label: "Lawyers", value: "89", icon: "⚖️" },
          { label: "Revenue", value: "GHS 42,350", icon: "💰" },
        ].map((s) => (
          <div key={s.label} className="bg-white border border-gray-200 rounded-xl p-5 text-center">
            <div className="text-3xl mb-2">{s.icon}</div>
            <div className="text-2xl font-bold text-primary">{s.value}</div>
            <p className="text-xs text-gray-500">{s.label}</p>
          </div>
        ))}
      </div>

      {/* Pending Lawyers */}
      <h2 className="text-xl font-bold mb-4">Pending Lawyer Verifications</h2>
      {lawyers.length === 0 ? (
        <EmptyState icon="✅" title="All caught up!" message="No pending verifications" />
      ) : (
        <div className="grid gap-4">
          {lawyers.map((l) => (
            <div key={l.id} className="bg-white border border-gray-200 rounded-xl p-4">
              <div className="flex items-start justify-between">
                <div>
                  <h3 className="font-bold text-gray-900">{l.fullName}</h3>
                  <p className="text-sm text-gray-500">Bar: {l.barNumber} · Called: {l.yearCalledToBar}</p>
                  {l.bio && <p className="text-sm text-gray-600 mt-1 line-clamp-2">{l.bio}</p>}
                  <div className="flex flex-wrap gap-1 mt-2">
                    {l.specializations.map((s) => (
                      <span key={s} className="bg-primary/10 text-primary text-xs px-2 py-0.5 rounded-full">{s}</span>
                    ))}
                  </div>
                </div>
                <div className="flex gap-2 shrink-0 ml-4">
                  <button
                    onClick={() => handleVerify(l.id, true)}
                    className="bg-success text-white px-4 py-2 rounded-full text-sm font-semibold hover:bg-green-600 transition"
                  >
                    ✓ Approve
                  </button>
                  <button
                    onClick={() => handleVerify(l.id, false)}
                    className="bg-red-500 text-white px-4 py-2 rounded-full text-sm font-semibold hover:bg-red-600 transition"
                  >
                    ✕ Reject
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

export default function AdminPage() {
  return (
    <ProtectedRoute>
      <AdminContent />
    </ProtectedRoute>
  );
}
