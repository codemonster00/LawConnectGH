"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import ProtectedRoute from "@/components/ProtectedRoute";
import { useAuth } from "@/components/AuthProvider";
import ConsultationCard from "@/components/ConsultationCard";
import LoadingSpinner from "@/components/LoadingSpinner";
import EmptyState from "@/components/EmptyState";
import { consultationsApi, documentsApi } from "@/lib/api";
import { ConsultationDto, GeneratedDocumentDto } from "@/lib/types";

function DashboardContent() {
  const { user } = useAuth();
  const [consultations, setConsultations] = useState<ConsultationDto[]>([]);
  const [documents, setDocuments] = useState<GeneratedDocumentDto[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    Promise.all([
      consultationsApi.list().catch(() => ({ items: [], totalCount: 0 })),
      documentsApi.getMyDocuments().catch(() => []),
    ]).then(([cRes, docs]) => {
      setConsultations(cRes.items);
      setDocuments(docs);
      setLoading(false);
    });
  }, []);

  if (loading) return <LoadingSpinner />;

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <h1 className="text-2xl font-bold text-gray-900 mb-1">
        Welcome back, {user?.fullName || "there"} 👋
      </h1>
      <p className="text-gray-500 mb-8">What would you like to do today?</p>

      {/* Quick Actions */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-10">
        {[
          { href: "/consultations/new", icon: "💬", title: "Ask a Lawyer", desc: "Start a new consultation", color: "border-primary" },
          { href: "/documents", icon: "📄", title: "Generate Document", desc: "Create legal documents", color: "border-accent" },
          { href: "/rights", icon: "📚", title: "Know Your Rights", desc: "Read legal articles", color: "border-success" },
        ].map((action) => (
          <Link
            key={action.href}
            href={action.href}
            className={`bg-white border-2 ${action.color} rounded-xl p-6 hover:shadow-lg transition`}
          >
            <div className="text-3xl mb-2">{action.icon}</div>
            <h3 className="font-bold text-gray-900">{action.title}</h3>
            <p className="text-sm text-gray-500">{action.desc}</p>
          </Link>
        ))}
      </div>

      {/* Active Consultations */}
      <section className="mb-10">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-xl font-bold">Your Consultations</h2>
          <Link href="/consultations/new" className="text-sm text-primary font-semibold hover:underline">+ New</Link>
        </div>
        {consultations.length === 0 ? (
          <EmptyState icon="💬" title="No consultations yet" message="Start your first consultation with a lawyer" />
        ) : (
          <div className="grid gap-3">
            {consultations.slice(0, 5).map((c) => (
              <ConsultationCard key={c.id} consultation={c} />
            ))}
          </div>
        )}
      </section>

      {/* Recent Documents */}
      <section>
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-xl font-bold">Recent Documents</h2>
          <Link href="/documents" className="text-sm text-primary font-semibold hover:underline">View All</Link>
        </div>
        {documents.length === 0 ? (
          <EmptyState icon="📄" title="No documents yet" message="Generate your first legal document" />
        ) : (
          <div className="grid gap-3">
            {documents.slice(0, 5).map((d) => (
              <div key={d.id} className="bg-white border border-gray-200 rounded-xl p-4 flex items-center justify-between">
                <div>
                  <h3 className="font-semibold text-sm">{d.title}</h3>
                  <p className="text-xs text-gray-500">{d.templateName} · {new Date(d.createdAt).toLocaleDateString()}</p>
                </div>
                <span className="text-xs bg-gray-100 px-2 py-1 rounded-full">{d.status}</span>
              </div>
            ))}
          </div>
        )}
      </section>
    </div>
  );
}

export default function DashboardPage() {
  return (
    <ProtectedRoute>
      <DashboardContent />
    </ProtectedRoute>
  );
}
