"use client";

import { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import Link from "next/link";
import { lawyersApi } from "@/lib/api";
import { LawyerProfileDto } from "@/lib/types";
import RatingStars from "@/components/RatingStars";
import PriceTag from "@/components/PriceTag";
import LoadingSpinner from "@/components/LoadingSpinner";

export default function LawyerProfilePage() {
  const params = useParams();
  const [lawyer, setLawyer] = useState<LawyerProfileDto | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    lawyersApi
      .getById(params.id as string)
      .then(setLawyer)
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [params.id]);

  if (loading) return <LoadingSpinner />;
  if (!lawyer) return <div className="text-center py-20 text-gray-500">Lawyer not found</div>;

  const yearsExp = new Date().getFullYear() - lawyer.yearCalledToBar;

  return (
    <div className="max-w-3xl mx-auto px-4 py-8">
      {/* Header */}
      <div className="bg-white border border-gray-200 rounded-xl p-6 mb-6">
        <div className="flex items-start gap-4">
          <div className="w-20 h-20 bg-primary/10 rounded-full flex items-center justify-center text-3xl font-bold text-primary shrink-0">
            {lawyer.fullName.charAt(0)}
          </div>
          <div className="flex-1">
            <h1 className="text-2xl font-bold text-gray-900">{lawyer.fullName}</h1>
            {lawyer.lawFirm && <p className="text-gray-500">{lawyer.lawFirm}</p>}
            <div className="flex items-center gap-4 mt-2 text-sm text-gray-600">
              <span>📜 Bar: {lawyer.barNumber}</span>
              <span>⏳ {yearsExp} year{yearsExp !== 1 ? "s" : ""} experience</span>
            </div>
            <div className="mt-2">
              <RatingStars rating={lawyer.ratingAvg} count={lawyer.ratingCount} />
            </div>
            <span className={`inline-block mt-2 text-xs ${lawyer.isAvailable ? "text-success" : "text-gray-400"}`}>
              {lawyer.isAvailable ? "● Available now" : "○ Currently unavailable"}
            </span>
          </div>
        </div>
      </div>

      {/* Bio */}
      {lawyer.bio && (
        <div className="bg-white border border-gray-200 rounded-xl p-6 mb-6">
          <h2 className="font-bold text-lg mb-2">About</h2>
          <p className="text-gray-700 whitespace-pre-wrap">{lawyer.bio}</p>
        </div>
      )}

      {/* Specializations */}
      <div className="bg-white border border-gray-200 rounded-xl p-6 mb-6">
        <h2 className="font-bold text-lg mb-3">Specializations</h2>
        <div className="flex flex-wrap gap-2">
          {lawyer.specializations.map((s) => (
            <span key={s} className="bg-primary/10 text-primary px-3 py-1 rounded-full text-sm font-semibold">
              {s}
            </span>
          ))}
        </div>
      </div>

      {/* Fees */}
      <div className="bg-white border border-gray-200 rounded-xl p-6 mb-6">
        <h2 className="font-bold text-lg mb-3">Consultation Fees</h2>
        <div className="grid grid-cols-2 gap-4">
          <div className="bg-gray-50 rounded-xl p-4 text-center">
            <p className="text-sm text-gray-500 mb-1">15 minutes</p>
            <PriceTag amount={lawyer.consultationFee15Min} className="text-xl" />
          </div>
          <div className="bg-gray-50 rounded-xl p-4 text-center">
            <p className="text-sm text-gray-500 mb-1">30 minutes</p>
            <PriceTag amount={lawyer.consultationFee30Min} className="text-xl" />
          </div>
        </div>
      </div>

      {/* Stats */}
      <div className="bg-white border border-gray-200 rounded-xl p-6 mb-6">
        <h2 className="font-bold text-lg mb-3">Stats</h2>
        <div className="grid grid-cols-3 gap-4 text-center">
          <div>
            <div className="text-2xl font-bold text-primary">{lawyer.totalConsultations}</div>
            <p className="text-xs text-gray-500">Consultations</p>
          </div>
          <div>
            <div className="text-2xl font-bold text-primary">{lawyer.ratingAvg.toFixed(1)}</div>
            <p className="text-xs text-gray-500">Rating</p>
          </div>
          <div>
            <div className="text-2xl font-bold text-primary">{Math.round(lawyer.responseTimeAvgMin)}m</div>
            <p className="text-xs text-gray-500">Avg Response</p>
          </div>
        </div>
      </div>

      {/* CTA */}
      <Link
        href={`/consultations/new?lawyerId=${lawyer.id}`}
        className="block w-full bg-primary text-white text-center py-4 rounded-full font-bold text-lg hover:bg-primary-light transition"
      >
        Start Consultation
      </Link>
    </div>
  );
}
